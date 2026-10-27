class apb_ral_test extends uvm_test;
  `uvm_component_utils(apb_ral_test)
  apb_env env;

  function new(string name = "apb_ral_test", uvm_component parent = null);
    super.new(name, parent);
  endfunction

  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    env = apb_env::type_id::create("env", this);
  endfunction

  virtual function void end_of_elaboration_phase(uvm_phase phase);
    super.end_of_elaboration_phase(phase);
    uvm_top.print_topology();
  endfunction
endclass

`define PKT_CSR_TEST(TNAME, SEQ) \
class TNAME extends apb_ral_test; \
  `uvm_component_utils(TNAME) \
  function new(string name = `"TNAME`", uvm_component parent = null); \
    super.new(name, parent); \
  endfunction \
  virtual task run_phase(uvm_phase phase); \
    SEQ seq; \
    phase.raise_objection(this); \
    seq = SEQ::type_id::create("seq"); \
    seq.regmodel = env.regmodel; \
    seq.start(env.apb_agnt.sequencer); \
    phase.phase_done.set_drain_time(this, 20ns); \
    phase.drop_objection(this); \
  endtask \
endclass

`PKT_CSR_TEST(apb_fwd_test,          apb_fwd_seq)
`PKT_CSR_TEST(apb_port_en_test,      port_enable_seq)
`PKT_CSR_TEST(apb_switch_ctrl_test,  switch_ctrl_seq)
`PKT_CSR_TEST(apb_err_en_test,       err_enable_seq)
`PKT_CSR_TEST(apb_irq_en_test,       irq_enable_seq)
`PKT_CSR_TEST(apb_gen_ctrl_test,     gen_ctrl_seq)
`PKT_CSR_TEST(apb_gen_pkt_test,      gen_pkt_cfg_seq)
`PKT_CSR_TEST(apb_gen_int_test,      gen_interval_seq)
`PKT_CSR_TEST(apb_gen_count_test,    gen_count_seq)
`PKT_CSR_TEST(apb_irq_status_test,   irq_status_seq)
`PKT_CSR_TEST(apb_irq_force_test,    irq_force_seq)
`PKT_CSR_TEST(apb_err_inject_test,   err_inject_count_seq)
`PKT_CSR_TEST(apb_status_reg_test,   status_regs_seq)
`PKT_CSR_TEST(apb_err_info_test,     err_info_seq)
`PKT_CSR_TEST(apb_soft_reset_test,   soft_reset_seq)
`PKT_CSR_TEST(apb_err_status_test,   err_status_seq)
