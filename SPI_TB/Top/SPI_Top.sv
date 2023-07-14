`include "defines.sv"
module top;

bit clk,rst;

//initialising clk and reset
initial begin
 clk=0;
 intf.PRESETN= 0;
#20;
 intf.PRESETN= 1;
end

//clock Generation
always #5 clk=~clk;

// interface
spi_interface intf(clk);
//dut instantiation
  SPI_WRAPPER dut( .PCLK(intf.PCLK),
	       .PRESETN(intf.PRESETN),
               .PADDR(intf.PADDR),
    	       .PSEL(intf.PSEL), 
	       .MISO_IN(intf.MISO_IN),
	       .MISO_OUT(intf.MISO_OUT),
	       .MOSI_IN(intf.MOSI_IN),
	       .MOSI_OUT(intf.MOSI_OUT), 
               .PWDATA(intf.PWDATA),
  	       .PWRITE(intf.PWRITE),
   	       .PRDATA(intf.PRDATA),
  	       .PREADY(intf.PREADY),
  	       .PSLVERR(intf.PSLVERR),
               .PENABLE(intf.PENABLE));

initial begin
//set interface in config_db
uvm_config_db#(virtual spi_interface)::set(null,"*","vif",intf);
end
//Assetion binding 
bind dut.top.apb_slave spi_assertions apb_assert(.PCLK(PCLK), .PRESETN(PRESETN) , .PADDR(PADDR) ,.PENABLE(PENABLE), .PSEL(PSEL), .PWDATA(PWDATA), .PWRITE(PWRITE), .PREADY(PREADY));

//test run
initial begin
run_test();
end

endmodule
