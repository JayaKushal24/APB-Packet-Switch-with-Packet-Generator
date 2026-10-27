package package_ral_pkt;
  import uvm_pkg::*;
  `include "uvm_macros.svh"

  //individual register class files
  `include "Registers/reg_1_device_rd.sv"
  `include "Registers/reg_2_version.sv"
  `include "Registers/reg_3_switch_status.sv"
  `include "Registers/reg_4_port_status.sv"
  `include "Registers/reg_5_gen_status.sv"
  `include "Registers/reg_6_stat_rx.sv"
  `include "Registers/reg_7_stat_tx.sv"
  `include "Registers/reg_8_stat_srop.sv"
  `include "Registers/reg_9_switch_ctrl.sv"
  `include "Registers/reg_10_port_enable.sv"
  `include "Registers/reg_11_fwd_enable.sv"
  `include "Registers/reg_12_gen_ctrl.sv"
  `include "Registers/reg_13_gen_pkt_cfg.sv"
  `include "Registers/reg_14_gen_interval.sv"
  `include "Registers/reg_15_gen_count.sv"
  `include "Registers/reg_16_irq_status.sv"
  `include "Registers/reg_17_irq_enable.sv"
  `include "Registers/reg_18_irq_force.sv"
  `include "Registers/reg_19_err_status.sv"
  `include "Registers/reg_20_err_enable.sv"
  `include "Registers/reg_21_err_inject.sv"
  `include "Registers/reg_22_err_count.sv"
  `include "Registers/reg_23_err_info.sv"
  `include "Registers/reg_24_lock.sv"
  `include "Registers/reg_25_soft_reset.sv"

  //main register block class
  `include "Registers/pkt_reg_block.sv"

endpackage
