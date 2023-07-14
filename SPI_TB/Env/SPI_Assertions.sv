module spi_assertions (
 
  input			    PCLK,
  input			    PRESETN,
  input[31:0]		    PADDR,
  input			    PSEL,
  input			    PENABLE,
  input [31:0]  	    PWDATA,
  input 		    PWRITE,
  input  		    PREADY
 );

 initial begin 

//	   $monitor (" Assertion WDATA = %0h ", PWDATA);

 end	 

  sequence write;
    PSEL ##1 $stable(PADDR) && $stable(PWDATA) ##0 PENABLE;
  endsequence

property apb_protocol_write;
@(posedge PCLK) disable iff(!PRESETN)
                 PWRITE |-> write;   
endproperty
property apb_protocol_read;
 @(posedge PCLK) disable iff(!PRESETN)
                 (!PWRITE && PSEL) |=>$stable(PADDR) ##0 PENABLE;   
endproperty


//apb_write_asst:assert property (apb_protocol_write); 
//apb_read_asst :assert property (apb_protocol_read);

endmodule
