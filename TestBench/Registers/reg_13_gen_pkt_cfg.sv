class reg_gen_pkt_cfg extends uvm_reg;
    `uvm_object_utils(reg_gen_pkt_cfg)

    rand uvm_reg_field dst_port;
    rand uvm_reg_field src_port;
    rand uvm_reg_field reserved_1;
    rand uvm_reg_field length;
    rand uvm_reg_field seed;
    rand uvm_reg_field reserved_2;

    function new(string name="reg_gen_pkt_cfg");
        super.new(name,32,UVM_NO_COVERAGE);
    endfunction

    function void build();
        dst_port=uvm_reg_field::type_id::create("dst_port");
        dst_port.configure(.parent(this),.size(2),.lsb_pos(0),.access("RW"),.volatile(0),.has_reset(1),.reset(2'b01),.is_rand(0),.individually_accessible(1));

        src_port=uvm_reg_field::type_id::create("src_port");
        src_port.configure(.parent(this),.size(2),.lsb_pos(2),.access("RW"),.volatile(0),.has_reset(1),.reset(2'b00),.is_rand(0),.individually_accessible(1));

        reserved_1=uvm_reg_field::type_id::create("reserved_1");
        reserved_1.configure(.parent(this),.size(4),.lsb_pos(4),.access("RO"),.volatile(0),.has_reset(1),.reset(4'h0),.is_rand(0),.individually_accessible(1));

        length=uvm_reg_field::type_id::create("length");
        length.configure(.parent(this),.size(8),.lsb_pos(8),.access("RW"),.volatile(0),.has_reset(1),.reset(8'h04),.is_rand(0),.individually_accessible(1));

        seed=uvm_reg_field::type_id::create("seed");
        seed.configure(.parent(this),.size(8),.lsb_pos(16),.access("RW"),.volatile(0),.has_reset(1),.reset(8'h00),.is_rand(0),.individually_accessible(1));

        reserved_2=uvm_reg_field::type_id::create("reserved_2");
        reserved_2.configure(.parent(this),.size(8),.lsb_pos(24),.access("RO"),.volatile(0),.has_reset(1),.reset(8'h00),.is_rand(0),.individually_accessible(1));
    endfunction
endclass