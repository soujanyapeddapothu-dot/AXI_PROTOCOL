class axi_magent extends uvm_agent;
`uvm_component_utils(axi_magent)
`NEW_COMP
	axi_sqr sqr;
	axi_drv drv;
	axi_mmon mmon;
	axi_cov cov;
	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		sqr=axi_sqr::type_id::create("sqr",this);
		drv=axi_drv::type_id::create("drv",this);
		mmon=axi_mmon::type_id::create("mmon",this);
		cov=axi_cov::type_id::create("cov",this);
	endfunction
	function void connect_phase(uvm_phase phase);
		super.connect_phase(phase); 
    	drv.seq_item_port.connect(sqr.seq_item_export);
    	mmon.ap.connect(cov.analysis_export);
	endfunction
endclass

