
class spi_master_driver extends uvm_driver#(packet);

	`uvm_component_utils(spi_master_driver)
  virtual spi_interface drv_if;
	//Default Constructor
  function new (string name = "spi_master_driver", uvm_component parent = null);
	super.new(name,parent);
  endfunction

  //build phase
  function void build_phase(uvm_phase phase);
	super.build_phase(phase);
	uvm_config_db#(virtual spi_interface)::get(this,"","vif",drv_if);
  endfunction

  task run_phase(uvm_phase phase);
	forever begin
	seq_item_port.get_next_item(req);
	`uvm_info(get_type_name, $sformatf("inside driver run_phase"),UVM_LOW);   
	  drive();    
	seq_item_port.item_done();
	end
  endtask

 task drive();
	 @(posedge drv_if.spi_cb);
	 drv_if.spi_mp.spi_cb.PENABLE <=1;
	 drv_if.spi_mp.spi_cb.PSEL  <= 1;
	 drv_if.spi_mp.spi_cb.PADDR <= req.PADDR;
	 drv_if.spi_mp.spi_cb.PWDATA <= req.PWDATA;
         drv_if.spi_mp.spi_cb.PWRITE <= req.PWRITE;
	 drv_if.spi_mp.spi_cb.MISO <=req.MISO;
	repeat(3)@(posedge drv_if.spi_cb);
	req.PRDATA = drv_if.PRDATA;

 endtask
endclass
