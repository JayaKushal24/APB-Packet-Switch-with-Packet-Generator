class reg_err_enable extends uvm_reg;
    `uvm_object_utils(reg_err_enable)

    rand uvm_reg_field bus_en;
    rand uvm_reg_field dest_en;
    rand uvm_reg_field overflow_en;
    rand uvm_reg_field undersize_en;
    rand uvm_reg_field protocol_en;
    rand uvm_reg_field crc_en;
    rand uvm_reg_field length_en;
    rand uvm_reg_field injected_en;
    rand uvm_reg_field reserved;

    function new(string name="reg_err_enable");
        super.new(name,32,UVM_NO_COVERAGE);
    endfunction

    function void build();
        bus_en=uvm_reg_field::type_id::create("bus_en");
        bus_en.configure(.parent(this),.size(1),.lsb_pos(0),.access("RW"),.volatile(0),.has_reset(1),.reset(1'b0),.is_rand(0),.individually_accessible(1));

        dest_en=uvm_reg_field::type_id::create("dest_en");
        dest_en.configure(.parent(this),.size(1),.lsb_pos(1),.access("RW"),.volatile(0),.has_reset(1),.reset(1'b0),.is_rand(0),.individually_accessible(1));

        overflow_en=uvm_reg_field::type_id::create("overflow_en");
        overflow_en.configure(.parent(this),.size(1),.lsb_pos(2),.access("RW"),.volatile(0),.has_reset(1),.reset(1'b0),.is_rand(0),.individually_accessible(1));

        undersize_en=uvm_reg_field::type_id::create("undersize_en");
        undersize_en.configure(.parent(this),.size(1),.lsb_pos(3),.access("RW"),.volatile(0),.has_reset(1),.reset(1'b0),.is_rand(0),.individually_accessible(1));

        protocol_en=uvm_reg_field::type_id::create("protocol_en");
        protocol_en.configure(.parent(this),.size(1),.lsb_pos(4),.access("RW"),.volatile(0),.has_reset(1),.reset(1'b0),.is_rand(0),.individually_accessible(1));

        crc_en=uvm_reg_field::type_id::create("crc_en");
        crc_en.configure(.parent(this),.size(1),.lsb_pos(5),.access("RW"),.volatile(0),.has_reset(1),.reset(1'b0),.is_rand(0),.individually_accessible(1));

        length_en=uvm_reg_field::type_id::create("length_en");
        length_en.configure(.parent(this),.size(1),.lsb_pos(6),.access("RW"),.volatile(0),.has_reset(1),.reset(1'b0),.is_rand(0),.individually_accessible(1));

        injected_en=uvm_reg_field::type_id::create("injected_en");
        injected_en.configure(.parent(this),.size(1),.lsb_pos(7),.access("RW"),.volatile(0),.has_reset(1),.reset(1'b0),.is_rand(0),.individually_accessible(1));

        reserved=uvm_reg_field::type_id::create("reserved");
        reserved.configure(.parent(this),.size(24),.lsb_pos(8),.access("RAZ"),.volatile(0),.has_reset(1),.reset(24'h000000),.is_rand(0),.individually_accessible(1));
    endfunction
endclass