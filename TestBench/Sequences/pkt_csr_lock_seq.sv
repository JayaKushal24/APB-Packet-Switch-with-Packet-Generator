class pkt_csr_lock_seq extends uvm_sequence;
  `uvm_object_utils(pkt_csr_lock_seq)

  pkt_reg_block regmodel;

  function new(string name = "pkt_csr_lock_seq");
    super.new(name);
  endfunction

  task body();
    uvm_status_e status;
    uvm_reg_data_t rdata;

    if (regmodel == null) begin
      `uvm_fatal("LOCK_SEQ", "Register model handle is null in pkt_csr_lock_seq!")
    end

    `uvm_info("LOCK_SEQ", "=== STEP 1: Checking initial power-on state ===", UVM_LOW)
    // Verify LOCK register powers up as 1
    regmodel.lock_reg.read(status, rdata);
    if (rdata == 32'h00000001) begin
      `uvm_info("LOCK_SEQ", "LOCK register verified as 1 (LOCKED).", UVM_LOW)
    end else begin
      `uvm_error("LOCK_SEQ", $sformatf("Expected LOCK=1 on power-up, got 0x%08X", rdata))
    end

    `uvm_info("LOCK_SEQ", "=== STEP 2: Testing write protection while LOCKED ===", UVM_LOW)
    // Attempt to write 0x00000000 to PORT_ENABLE (default is 0x0F)
    regmodel.port_enable_reg.write(status, 32'h00000000);
    regmodel.port_enable_reg.read(status, rdata);

    if (rdata == 32'h0000000F) begin
      `uvm_info("LOCK_SEQ", "PASS: Write ignored while LOCKED. PORT_ENABLE remains 0x0F.", UVM_LOW)
    end else begin
      `uvm_error("LOCK_SEQ", $sformatf("FAIL: Security breach! PORT_ENABLE updated to 0x%08X while locked.", rdata))
    end

    `uvm_info("LOCK_SEQ", "=== STEP 3: Writing Unlock Key (0xA5A5C3C3) ===", UVM_LOW)
    regmodel.lock_reg.write(status, 32'hA5A5C3C3);
    
    // Read back LOCK register to verify it cleared to 0
    regmodel.lock_reg.read(status, rdata);
    if (rdata == 32'h00000000) begin
      `uvm_info("LOCK_SEQ", "PASS: CSR Bank successfully UNLOCKED (LOCK=0).", UVM_LOW)
    end else begin
      `uvm_error("LOCK_SEQ", $sformatf("FAIL: Register bank failed to unlock. LOCK=0x%08X", rdata))
    end

    `uvm_info("LOCK_SEQ", "=== STEP 4: Testing write access after UNLOCK ===", UVM_LOW)
    // Write 0x00000005 to PORT_ENABLE again
    regmodel.port_enable_reg.write(status, 32'h00000005);
    regmodel.port_enable_reg.read(status, rdata);

    if (rdata == 32'h00000005) begin
      `uvm_info("LOCK_SEQ", "PASS: Write succeeded after unlock. PORT_ENABLE updated to 0x05.", UVM_LOW)
    end else begin
      `uvm_error("LOCK_SEQ", $sformatf("FAIL: Write failed after unlock. PORT_ENABLE reads 0x%08X", rdata))
    end

  endtask
endclass