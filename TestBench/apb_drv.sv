class apb_driver extends uvm_driver #(apb_seq_item);
    `uvm_component_utils(apb_driver)
    virtual apb_if vif;
    function new(string name = "apb_driver", uvm_component parent = null);
        super.new(name, parent);
    endfunction

    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        if (!uvm_config_db#(virtual apb_if)::get(this,"","vif",vif)) 
        begin
            `uvm_fatal("DRV","NO_VIF")
        end
    endfunction

    virtual task run_phase(uvm_phase phase);
        wait(vif.presetn===1'b0);
        vif.drv_cb.psel<=1'b0;
        vif.drv_cb.penable<=1'b0;
        vif.drv_cb.pwrite<=1'b0;
        vif.drv_cb.paddr<='0;
        vif.drv_cb.pwdata<='0;
        wait(vif.presetn===1'b1);
        `uvm_info("APB_DRV","reset released",UVM_MEDIUM)
        forever begin
            seq_item_port.get_next_item(req);
            drive_transfer(req);
            seq_item_port.item_done();
        end
    endtask

    virtual task drive_transfer(apb_seq_item item);
        @(vif.drv_cb);
        vif.drv_cb.psel<=1'b1;//set up state
        vif.drv_cb.penable<=1'b0;
        vif.drv_cb.pwrite<=item.pwrite;
        vif.drv_cb.paddr<=item.paddr;
        vif.drv_cb.pwdata<=item.pwdata;
        
        @(posedge vif.pclk);
        vif.drv_cb.penable<=1'b1;//access state

        do begin
            @(posedge vif.pclk);
        end while (vif.drv_cb.pready===1'b0);

        vif.drv_cb.psel<=1'b0;
        vif.drv_cb.penable<=1'b0;
endtask
endclass
