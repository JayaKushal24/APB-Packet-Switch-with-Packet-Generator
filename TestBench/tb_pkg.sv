package tb_pkg;
  import uvm_pkg::*;
  `include "uvm_macros.svh"

  import package_ral_pkt::*;
  import package_ral_seq::*;

  // Component classes (in dependency order)
  `include "apb_seq_item.sv"
  `include "apb_seqr.sv"
  `include "apb_drv.sv"
  `include "apb_mon.sv"
  `include "apb_reg_adapter.sv"
  `include "apb_agent.sv"
  `include "apb_env.sv"      // <--- Must come BEFORE reg_test.sv

  // Test classes
  `include "reg_test.sv"     // <--- Uses apb_env

endpackage
