class pkt_reg_block extends uvm_reg_block;
    `uvm_object_utils(pkt_reg_block)

    reg_device_id    device_id;
    reg_version      version;
    reg_switch_status switch_status;
    reg_port_status  port_status;
    reg_gen_status   gen_status;
    reg_stat_rx      stat_rx;
    reg_stat_tx      stat_tx;
    reg_stat_drop    stat_drop;
    reg_switch_ctrl  switch_ctrl;
    reg_port_enable  port_enable;
    reg_fwd_enable   fwd_enable;
    reg_gen_ctrl     gen_ctrl;
    reg_gen_pkt_cfg  gen_pkt_cfg;
    reg_gen_interval gen_interval;
    reg_gen_count    gen_count;
    reg_irq_status   irq_status;
    reg_irq_enable   irq_enable;
    reg_irq_force    irq_force;
    reg_err_status   err_status;
    reg_err_enable   err_enable;
    reg_err_inject   err_inject;
    reg_err_count    err_count;
    reg_err_info     err_info;
    reg_lock         lock;
    reg_soft_reset   soft_reset;

    uvm_reg_map apb_map;

    function new(string name="pkt_reg_block");
        super.new(name, UVM_NO_COVERAGE);
    endfunction

    function void build();
        apb_map = create_map("apb_map",'h0,4,UVM_LITTLE_ENDIAN);

        device_id = reg_device_id::type_id::create("device_id");
        device_id.build();
        device_id.configure(this);
        apb_map.add_reg(device_id,'h00,"RO");

        version = reg_version::type_id::create("version");
        version.build();
        version.configure(this);
        apb_map.add_reg(version,'h04,"RO");

        switch_status = reg_switch_status::type_id::create("switch_status");
        switch_status.build();
        switch_status.configure(this);
        apb_map.add_reg(switch_status,'h08,"RO");

        port_status = reg_port_status::type_id::create("port_status");
        port_status.build();
        port_status.configure(this);
        apb_map.add_reg(port_status,'h0C,"RO");

        gen_status = reg_gen_status::type_id::create("gen_status");
        gen_status.build();
        gen_status.configure(this);
        apb_map.add_reg(gen_status,'h10,"RO");

        stat_rx = reg_stat_rx::type_id::create("stat_rx");
        stat_rx.build();
        stat_rx.configure(this);
        apb_map.add_reg(stat_rx,'h14,"RO");

        stat_tx = reg_stat_tx::type_id::create("stat_tx");
        stat_tx.build();
        stat_tx.configure(this);
        apb_map.add_reg(stat_tx,'h18,"RO");

        stat_drop = reg_stat_drop::type_id::create("stat_drop");
        stat_drop.build();
        stat_drop.configure(this);
        apb_map.add_reg(stat_drop,'h1C,"RO");

        switch_ctrl = reg_switch_ctrl::type_id::create("switch_ctrl");
        switch_ctrl.build();
        switch_ctrl.configure(this);
        apb_map.add_reg(switch_ctrl,'h20,"RW");

        port_enable = reg_port_enable::type_id::create("port_enable");
        port_enable.build();
        port_enable.configure(this);
        apb_map.add_reg(port_enable,'h24,"RW");

        fwd_enable = reg_fwd_enable::type_id::create("fwd_enable");
        fwd_enable.build();
        fwd_enable.configure(this);
        apb_map.add_reg(fwd_enable,'h28,"RW");

        gen_ctrl = reg_gen_ctrl::type_id::create("gen_ctrl");
        gen_ctrl.build();
        gen_ctrl.configure(this);
        apb_map.add_reg(gen_ctrl,'h2C,"RW");

        gen_pkt_cfg = reg_gen_pkt_cfg::type_id::create("gen_pkt_cfg");
        gen_pkt_cfg.build();
        gen_pkt_cfg.configure(this);
        apb_map.add_reg(gen_pkt_cfg,'h30,"RW");

        gen_interval = reg_gen_interval::type_id::create("gen_interval");
        gen_interval.build();
        gen_interval.configure(this);
        apb_map.add_reg(gen_interval,'h34,"RW");

        gen_count = reg_gen_count::type_id::create("gen_count");
        gen_count.build();
        gen_count.configure(this);
        apb_map.add_reg(gen_count,'h38,"RW");

        irq_status = reg_irq_status::type_id::create("irq_status");
        irq_status.build();
        irq_status.configure(this);
        apb_map.add_reg(irq_status,'h3C,"RW");

        irq_enable = reg_irq_enable::type_id::create("irq_enable");
        irq_enable.build();
        irq_enable.configure(this);
        apb_map.add_reg(irq_enable,'h40,"RW");

        irq_force = reg_irq_force::type_id::create("irq_force");
        irq_force.build();
        irq_force.configure(this);
        apb_map.add_reg(irq_force,'h44,"WO");

        err_status = reg_err_status::type_id::create("err_status");
        err_status.build();
        err_status.configure(this);
        apb_map.add_reg(err_status,'h48,"RW");

        err_enable = reg_err_enable::type_id::create("err_enable");
        err_enable.build();
        err_enable.configure(this);
        apb_map.add_reg(err_enable,'h4C,"RW");

        err_inject = reg_err_inject::type_id::create("err_inject");
        err_inject.build();
        err_inject.configure(this);
        apb_map.add_reg(err_inject,'h50,"WO");

        err_count = reg_err_count::type_id::create("err_count");
        err_count.build();
        err_count.configure(this);
        apb_map.add_reg(err_count,'h54,"RO");

        err_info = reg_err_info::type_id::create("err_info");
        err_info.build();
        err_info.configure(this);
        apb_map.add_reg(err_info,'h58,"RO");

        lock = reg_lock::type_id::create("lock");
        lock.build();
        lock.configure(this);
        apb_map.add_reg(lock,'h5C,"RW");

        soft_reset = reg_soft_reset::type_id::create("soft_reset");
        soft_reset.build();
        soft_reset.configure(this);
        apb_map.add_reg(soft_reset,'h60,"WO");
        lock_model();
    endfunction
endclass