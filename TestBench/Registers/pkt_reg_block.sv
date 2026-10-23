class pkt_reg_block extends uvm_reg_block;
    `uvm_object_utils(pkt_reg_block)

    rand reg_device_id device_id;
    rand reg_version version;
    rand reg_switch_status switch_status;
    rand reg_port_status port_status;
    rand reg_gen_status gen_status;
    rand reg_stat_rx stat_rx;
    rand reg_stat_tx stat_tx;
    rand reg_stat_drop stat_drop;
    rand reg_switch_ctrl switch_ctrl;
    rand reg_port_enable port_enable;
    rand reg_fwd_enable fwd_enable;
    rand reg_gen_ctrl gen_ctrl;
    rand reg_gen_pkt_cfg gen_pkt_cfg;
    rand reg_gen_interval gen_interval;
    rand reg_gen_count gen_count;
    rand reg_irq_status irq_status;
    rand reg_irq_enable irq_enable;
    rand reg_irq_force irq_force;
    rand reg_err_status err_status;
    rand reg_err_enable err_enable;
    rand reg_err_inject err_inject;
    rand reg_err_count err_count;
    rand reg_err_info err_info;
    rand reg_lock lock;
    rand reg_soft_reset soft_reset;

    uvm_reg_map apb_map;

    function new(string name="pkt_reg_block");
        super.new(name,UVM_NO_COVERAGE);
    endfunction

    function void build();
        add_hdl_path("dut","RTL");
        device_id=reg_device_id::type_id::create("device_id");
        device_id.build();
        device_id.configure(this);
        device_id.add_hdl_path_slice("DEVICE_ID",0,32);

        version=reg_version::type_id::create("version");
        version.build();
        version.configure(this);
        version.add_hdl_path_slice("VERSION",0,32);

        switch_status=reg_switch_status::type_id::create("switch_status");
        switch_status.build();
        switch_status.configure(this);
        switch_status.add_hdl_path_slice("SWITCH_STATUS",0,32);

        port_status=reg_port_status::type_id::create("port_status");
        port_status.build();
        port_status.configure(this);
        port_status.add_hdl_path_slice("PORT_STATUS",0,32);

        gen_status=reg_gen_status::type_id::create("gen_status");
        gen_status.build();
        gen_status.configure(this);
        gen_status.add_hdl_path_slice("GEN_STATUS",0,32);

        stat_rx=reg_stat_rx::type_id::create("stat_rx");
        stat_rx.build();
        stat_rx.configure(this);
        stat_rx.add_hdl_path_slice("STAT_RX",0,32);

        stat_tx=reg_stat_tx::type_id::create("stat_tx");
        stat_tx.build();
        stat_tx.configure(this);
        stat_tx.add_hdl_path_slice("STAT_TX",0,32);

        stat_drop=reg_stat_drop::type_id::create("stat_drop");
        stat_drop.build();
        stat_drop.configure(this);
        stat_drop.add_hdl_path_slice("STAT_DROP",0,32);

        switch_ctrl=reg_switch_ctrl::type_id::create("switch_ctrl");
        switch_ctrl.build();
        switch_ctrl.configure(this);
        switch_ctrl.add_hdl_path_slice("SWITCH_CTRL",0,32);

        port_enable=reg_port_enable::type_id::create("port_enable");
        port_enable.build();
        port_enable.configure(this);
        port_enable.add_hdl_path_slice("PORT_ENABLE",0,32);

        fwd_enable=reg_fwd_enable::type_id::create("fwd_enable");
        fwd_enable.build();
        fwd_enable.configure(this);
        fwd_enable.add_hdl_path_slice("FWD_ENABLE",0,32);

        gen_ctrl=reg_gen_ctrl::type_id::create("gen_ctrl");
        gen_ctrl.build();
        gen_ctrl.configure(this);
        gen_ctrl.add_hdl_path_slice("GEN_CTRL",0,32);

        gen_pkt_cfg=reg_gen_pkt_cfg::type_id::create("gen_pkt_cfg");
        gen_pkt_cfg.build();
        gen_pkt_cfg.configure(this);
        gen_pkt_cfg.add_hdl_path_slice("GEN_PKT_CFG",0,32);

        gen_interval=reg_gen_interval::type_id::create("gen_interval");
        gen_interval.build();
        gen_interval.configure(this);
        gen_interval.add_hdl_path_slice("GEN_INTERVAL",0,32);

        gen_count=reg_gen_count::type_id::create("gen_count");
        gen_count.build();
        gen_count.configure(this);
        gen_count.add_hdl_path_slice("GEN_COUNT",0,32);

        irq_status=reg_irq_status::type_id::create("irq_status");
        irq_status.build();
        irq_status.configure(this);
        irq_status.add_hdl_path_slice("IRQ_STATUS",0,32);

        irq_enable=reg_irq_enable::type_id::create("irq_enable");
        irq_enable.build();
        irq_enable.configure(this);
        irq_enable.add_hdl_path_slice("irq_enable_q",0,32);

        irq_force=reg_irq_force::type_id::create("irq_force");
        irq_force.build();
        irq_force.configure(this);
        irq_force.add_hdl_path_slice("irq_force_q",0,32);

        err_status=reg_err_status::type_id::create("err_status");
        err_status.build();
        err_status.configure(this);
        err_status.add_hdl_path_slice("ERR_STATUS",0,32);

        err_enable=reg_err_enable::type_id::create("err_enable");
        err_enable.build();
        err_enable.configure(this);
        err_enable.add_hdl_path_slice("ERR_ENABLE",0,32);

        err_inject=reg_err_inject::type_id::create("err_inject");
        err_inject.build();
        err_inject.configure(this);
        err_inject.add_hdl_path_slice("ERR_INJECT",0,32);

        err_count=reg_err_count::type_id::create("err_count");
        err_count.build();
        err_count.configure(this);
        err_count.add_hdl_path_slice("ERR_COUNT",0,32);

        err_info=reg_err_info::type_id::create("err_info");
        err_info.build();
        err_info.configure(this);
        err_info.add_hdl_path_slice("ERR_INFO",0,32);

        lock=reg_lock::type_id::create("lock");
        lock.build();
        lock.configure(this);
        lock.add_hdl_path_slice("LOCK",0,32);

        soft_reset=reg_soft_reset::type_id::create("soft_reset");
        soft_reset.build();
        soft_reset.configure(this);
        soft_reset.add_hdl_path_slice("SOFT_RESET",0,32);

        apb_map=create_map("apb_map",'h0,4,UVM_LITTLE_ENDIAN);
        apb_map.add_reg(device_id,'h00,"RO");
        apb_map.add_reg(version,'h04,"RO");
        apb_map.add_reg(switch_status,'h08,"RO");
        apb_map.add_reg(port_status,'h0C,"RO");
        apb_map.add_reg(gen_status,'h10,"RO");
        apb_map.add_reg(stat_rx,'h14,"RO");
        apb_map.add_reg(stat_tx,'h18,"RO");
        apb_map.add_reg(stat_drop,'h1C,"RO");
        apb_map.add_reg(switch_ctrl,'h20,"RW");
        apb_map.add_reg(port_enable,'h24,"RW");
        apb_map.add_reg(fwd_enable,'h28,"RW");
        apb_map.add_reg(gen_ctrl,'h2C,"RW");
        apb_map.add_reg(gen_pkt_cfg,'h30,"RW");
        apb_map.add_reg(gen_interval,'h34,"RW");
        apb_map.add_reg(gen_count,'h38,"RW");
        apb_map.add_reg(irq_status,'h3C,"RW");
        apb_map.add_reg(irq_enable,'h40,"RW");
        apb_map.add_reg(irq_force,'h44,"WO");
        apb_map.add_reg(err_status,'h48,"RW");
        apb_map.add_reg(err_enable,'h4C,"RW");
        apb_map.add_reg(err_inject,'h50,"WO");
        apb_map.add_reg(err_count,'h54,"RO");
        apb_map.add_reg(err_info,'h58,"RO");
        apb_map.add_reg(lock,'h5C,"RW");
        apb_map.add_reg(soft_reset,'h60,"WO");
        lock_model();

    endfunction
endclass
