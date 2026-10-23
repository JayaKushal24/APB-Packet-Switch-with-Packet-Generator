
class ral_backdoor_test extends uvm_test;
`uvm_component_utils(ral_backdoor_test)

apb_env env;
function new(string name="ral_backdoor_test",uvm_component parent=null);
super.new(name,parent);
endfunction
virtual function void build_phase(uvm_phase phase);
super.build_phase(phase);
env=apb_env::type_id::create("env",this);
endfunction

virtual task run_phase(uvm_phase phase);
device_id_backdoor_read_seq seq;
phase.raise_objection(this);
seq=device_id_backdoor_read_seq::type_id::create("seq");
seq.ral_model=env.regmodel;
seq.start(null);
phase.drop_objection(this);
endtask
endclass

