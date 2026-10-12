class reg_soft_reset extends uvm_reg;
    `uvm_object_utils(reg_soft_reset)

    rand uvm_reg_field pulse;
    rand uvm_reg_field reserved;

    function new(string name="reg_soft_reset");
        super.new(name,32,UVM_NO_COVERAGE);
    endfunction

    function void build();
        pulse=uvm_reg_field::type_id::create("pulse");
        pulse.configure(.parent(this),.size(1),.lsb_pos(0),
        .access("WO"),.volatile(0),.has_reset(1),.reset(1'b0),.is_rand(0),
        .individually_accessible(1));

        reserved=uvm_reg_field::type_id::create("reserved");
        reserved.configure(.parent(this),.size(31),.lsb_pos(1),
        .access("RO"),.volatile(0),.has_reset(1),.reset(31'h00000000),.is_rand(0),
        .individually_accessible(1));
    endfunction
endclass