class reg_gen_interval extends uvm_reg;
    `uvm_object_utils(reg_gen_interval)

    rand uvm_reg_field interval;
    rand uvm_reg_field reserved;

    function new(string name="reg_gen_interval");
        super.new(name,32,UVM_NO_COVERAGE);
    endfunction

    function void build();
        interval=uvm_reg_field::type_id::create("interval");
        interval.configure(.parent(this),.size(16),.lsb_pos(0),.access("RW"),.volatile(0),.has_reset(1),.reset(16'h0002),.is_rand(0),.individually_accessible(1));

        reserved=uvm_reg_field::type_id::create("reserved");
        reserved.configure(.parent(this),.size(16),.lsb_pos(16),.access("RAZ"),.volatile(0),.has_reset(1),.reset(16'h0000),.is_rand(0),.individually_accessible(1));
    endfunction
endclass


