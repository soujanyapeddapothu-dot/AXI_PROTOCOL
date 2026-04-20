class axi_cov extends uvm_subscriber#(axi_tx);
`uvm_component_utils(axi_cov)
`NEW_COMP
function void write(axi_tx t);
	
endfunction
endclass

