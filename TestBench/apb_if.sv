interface apb_if(input bit pclk,input bit presetn);
    logic psel;
    logic penable;
    logic pwrite;
    logic[15:0]paddr;
    logic[31:0]pwdata;
    logic[31:0]prdata;
    logic pslverr;
    logic pready;
    logic irq;

    clocking drv_cb@(posedge pclk);
        default input #1 output #1;
        output psel,penable,pwrite,pwdata,paddr;
        input prdata,pready,pslverr;
    endclocking

    clocking mon_cb@(posedge pclk);
        default input #1 output #1;
        input psel,penable,pwrite,pwdata,paddr,prdata,pslverr,pready,irq;
    endclocking

    modport drv(clocking drv_cb,input pclk,presetn);
    modport mon(clocking mon_cb,input pclk,presetn);
endinterface
