class reg_switch_ctrl extends uvm_reg;
    `uvm_object_utils(reg_switch_ctrl)

    rand uvm_reg_field enable;
    rand uvm_reg_field stat_clear;
    rand uvm_reg_field reserved_1;
    rand uvm_reg_field irq_global_en;
    rand uvm_reg_field reserved_2;

    function new(string name="reg_switch_ctrl");
        super.new(name,32,UVM_NO_COVERAGE);
    endfunction

    function void build();
        enable=uvm_reg_field::type_id::create("enable");
        enable.configure(.parent(this),.size(1),.lsb_pos(0),.access("RW"),.volatile(0),.has_reset(1),.reset(1'b0),.is_rand(0),.individually_accessible(1));

        stat_clear=uvm_reg_field::type_id::create("stat_clear");
        stat_clear.configure(.parent(this),.size(1),.lsb_pos(1),.access("WO"),.volatile(0),.has_reset(1),.reset(1'b0),.is_rand(0),.individually_accessible(1));

        reserved_1=uvm_reg_field::type_id::create("reserved_1");
        reserved_1.configure(.parent(this),.size(1),.lsb_pos(2),.access("RO"),.volatile(0),.has_reset(1),.reset(1'b0),.is_rand(0),.individually_accessible(1));

        irq_global_en=uvm_reg_field::type_id::create("irq_global_en");
        irq_global_en.configure(.parent(this),.size(1),.lsb_pos(3),.access("RW"),.volatile(0),.has_reset(1),.reset(1'b0),.is_rand(0),.individually_accessible(1));

        reserved_2=uvm_reg_field::type_id::create("reserved_2");
        reserved_2.configure(.parent(this),.size(28),.lsb_pos(4),.access("RO"),.volatile(0),.has_reset(1),.reset(28'h0000000),.is_rand(0),.individually_accessible(1));
    endfunction
endclass