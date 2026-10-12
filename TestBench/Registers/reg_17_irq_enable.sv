class reg_irq_enable extends uvm_reg;
    `uvm_object_utils(reg_irq_enable)

    rand uvm_reg_field gen_done_en;
    rand uvm_reg_field error_en;
    rand uvm_reg_field overflow_en;
    rand uvm_reg_field packet_drop_en;
    rand uvm_reg_field packet_fwd_en;
    rand uvm_reg_field queue_af_en;
    rand uvm_reg_field start_ack_en;
    rand uvm_reg_field sw_event_en;
    rand uvm_reg_field reserved;

    function new(string name="reg_irq_enable");
        super.new(name,32,UVM_NO_COVERAGE);
    endfunction

    function void build();
        gen_done_en=uvm_reg_field::type_id::create("gen_done_en");
        gen_done_en.configure(.parent(this),.size(1),.lsb_pos(0),.access("RW"),.volatile(0),.has_reset(1),.reset(1'b0),.is_rand(0),.individually_accessible(1));

        error_en=uvm_reg_field::type_id::create("error_en");
        error_en.configure(.parent(this),.size(1),.lsb_pos(1),.access("RW"),.volatile(0),.has_reset(1),.reset(1'b0),.is_rand(0),.individually_accessible(1));

        overflow_en=uvm_reg_field::type_id::create("overflow_en");
        overflow_en.configure(.parent(this),.size(1),.lsb_pos(2),.access("RW"),.volatile(0),.has_reset(1),.reset(1'b0),.is_rand(0),.individually_accessible(1));

        packet_drop_en=uvm_reg_field::type_id::create("packet_drop_en");
        packet_drop_en.configure(.parent(this),.size(1),.lsb_pos(3),.access("RW"),.volatile(0),.has_reset(1),.reset(1'b0),.is_rand(0),.individually_accessible(1));

        packet_fwd_en=uvm_reg_field::type_id::create("packet_fwd_en");
        packet_fwd_en.configure(.parent(this),.size(1),.lsb_pos(4),.access("RW"),.volatile(0),.has_reset(1),.reset(1'b0),.is_rand(0),.individually_accessible(1));

        queue_af_en=uvm_reg_field::type_id::create("queue_af_en");
        queue_af_en.configure(.parent(this),.size(1),.lsb_pos(5),.access("RW"),.volatile(0),.has_reset(1),.reset(1'b0),.is_rand(0),.individually_accessible(1));

        start_ack_en=uvm_reg_field::type_id::create("start_ack_en");
        start_ack_en.configure(.parent(this),.size(1),.lsb_pos(6),.access("RW"),.volatile(0),.has_reset(1),.reset(1'b0),.is_rand(0),.individually_accessible(1));

        sw_event_en=uvm_reg_field::type_id::create("sw_event_en");
        sw_event_en.configure(.parent(this),.size(1),.lsb_pos(7),.access("RW"),.volatile(0),.has_reset(1),.reset(1'b0),.is_rand(0),.individually_accessible(1));

        reserved=uvm_reg_field::type_id::create("reserved");
        reserved.configure(.parent(this),.size(24),.lsb_pos(8),.access("RAZ"),.volatile(0),.has_reset(1),.reset(24'h000000),.is_rand(0),.individually_accessible(1));
    endfunction
endclass

