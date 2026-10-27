// Lockable   : SWITCH_CTRL, PORT_ENABLE, FWD_ENABLE, GEN_CTRL, GEN_PKT_CFG,GEN_INTERVAL, GEN_COUNT, IRQ_ENABLE, ERR_ENABLE
// NOT lockable (work while locked): IRQ_STATUS, IRQ_FORCE, ERR_STATUS,ERR_INJECT, SOFT_RESET

class pkt_csr_base_seq extends uvm_sequence;
  `uvm_object_utils(pkt_csr_base_seq)

  pkt_reg_block  regmodel;
  uvm_status_e   status;
  uvm_reg_data_t rdata;

  localparam bit [31:0] UNLOCK_KEY = 32'hA5A5C3C3;

  function new(string name = "pkt_csr_base_seq");
    super.new(name);
  endfunction

  virtual task pre_body();
    if (regmodel == null)
      `uvm_fatal("CSR_SEQ", $sformatf("regmodel handle is null in %s", get_type_name()))
  endtask

  function void chk(string id, uvm_reg_data_t got, uvm_reg_data_t exp, string what);
    if (got !== exp)
      `uvm_error(id, $sformatf("%s: expected 0x%08h, got 0x%08h", what, exp, got))
    else
      `uvm_info(id, $sformatf("%s: 0x%08h OK", what, got), UVM_MEDIUM)
  endfunction

  task unlock_bank();
    regmodel.lock.write(status, UNLOCK_KEY);
    regmodel.lock.read(status, rdata);
    if (rdata[0] !== 1'b0)
      `uvm_error("LOCK", $sformatf("unlock_bank: LOCKED expected 0, got %0b", rdata[0]))
  endtask

  task lock_bank();
    regmodel.lock.write(status, 32'h1);
    regmodel.lock.read(status, rdata);
    if (rdata[0] !== 1'b1)
      `uvm_error("LOCK", $sformatf("lock_bank: LOCKED expected 1, got %0b", rdata[0]))
  endtask
endclass

class apb_fwd_seq extends pkt_csr_base_seq;
  `uvm_object_utils(apb_fwd_seq)
  int unsigned vals[] = '{32'h0, 32'h5, 32'hFFFF_FFFA, 32'hF};

  function new(string name = "apb_fwd_seq");
    super.new(name);
  endfunction

  virtual task body();
    uvm_reg_data_t exp, old;

    exp = regmodel.fwd_enable.get_reset();
    regmodel.fwd_enable.read(status, rdata);
    if (rdata !== exp)
      `uvm_error(get_type_name(), $sformatf("Reset value: expected 0x%08h, got 0x%08h", exp, rdata))
    else
      `uvm_info(get_type_name(), $sformatf("Reset value: 0x%08h OK", rdata), UVM_MEDIUM)

    unlock_bank();
    foreach (vals[i]) begin
      regmodel.fwd_enable.write(status, vals[i]);
      exp = regmodel.fwd_enable.get_mirrored_value();
      regmodel.fwd_enable.read(status, rdata);
      if (rdata !== exp)
        `uvm_error(get_type_name(), $sformatf("Write 0x%08h: expected 0x%08h, got 0x%08h", vals[i], exp, rdata))
      else
        `uvm_info(get_type_name(), $sformatf("Write 0x%08h: 0x%08h OK", vals[i], rdata), UVM_MEDIUM)
    end

    lock_bank();
    old = regmodel.fwd_enable.get_mirrored_value();
    regmodel.fwd_enable.write(status, 32'h5);
    regmodel.fwd_enable.read(status, rdata);
    if (rdata !== old)
      `uvm_error(get_type_name(), $sformatf("Write while locked: expected 0x%08h, got 0x%08h", old, rdata))
    else
      `uvm_info(get_type_name(), $sformatf("Write while locked ignored: 0x%08h OK", rdata), UVM_MEDIUM)
  endtask
endclass

class port_enable_seq extends pkt_csr_base_seq;
  `uvm_object_utils(port_enable_seq)
  int unsigned vals[] = '{32'h0, 32'h5, 32'hFFFF_FFFA, 32'hF};

  function new(string name = "port_enable_seq");
    super.new(name);
  endfunction

  virtual task body();
    uvm_reg_data_t exp, old;

    exp = regmodel.port_enable.get_reset();
    regmodel.port_enable.read(status, rdata);
    if (rdata !== exp)
      `uvm_error(get_type_name(), $sformatf("Reset value: expected 0x%08h, got 0x%08h", exp, rdata))
    else
      `uvm_info(get_type_name(), $sformatf("Reset value: 0x%08h OK", rdata), UVM_MEDIUM)

    unlock_bank();
    foreach (vals[i]) begin
      regmodel.port_enable.write(status, vals[i]);
      exp = regmodel.port_enable.get_mirrored_value();
      regmodel.port_enable.read(status, rdata);
      if (rdata !== exp)
        `uvm_error(get_type_name(), $sformatf("Write 0x%08h: expected 0x%08h, got 0x%08h", vals[i], exp, rdata))
      else
        `uvm_info(get_type_name(), $sformatf("Write 0x%08h: 0x%08h OK", vals[i], rdata), UVM_MEDIUM)
    end

    lock_bank();
    old = regmodel.port_enable.get_mirrored_value();
    regmodel.port_enable.write(status, 32'h5);
    regmodel.port_enable.read(status, rdata);
    if (rdata !== old)
      `uvm_error(get_type_name(), $sformatf("Write while locked: expected 0x%08h, got 0x%08h", old, rdata))
    else
      `uvm_info(get_type_name(), $sformatf("Write while locked ignored: 0x%08h OK", rdata), UVM_MEDIUM)
  endtask
endclass

class switch_ctrl_seq extends pkt_csr_base_seq;
  `uvm_object_utils(switch_ctrl_seq)
  localparam bit [31:0] RD_MASK = 32'h0000_0009;
  int unsigned vals[] = '{32'h0, 32'h1,            // ENABLE bins
                          32'h0, 32'h2,            // STAT_CLEAR bins
                          32'h0, 32'h8,            // IRQ_GLOBAL_EN bins
                          32'hB, 32'h9, 32'hA,     // combinations
                          32'hFFFF_FFFF,           // reserved bits ignored
                          32'h0};

  function new(string name = "switch_ctrl_seq");
    super.new(name);
  endfunction

  virtual task body();
    uvm_reg_data_t exp, old;

    exp = regmodel.switch_ctrl.get_reset();
    regmodel.switch_ctrl.read(status, rdata);
    if (rdata !== exp)
      `uvm_error(get_type_name(), $sformatf("Reset value: expected 0x%08h, got 0x%08h", exp, rdata))
    else
      `uvm_info(get_type_name(), $sformatf("Reset value: 0x%08h OK", rdata), UVM_MEDIUM)

    unlock_bank();
    foreach (vals[i]) begin
      regmodel.switch_ctrl.write(status, vals[i]);
      exp = regmodel.switch_ctrl.get_mirrored_value() & RD_MASK;   // STAT_CLEAR always reads 0
      regmodel.switch_ctrl.read(status, rdata);
      if (rdata !== exp)
        `uvm_error(get_type_name(), $sformatf("Write 0x%08h: expected 0x%08h, got 0x%08h", vals[i], exp, rdata))
      else
        `uvm_info(get_type_name(), $sformatf("Write 0x%08h: 0x%08h OK", vals[i], rdata), UVM_MEDIUM)
    end

    lock_bank();
    old = regmodel.switch_ctrl.get_mirrored_value() & RD_MASK;
    regmodel.switch_ctrl.write(status, 32'hB);
    regmodel.switch_ctrl.read(status, rdata);
    if (rdata !== old)
      `uvm_error(get_type_name(), $sformatf("Write while locked: expected 0x%08h, got 0x%08h", old, rdata))
    else
      `uvm_info(get_type_name(), $sformatf("Write while locked ignored: 0x%08h OK", rdata), UVM_MEDIUM)
  endtask
endclass

class err_enable_seq extends pkt_csr_base_seq;
  `uvm_object_utils(err_enable_seq)
  int unsigned bits[] = '{32'h01, 32'h02, 32'h04, 32'h08, 32'h10, 32'h20, 32'h40, 32'h80};

  function new(string name = "err_enable_seq");
    super.new(name);
  endfunction

  virtual task body();
    uvm_reg_data_t exp, old;
    uvm_reg_data_t wval;

    exp = regmodel.err_enable.get_reset();
    regmodel.err_enable.read(status, rdata);
    if (rdata !== exp)
      `uvm_error(get_type_name(), $sformatf("Reset value: expected 0x%08h, got 0x%08h", exp, rdata))
    else
      `uvm_info(get_type_name(), $sformatf("Reset value: 0x%08h OK", rdata), UVM_MEDIUM)

    unlock_bank();
    foreach (bits[i]) begin
      regmodel.err_enable.write(status, 32'h0);
      exp = regmodel.err_enable.get_mirrored_value();
      regmodel.err_enable.read(status, rdata);
      if (rdata !== exp)
        `uvm_error(get_type_name(), $sformatf("bit %0d low: expected 0x%08h, got 0x%08h", i, exp, rdata))
      else
        `uvm_info(get_type_name(), $sformatf("bit %0d low: 0x%08h OK", i, rdata), UVM_MEDIUM)
      regmodel.err_enable.write(status, bits[i]);
      exp = regmodel.err_enable.get_mirrored_value();
      regmodel.err_enable.read(status, rdata);
      if (rdata !== exp)
        `uvm_error(get_type_name(), $sformatf("bit %0d high: expected 0x%08h, got 0x%08h", i, exp, rdata))
      else
        `uvm_info(get_type_name(), $sformatf("bit %0d high: 0x%08h OK", i, rdata), UVM_MEDIUM)
    end

    // all fields set; upper (reserved) bits written as 1 must be ignored
    wval = 32'hFFFF_FFFF;
    regmodel.err_enable.write(status, wval);
    exp = regmodel.err_enable.get_mirrored_value();
    regmodel.err_enable.read(status, rdata);
    if (rdata !== exp)
      `uvm_error(get_type_name(), $sformatf("All fields set: expected 0x%08h, got 0x%08h", exp, rdata))
    else
      `uvm_info(get_type_name(), $sformatf("All fields set: 0x%08h OK", rdata), UVM_MEDIUM)

    lock_bank();
    old = regmodel.err_enable.get_mirrored_value();
    regmodel.err_enable.write(status, 32'h0);
    regmodel.err_enable.read(status, rdata);
    if (rdata !== old)
      `uvm_error(get_type_name(), $sformatf("Write while locked: expected 0x%08h, got 0x%08h", old, rdata))
    else
      `uvm_info(get_type_name(), $sformatf("Write while locked ignored: 0x%08h OK", rdata), UVM_MEDIUM)
  endtask
endclass

class irq_enable_seq extends pkt_csr_base_seq;
  `uvm_object_utils(irq_enable_seq)
  // gen_done, error, overflow, pkt_drop, pkt_fwd, queue_af, start_ack, sw_event
  int unsigned bits[] = '{32'h01, 32'h02, 32'h04, 32'h08, 32'h10, 32'h20, 32'h40, 32'h80};

  function new(string name = "irq_enable_seq");
    super.new(name);
  endfunction

  virtual task body();
    uvm_reg_data_t exp, old;
    uvm_reg_data_t wval;

    exp = regmodel.irq_enable.get_reset();
    regmodel.irq_enable.read(status, rdata);
    if (rdata !== exp)
      `uvm_error(get_type_name(), $sformatf("Reset value: expected 0x%08h, got 0x%08h", exp, rdata))
    else
      `uvm_info(get_type_name(), $sformatf("Reset value: 0x%08h OK", rdata), UVM_MEDIUM)

    unlock_bank();
    foreach (bits[i]) begin
      regmodel.irq_enable.write(status, 32'h0);
      exp = regmodel.irq_enable.get_mirrored_value();
      regmodel.irq_enable.read(status, rdata);
      if (rdata !== exp)
        `uvm_error(get_type_name(), $sformatf("bit %0d low: expected 0x%08h, got 0x%08h", i, exp, rdata))
      else
        `uvm_info(get_type_name(), $sformatf("bit %0d low: 0x%08h OK", i, rdata), UVM_MEDIUM)

      regmodel.irq_enable.write(status, bits[i]);
      exp = regmodel.irq_enable.get_mirrored_value();
      regmodel.irq_enable.read(status, rdata);
      if (rdata !== exp)
        `uvm_error(get_type_name(), $sformatf("bit %0d high: expected 0x%08h, got 0x%08h", i, exp, rdata))
      else
        `uvm_info(get_type_name(), $sformatf("bit %0d high: 0x%08h OK", i, rdata), UVM_MEDIUM)
    end

    wval = 32'hFFFF_FFFF;
    regmodel.irq_enable.write(status, wval);
    exp = regmodel.irq_enable.get_mirrored_value();
    regmodel.irq_enable.read(status, rdata);
    if (rdata !== exp)
      `uvm_error(get_type_name(), $sformatf("All fields set: expected 0x%08h, got 0x%08h", exp, rdata))
    else
      `uvm_info(get_type_name(), $sformatf("All fields set: 0x%08h OK", rdata), UVM_MEDIUM)

    lock_bank();
    old = regmodel.irq_enable.get_mirrored_value();
    regmodel.irq_enable.write(status, 32'h0);
    regmodel.irq_enable.read(status, rdata);
    if (rdata !== old)
      `uvm_error(get_type_name(), $sformatf("Write while locked: expected 0x%08h, got 0x%08h", old, rdata))
    else
      `uvm_info(get_type_name(), $sformatf("Write while locked ignored: 0x%08h OK", rdata), UVM_MEDIUM)
  endtask
endclass

// GEN_CTRL  (spec: ENABLE[0] RW, START[1] WO pulse, STOP[2] WO pulse,
//            CONTINUOUS[3] RW)  => readable bits = 0x9
class gen_ctrl_seq extends pkt_csr_base_seq;
  `uvm_object_utils(gen_ctrl_seq)
  localparam bit [31:0] RD_MASK = 32'h0000_0009;
  int unsigned vals[] = '{32'h0, 32'h1,            // ENABLE bins
                          32'h0, 32'h2,            // START bins (ENABLE=0 -> not accepted)
                          32'h0, 32'h4,            // STOP bins
                          32'h0, 32'h8,            // CONTINUOUS bins
                          32'h9,                   // ENABLE + CONTINUOUS
                          32'hFFFF_FFF9};          // reserved bits ignored

  function new(string name = "gen_ctrl_seq");
    super.new(name);
  endfunction

  virtual task body();
    uvm_reg_data_t exp, old;

    exp = regmodel.gen_ctrl.get_reset();
    regmodel.gen_ctrl.read(status, rdata);
    if (rdata !== exp)
      `uvm_error(get_type_name(), $sformatf("Reset value: expected 0x%08h, got 0x%08h", exp, rdata))
    else
      `uvm_info(get_type_name(), $sformatf("Reset value: 0x%08h OK", rdata), UVM_MEDIUM)

    unlock_bank();
    foreach (vals[i]) begin
      regmodel.gen_ctrl.write(status, vals[i]);
      exp = regmodel.gen_ctrl.get_mirrored_value() & RD_MASK;       // START/STOP always read 0
      regmodel.gen_ctrl.read(status, rdata);
      if (rdata !== exp)
        `uvm_error(get_type_name(), $sformatf("Write 0x%08h: expected 0x%08h, got 0x%08h", vals[i], exp, rdata))
      else
        `uvm_info(get_type_name(), $sformatf("Write 0x%08h: 0x%08h OK", vals[i], rdata), UVM_MEDIUM)

      regmodel.gen_status.read(status, rdata);
      if ((rdata & 32'hF) !== 32'h0)
        `uvm_error(get_type_name(), $sformatf("Write 0x%08h: generator left IDLE, GEN_STATUS=0x%08h", vals[i], rdata))
    end

    lock_bank();
    old = regmodel.gen_ctrl.get_mirrored_value() & RD_MASK;
    regmodel.gen_ctrl.write(status, 32'h0);
    regmodel.gen_ctrl.read(status, rdata);
    if (rdata !== old)
      `uvm_error(get_type_name(), $sformatf("Write while locked: expected 0x%08h, got 0x%08h", old, rdata))
    else
      `uvm_info(get_type_name(), $sformatf("Write while locked ignored: 0x%08h OK", rdata), UVM_MEDIUM)

    unlock_bank();
    regmodel.gen_ctrl.write(status, 32'h0);
    lock_bank();
  endtask
endclass

class gen_pkt_cfg_seq extends pkt_csr_base_seq;
  `uvm_object_utils(gen_pkt_cfg_seq)
  int unsigned seed_bins[] = '{0, 65536, 131072, 196608, 262144, 327680, 458752, 524288, 589824, 655360, 720896};
  int unsigned len_bins[]  = '{0, 256, 512, 768, 1024, 1280, 1792, 2048, 2304, 2816, 3840, 3328, 1536};
  int unsigned src_bins[]  = '{0, 4, 8, 12};
  int unsigned dst_bins[]  = '{0, 1, 2, 3};

  function new(string name = "gen_pkt_cfg_seq");
    super.new(name);
  endfunction

  virtual task body();
    uvm_reg_data_t exp, old;
    int unsigned   all_bins[$];

    foreach (seed_bins[i]) all_bins.push_back(seed_bins[i]);
    foreach (len_bins[i])  all_bins.push_back(len_bins[i]);
    foreach (src_bins[i])  all_bins.push_back(src_bins[i]);
    foreach (dst_bins[i])  all_bins.push_back(dst_bins[i]);

    exp = regmodel.gen_pkt_cfg.get_reset();
    regmodel.gen_pkt_cfg.read(status, rdata);
    if (rdata !== exp)
      `uvm_error(get_type_name(), $sformatf("Reset value: expected 0x%08h, got 0x%08h", exp, rdata))
    else
      `uvm_info(get_type_name(), $sformatf("Reset value: 0x%08h OK", rdata), UVM_MEDIUM)

    unlock_bank();
    foreach (all_bins[i]) begin
      regmodel.gen_pkt_cfg.write(status, all_bins[i]);
      exp = regmodel.gen_pkt_cfg.get_mirrored_value();
      if (exp[15:8] == 8'd0)
        exp[15:8] = 8'd1;                       // LENGTH 0 is stored as 1
      regmodel.gen_pkt_cfg.read(status, rdata);
      if (rdata !== exp)
        `uvm_error(get_type_name(), $sformatf("Write 0x%08h: expected 0x%08h, got 0x%08h", all_bins[i], exp, rdata))
      else
        `uvm_info(get_type_name(), $sformatf("Write 0x%08h: 0x%08h OK", all_bins[i], rdata), UVM_MEDIUM)
    end

    // reserved bits [31:24] and [7:4] are RAZ/WI; LENGTH > 16 stays readable
    regmodel.gen_pkt_cfg.write(status, 32'hFFFF_FFFF);
    exp = regmodel.gen_pkt_cfg.get_mirrored_value();
    regmodel.gen_pkt_cfg.read(status, rdata);
    if (rdata !== exp)
      `uvm_error(get_type_name(), $sformatf("All ones: expected 0x%08h, got 0x%08h", exp, rdata))
    else
      `uvm_info(get_type_name(), $sformatf("All ones: 0x%08h OK", rdata), UVM_MEDIUM)

    lock_bank();
    old = regmodel.gen_pkt_cfg.get_mirrored_value();
    regmodel.gen_pkt_cfg.write(status, 32'h0);
    regmodel.gen_pkt_cfg.read(status, rdata);
    if (rdata !== old)
      `uvm_error(get_type_name(), $sformatf("Write while locked: expected 0x%08h, got 0x%08h", old, rdata))
    else
      `uvm_info(get_type_name(), $sformatf("Write while locked ignored: 0x%08h OK", rdata), UVM_MEDIUM)
  endtask
endclass

class gen_interval_seq extends pkt_csr_base_seq;
  `uvm_object_utils(gen_interval_seq)
  int unsigned vals[] = '{32'h0, 32'hFFFF_FFFF, 32'h100};

  function new(string name = "gen_interval_seq");
    super.new(name);
  endfunction

  virtual task body();
    uvm_reg_data_t exp, old;

    exp = regmodel.gen_interval.get_reset();
    regmodel.gen_interval.read(status, rdata);
    if (rdata !== exp)
      `uvm_error(get_type_name(), $sformatf("Reset value: expected 0x%08h, got 0x%08h", exp, rdata))
    else
      `uvm_info(get_type_name(), $sformatf("Reset value: 0x%08h OK", rdata), UVM_MEDIUM)

    unlock_bank();
    foreach (vals[i]) begin
      regmodel.gen_interval.write(status, vals[i]);
      exp = regmodel.gen_interval.get_mirrored_value();
      regmodel.gen_interval.read(status, rdata);
      if (rdata !== exp)
        `uvm_error(get_type_name(), $sformatf("Write 0x%08h: expected 0x%08h, got 0x%08h", vals[i], exp, rdata))
      else
        `uvm_info(get_type_name(), $sformatf("Write 0x%08h: 0x%08h OK", vals[i], rdata), UVM_MEDIUM)
    end

    lock_bank();
    old = regmodel.gen_interval.get_mirrored_value();
    regmodel.gen_interval.write(status, 32'h5);
    regmodel.gen_interval.read(status, rdata);
    if (rdata !== old)
      `uvm_error(get_type_name(), $sformatf("Write while locked: expected 0x%08h, got 0x%08h", old, rdata))
    else
      `uvm_info(get_type_name(), $sformatf("Write while locked ignored: 0x%08h OK", rdata), UVM_MEDIUM)
  endtask
endclass

class gen_count_seq extends pkt_csr_base_seq;
  `uvm_object_utils(gen_count_seq)
  int unsigned vals[] = '{32'h0, 32'hFFFF_FFFF, 32'h100};

  function new(string name = "gen_count_seq");
    super.new(name);
  endfunction

  virtual task body();
    uvm_reg_data_t exp, old;

    exp = regmodel.gen_count.get_reset();
    regmodel.gen_count.read(status, rdata);
    if (rdata !== exp)
      `uvm_error(get_type_name(), $sformatf("Reset value: expected 0x%08h, got 0x%08h", exp, rdata))
    else
      `uvm_info(get_type_name(), $sformatf("Reset value: 0x%08h OK", rdata), UVM_MEDIUM)

    unlock_bank();
    foreach (vals[i]) begin
      regmodel.gen_count.write(status, vals[i]);
      exp = regmodel.gen_count.get_mirrored_value();
      regmodel.gen_count.read(status, rdata);
      if (rdata !== exp)
        `uvm_error(get_type_name(), $sformatf("Write 0x%08h: expected 0x%08h, got 0x%08h", vals[i], exp, rdata))
      else
        `uvm_info(get_type_name(), $sformatf("Write 0x%08h: 0x%08h OK", vals[i], rdata), UVM_MEDIUM)
    end

    lock_bank();
    old = regmodel.gen_count.get_mirrored_value();
    regmodel.gen_count.write(status, 32'h5);
    regmodel.gen_count.read(status, rdata);
    if (rdata !== old)
      `uvm_error(get_type_name(), $sformatf("Write while locked: expected 0x%08h, got 0x%08h", old, rdata))
    else
      `uvm_info(get_type_name(), $sformatf("Write while locked ignored: 0x%08h OK", rdata), UVM_MEDIUM)
  endtask
endclass

class irq_status_seq extends pkt_csr_base_seq;
  `uvm_object_utils(irq_status_seq)
  function new(string name = "irq_status_seq");
    super.new(name);
  endfunction

  virtual task body();
    uvm_reg_data_t exp;

    exp = regmodel.irq_status.get_reset();
    regmodel.irq_status.read(status, rdata);
    if (rdata !== exp)
      `uvm_error(get_type_name(), $sformatf("Reset value: expected 0x%08h, got 0x%08h", exp, rdata))
    else
      `uvm_info(get_type_name(), $sformatf("Reset value: 0x%08h OK", rdata), UVM_MEDIUM)

    lock_bank();

    regmodel.irq_force.write(status, 32'h80);
    regmodel.irq_status.read(status, rdata);
    if (rdata[7] !== 1'b1)
      `uvm_error(get_type_name(), $sformatf("IRQ_FORCE[7] did not set IRQ_STATUS[7]: 0x%08h", rdata))
    else
      `uvm_info(get_type_name(), $sformatf("SW_EVENT set via IRQ_FORCE: 0x%08h OK", rdata), UVM_MEDIUM)

    regmodel.irq_status.write(status, 32'h0);
    regmodel.irq_status.read(status, rdata);
    if (rdata[7] !== 1'b1)
      `uvm_error(get_type_name(), $sformatf("W1C write 0 cleared SW_EVENT: 0x%08h", rdata))
    else
      `uvm_info(get_type_name(), $sformatf("W1C write 0 leaves SW_EVENT: 0x%08h OK", rdata), UVM_MEDIUM)

    regmodel.irq_status.write(status, 32'h80);
    regmodel.irq_status.read(status, rdata);
    if (rdata[7] !== 1'b0)
      `uvm_error(get_type_name(), $sformatf("W1C write 0x80 did not clear SW_EVENT: 0x%08h", rdata))
    else
      `uvm_info(get_type_name(), $sformatf("W1C clear SW_EVENT while locked: 0x%08h OK", rdata), UVM_MEDIUM)

    regmodel.irq_force.write(status, 32'hC0);
    regmodel.irq_status.read(status, rdata);
    if (rdata[7:6] !== 2'b11)
      `uvm_error(get_type_name(), $sformatf("Force 0xC0: expected bits 7:6 set, got 0x%08h", rdata))
    regmodel.irq_status.write(status, 32'h40);
    regmodel.irq_status.read(status, rdata);
    if (rdata[7:6] !== 2'b10)
      `uvm_error(get_type_name(), $sformatf("W1C 0x40: expected bits 7:6 = 10, got 0x%08h", rdata))
    else
      `uvm_info(get_type_name(), $sformatf("W1C clears only written bit: 0x%08h OK", rdata), UVM_MEDIUM)
    regmodel.irq_status.write(status, 32'h80);
    regmodel.irq_status.read(status, rdata);
    if (rdata[7:6] !== 2'b00)
      `uvm_error(get_type_name(), $sformatf("Final clear: expected bits 7:6 = 00, got 0x%08h", rdata))
  endtask
endclass

class irq_force_seq extends pkt_csr_base_seq;
  `uvm_object_utils(irq_force_seq)
  function new(string name = "irq_force_seq");
    super.new(name);
  endfunction

  virtual task body();
    uvm_reg_data_t exp;

    exp = regmodel.irq_force.get_reset();
    regmodel.irq_force.read(status, rdata);
    if (rdata !== exp)
      `uvm_error(get_type_name(), $sformatf("Reset value: expected 0x%08h, got 0x%08h", exp, rdata))
    else
      `uvm_info(get_type_name(), $sformatf("Reset value: 0x%08h OK", rdata), UVM_MEDIUM)

    lock_bank();   // IRQ_FORCE must work while locked
    for (int i = 0; i < 8; i++) begin
      regmodel.irq_force.write(status, 32'h1 << i);

      regmodel.irq_force.read(status, rdata);
      if (rdata !== 32'h0)
        `uvm_error(get_type_name(), $sformatf("bit %0d: IRQ_FORCE read expected 0, got 0x%08h", i, rdata))

      regmodel.irq_status.read(status, rdata);
      if (rdata[i] !== 1'b1)
        `uvm_error(get_type_name(), $sformatf("bit %0d: IRQ_STATUS bit not set, got 0x%08h", i, rdata))
      else
        `uvm_info(get_type_name(), $sformatf("bit %0d: forced status bit set, 0x%08h OK", i, rdata), UVM_MEDIUM)

      regmodel.irq_status.write(status, 32'h1 << i);
      regmodel.irq_status.read(status, rdata);
      if (i != 1 && rdata[i] !== 1'b0)
        `uvm_error(get_type_name(), $sformatf("bit %0d: IRQ_STATUS bit not cleared, got 0x%08h", i, rdata))
    end
  endtask
endclass

class err_inject_count_seq extends pkt_csr_base_seq;
  `uvm_object_utils(err_inject_count_seq)

  function new(string name = "err_inject_count_seq");
    super.new(name);
  endfunction

  virtual task body();
    uvm_reg_data_t exp;
    uvm_reg_data_t inj;
    int unsigned   exp_cnt;

    exp = regmodel.err_inject.get_reset();
    regmodel.err_inject.read(status, rdata);
    if (rdata !== exp)
      `uvm_error(get_type_name(), $sformatf("ERR_INJECT reset: expected 0x%08h, got 0x%08h", exp, rdata))
    else
      `uvm_info(get_type_name(), $sformatf("ERR_INJECT reset: 0x%08h OK", rdata), UVM_MEDIUM)

    exp = regmodel.err_count.get_reset();
    regmodel.err_count.read(status, rdata);
    if (rdata !== exp)
      `uvm_error(get_type_name(), $sformatf("ERR_COUNT reset: expected 0x%08h, got 0x%08h", exp, rdata))
    else
      `uvm_info(get_type_name(), $sformatf("ERR_COUNT reset: 0x%08h OK", rdata), UVM_MEDIUM)

    lock_bank();   // ERR_INJECT is not lockable: everything below runs locked

    regmodel.err_inject.write(status, 32'h8000_0000);
    regmodel.err_count.read(status, rdata);
    if (rdata !== 32'h0)
      `uvm_error(get_type_name(), $sformatf("ERR_COUNT after CLEAR_COUNT: expected 0, got 0x%08h", rdata))
    regmodel.err_info.read(status, rdata);
    if (rdata !== 32'h0)
      `uvm_error(get_type_name(), $sformatf("ERR_INFO after CLEAR_COUNT: expected 0, got 0x%08h", rdata))
    exp_cnt = 0;

    for (int i = 0; i < 8; i++) begin
      regmodel.err_inject.write(status, 32'h0);          // bin 0 (no event)
      inj = 32'h1 << i;
      regmodel.err_inject.write(status, inj);
      exp_cnt += 1;

      regmodel.err_inject.read(status, rdata);           // WO: reads 0
      if (rdata !== 32'h0)
        `uvm_error(get_type_name(), $sformatf("bit %0d: ERR_INJECT read expected 0, got 0x%08h", i, rdata))

      regmodel.err_count.read(status, rdata);
      if (rdata !== exp_cnt)
        `uvm_error(get_type_name(), $sformatf("bit %0d: ERR_COUNT expected %0d, got %0d", i, exp_cnt, rdata))
      else
        `uvm_info(get_type_name(), $sformatf("bit %0d: ERR_COUNT %0d OK", i, rdata), UVM_MEDIUM)

      exp = (32'h1 << 8) | i;                            // SOURCE=1, LAST_CODE=i
      regmodel.err_info.read(status, rdata);
      if ((rdata & 32'hFFFF) !== exp)
        `uvm_error(get_type_name(), $sformatf("bit %0d: ERR_INFO[15:0] expected 0x%04h, got 0x%08h", i, exp[15:0], rdata))
      else
        `uvm_info(get_type_name(), $sformatf("bit %0d: ERR_INFO 0x%08h OK", i, rdata), UVM_MEDIUM)
    end

    inj = 32'h0F;
    regmodel.err_inject.write(status, inj);
    exp_cnt += $countones(inj & 32'h7F);
    regmodel.err_count.read(status, rdata);
    if (rdata !== exp_cnt)
      `uvm_error(get_type_name(), $sformatf("4-bit inject: ERR_COUNT expected %0d, got %0d", exp_cnt, rdata))
    else
      `uvm_info(get_type_name(), $sformatf("4-bit inject: ERR_COUNT %0d OK", rdata), UVM_MEDIUM)
    regmodel.err_info.read(status, rdata);
    if ((rdata & 32'hFFFF) !== 32'h0100)
      `uvm_error(get_type_name(), $sformatf("4-bit inject: ERR_INFO[15:0] expected 0x0100, got 0x%08h", rdata))

    regmodel.err_inject.write(status, 32'h8000_0003);
    regmodel.err_count.read(status, rdata);
    if (rdata !== 32'h0)
      `uvm_error(get_type_name(), $sformatf("CLEAR_COUNT+inject: ERR_COUNT expected 0, got 0x%08h", rdata))
    regmodel.err_info.read(status, rdata);
    if (rdata !== 32'h0)
      `uvm_error(get_type_name(), $sformatf("CLEAR_COUNT+inject: ERR_INFO expected 0, got 0x%08h", rdata))
    else
      `uvm_info(get_type_name(), "CLEAR_COUNT priority over injection OK", UVM_MEDIUM)

    regmodel.err_status.write(status, 32'hFF);
  endtask
endclass

class status_regs_seq extends pkt_csr_base_seq;
  `uvm_object_utils(status_regs_seq)
  function new(string name = "status_regs_seq");
    super.new(name);
  endfunction

  virtual task body();
    uvm_reg_data_t exp;
    uvm_reg_data_t sw, gs, ps, es, lk;
    uvm_reg_data_t pe_m, sc_m;   // mirror snapshots (VCS: no bit-select on a function call)

    `uvm_info(get_type_name(), "Reading all RO registers", UVM_LOW)

    exp = regmodel.device_id.get_reset();
    regmodel.device_id.read(status, rdata);
    if (rdata !== exp)
      `uvm_error(get_type_name(), $sformatf("DEVICE_ID: expected 0x%08h, got 0x%08h", exp, rdata))
    else
      `uvm_info(get_type_name(), $sformatf("DEVICE_ID: 0x%08h OK", rdata), UVM_LOW)

    exp = regmodel.version.get_reset();
    regmodel.version.read(status, rdata);
    if (rdata !== exp)
      `uvm_error(get_type_name(), $sformatf("VERSION: expected 0x%08h, got 0x%08h", exp, rdata))
    else
      `uvm_info(get_type_name(), $sformatf("VERSION: 0x%08h OK", rdata), UVM_LOW)

    regmodel.lock.read(status, lk);
    regmodel.err_status.read(status, es);
    regmodel.switch_status.read(status, sw);
    `uvm_info(get_type_name(), $sformatf("Switch Status: 0x%08h", sw), UVM_LOW)
    if (sw[31:18] !== 14'h0 || sw[15:10] !== 6'h0)
      `uvm_error(get_type_name(), $sformatf("SWITCH_STATUS reserved bits not zero: 0x%08h", sw))
    if (sw[3] !== lk[0])
      `uvm_error(get_type_name(), $sformatf("SWITCH_STATUS.LOCKED=%0b but LOCK reads %0b", sw[3], lk[0]))
    pe_m = regmodel.port_enable.get_mirrored_value();
    sc_m = regmodel.switch_ctrl.get_mirrored_value();
    if (sw[7:4] !== pe_m[3:0])
      `uvm_error(get_type_name(), $sformatf("SWITCH_STATUS.PORT_ENABLED=0x%0h, PORT_ENABLE mirror=0x%0h",
                                           sw[7:4], pe_m[3:0]))
    if (sw[2] !== sc_m[0])
      `uvm_error(get_type_name(), $sformatf("SWITCH_STATUS.SWITCH_ENABLED=%0b, SWITCH_CTRL.ENABLE mirror=%0b",
                                           sw[2], sc_m[0]))
    if (sw[9] !== (|es[7:0]))
      `uvm_error(get_type_name(), $sformatf("SWITCH_STATUS.ERR_PENDING=%0b but ERR_STATUS=0x%08h", sw[9], es))
    if (sw[8] !== (sw[17:16] == 2'd1 || sw[17:16] == 2'd2))
      `uvm_error(get_type_name(), $sformatf("SWITCH_STATUS.GEN_RUNNING=%0b inconsistent with GEN_FSM=%0d", sw[8], sw[17:16]))
    if (sw[0] !== ~sw[8])
      `uvm_error(get_type_name(), $sformatf("SWITCH_STATUS.READY=%0b inconsistent with GEN_RUNNING=%0b", sw[0], sw[8]))

    regmodel.port_status.read(status, ps);
    `uvm_info(get_type_name(), $sformatf("Port Status: 0x%08h", ps), UVM_LOW)
    if (ps[7:0] > 16 || ps[15:8] > 16 || ps[23:16] > 16 || ps[31:24] > 16)
      `uvm_error(get_type_name(), $sformatf("PORT_STATUS queue level above 16: 0x%08h", ps))

    regmodel.gen_status.read(status, gs);
    `uvm_info(get_type_name(), $sformatf("Gen Status: 0x%08h", gs), UVM_LOW)
    if (gs[31:24] !== 8'h0 || gs[7:4] !== 4'h0)
      `uvm_error(get_type_name(), $sformatf("GEN_STATUS reserved bits not zero: 0x%08h", gs))
    if (gs[1] !== (gs[3:2] == 2'd3))
      `uvm_error(get_type_name(), $sformatf("GEN_STATUS.DONE=%0b inconsistent with FSM=%0d", gs[1], gs[3:2]))
    if (gs[0] !== (gs[3:2] == 2'd1 || gs[3:2] == 2'd2))
      `uvm_error(get_type_name(), $sformatf("GEN_STATUS.RUNNING=%0b inconsistent with FSM=%0d", gs[0], gs[3:2]))

    regmodel.stat_rx.read(status, rdata);
    `uvm_info(get_type_name(), $sformatf("Stat Rx Count: %0d", rdata), UVM_LOW)
    if (rdata[31:16] !== 16'h0)
      `uvm_error(get_type_name(), $sformatf("STAT_RX reserved bits not zero: 0x%08h", rdata))
    regmodel.stat_tx.read(status, rdata);
    `uvm_info(get_type_name(), $sformatf("Stat Tx Count: %0d", rdata), UVM_LOW)
    if (rdata[31:16] !== 16'h0)
      `uvm_error(get_type_name(), $sformatf("STAT_TX reserved bits not zero: 0x%08h", rdata))
    regmodel.stat_drop.read(status, rdata);
    `uvm_info(get_type_name(), $sformatf("Stat Drop Count: %0d", rdata), UVM_LOW)
    if (rdata[31:16] !== 16'h0)
      `uvm_error(get_type_name(), $sformatf("STAT_DROP reserved bits not zero: 0x%08h", rdata))
  endtask
endclass

class err_info_seq extends pkt_csr_base_seq;
  `uvm_object_utils(err_info_seq)
  function new(string name = "err_info_seq");
    super.new(name);
  endfunction

  virtual task body();
    regmodel.err_info.read(status, rdata);
    `uvm_info(get_type_name(), $sformatf("ERR_INFO read: 0x%08h", rdata), UVM_LOW)
    if (rdata[19:18] !== 2'b00)
      `uvm_error(get_type_name(), $sformatf("ERR_INFO reserved bits [19:18] not zero: 0x%08h", rdata))
    if (rdata[15:8] > 8'd1)
      `uvm_error(get_type_name(), $sformatf("ERR_INFO.SOURCE must be 0 or 1: 0x%08h", rdata))
    if (rdata[7:0] > 8'd7)
      `uvm_error(get_type_name(), $sformatf("ERR_INFO.LAST_CODE must be 0..7: 0x%08h", rdata))
  endtask
endclass

class soft_reset_seq extends pkt_csr_base_seq;
  `uvm_object_utils(soft_reset_seq)
  function new(string name = "soft_reset_seq");
    super.new(name);
  endfunction

  virtual task body();
    uvm_reg_data_t exp;
    uvm_reg regs[$];

    unlock_bank();
    regmodel.switch_ctrl.write(status, 32'h9);
    regmodel.port_enable.write(status, 32'h5);
    regmodel.fwd_enable.write(status, 32'h5);
    regmodel.gen_pkt_cfg.write(status, 32'h00AB_0C0B);
    regmodel.gen_interval.write(status, 32'h100);
    regmodel.gen_count.write(status, 32'h100);
    regmodel.irq_enable.write(status, 32'hFF);
    regmodel.err_enable.write(status, 32'hFF);
    lock_bank();    // SOFT_RESET must work while locked

    regmodel.soft_reset.write(status, 32'h0);
    regmodel.soft_reset.write(status, 32'h2);
    exp = regmodel.port_enable.get_mirrored_value();
    regmodel.port_enable.read(status, rdata);
    if (rdata !== exp)
      `uvm_error(get_type_name(), $sformatf("PULSE=0 write changed PORT_ENABLE: expected 0x%08h, got 0x%08h", exp, rdata))
    else
      `uvm_info(get_type_name(), "PULSE=0 writes have no effect OK", UVM_LOW)

    regmodel.soft_reset.write(status, 32'h1);
    `uvm_info(get_type_name(), "Soft reset pulse applied", UVM_LOW)

    regmodel.soft_reset.read(status, rdata);
    if (rdata !== 32'h0)
      `uvm_error(get_type_name(), $sformatf("SOFT_RESET read expected 0, got 0x%08h", rdata))

    regmodel.lock.read(status, rdata);
    if (rdata[0] !== 1'b1)
      `uvm_error(get_type_name(), $sformatf("LOCKED expected 1 after soft reset, got %0b", rdata[0]))

    regs = '{regmodel.switch_ctrl, regmodel.port_enable, regmodel.fwd_enable,
             regmodel.gen_ctrl,    regmodel.gen_pkt_cfg, regmodel.gen_interval,
             regmodel.gen_count,   regmodel.irq_status,  regmodel.irq_enable,
             regmodel.err_status,  regmodel.err_enable,  regmodel.err_count,
             regmodel.err_info};
    foreach (regs[i]) begin
      exp = regs[i].get_reset();
      regs[i].read(status, rdata);
      if (rdata !== exp)
        `uvm_error(get_type_name(), $sformatf("%s after soft reset: expected 0x%08h, got 0x%08h",
                                             regs[i].get_name(), exp, rdata))
      else
        `uvm_info(get_type_name(), $sformatf("%s after soft reset: 0x%08h OK", regs[i].get_name(), rdata), UVM_MEDIUM)
    end
  endtask
endclass

class err_status_seq extends pkt_csr_base_seq;
  `uvm_object_utils(err_status_seq)
  function new(string name = "err_status_seq");
    super.new(name);
  endfunction

  virtual task body();
    uvm_reg_data_t exp;
    uvm_reg_data_t m;

    exp = regmodel.err_status.get_reset();
    regmodel.err_status.read(status, rdata);
    if (rdata !== exp)
      `uvm_error(get_type_name(), $sformatf("Reset value: expected 0x%08h, got 0x%08h", exp, rdata))
    else
      `uvm_info(get_type_name(), $sformatf("Reset value: 0x%08h OK", rdata), UVM_MEDIUM)

    lock_bank();

    for (int i = 0; i < 7; i++) begin
      m = (32'h1 << i) | 32'h80;                       // bit i + INJECTED

      regmodel.err_inject.write(status, 32'h1 << i);
      regmodel.err_status.read(status, rdata);
      if ((rdata & m) !== m)
        `uvm_error(get_type_name(), $sformatf("bit %0d: inject should set mask 0x%02h, ERR_STATUS=0x%08h", i, m[7:0], rdata))
      else
        `uvm_info(get_type_name(), $sformatf("bit %0d: ERR_STATUS 0x%08h OK", i, rdata), UVM_MEDIUM)

      regmodel.err_status.write(status, 32'h1 << i);
      regmodel.err_status.read(status, rdata);
      if (rdata[i] !== 1'b0 || rdata[7] !== 1'b1)
        `uvm_error(get_type_name(), $sformatf("bit %0d: W1C should clear only bit %0d, ERR_STATUS=0x%08h", i, i, rdata))

      regmodel.err_status.write(status, 32'h80);
      regmodel.err_status.read(status, rdata);
      if (rdata[7] !== 1'b0)
        `uvm_error(get_type_name(), $sformatf("bit %0d: INJECTED not cleared, ERR_STATUS=0x%08h", i, rdata))
    end

    regmodel.err_inject.write(status, 32'h80);
    regmodel.err_status.read(status, rdata);
    if (rdata[7] !== 1'b1)
      `uvm_error(get_type_name(), $sformatf("bit 7 inject: INJECTED not set, ERR_STATUS=0x%08h", rdata))
    regmodel.err_status.write(status, 32'h80);
    regmodel.err_status.read(status, rdata);
    if (rdata[7] !== 1'b0)
      `uvm_error(get_type_name(), $sformatf("bit 7 clear: INJECTED not cleared, ERR_STATUS=0x%08h", rdata))
    else
      `uvm_info(get_type_name(), "INJECTED set/clear OK", UVM_MEDIUM)
  endtask
endclass
