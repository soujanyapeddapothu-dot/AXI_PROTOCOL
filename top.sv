`include "uvm_pkg.sv"
import uvm_pkg::*;
`include "axi_common.sv"
`include "axi_tx.sv"
`include "axi_inter.sv"
`include "axi_sqr.sv"
`include "axi_drv.sv"
`include "axi_mmon.sv"
`include "axi_cov.sv"
`include "axi_smon.sv"
`include "axi_responder.sv"
`include "axi_magent.sv"
`include "axi_sagent.sv"
`include "axi_seq_lib.sv"
`include "axi_sbd.sv"
`include "axi_env.sv"
`include "test_case.sv"
module top;
  reg aclk,arstn;
  axi_intrf pif(aclk,arstn);
  initial begin
    aclk=0;
    forever #5 aclk=~aclk;
  end
	initial begin
      arstn=1;
      arstn=0;
      uvm_config_db#(virtual axi_intrf)::set(null,"*","vif",pif);
		run_test("axi_wr_rd");
	end
  initial begin
    $dumpfile("1.vcd");
    $dumpvars;
  end
  initial begin
    #2000;
    $finish();
  end
endmodule

