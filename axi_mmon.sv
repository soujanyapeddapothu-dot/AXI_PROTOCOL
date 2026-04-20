class axi_mmon extends uvm_monitor;
  `uvm_component_utils(axi_mmon)
`NEW_COMP
  uvm_analysis_port #(axi_tx)ap;
  axi_tx tx;
  virtual axi_intrf vif;
function void build_phase(uvm_phase phase);
    	super.build_phase(phase);
    	vif=top.pif;
        ap=new("ap",this);
    	if(!uvm_config_db#(virtual axi_intrf)::get(this,"","vif",vif))
      	`uvm_fatal("DRV","VIF not found")
  	endfunction
task run();
	if(vif.awvalid && vif.awready)begin
		tx=new("tx");
		tx.addr=vif.awaddr;
		tx.burst_len=vif.awlen;
		tx.burst_size=vif.awsize;
		tx.id=vif.awid;
	end
	if(vif.wvalid && vif.wready)begin
		tx.dataq.push_back(vif.wdata);
		tx.strbq.push_back(vif.wstrb);
	end
	if(vif.bvalid && vif.bready)begin
		tx.respq.push_back(vif.bresp);
		ap.write(tx);
	end
	if(vif.arvalid && vif.arready)begin
			tx=new("tx");
		tx.addr=vif.araddr;
		tx.burst_len=vif.arlen;
		tx.burst_size=vif.arsize;
		tx.id=vif.arid;
	end
	if(vif.rvalid && vif.rready)begin
		tx.dataq.push_back(vif.rdata);
		if(vif.rlast==1)ap.write(tx);
	end
endtask
endclass
