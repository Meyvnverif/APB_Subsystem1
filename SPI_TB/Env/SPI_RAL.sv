
class SPI_CR1_reg extends uvm_reg;
  
  rand uvm_reg_field CPHA;
  rand uvm_reg_field CPOL;
  rand uvm_reg_field MSTR;
  rand uvm_reg_field BR;
  rand uvm_reg_field SPE;
  rand uvm_reg_field LSBFIRST;
  rand uvm_reg_field SSI;
  rand uvm_reg_field SSM;
  rand uvm_reg_field RXONLY;
  rand uvm_reg_field DFF;
  rand uvm_reg_field CRCNEXT;
  rand uvm_reg_field CRCEN;
  rand uvm_reg_field BIDIOE;
  rand uvm_reg_field BIDIMODE;
   
  //Functional coverage
  covergroup cr1_cov();
   cpha:coverpoint CPHA.value[1];
   cpol: coverpoint CPOL.value[1];
   mstr: coverpoint MSTR.value[1];
   br: coverpoint BR.value[2:0];
   spe: coverpoint SPE.value[1];
   lsbfirst: coverpoint LSBFIRST.value[1];
   ssi: coverpoint SSI.value[1];
   ssm: coverpoint SSM.value[1];
   rxonly: coverpoint RXONLY.value[1];
   dff: coverpoint DFF.value[1];
   crcnext: coverpoint CRCNEXT.value[1];
   crcen: coverpoint CRCEN.value[1];
   bidioe: coverpoint BIDIOE.value[1];
   bidimode: coverpoint BIDIMODE.value[1];
