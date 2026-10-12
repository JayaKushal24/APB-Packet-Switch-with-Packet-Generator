class reg_switch_status extends uvm_reg;
    `uvm_object_utils(reg_switch_status)

    rand uvm_reg_field ready;
    rand uvm_reg_field busy;
    rand uvm_reg_field switch_enabled;
    rand uvm_reg_field locked;
    rand uvm_reg_field port_enabled;
    rand uvm_reg_field gen_running;
    rand uvm_reg_field err_pending;
    rand uvm_reg_field reserved_1;
    rand uvm_reg_field gen_fsm;
    rand uvm_reg_field reserved_2;

    function new(string name="reg_switch_status");
        super.new(name,32,UVM_NO_COVERAGE);
    endfunction

    function void build();
    //Generator is not running; it may be IDLE or DONE.
        ready=uvm_reg_field::type_id::create("ready");
        ready.configure(.parent(this),.size(1),.lsb_pos(0),.access("RO"),.volatile(1),.has_reset(1),.reset(1'b1),.is_rand(0),.individually_accessible(1));
    //Generator running or at least one destination queue non-empt
        busy=uvm_reg_field::type_id::create("busy");
        busy.configure(.parent(this),.size(1),.lsb_pos(1),.access("RO"),.volatile(1),.has_reset(1),.reset(1'b0),.is_rand(0),.individually_accessible(1));
    //Mirror of SWITCH_CTRL.ENABLE 
        switch_enabled=uvm_reg_field::type_id::create("switch_enabled");
        switch_enabled.configure(.parent(this),.size(1),.lsb_pos(2),.access("RO"),.volatile(1),.has_reset(1),.reset(1'b0),.is_rand(0),.individually_accessible(1));
    //Live configuration-lock state.
        locked=uvm_reg_field::type_id::create("locked");
        locked.configure(.parent(this),.size(1),.lsb_pos(3),.access("RO"),.volatile(1),.has_reset(1),.reset(1'b1),.is_rand(0),.individually_accessible(1));
    //Live mirror of PORT_ENABLE[3:0]
        port_enabled=uvm_reg_field::type_id::create("port_enabled");
        port_enabled.configure(.parent(this),.size(4),.lsb_pos(4),.access("RO"),.volatile(1),.has_reset(1),.reset(4'hF),.is_rand(0),.individually_accessible(1));
    //1 while generator is in SEND or GAP.
        gen_running=uvm_reg_field::type_id::create("gen_running");
        gen_running.configure(.parent(this),.size(1),.lsb_pos(8),.access("RO"),.volatile(1),.has_reset(1),.reset(1'b0),.is_rand(0),.individually_accessible(1));
    //OR-reduction of ERR_STATUS[7:0]
        err_pending=uvm_reg_field::type_id::create("err_pending");
        err_pending.configure(.parent(this),.size(1),.lsb_pos(9),.access("RO"),.volatile(1),.has_reset(1),.reset(1'b0),.is_rand(0),.individually_accessible(1));
    //Reserved
        reserved_1=uvm_reg_field::type_id::create("reserved_1");
        reserved_1.configure(.parent(this),.size(6),.lsb_pos(10),.access("RAZ"),.volatile(0),.has_reset(1),.reset(6'h00),.is_rand(0),.individually_accessible(1));
    //Generator state: 0 IDLE, 1 SEND, 2 GAP, 3 DONE.
        gen_fsm=uvm_reg_field::type_id::create("gen_fsm");
        gen_fsm.configure(.parent(this),.size(2),.lsb_pos(16),.access("RO"),.volatile(1),.has_reset(1),.reset(2'b00),.is_rand(0),.individually_accessible(1));
    //Reserved
        reserved_2=uvm_reg_field::type_id::create("reserved_2");
        reserved_2.configure(.parent(this),.size(14),.lsb_pos(18),.access("RAZ"),.volatile(0),.has_reset(1),.reset(14'h0000),.is_rand(0),.individually_accessible(1));
    endfunction
endclass