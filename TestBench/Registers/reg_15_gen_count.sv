class reg_gen_count extends uvm_reg;
    `uvm_object_utils(reg_gen_count)

    rand uvm_reg_field packet_count;
    rand uvm_reg_field reserved;

    function new(string name="reg_gen_count");
        super.new(name,32,UVM_NO_COVERAGE);
    endfunction

    function void build();
        packet_count=uvm_reg_field::type_id::create("packet_count");
        packet_count.configure(.parent(this),.size(16),.lsb_pos(0),.access("RW"),.volatile(0),.has_reset(1),.reset(16'h0004),.is_rand(0),.individually_accessible(1));

        reserved=uvm_reg_field::type_id::create("reserved");
        reserved.configure(.parent(this),.size(16),.lsb_pos(16),.access("RO"),.volatile(0),.has_reset(1),.reset(16'h0000),.is_rand(0),.individually_accessible(1));
    endfunction
endclass