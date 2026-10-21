class apb_monitor extends uvm_component;
    `uvm_component_utils(apb_monitor)
    virtual apb_if vif;
    uvm_analysis_port #(apb_seq_item) ap;
    function new(string name="apb_monitor",uvm_component parent=null);
        super.new(name, parent);
        ap=new("ap", this);
    endfunction

    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        if (!uvm_config_db#(virtual apb_if)::get(this, "", "vif", vif)) begin
            `uvm_fatal("MON_NO_VIF", "Virtual interface 'vif' not found in uvm_config_db!")
        end
    endfunction

    virtual task run_phase(uvm_phase phase);
        apb_seq_item item;
        wait (vif.presetn === 1'b1);
        forever begin
            @(posedge vif.pclk);
            if (vif.psel===1'b1 && vif.penable===1'b1 && vif.pready===1'b1) begin
            item=apb_seq_item::type_id::create("item");
            item.paddr=vif.paddr;
            item.pwrite=vif.pwrite;
            item.pwdata=vif.pwdata;
            item.psel=vif.psel;
            item.penable=vif.penable;
            item.prdata=vif.prdata;
            item.pslverr=vif.pslverr;
            item.pready=vif.pready;
            item.irq=vif.irq;
            `uvm_info("APB_MON", 
            $sformatf("PADDR: 0x%04X, PWRITE:%0b,PWDATA:0x%08X, PSEL: %0b, PENABLE: %0b | PRDATA: 0x%08X, PSLVERR: %0b, PREADY: %0b, IRQ: %0b", item.paddr, item.pwrite, item.pwdata, item.psel, item.penable, item.prdata, item.pslverr, item.pready, item.irq),
            UVM_MEDIUM)
            ap.write(item);
        end
        end
    endtask
endclass