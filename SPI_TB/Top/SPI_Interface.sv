interface spi_interface(input logic PCLK);
  		
  logic		PRESETN;
  logic         [31:0]PADDR;
  logic 	PSEL;
  logic         [31:0]PWDATA;
  logic		PWRITE;
  logic		MISO_IN;
  logic         MISO_OUT;
  logic 	[31:0]PRDATA;
  logic	        PREADY;
  logic 	PSLVERR;
  logic	        MOSI_IN;
  logic         MOSI_OUT;
  logic         PENABLE;
  logic         sck;

 assign  sck   = dut.top.generater.SCK;
  

  clocking spi_cb@(posedge PCLK);

	default  input #0; 
        default	output #1;

  output 	PADDR;
  output 	PSEL;
  output	PWDATA;
  output	PWRITE;
  output	MISO_IN;
  output        MOSI_IN;
  output        PENABLE;
  
  input 	PRDATA;
  input		PREADY;
  input 	PSLVERR;
  input		MOSI_OUT;
  input         MISO_OUT;

  
  endclocking

  modport spi_mp(clocking spi_cb, input PRESETN);
endinterface
