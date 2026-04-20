interface axi_intrf (input aclk,arstn);
	logic wr_rd;
//write address channel
	logic [3:0]awid;
	logic [`addr_width-1:0]awaddr;
	logic [3:0]awlen;
	logic [2:0]awsize;
	logic [1:0]awburst;
	logic [1:0]awlock;
	logic [1:0]awcache;
    logic [2:0]awprot;
	logic awvalid;
	logic awready;
//write data channel
	logic [3:0]wid;
	logic [`data_width-1:0]wdata;
	logic [`strb_width-1:0]wstrb;
    logic wlast;
	logic wvalid;
	logic wready;
//write responce channel
	logic [3:0]bid;
	logic [1:0]bresp;
	logic bvalid;
	logic bready;
//read address channel 
	logic [3:0]arid;
	logic [`addr_width-1:0]araddr;
	logic [3:0]arlen;
	logic [2:0]arsize;
	logic [1:0]arburst;
	logic [1:0]arlock;
	logic [1:0]arcache;
    logic [2:0]arprot;
	logic arvalid;
	logic arready;
//read data & responce channel
	logic [3:0]rid;
	logic [`data_width-1:0]rdata;
	logic [1:0]rresp;
	logic rlast;
	logic rvalid;
	logic rready;
endinterface