endgroup  
  
  `uvm_object_utils(SPI_CR1_reg)
  
  function new(string name = "SPI_CR1_reg");
  super.new(name,16,build_coverage(UVM_CVR_FIELD_VALS));
  add_coverage(build_coverage(UVM_CVR_FIELD_VALS));
  if(has_coverage(UVM_CVR_FIELD_VALS)) begin
	  cr1_cov = new();
	  //cr1_cov.set_inst_name(name);
  end
  endfunction

   virtual function void sample(uvm_reg_data_t  data,
                                          uvm_reg_data_t  byte_en,
                                          bit             is_read,
                                          uvm_reg_map     map);
          if(get_coverage(UVM_CVR_FIELD_VALS))
             cr1_cov.sample();
 
      endfunction: sample
  
  virtual function void build();
    
    // Create object instance for each register field
    LSBFIRST = uvm_reg_field::type_id::create("LSBFIRST");
    SPE = uvm_reg_field::type_id::create("SPE");
    BR = uvm_reg_field::type_id::create("BR");
    MSTR = uvm_reg_field::type_id::create("MSTR");
    CPOL = uvm_reg_field::type_id::create("CPOL");
    CPHA = uvm_reg_field::type_id::create("CPHA");
    BIDIMODE = uvm_reg_field::type_id::create("BIDIMODE");
    BIDIOE = uvm_reg_field::type_id::create("BIDIOE");
    CRCEN = uvm_reg_field::type_id::create("CRCEN");
    CRCNEXT = uvm_reg_field::type_id::create("CRCNEXT");
    DFF = uvm_reg_field::type_id::create("DFF");
    RXONLY = uvm_reg_field::type_id::create("RXONLY");
    SSM = uvm_reg_field::type_id::create("SSM");
    SSI = uvm_reg_field::type_id::create("SSI");
    
    // Configure each field
	//regmodel.register_name.field_name.set(value)
	//configure(parent,size,lsb_pos,access,volatile,reset,has_reset,is_rand,individually_accessible);
	this.CPHA.configure(this,1,0,"RW",0,1'h0,1,1,1);
	this.CPOL.configure(this,1,1,"RW",0,1'h0,1,1,1);
        this.MSTR.configure(this,1,2,"RW",0,1'h0,1,1,1);
	this.BR.configure(this,3,3,"RW",0,3'h0,1,1,1);
	this.SPE.configure(this,1,6,"RW",0,1'h0,1,1,1);
	this.LSBFIRST.configure(this,1,7,"RW",0,1'h0,1,1,1);
	this.SSI.configure(this,1,8,"RW",0,1'h0,1,1,1);	
	this.SSM.configure(this,1,9,"RW",0,1'h0,1,1,1);
        this.RXONLY.configure(this,1,10,"RW",0,1'h0,1,1,1);
        this.DFF.configure(this,1,11,"RW",0,1'h0,1,1,1);
        this.CRCNEXT.configure(this,1,12,"RW",0,1'h0,1,1,1);
        this.CRCEN.configure(this,1,13,"RW",0,1'h0,1,1,1);
        this.BIDIOE.configure(this,1,14,"RW",0,1'h0,1,1,1);
	this.BIDIMODE.configure(this,1,15,"RW",0,1'h0,1,1,1);
			
    add_hdl_path_slice( .name( "SPI_CR1" ), .offset( 0 ), .size( 2 ) ); 
  endfunction: build
  
endclass: SPI_CR1_reg


class SPI_CR2_reg extends uvm_reg;
  
  rand uvm_reg_field RXDMAEN;
  rand uvm_reg_field TXDMAEN;
  rand uvm_reg_field SSOE;
  rand uvm_reg_field resrvd1;
  rand uvm_reg_field ERRIE;
  rand uvm_reg_field RXNEIE;
  rand uvm_reg_field TXEIE;
  rand uvm_reg_field resrvd2;

  //functional coverage
  covergroup cr2_cov();
   rxdmaen: coverpoint RXDMAEN.value[1];
   txdmaen: coverpoint TXDMAEN.value[1];
   ssoe:    coverpoint SSOE.value[1];
   errie:   coverpoint ERRIE.value[1];
   rxneie:  coverpoint RXNEIE.value[1];
   txeie:   coverpoint TXEIE.value[1];
     endgroup
  `uvm_object_utils(SPI_CR2_reg)
  
  function new(string name = "SPI_CR2_reg");
	  super.new(name,16,build_coverage(UVM_CVR_FIELD_VALS));
  add_coverage(build_coverage(UVM_CVR_FIELD_VALS));
  if(has_coverage(UVM_CVR_FIELD_VALS)) begin
	  cr2_cov = new();
	 // cr2_cov.set_inst_name(name);
  end

    endfunction:new

     virtual function void sample(uvm_reg_data_t  data,
                                          uvm_reg_data_t  byte_en,
                                          bit             is_read,
                                          uvm_reg_map     map);
          if(get_coverage(UVM_CVR_FIELD_VALS))
             cr2_cov.sample();
 
      endfunction: sample

  
  virtual function void build();
    
    // Create object instance for each field
    this.TXEIE = uvm_reg_field::type_id::create("TXEIE");
    this.RXNEIE = uvm_reg_field::type_id::create("RXNEIE");
    this.ERRIE = uvm_reg_field::type_id::create("ERRIE");
    this.SSOE = uvm_reg_field::type_id::create("SSOE");
    this.TXDMAEN = uvm_reg_field::type_id::create("TXDMAEN");
    this.RXDMAEN = uvm_reg_field::type_id::create("RXDMAEN");
    this.resrvd1 = uvm_reg_field::type_id::create("resrvd1");
    this.resrvd2 = uvm_reg_field::type_id::create("resrvd2");

     // Configure each field
    //configure(parent,size,lsb_pos,access,volatile,reset,
    //has_reset,is_rand,individually_accessible);
	this.resrvd2.configure(this,8,8,"RO",1,8'h0,1,1,0);
	this.TXEIE.configure(this,1,7,"RW",0,1'h0,1,1,0);
	this.RXNEIE.configure(this,1,6,"RW",0,1'h0,1,1,0);
	this.ERRIE.configure(this,1,5,"RW",0,1'h0,1,1,0);
	this.resrvd1.configure(this,2,3,"RO",1,2'h0,1,1,0);
	this.SSOE.configure(this,1,2,"RW",0,1'h0,1,1,0);
	this.TXDMAEN.configure(this,1,1,"RW",0,1'h0,1,1,0);
	this.RXDMAEN.configure(this,1,0,"RW",0,1'h0,1,1,0);
	
  endfunction:build
endclass:SPI_CR2_reg

class SPI_SR_reg extends uvm_reg;
  
  rand uvm_reg_field BSY;
  rand uvm_reg_field OVR;
  rand uvm_reg_field MODF;
  rand uvm_reg_field CRCERR;
  rand uvm_reg_field UDR;
  rand uvm_reg_field CHSIDE;
  rand uvm_reg_field TXE;
  rand uvm_reg_field RXNE;
  rand uvm_reg_field resrvd;

  //funcitonal coverage

  covergroup sr_cov();
   bsy: coverpoint BSY.value[1];
   ove: coverpoint OVR.value[1];
   modf: coverpoint MODF.value[1];
   crcerr: coverpoint CRCERR.value[1];
   udr: coverpoint UDR.value[1];
   chside: coverpoint CHSIDE.value[1];
   txe: coverpoint TXE.value[1];
   rxne: coverpoint  RXNE.value[1];
 endgroup
  `uvm_object_utils(SPI_SR_reg)
  
  function new(string name = "SPI_SR_reg");
    super.new(name,16,build_coverage(UVM_CVR_FIELD_VALS));
  add_coverage(build_coverage(UVM_CVR_FIELD_VALS));
  if(has_coverage(UVM_CVR_FIELD_VALS)) begin
	  sr_cov = new();
	 // sr_cov.set_inst_name(name);
  end
  endfunction:new

   virtual function void sample(uvm_reg_data_t  data,
                                          uvm_reg_data_t  byte_en,
                                          bit             is_read,
                                          uvm_reg_map     map);
          if(get_coverage(UVM_CVR_FIELD_VALS))
             sr_cov.sample();
 
      endfunction: sample

  
  virtual function void build();
    
    // Create object instance for each field
    BSY = uvm_reg_field::type_id::create("BSY");
    OVR = uvm_reg_field::type_id::create("OVR");
    MODF = uvm_reg_field::type_id::create("MODF");
    CRCERR = uvm_reg_field::type_id::create("CRCERR");
    UDR = uvm_reg_field::type_id::create("UDR");
    CHSIDE = uvm_reg_field::type_id::create("CHSIDE");
    TXE = uvm_reg_field::type_id::create("TXE");
    RXNE = uvm_reg_field::type_id::create("RXNE");
    resrvd = uvm_reg_field::type_id::create("resrvd");
     // Configure each field
    //configure(parent,size,lsb_pos,access,volatile,reset,has_reset,is_rand,individually_accessible);

	this.resrvd.configure(this,8,8,"RO",1,8'h0,1,1,0);
	this.BSY.configure(this,1,7,"RO",0,1'h0,1,1,0);
	this.OVR.configure(this,1,6,"RO",0,1'h0,1,1,0);
	this.MODF.configure(this,1,5,"RO",0,1'h0,1,1,0);
	this.CRCERR.configure(this,1,4,"W0C",0,1'h0,1,1,0); //RC_W0
        this.UDR.configure(this,1,3,"RO",0,1'h0,1,1,0);
	this.CHSIDE.configure(this,1,2,"RO",0,1'h0,1,1,0);
	this.TXE.configure(this,1,1,"RO",0,1'h1,1,1,0);
	this.RXNE.configure(this,1,0,"RO",0,1'h0,1,1,0);
	
	
  endfunction:build
endclass:SPI_SR_reg

class SPI_DR_TX_reg extends uvm_reg;
`uvm_object_utils(SPI_DR_TX_reg)


  	rand uvm_reg_field DR;

	covergroup dr_tx_cov();
       dr: coverpoint DR.value[15:0];
       endgroup
       
	function new(string name ="SPI_DR_TX_reg");
  super.new(name,16,build_coverage(UVM_CVR_FIELD_VALS));
  add_coverage(build_coverage(UVM_CVR_FIELD_VALS));
  if(has_coverage(UVM_CVR_FIELD_VALS)) begin
	  dr_tx_cov = new();
	 // dr_tx_cov.set_inst_name(name);
	  end
	endfunction

	 virtual function void sample(uvm_reg_data_t  data,
                                          uvm_reg_data_t  byte_en,
                                          bit             is_read,
                                          uvm_reg_map     map);
          if(get_coverage(UVM_CVR_FIELD_VALS))
             dr_tx_cov.sample();
 
      endfunction: sample


	virtual function void build();
	//create object
  	DR = uvm_reg_field::type_id::create("DR");

	//configure each field
	this.DR.configure(this,16,0,"RW",0,16'h0,1,1,1);
	endfunction


endclass

class SPI_DR_RX_reg extends uvm_reg;
`uvm_object_utils(SPI_DR_RX_reg)


  	rand uvm_reg_field DR;

	covergroup dr_rx_cov();
	       dr: coverpoint DR.value[15:0];
       endgroup

	function new(string name ="SPI_DR_RX_reg");
  super.new(name,16,build_coverage(UVM_CVR_FIELD_VALS));
  add_coverage(build_coverage(UVM_CVR_FIELD_VALS));
  if(has_coverage(UVM_CVR_FIELD_VALS)) begin
	  dr_rx_cov = new();
	//  dr_rx_cov.set_inst_name(name);
        end
	endfunction

 virtual function void sample(uvm_reg_data_t  data,
                                          uvm_reg_data_t  byte_en,
                                          bit             is_read,
                                          uvm_reg_map     map);
          if(get_coverage(UVM_CVR_FIELD_VALS))
             dr_rx_cov.sample();
 
      endfunction: sample


	virtual function void build();
	//create object
  	DR = uvm_reg_field::type_id::create("DR");

	//configure each field
	this.DR.configure(this,16,0,"RO",0,16'h0,1,1,1);
	endfunction


endclass


class module_reg extends uvm_reg_block;
  
  rand SPI_CR1_reg spi_cr1;
  rand SPI_CR2_reg spi_cr2;
  rand SPI_SR_reg spi_sr;
  rand SPI_DR_TX_reg spi_dr_tx;
  rand SPI_DR_RX_reg spi_dr_rx;
  
  `uvm_object_utils(module_reg)
  
  function new(string name = "module_reg");
    super.new(name);
  endfunction
  
  virtual function void build();
    //Coverage
    uvm_reg::include_coverage("*",UVM_CVR_ALL);
    default_map = create_map("", `UVM_REG_ADDR_WIDTH'h0, 4, UVM_LITTLE_ENDIAN, 1);    
    
    spi_cr1 = SPI_CR1_reg::type_id::create("spi_cr1",,get_full_name());
    spi_cr1.configure(this,null,"");
    spi_cr1.build();
    //coverage
    spi_cr1.set_coverage(UVM_CVR_ALL);
    //spi_cr1.add_hdl_path_slice("SPI_CR1",0,spi_cr1.get_n_bits());
    this.default_map.add_reg (spi_cr1,`UVM_REG_ADDR_WIDTH'h0, "RW", 0);
   // add_hdl_path_slice( .name( ""SPI_CR1 ), .offset( 0 ), .size( 2 ) ); 

    spi_cr2 =SPI_CR2_reg::type_id::create("spi_cr2",,get_full_name());
    spi_cr2.configure(this,null,"");
    spi_cr2.build();
    spi_cr2.set_coverage(UVM_CVR_ALL);
    spi_cr2.add_hdl_path_slice("SPI_CR2",0,spi_cr2.get_n_bits());
    this.default_map.add_reg (spi_cr2,`UVM_REG_ADDR_WIDTH'h4, "RW", 0);

    spi_sr = SPI_SR_reg::type_id::create("spi_sr",,get_full_name());
    spi_sr.configure(this,null,"");
    spi_sr.build();
    spi_sr.set_coverage(UVM_CVR_ALL);
    spi_sr.add_hdl_path_slice("SPI_SR",0,spi_sr.get_n_bits());
    this.default_map.add_reg (spi_sr,`UVM_REG_ADDR_WIDTH'h8, "RO", 0);

    spi_dr_tx = SPI_DR_TX_reg::type_id::create("spi_dr_tx",,get_full_name());
    spi_dr_tx.configure(this,null,"");
    spi_dr_tx.build(); 
    spi_dr_tx.set_coverage(UVM_CVR_ALL);
    spi_dr_tx.add_hdl_path_slice("SPI_DR_TX",0,spi_dr_tx.get_n_bits());
    this.default_map.add_reg (spi_dr_tx,`UVM_REG_ADDR_WIDTH'h0C, "RW", 0);
    
    spi_dr_rx = SPI_DR_RX_reg::type_id::create("spi_dr_rx",,get_full_name());
    spi_dr_rx.configure(this,null,"");
    spi_dr_rx.build(); 
    spi_dr_rx.set_coverage(UVM_CVR_ALL);
    spi_dr_rx.add_hdl_path_slice("SPI_DR_RX",0,spi_dr_rx.get_n_bits());
    this.default_map.add_reg (spi_dr_rx,`UVM_REG_ADDR_WIDTH'h24, "RW", 0);
  endfunction:build
  
  endclass:module_reg
  
  //toplevel class
  
  class spi_reg_model extends uvm_reg_block;
    
    rand module_reg mod_reg;
    
    `uvm_object_utils(spi_reg_model)
    
    function new(string name ="reg_model");
      super.new(name,has_coverage(UVM_NO_COVERAGE));
    endfunction
    
    virtual function build();
      default_map = create_map("", 'h0, 4, UVM_LITTLE_ENDIAN, 0); 
      mod_reg = module_reg::type_id::create("mod_reg",,get_full_name());
      mod_reg.configure(this);   //for backdoor access
      mod_reg.build();
      //add_hdl_path("top");  //for backdoor access
      add_hdl_path("top.dut.top.apb_slave"); 
      lock_model();
      default_map.add_submap (this.mod_reg.default_map,0);
      
    endfunction: build
    
  endclass: spi_reg_model
    


