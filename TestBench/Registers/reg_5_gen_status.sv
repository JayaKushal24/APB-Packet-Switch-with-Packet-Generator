class reg_gen_status extends uvm_reg;
    `uvm_object_utils(reg_gen_status)

    rand uvm_reg_field running;
    rand uvm_reg_field done;
    rand uvm_reg_field fsm;
    rand uvm_reg_field reserved_1;
    rand uvm_reg_field remaining;
    rand uvm_reg_field reserved_2;

    function new(string name="reg_gen_status");
        super.new(name,32,UVM_NO_COVERAGE);
    endfunction

    function void build();
        running=uvm_reg_field::type_id::create("running");
        running.configure(.parent(this),.size(1),.lsb_pos(0),.access("RO"),.volatile(1),.has_reset(1),.reset(1'b0),.is_rand(0),.individually_accessible(1));

        done=uvm_reg_field::type_id::create("done");
        done.configure(.parent(this),.size(1),.lsb_pos(1),.access("RO"),.volatile(1),.has_reset(1),.reset(1'b0),.is_rand(0),.individually_accessible(1));

        fsm=uvm_reg_field::type_id::create("fsm");
        fsm.configure(.parent(this),.size(2),.lsb_pos(2),.access("RO"),.volatile(1),.has_reset(1),.reset(2'b00),.is_rand(0),.individually_accessible(1));

        reserved_1=uvm_reg_field::type_id::create("reserved_1");
        reserved_1.configure(.parent(this),.size(4),.lsb_pos(4),.access("RO"),.volatile(0),.has_reset(1),.reset(4'h0),.is_rand(0),.individually_accessible(1));

        remaining=uvm_reg_field::type_id::create("remaining");
        remaining.configure(.parent(this),.size(16),.lsb_pos(8),.access("RO"),.volatile(1),.has_reset(1),.reset(16'h0000),.is_rand(0),.individually_accessible(1));

        reserved_2=uvm_reg_field::type_id::create("reserved_2");
        reserved_2.configure(.parent(this),.size(8),.lsb_pos(24),.access("RO"),.volatile(0),.has_reset(1),.reset(8'h00),.is_rand(0),.individually_accessible(1));
    endfunction
endclass