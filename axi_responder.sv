class axi_responder extends uvm_component;
virtual axi_intrf vif;
`uvm_component_utils(axi_responder)
`NEW_COMP
bit [31:0]awaddr_t;
bit [3:0]awlen_t;
bit [2:0]awsize_t;
bit [1:0]awburst_t;
bit [31:0] mem[*];
  bit [31:0]araddr_t;
  bit [3:0]arlen_t;
  bit [2:0]arsize_t;
  bit [1:0]arburst_t;
  bit [31:0]wrap_lower_addr;
  bit [31:0]wrap_upper_addr;
  function void build_phase(uvm_phase phase);
    	super.build_phase(phase);
    	vif=top.pif;
    	if(!uvm_config_db#(virtual axi_intrf)::get(this,"","vif",vif))
      	`uvm_fatal("DRV","VIF not found")
  	endfunction

task run();
	@(posedge vif.aclk);
	if(vif.arvalid==1)begin
		vif.arready=1;
		araddr_t=vif.araddr;
		arlen_t=vif.arlen;
		arsize_t=vif.arsize;
		arburst_t=vif.arburst;
      drive_read_data(4'b0000);
	end
	@(posedge vif.aclk);
	if(vif.awvalid==1)begin
		vif.awready=1;
		awaddr_t=vif.awaddr;
		awlen_t=vif.awlen;
		awsize_t=vif.awsize;
		awburst_t=vif.awburst;

	end

	if(vif.wvalid==1)begin
		vif.wready=1;
		mem[awaddr_t]=vif.wdata[7:0];
		mem[awaddr_t+1]=vif.wdata[15:8];
		mem[awaddr_t+2]=vif.wdata[23:16];
		mem[awaddr_t+3]=vif.wdata[31:24];
		awaddr_t=awaddr_t+2**awsize_t;
		awlen_t -=1;
		if(awburst_t==WRAP)begin
			if(awaddr_t>wrap_upper_addr)begin
				awaddr_t=wrap_lower_addr;
			end
		end
		if(vif.wlast==1 && awlen_t==-1)begin
          write_resp(4'b0000);
		end
	end
endtask
task write_resp(bit[3:0]id);
	@(posedge vif.aclk);
	vif.bid=id;
	vif.bresp= OKAY;
	vif.bvalid=1;
	wait(vif.bready==1);
	@(posedge vif.aclk);
	vif.bid=0;
	vif.bresp=0;
	vif.bvalid=0;
endtask
task drive_read_data(bit[3:0]id);
for(int i=0;i<=arlen_t;i++)begin
	@(posedge vif.aclk);
	vif.rid=id;
	vif.rresp= OKAY;
	vif.rdata={
				mem[araddr_t+3],mem[araddr_t+2],mem[araddr_t+1],mem[araddr_t]
	          };
	vif.rvalid=1;
	wait(vif.rready==1);
	@(posedge vif.aclk);
	araddr_t=araddr_t+2**arsize_t;
	vif.rid=0;
	vif.rresp=0;
	vif.rvalid=0;
	vif.rdata=0;
end
endtask
endclass
