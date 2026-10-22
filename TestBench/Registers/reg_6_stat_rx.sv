class reg_stat_rx extends uvm_reg;
    `uvm_object_utils(reg_stat_rx)

    rand uvm_reg_field rx_packets;
    rand uvm_reg_field reserved;

    function new(string name="reg_stat_rx");
        super.new(name,32,UVM_NO_COVERAGE);
    endfunction

    function void build();
        rx_packets=uvm_reg_field::type_id::create("rx_packets");
        rx_packets.configure(.parent(this),.size(16),.lsb_pos(0),.access("RO"),.volatile(1),.has_reset(1),.reset(16'h0000),.is_rand(0),.individually_accessible(1));

        reserved=uvm_reg_field::type_id::create("reserved");
        reserved.configure(.parent(this),.size(16),.lsb_pos(16),.access("RO"),.volatile(0),.has_reset(1),.reset(16'h0000),.is_rand(0),.individually_accessible(1));
    endfunction
endclass


