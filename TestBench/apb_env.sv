class apb_env extends uvm_env;
    `uvm_component_utils(apb_env)
    pkt_reg_block regmodel;
    apb_reg_adapter adapter;
    uvm_reg_predictor #(apb_seq_item) predictor; // Built-in UVM Predictor
    apb_agent apb_agnt;

    function new(string name="apb_env", uvm_component parent=null);
        super.new(name, parent);
    endfunction

    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        uvm_config_db#(uvm_active_passive_enum)::set(this,"apb_agnt","is_active", UVM_ACTIVE);
        regmodel=pkt_reg_block::type_id::create("regmodel");
        adapter=apb_reg_adapter::type_id::create("adapter");
        predictor=uvm_reg_predictor#(apb_seq_item)::type_id::create("predictor", this);
        apb_agnt=apb_agent::type_id::create("apb_agnt", this);
        regmodel.build();
        regmodel.reset();
    endfunction

    virtual function void connect_phase(uvm_phase phase);
        super.connect_phase(phase);
        //attach Sequencer and Adapter to RAL Address Map
        regmodel.apb_map.set_sequencer(apb_agnt.sequencer, adapter);
        regmodel.apb_map.set_auto_predict(0);
        predictor.map = regmodel.apb_map; //assign RAL Address Map
        predictor.adapter = adapter; //assign Bus Adapter (calls bus2reg)
        apb_agnt.monitor.ap.connect(predictor.bus_in); //hook APB Monitor output to Predictor input
    endfunction
endclass
