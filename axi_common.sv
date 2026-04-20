`define NEW_COMP\
function new(input string name="",uvm_component parent);\
  super.new(name,parent);\
endfunction

`define NEW_OBJ\
function new(input string name="");\
	super.new(name);\
endfunction

`define addr_width 32
`define data_width 32
`define strb_width 4

