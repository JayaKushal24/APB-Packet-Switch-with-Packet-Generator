class reg_gen_ctrl extends uvm_reg;
    `uvm_object_utils(reg_gen_ctrl)

    rand uvm_reg_field enable;
    rand uvm_reg_field start;
    rand uvm_reg_field stop;
    rand uvm_reg_field continuous;
    rand uvm_reg_field reserved;

    function new(string name="reg_gen_ctrl");
        super.new(name,32,UVM_NO_COVERAGE);
    endfunction

    function void build();
        enable=uvm_reg_field::type_id::create("enable");
        enable.configure(.parent(this),.size(1),.lsb_pos(0),.access("RW"),.volatile(0),.has_reset(1),.reset(1'b0),.is_rand(0),.individually_accessible(1));

        start=uvm_reg_field::type_id::create("start");
        start.configure(.parent(this),.size(1),.lsb_pos(1),.access("WO"),.volatile(0),.has_reset(1),.reset(1'b0),.is_rand(0),.individually_accessible(1));

        stop=uvm_reg_field::type_id::create("stop");
        stop.configure(.parent(this),.size(1),.lsb_pos(2),.access("WO"),.volatile(0),.has_reset(1),.reset(1'b0),.is_rand(0),.individually_accessible(1));

        continuous=uvm_reg_field::type_id::create("continuous");
        continuous.configure(.parent(this),.size(1),.lsb_pos(3),.access("RW"),.volatile(0),.has_reset(1),.reset(1'b0),.is_rand(0),.individually_accessible(1));

        reserved=uvm_reg_field::type_id::create("reserved");
        reserved.configure(.parent(this),.size(28),.lsb_pos(4),.access("RO"),.volatile(0),.has_reset(1),.reset(28'h0000000),.is_rand(0),.individually_accessible(1));
    endfunction
endclass