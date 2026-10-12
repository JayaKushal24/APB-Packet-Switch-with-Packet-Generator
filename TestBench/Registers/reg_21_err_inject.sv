class reg_err_inject extends uvm_reg;
    `uvm_object_utils(reg_err_inject)

    rand uvm_reg_field bus;
    rand uvm_reg_field dest;
    rand uvm_reg_field overflow;
    rand uvm_reg_field undersize;
    rand uvm_reg_field protocol;
    rand uvm_reg_field crc;
    rand uvm_reg_field length;
    rand uvm_reg_field injected;
    rand uvm_reg_field reserved;
    rand uvm_reg_field clear_count;

    function new(string name="reg_err_inject");
        super.new(name,32,UVM_NO_COVERAGE);
    endfunction

    function void build();
        bus=uvm_reg_field::type_id::create("bus");
        bus.configure(.parent(this),.size(1),.lsb_pos(0),
        .access("WO"),.volatile(0),.has_reset(1),.reset(1'b0),.is_rand(0),
        .individually_accessible(1));

        dest=uvm_reg_field::type_id::create("dest");
        dest.configure(.parent(this),.size(1),.lsb_pos(1),
        .access("WO"),.volatile(0),.has_reset(1),.reset(1'b0),.is_rand(0),
        .individually_accessible(1));

        overflow=uvm_reg_field::type_id::create("overflow");
        overflow.configure(.parent(this),.size(1),.lsb_pos(2),
        .access("WO"),.volatile(0),.has_reset(1),.reset(1'b0),.is_rand(0),
        .individually_accessible(1));

        undersize=uvm_reg_field::type_id::create("undersize");
        undersize.configure(.parent(this),.size(1),.lsb_pos(3),
        .access("WO"),.volatile(0),.has_reset(1),.reset(1'b0),.is_rand(0),
        .individually_accessible(1));

        protocol=uvm_reg_field::type_id::create("protocol");
        protocol.configure(.parent(this),.size(1),.lsb_pos(4),
        .access("WO"),.volatile(0),.has_reset(1),.reset(1'b0),.is_rand(0),
        .individually_accessible(1));

        crc=uvm_reg_field::type_id::create("crc");
        crc.configure(.parent(this),.size(1),.lsb_pos(5),
        .access("WO"),.volatile(0),.has_reset(1),.reset(1'b0),.is_rand(0),
        .individually_accessible(1));

        length=uvm_reg_field::type_id::create("length");
        length.configure(.parent(this),.size(1),.lsb_pos(6),
        .access("WO"),.volatile(0),.has_reset(1),.reset(1'b0),.is_rand(0),
        .individually_accessible(1));

        injected=uvm_reg_field::type_id::create("injected");
        injected.configure(.parent(this),.size(1),.lsb_pos(7),
        .access("WO"),.volatile(0),.has_reset(1),.reset(1'b0),.is_rand(0),
        .individually_accessible(1));

        reserved=uvm_reg_field::type_id::create("reserved");
        reserved.configure(.parent(this),.size(23),.lsb_pos(8),
        .access("RO"),.volatile(0),.has_reset(1),.reset(23'h000000),.is_rand(0),
        .individually_accessible(1));

        clear_count=uvm_reg_field::type_id::create("clear_count");
        clear_count.configure(.parent(this),.size(1),.lsb_pos(31),
        .access("WO"),.volatile(0),.has_reset(1),.reset(1'b0),.is_rand(0),
        .individually_accessible(1));
    endfunction
endclass

