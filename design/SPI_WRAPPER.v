//===========================================//
// Designer Name     : Purushothama K M
// Design   Name     : SPI Wrapper
//===========================================//
`include "SPI_TOP.v"
module SPI_WRAPPER(
  input	           PCLK,
  input	           PRESETN,
  input            PENABLE,
  input [31:0]     PADDR,
  input            PSEL,
  input [31:0]     PWDATA,
  input	           PWRITE,
  input	           MISO_IN,
  input            MOSI_IN,
  output [31:0]    PRDATA,
  output           PREADY,
  output           PSLVERR,
  output           MISO_OUT,
  output           MOSI_OUT
  );
  
  SPI_TOP top(
    .PCLK(PCLK),
    .PRESETN(PRESETN),
    .PENABLE(PENABLE),
    .PADDR(PADDR),
    .PSEL(PSEL),
    .PWDATA(PWDATA),
    .PWRITE(PWRITE),
    .MISO_IN(MISO_IN),
    .MOSI_IN(MOSI_IN),
    .PRDATA(PRDATA),
    .PREADY(PREADY),
    .PSLVERR(PSLVERR),
    .MISO_OUT(MISO_OUT),
    .MOSI_OUT(MOSI_OUT)
  );
  
endmodule
