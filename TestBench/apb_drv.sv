class apb_driver extends uvm_driver #(apb_seq_item);
    `uvm_component_utils(apb_driver)
    virtual apb_if vif;

    function new(string name = "apb_driver", uvm_component parent = null);
        super.new(name, parent);
    endfunction

    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        if (!uvm_config_db#(virtual apb_if)::get(this, "", "vif", vif)) begin
            `uvm_fatal("DRV_NO_VIF", "Virtual interface 'vif' not found in uvm_config_db!")
        end
    endfunction

    virtual task run_phase(uvm_phase phase);
        vif.psel    <= 1'b0;
        vif.penable <= 1'b0;
        vif.pwrite  <= 1'b0;
        vif.paddr   <= '0;
        vif.pwdata  <= '0;
        wait (vif.presetn === 1'b1);
        `uvm_info("APB_DRV", "Reset released. APB Driver active.", UVM_MEDIUM)
        forever begin
            seq_item_port.get_next_item(req);
            drive_transfer(req);
            seq_item_port.item_done();
        end
    endtask

    virtual task drive_transfer(apb_seq_item item);
        @(posedge vif.pclk);
        vif.psel    <= 1'b1;
        vif.penable <= 1'b0;
        vif.pwrite  <= item.pwrite;
        vif.paddr   <= item.paddr;
        vif.pwdata <= item.pwdata;
        
        @(posedge vif.pclk);
        vif.penable <= 1'b1;

        do begin
            @(posedge vif.pclk);
        end while (vif.pready === 1'b0);

        vif.psel<=1'b0;
        vif.penable<=1'b0;
        vif.pwrite<=1'b0;
endtask
endclass