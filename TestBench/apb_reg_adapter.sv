class apb_reg_adapter extends uvm_reg_adapter;
    `uvm_object_utils(apb_reg_adapter)

    function new(string name="apb_reg_adapter");
        super.new(name);
    endfunction

    virtual function uvm_sequence_item reg2bus(const ref uvm_reg_bus_op rw);
        apb_seq_item tr;
        tr=apb_seq_item::type_id::create("tr");
        tr.paddr=rw.addr;
        tr.pwrite=(rw.kind==UVM_WRITE);
        tr.pwdata=rw.data;
        return tr;
    endfunction

    virtual function void bus2reg(uvm_sequence_item bus_item,ref uvm_reg_bus_op rw);
        apb_seq_item tr;
        if (!$cast(tr, bus_item))   
            `uvm_fatal("APB_ADAPTER","Failed to cast")
        rw.kind=tr.pwrite?UVM_WRITE:UVM_READ;
        rw.addr=tr.paddr;
        rw.data=tr.pwrite?tr.pwdata:tr.prdata;
        rw.status=tr.pslverr?UVM_NOT_OK:UVM_IS_OK;
       `uvm_info("BUS_2_REG", $sformatf("PADDR: 0x%04X, PWRITE:%0b | PRDATA: 0x%08X, PSLVERR: %0b, PREADY: %0b",tr.paddr,tr.pwrite,tr.prdata,tr.pslverr,tr.pready),UVM_MEDIUM)
    
    
    
    endfunction
endclass
