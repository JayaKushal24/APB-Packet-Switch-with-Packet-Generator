class reg_fwd_enable extends uvm_reg;
    `uvm_object_utils(reg_fwd_enable)

    rand uvm_reg_field fwd0_en;
    rand uvm_reg_field fwd1_en;
    rand uvm_reg_field fwd2_en;
    rand uvm_reg_field fwd3_en;
    rand uvm_reg_field reserved;

    function new(string name="reg_fwd_enable");
        super.new(name,32,UVM_NO_COVERAGE);
    endfunction

    function void build();
        fwd0_en=uvm_reg_field::type_id::create("fwd0_en");
        fwd0_en.configure(.parent(this),.size(1),.lsb_pos(0),.access("RW"),.volatile(0),.has_reset(1),.reset(1'b1),.is_rand(0),.individually_accessible(1));

        fwd1_en=uvm_reg_field::type_id::create("fwd1_en");
        fwd1_en.configure(.parent(this),.size(1),.lsb_pos(1),.access("RW"),.volatile(0),.has_reset(1),.reset(1'b1),.is_rand(0),.individually_accessible(1));

        fwd2_en=uvm_reg_field::type_id::create("fwd2_en");
        fwd2_en.configure(.parent(this),.size(1),.lsb_pos(2),.access("RW"),.volatile(0),.has_reset(1),.reset(1'b1),.is_rand(0),.individually_accessible(1));

        fwd3_en=uvm_reg_field::type_id::create("fwd3_en");
        fwd3_en.configure(.parent(this),.size(1),.lsb_pos(3),.access("RW"),.volatile(0),.has_reset(1),.reset(1'b1),.is_rand(0),.individually_accessible(1));

        reserved=uvm_reg_field::type_id::create("reserved");
        reserved.configure(.parent(this),.size(28),.lsb_pos(4),.access("RAZ"),.volatile(0),.has_reset(1),.reset(28'h0000000),.is_rand(0),.individually_accessible(1));
    endfunction
endclass