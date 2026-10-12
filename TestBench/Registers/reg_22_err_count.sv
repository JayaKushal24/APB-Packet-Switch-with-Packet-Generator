class reg_err_count extends uvm_reg;
    `uvm_object_utils(reg_err_count)

    rand uvm_reg_field error_count;
    rand uvm_reg_field reserved;

    function new(string name="reg_err_count");
        super.new(name,32,UVM_NO_COVERAGE);
    endfunction

    function void build();
        error_count=uvm_reg_field::type_id::create("error_count");
        error_count.configure(.parent(this),.size(16),.lsb_pos(0),
        .access("RO"),.volatile(1),.has_reset(1),.reset(16'h0000),.is_rand(0),
        .individually_accessible(1));

        reserved=uvm_reg_field::type_id::create("reserved");
        reserved.configure(.parent(this),.size(16),.lsb_pos(16),
        .access("RO"),.volatile(0),.has_reset(1),.reset(16'h0000),.is_rand(0),
        .individually_accessible(1));
    endfunction
endclass