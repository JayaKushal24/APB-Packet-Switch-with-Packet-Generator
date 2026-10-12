class reg_lock extends uvm_reg;
    `uvm_object_utils(reg_lock)

    rand uvm_reg_field locked;
    rand uvm_reg_field key_reserved;

    function new(string name="reg_lock");
        super.new(name,32,UVM_NO_COVERAGE);
    endfunction

    function void build();
        locked=uvm_reg_field::type_id::create("locked");
        locked.configure(.parent(this),.size(1),.lsb_pos(0),
        .access("RO"),.volatile(1),.has_reset(1),.reset(1'b1),.is_rand(0),
        .individually_accessible(1));

        key_reserved=uvm_reg_field::type_id::create("key_reserved");
        key_reserved.configure(.parent(this),.size(31),.lsb_pos(1),
        .access("RO"),.volatile(0),.has_reset(1),.reset(31'h00000000),.is_rand(0),
        .individually_accessible(1));
    endfunction
endclass

