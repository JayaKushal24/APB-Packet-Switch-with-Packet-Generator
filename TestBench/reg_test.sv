//import uvm_pkg::*;
`include "uvm_macros.svh"

//import package_ral_pkt::*;
//import package_ral_seq::*;

class reg_test extends uvm_test;
  `uvm_component_utils(reg_test)
  apb_env env;
  function new(string name="reg_test", uvm_component parent=null);
    super.new(name, parent);
  endfunction
  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    env = apb_env::type_id::create("env", this);
  endfunction

  virtual task run_phase(uvm_phase phase);
    pkt_csr_lock_seq lock_seq;
    phase.raise_objection(this);
      `uvm_info("REG_TEST", "Starting CSR Lock Verification Sequence...", UVM_LOW)
      lock_seq=pkt_csr_lock_seq::type_id::create("lock_seq");
      lock_seq.regmodel=env.regmodel;
      lock_seq.start(env.apb_agnt.sequencer);
    phase.drop_objection(this);
  endtask
endclass
