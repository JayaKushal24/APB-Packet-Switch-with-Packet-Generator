class pkt_bd_base_seq extends pkt_csr_base_seq;
  `uvm_object_utils(pkt_bd_base_seq)
  function new(string name = "pkt_bd_base_seq");
    super.new(name);
  endfunction

  task wait_reset_done();
    regmodel.device_id.read(status, rdata);
  endtask

  task peek_chk(uvm_reg r, uvm_reg_data_t expd, string what);
    uvm_reg_data_t v;
    r.peek(status, v);
    if (status != UVM_IS_OK)
      `uvm_error("BD", $sformatf("%s: peek failed (check hdl path)", what))
    else
      chk("BD", v, expd, {what, " [peek]"});
  endtask

  task poke_rd_chk(uvm_reg r, uvm_reg_data_t val, string what);
    r.poke(status, val);
    r.read(status, rdata);
    chk("BD", rdata, val, {what, " [poke -> read]"});
  endtask

  task wr_peek_chk(uvm_reg r, uvm_reg_data_t wdata, uvm_reg_data_t expd, string what);
    r.write(status, wdata);
    peek_chk(r, expd, what);
  endtask
endclass

class pkt_bd_reset_seq extends pkt_bd_base_seq;
  `uvm_object_utils(pkt_bd_reset_seq)
  function new(string name = "pkt_bd_reset_seq");
    super.new(name);
  endfunction

  virtual task body();
    uvm_reg regs[$];
    wait_reset_done();
    regmodel.get_registers(regs);
    foreach (regs[i])
      peek_chk(regs[i], regs[i].get_reset(), {regs[i].get_name(), " reset value"});
  endtask
endclass

//Poke a value into the DUT, frontdoor read must return it
class pkt_bd_poke_seq extends pkt_bd_base_seq;
  `uvm_object_utils(pkt_bd_poke_seq)
  function new(string name = "pkt_bd_poke_seq");
    super.new(name);
  endfunction

  virtual task body();
    wait_reset_done();
    poke_rd_chk(regmodel.fwd_enable,   32'h5,     "fwd_enable");
    poke_rd_chk(regmodel.port_enable,  32'h6,     "port_enable");
    poke_rd_chk(regmodel.gen_interval, 32'h40,    "gen_interval");
    poke_rd_chk(regmodel.gen_count,    32'h20,    "gen_count");
    poke_rd_chk(regmodel.irq_enable,   32'h55,    "irq_enable");
    poke_rd_chk(regmodel.err_enable,   32'hAA,    "err_enable");
    poke_rd_chk(regmodel.gen_pkt_cfg,  32'h10206, "gen_pkt_cfg");
  endtask
endclass

//Frontdoor write, backdoor read: unlocked write must land in the DUT,
class pkt_bd_write_seq extends pkt_bd_base_seq;
  `uvm_object_utils(pkt_bd_write_seq)
  function new(string name = "pkt_bd_write_seq");
    super.new(name);
  endfunction

  virtual task body();
    wait_reset_done();
    //unlocked:DUT value must equal the written value
    unlock_bank();
    wr_peek_chk(regmodel.fwd_enable,   32'h5,     32'h5,     "fwd_enable unlocked");
    wr_peek_chk(regmodel.port_enable,  32'h6,     32'h6,     "port_enable unlocked");
    wr_peek_chk(regmodel.gen_interval, 32'h40,    32'h40,    "gen_interval unlocked");
    wr_peek_chk(regmodel.gen_count,    32'h20,    32'h20,    "gen_count unlocked");
    wr_peek_chk(regmodel.irq_enable,   32'h55,    32'h55,    "irq_enable unlocked");
    wr_peek_chk(regmodel.err_enable,   32'hAA,    32'hAA,    "err_enable unlocked");
    wr_peek_chk(regmodel.gen_pkt_cfg,  32'h10206, 32'h10206, "gen_pkt_cfg unlocked");
    wr_peek_chk(regmodel.irq_force,    32'h40,    32'h40,    "irq_force unlocked");
    //locked:DUT value must keep the previous value
    lock_bank();
    wr_peek_chk(regmodel.fwd_enable,   32'hA,     32'h5,     "fwd_enable locked");
    wr_peek_chk(regmodel.port_enable,  32'h9,     32'h6,     "port_enable locked");
    wr_peek_chk(regmodel.gen_interval, 32'h80,    32'h40,    "gen_interval locked");
    wr_peek_chk(regmodel.gen_count,    32'h10,    32'h20,    "gen_count locked");
    wr_peek_chk(regmodel.irq_enable,   32'hAA,    32'h55,    "irq_enable locked");
    wr_peek_chk(regmodel.err_enable,   32'h55,    32'hAA,    "err_enable locked");
    wr_peek_chk(regmodel.gen_pkt_cfg,  32'h20301, 32'h10206, "gen_pkt_cfg locked");
    wr_peek_chk(regmodel.irq_force,    32'h80,    32'h40,    "irq_force locked");
  endtask
endclass
