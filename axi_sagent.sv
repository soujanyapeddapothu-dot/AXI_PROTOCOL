class axi_sagent extends uvm_agent;
`uvm_component_utils(axi_sagent)
`NEW_COMP
	axi_responder resp;
	axi_smon smon;
	function void build_phase(uvm_phase phase);
		resp=axi_responder::type_id::create("resp",this);
		smon=axi_smon::type_id::create("smon",this);
	endfunction
endclass

