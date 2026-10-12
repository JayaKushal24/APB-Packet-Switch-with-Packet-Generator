class apb_seq_item extends uvm_sequence_item;
    `uvm_object_utils(apb_seq_item)
    
    rand logic        psel;
    rand logic        penable;
    rand logic        pwrite;
    rand logic [15:0] paddr;
    rand logic [31:0] pwdata;
    rand logic [31:0] prdata;
    rand logic        pready;
    rand logic        pslverr;
    rand logic        irq;
    function new(string name="apb_seq_item");
        super.new(name);
    endfunction
endclass