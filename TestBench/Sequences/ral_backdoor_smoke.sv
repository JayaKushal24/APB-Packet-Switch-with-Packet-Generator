class device_id_backdoor_read_seq extends uvm_reg_sequence;
`uvm_object_utils(device_id_backdoor_read_seq)

uvm_status_e status;
uvm_reg_data_t read_data;

function new(string name="device_id_backdoor_read_seq");
super.new(name);
endfunction

virtual task body();
if(!uvm_config_db#(pkt_reg_block)::get(null,get_full_name(),"ral",ral_model))
`uvm_fatal("RAL","Failed to get register model")

ral_model.device_id.read(status,read_data,UVM_BACKDOOR);

if(status==UVM_IS_OK)
`uvm_info("DEVICE_ID",$sformatf("Backdoor read DEVICE_ID = 0x%08h",read_data),UVM_MEDIUM)
else
`uvm_error("DEVICE_ID","Backdoor read of DEVICE_ID failed")
endtask

endclass
