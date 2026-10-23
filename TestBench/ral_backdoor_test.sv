class ral_backdoor_test extends base_test;
`uvm_component_utils(ral_backdoor_test)

function new(string name="ral_backdoor_test",uvm_component parent=null);
super.new(name,parent);
endfunction

virtual task run_phase(uvm_phase phase);
device_id_backdoor_read_seq seq;

phase.raise_objection(this);

seq=device_id_backdoor_read_seq::type_id::create("seq");
seq.start(null);

phase.drop_objection(this);
endtask

endclass
