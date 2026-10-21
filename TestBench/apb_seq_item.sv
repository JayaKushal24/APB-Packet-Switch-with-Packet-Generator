class apb_seq_item extends uvm_sequence_item;
    `uvm_object_utils(apb_seq_item)
    rand logic [15:0]paddr;
    rand logic [31:0]pwdata;
    rand logic pwrite;
    rand logic psel;
    rand logic penable;
    logic [31:0]prdata;
    logic   pready;
    logic   pslverr;
    logic   irq;
    //address alignment constraint (32-bit word aligned)
    constraint c_addr_aligned {
        soft paddr[1:0] == 2'b00;
    }

    //address range constraint (0x00 to 0x60 for valid CSR range)
    constraint c_valid_csr_range {
        soft paddr <= 16'h0060;
    }
    function new(string name = "apb_seq_item");
        super.new(name);
    endfunction
endclass