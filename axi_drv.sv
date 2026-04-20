class axi_drv extends uvm_driver #(axi_tx);

  `uvm_component_utils(axi_drv)

  virtual axi_intrf vif;

  `NEW_COMP
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    vif=top.pif;
    if(!uvm_config_db#(virtual axi_intrf)::get(this, "", "vif", vif))
      `uvm_fatal("DRV", "VIF not found")
  endfunction

  task run_phase(uvm_phase phase);
    forever begin
      seq_item_port.get_next_item(req);

      drive_tx(req);

      req.print();
      seq_item_port.item_done();
    end
  endtask

  task drive_tx(axi_tx tx);

    if(tx.wr_rd == 1'b1) begin
      write_addr(tx);
      write_data(tx);
      write_resp(tx);
    end
    else begin
      read_addr(tx);
      read_data(tx);
    end

  endtask


  // -------------------------
  // Dummy implementations
  // -------------------------

  task write_addr(axi_tx tx);
    @(posedge vif.aclk);
    vif.awaddr <= tx.addr;
    vif.awvalid <= 1;
  endtask

  task write_data(axi_tx tx);
    @(posedge vif.aclk);
    vif.wdata <= $random;
  endtask

  task write_resp(axi_tx tx);
    @(posedge vif.aclk);
    vif.bready <= 1;
  endtask

  task read_addr(axi_tx tx);
    @(posedge vif.aclk);
    vif.araddr <= tx.addr;
    vif.arvalid <= 1;
  endtask

  task read_data(axi_tx tx);
    @(posedge vif.aclk);
    vif.rready <= 1;
  endtask

endclass

