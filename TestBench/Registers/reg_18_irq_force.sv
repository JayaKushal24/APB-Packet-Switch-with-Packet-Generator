class reg_irq_force extends uvm_reg;
    `uvm_object_utils(reg_irq_force)

    rand uvm_reg_field force_;
    rand uvm_reg_field reserved;

    function new(string name="reg_irq_force");
        super.new(name,32,UVM_NO_COVERAGE);
    endfunction

    function void build();
        force_=uvm_reg_field::type_id::create("force");
        force_.configure(.parent(this),.size(8),.lsb_pos(0),.access("WO"),.volatile(0),.has_reset(1),.reset(8'h00),.is_rand(0),.individually_accessible(1));

        reserved=uvm_reg_field::type_id::create("reserved");
        reserved.configure(.parent(this),.size(24),.lsb_pos(8),.access("RAZ"),.volatile(0),.has_reset(1),.reset(24'h000000),.is_rand(0),.individually_accessible(1));
    endfunction
endclass
