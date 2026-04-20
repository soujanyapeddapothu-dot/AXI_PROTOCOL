`uvm_analysis_imp_decl(_m)
`uvm_analysis_imp_decl(_s)

class axi_sbd extends uvm_scoreboard;
uvm_analysis_imp_m#(axi_tx,axi_sbd)imp_m;
uvm_analysis_imp_s#(axi_tx,axi_sbd)imp_s;
axi_tx mtxQ[$];
axi_tx stxQ[$];
axi_tx m_tx,s_tx;
  int match_count=0;
  int mismatch_count=0;
`uvm_component_utils(axi_sbd)
`NEW_COMP
function void build();
	imp_m=new("imp_m",this);
  imp_s=new("imp_s",this);
endfunction
function void write_m(axi_tx tx);
	mtxQ.push_back(tx);
endfunction
function void write_s(axi_tx tx);
	stxQ.push_back(tx);
endfunction
task run();
	while(1)begin
		wait (mtxQ.size() >0 && stxQ.size() >0);
		m_tx=mtxQ.pop_front();
		s_tx=stxQ.pop_front();
		if(m_tx.compare(s_tx))begin
			match_count++;
		end
		else begin
			mismatch_count++;
		end
	end
endtask
endclass
