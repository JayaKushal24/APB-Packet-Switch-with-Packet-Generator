
class device_id_backdoor_read_seq extends uvm_reg_sequence;
`uvm_object_utils(device_id_backdoor_read_seq)

pkt_reg_block ral_model;
uvm_status_e status;
uvm_reg_data_t frontdoor_data;
uvm_reg_data_t backdoor_data;

function new(string name="device_id_backdoor_read_seq");
super.new(name);
endfunction

virtual task body();

if(ral_model==null)
`uvm_fatal("RAL","Register model handle is null")

// Frontdoor read through APB
ral_model.device_id.read(status,frontdoor_data,UVM_FRONTDOOR);

if(status!=UVM_IS_OK)
`uvm_fatal("FD_READ","Frontdoor read of DEVICE_ID failed")

`uvm_info("FD_READ",$sformatf("Frontdoor DEVICE_ID=0x%08h",frontdoor_data),UVM_MEDIUM)

// Backdoor read through the HDL path
ral_model.device_id.read(status,backdoor_data,UVM_BACKDOOR);

if(status!=UVM_IS_OK)
`uvm_fatal("BD_READ","Backdoor read of DEVICE_ID failed")

`uvm_info("BD_READ",$sformatf("Backdoor DEVICE_ID=0x%08h",backdoor_data),UVM_MEDIUM)

// Compare both read values
if(frontdoor_data!==backdoor_data)
`uvm_error("RAL_MISMATCH",$sformatf("DEVICE_ID mismatch: Frontdoor=0x%08h Backdoor=0x%08h",frontdoor_data,backdoor_data))
else
`uvm_info("RAL_PASS","Frontdoor and backdoor DEVICE_ID values match",UVM_LOW)

endtask
endclass

