typedef enum bit[1:0] {
	FIXED=2'b00,
	INCR=2'b01,
	WRAP=2'b10,
	RSVD=2'b11
} burst_type;

typedef enum bit[1:0] {
	OKAY=2'b00,
	EXOKAY=2'b01,
	SLVERR=2'b10,
	DECERR=2'b11
} resp_type;
typedef enum bit[1:0]{
  NORMAL=2'b00,
  EXCL=2'b01,
  LOCK=2'b10,
  RSVD_LOCK=2'b11
}lock_t;

class axi_tx extends uvm_sequence_item;
	`NEW_OBJ
	rand bit wr_rd;
	rand bit[`addr_width-1:0]addr;
	rand bit[3:0]burst_len;
	rand bit[2:0]burst_size;
	rand burst_type burst_t;
	rand bit[3:0]id;
    rand lock_t lock;
	rand bit [1:0]cache;
  	rand bit[2:0]prot;
	rand bit[`data_width-1:0]dataq[$];
	rand bit[`strb_width-1:0]strbq[$];
     rand bit [1:0] respq[$];
    rand resp_type resp_t;
	bit valid;
	bit ready;
  	bit [31:0]wrap_lower_addr;
  	bit [31:0]wrap_upper_addr;
    	`uvm_object_utils_begin(axi_tx)
		`uvm_field_int(wr_rd,UVM_ALL_ON)
     	`uvm_field_int(addr,UVM_ALL_ON)
		`uvm_field_int(burst_len,UVM_ALL_ON)
		`uvm_field_int(burst_size,UVM_ALL_ON)
		`uvm_field_enum(burst_type,burst_t,UVM_ALL_ON)
		`uvm_field_int(id,UVM_ALL_ON)
		`uvm_field_int(prot,UVM_ALL_ON)
		`uvm_field_int(cache,UVM_ALL_ON)
  `uvm_field_enum(lock_t,lock,UVM_ALL_ON)
		`uvm_field_queue_int(dataq,UVM_ALL_ON)
		`uvm_field_queue_int(strbq,UVM_ALL_ON)
		`uvm_field_enum(resp_type,resp_t,UVM_ALL_ON)
		`uvm_field_int(valid,UVM_ALL_ON)
		`uvm_field_int(ready,UVM_ALL_ON)
  `uvm_field_queue_int(respq,UVM_ALL_ON)
 		 `uvm_field_int(wrap_lower_addr,UVM_ALL_ON)
  		`uvm_field_int(wrap_upper_addr,UVM_ALL_ON)
    	`uvm_object_utils_end
  constraint reserved_v{
    burst_t!=RSVD;
    lock!=RSVD_LOCK;
  }
  constraint burst_s{
    wr_rd==1->(dataq.size()==burst_len+1 && strbq.size() ==burst_len+1);
    wr_rd==0->(dataq.size()==0 && strbq.size()==0);
  }
  constraint soft_c{
    soft burst_t==INCR;
    soft burst_size==2;
    soft lock==NORMAL;
    soft addr%2**burst_size==0;
  }
endclass

