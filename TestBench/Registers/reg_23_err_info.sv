class reg_err_info extends uvm_reg;
    `uvm_object_utils(reg_err_info)

    rand uvm_reg_field last_code;
    rand uvm_reg_field source;
    rand uvm_reg_field dest_port;
    rand uvm_reg_field reserved;
    rand uvm_reg_field tx_snapshot;

    function new(string name="reg_err_info");
        super.new(name,32,UVM_NO_COVERAGE);
    endfunction

    function void build();
        last_code=uvm_reg_field::type_id::create("last_code");
        last_code.configure(.parent(this),.size(8),.lsb_pos(0),
        .access("RO"),.volatile(1),.has_reset(1),.reset(8'h00),.is_rand(0),
        .individually_accessible(1));
        //not sure about reset value..need to check with spec

        source=uvm_reg_field::type_id::create("source");
        source.configure(.parent(this),.size(8),.lsb_pos(8),
        .access("RO"),.volatile(1),.has_reset(1),.reset(8'h00),.is_rand(0),
        .individually_accessible(1));
        //not sure about reset value..need to check with spec

        dest_port=uvm_reg_field::type_id::create("dest_port");
        dest_port.configure(.parent(this),.size(2),.lsb_pos(16),
        .access("RO"),.volatile(1),.has_reset(1),.reset(2'b00),.is_rand(0),
        .individually_accessible(1));

        reserved=uvm_reg_field::type_id::create("reserved");
        reserved.configure(.parent(this),.size(2),.lsb_pos(18),
        .access("RO"),.volatile(0),.has_reset(1),.reset(2'b00),.is_rand(0),
        .individually_accessible(1));

        tx_snapshot=uvm_reg_field::type_id::create("tx_snapshot");
        tx_snapshot.configure(.parent(this),.size(12),.lsb_pos(20),
        .access("RO"),.volatile(1),.has_reset(1),.reset(12'h000),.is_rand(0),
        .individually_accessible(1));
    endfunction
endclass

