class axi_sequence extends uvm_sequence#(axi_tx);
`uvm_object_utils(axi_sequence)
`NEW_OBJ
endclass

class axi_wr_rd_seq extends axi_sequence;
`uvm_object_utils(axi_wr_rd_seq)
`NEW_OBJ
	axi_tx tx;
	axi_tx txq[$];
	task body();
      repeat(5) begin
		`uvm_do_with(req,{wr_rd==1'b1;})
		//tx= new req;
      tx=axi_tx::type_id::create("tx");
      tx.copy(req);
		txq.push_back(tx);
	end
      repeat(5) begin
		tx = txq.pop_front();
		`uvm_do_with(req,{wr_rd==1'b0; 
		addr==tx.addr; 
		burst_len == tx.burst_len;
		burst_size==tx.burst_size; 
		id==tx.id;})
	end
	endtask
endclass

