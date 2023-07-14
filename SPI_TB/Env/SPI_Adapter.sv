
class reg2spi_adapter extends uvm_reg_adapter;

	`uvm_object_utils(reg2spi_adapter)
  function new(string name = "reg2spi_adapter");
	super.new(name);
  endfunction

  //reg2bus method
  virtual function uvm_sequence_item reg2bus(const ref uvm_reg_bus_op rw);
	packet pkt = packet::type_id::create("pkt");
	pkt.PWRITE = (rw.kind == UVM_WRITE) ? 1:0;
	pkt.PADDR = rw.addr;
//	pkt.PWDATA = (rw.kind == UVM_WRITE) ? rw.data : 'hFF;  
	//added for testing that while reading it is taking data or not? 
	//if it take there is bug in the design
	pkt.PWDATA = rw.data;
	`uvm_info("adapter", $sformatf("reg2bus addr = 0x%0h data = 0x%0h kind = %s",
		pkt.PADDR,pkt.PWDATA,rw.kind.name),UVM_LOW);
	return pkt;
  endfunction
   //bus2reg method
 
  virtual function void bus2reg (uvm_sequence_item bus_item, ref uvm_reg_bus_op rw);
     packet pkt; //= packet::type_id::create("pkt");

	if(!$cast (pkt, bus_item)) begin
	  `uvm_fatal("reg2spi_adapter","failed to cast bus_item to pkt")
	end
         
	rw.kind = pkt.PWRITE ? UVM_WRITE : UVM_READ;
	rw.addr = pkt.PADDR;
	rw.data = pkt.PRDATA;

	`uvm_info("reg2spiadapter", $sformatf("bus2reg : addr = 0x%0h data = 0x%0h kind = %s status = %s readdata = %0h",rw.addr,rw.data,rw.kind.name(),rw.status.name(),pkt.PRDATA),UVM_LOW);

  endfunction

endclass


