class axi_test extends uvm_test;
`uvm_component_utils(axi_test)
`NEW_COMP
	axi_env env;
	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		env=axi_env::type_id::create("env",this);
	endfunction
	function void end_of_elaboration_phase(uvm_phase phase);
		super.end_of_elaboration_phase(phase);
		uvm_top.print_topology();
	endfunction
endclass

class axi_wr_rd extends axi_test;
	`uvm_component_utils(axi_wr_rd)
	`NEW_COMP
	task run_phase(uvm_phase phase);
		axi_wr_rd_seq seq;
		seq=axi_wr_rd_seq::type_id::create("seq");
		phase.raise_objection(this);
		phase.phase_done.set_drain_time(this,100);
		seq.start(env.magent.sqr);
		phase.drop_objection(this);
	endtask
endclass

