class apb_driver extends uvm_driver#(packet);

	`uvm_component_utils(apb_driver)
  virtual spi_interface drv_if;
	//Default Constructor
  function new (string name = "apb_driver", uvm_component parent = null);
	super.new(name,parent);
  endfunction
  packet req;
  //build phase
  function void build_phase(uvm_phase phase);
	super.build_phase(phase);
	req = packet::type_id::create("req");
	uvm_config_db#(virtual spi_interface)::get(this,"","vif",drv_if);
  endfunction

  task run_phase(uvm_phase phase);
	reset_values();  
	forever begin
	seq_item_port.get_next_item(req);
	`uvm_info(get_type_name, $sformatf("inside driver run_phase"),UVM_LOW);
          	
	  drive();    
	seq_item_port.item_done();
	end
  endtask

  task reset_values();
	 @(posedge drv_if.spi_cb);
         drv_if.spi_cb.PENABLE <=0;
	 drv_if.spi_cb.PSEL  <= 0;
	 drv_if.spi_cb.PADDR <= 0;
	 drv_if.spi_cb.PWDATA <= 0;
         drv_if.spi_cb.PWRITE <= 0;

  endtask

 task drive();
	 //Write
	 wait(drv_if.PRESETN)
	 if(req.PWRITE==1)begin
	 @(posedge drv_if.spi_cb);
	 
	 drv_if.spi_cb.PSEL  <= 1;
	 drv_if.spi_cb.PWRITE <= req.PWRITE;
	 drv_if.spi_cb.PADDR <= req.PADDR;
	 drv_if.spi_cb.PWDATA <= req.PWDATA;      
	 @(posedge drv_if.spi_cb);	 
	 drv_if.spi_cb.PENABLE <= 1;
	 repeat(5)@(posedge drv_if.spi_cb);
         end
	 //Read
	 else if(req.PWRITE==0) begin
	 @(posedge drv_if.spi_cb);
	 drv_if.spi_cb.PSEL  <= 1;
	 drv_if.spi_cb.PADDR <= req.PADDR;
	 drv_if.spi_cb.PWRITE <= req.PWRITE;
	 @(posedge drv_if.spi_cb);
	 drv_if.spi_cb.PENABLE <= 1;
	 req.PRDATA = drv_if.PRDATA;
       	 `uvm_info(get_type_name(),$sformatf("The intf data is %0h and pkt data is %0h",drv_if.PRDATA,req.PRDATA),UVM_NONE)
	 end
	
  endtask
endclass
