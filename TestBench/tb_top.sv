`timescale 1ns/1ps
import uvm_pkg::*;
import tb_pkg::*; // Import master testbench package
`include "uvm_macros.svh"
module tb_top;
  logic pclk;
  logic presetn;

  initial begin
    pclk=0;
    forever #5 pclk = ~pclk;
  end

  initial begin
    presetn=0;
    repeat (3) @(posedge pclk);
    presetn=1;
  end

  apb_if vif(pclk, presetn);

  apb_pkt_switch dut (
    .pclk(vif.pclk),.presetn(vif.presetn),
    .psel(vif.psel),.penable(vif.penable),
    .pwrite(vif.pwrite),.paddr(vif.paddr),.pwdata(vif.pwdata),
    .prdata(vif.prdata),.pready(vif.pready),.pslverr(vif.pslverr),.irq(vif.irq)
    );

  initial begin
    uvm_config_db#(virtual apb_if)::set(null,"*","vif",vif);
    run_test();
  end
endmodule
