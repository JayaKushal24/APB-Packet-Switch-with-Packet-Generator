class reg_version extends uvm_reg;
    `uvm_object_utils(reg_version)
    
    rand uvm_reg_field patch;
    rand uvm_reg_field minor;
    rand uvm_reg_field major;
    rand uvm_reg_field reserved;
    
    function new(string name="reg_version");
        super.new(name,32,UVM_NO_COVERAGE);
    endfunction

    function void build();
        patch=uvm_reg_field::type_id::create("patch");
        patch.configure(.parent(this),.size(8),.lsb_pos(0),.access("RO"),.volatile(0),.has_reset(1),.reset(0),.is_rand(0),.individually_accessible(1));
        
        minor=uvm_reg_field::type_id::create("minor");
        minor.configure(.parent(this),.size(8),.lsb_pos(8),.access("RO"),.volatile(0),.has_reset(1),.reset(8'h02),.is_rand(0),.individually_accessible(1));
        
        major=uvm_reg_field::type_id::create("major");
        major.configure(.parent(this),.size(8),.lsb_pos(16),.access("RO"),.volatile(0),.has_reset(1),.reset(8'h01),.is_rand(0),.individually_accessible(1));

        reserved=uvm_reg_field::type_id::create("reserved");
        reserved.configure(.parent(this),.size(8),.lsb_pos(24),.access("RAZ"),.volatile(0),.has_reset(1),.reset(8'h00),.is_rand(0),.individually_accessible(1));
    endfunction
endclass