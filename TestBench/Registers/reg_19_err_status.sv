class reg_err_status extends uvm_reg;
    `uvm_object_utils(reg_err_status)

    rand uvm_reg_field bus_error;
    rand uvm_reg_field dest_error;
    rand uvm_reg_field queue_overflow;
    rand uvm_reg_field undersize;
    rand uvm_reg_field protocol_error;
    rand uvm_reg_field crc_error;
    rand uvm_reg_field length_error;
    rand uvm_reg_field injected;
    rand uvm_reg_field reserved;

    function new(string name="reg_err_status");
        super.new(name,32,UVM_NO_COVERAGE);
    endfunction

    function void build();
        bus_error=uvm_reg_field::type_id::create("bus_error");
        bus_error.configure(.parent(this),.size(1),.lsb_pos(0),.access("W1C"),.volatile(1),.has_reset(1),.reset(1'b0),.is_rand(0),.individually_accessible(1));

        dest_error=uvm_reg_field::type_id::create("dest_error");
        dest_error.configure(.parent(this),.size(1),.lsb_pos(1),.access("W1C"),.volatile(1),.has_reset(1),.reset(1'b0),.is_rand(0),.individually_accessible(1));

        queue_overflow=uvm_reg_field::type_id::create("queue_overflow");
        queue_overflow.configure(.parent(this),.size(1),.lsb_pos(2),.access("W1C"),.volatile(1),.has_reset(1),.reset(1'b0),.is_rand(0),.individually_accessible(1));

        undersize=uvm_reg_field::type_id::create("undersize");
        undersize.configure(.parent(this),.size(1),.lsb_pos(3),.access("W1C"),.volatile(1),.has_reset(1),.reset(1'b0),.is_rand(0),.individually_accessible(1));

        protocol_error=uvm_reg_field::type_id::create("protocol_error");
        protocol_error.configure(.parent(this),.size(1),.lsb_pos(4),.access("W1C"),.volatile(1),.has_reset(1),.reset(1'b0),.is_rand(0),.individually_accessible(1));

        crc_error=uvm_reg_field::type_id::create("crc_error");
        crc_error.configure(.parent(this),.size(1),.lsb_pos(5),.access("W1C"),.volatile(1),.has_reset(1),.reset(1'b0),.is_rand(0),.individually_accessible(1));

        length_error=uvm_reg_field::type_id::create("length_error");
        length_error.configure(.parent(this),.size(1),.lsb_pos(6),.access("W1C"),.volatile(1),.has_reset(1),.reset(1'b0),.is_rand(0),.individually_accessible(1));

        injected=uvm_reg_field::type_id::create("injected");
        injected.configure(.parent(this),.size(1),.lsb_pos(7),.access("W1C"),.volatile(1),.has_reset(1),.reset(1'b0),.is_rand(0),.individually_accessible(1));

        reserved=uvm_reg_field::type_id::create("reserved");
        reserved.configure(.parent(this),.size(24),.lsb_pos(8),.access("RAZ"),.volatile(0),.has_reset(1),.reset(24'h000000),.is_rand(0),.individually_accessible(1));
    endfunction
endclass