//================================================================================//
// Design Name		: SPI TOP
// Designer Name	: Purushothama K M
// ==============================================================================//
`include "module_apb_interface.v"
`include "SPI.v"
`include "SPI_CLOCK_GEN.v"
`include "A_fifo.v"
module SPI_TOP(
  input				PCLK,
  input				PRESETN,
  input				PENABLE,
  input [31:0]			PADDR,
  input 			PSEL,
  input [31:0]			PWDATA,
  input				PWRITE,
  input				MISO_IN,
  input                         MOSI_IN,
  output [31:0]			PRDATA,
  output			PREADY,
  output 			PSLVERR,
  output                        MISO_OUT,
  output			MOSI_OUT
  );
  
  wire 				BIDIMODE;
  wire				BIDIOE;
  wire				CRCEN;
  wire				CRCNEXT;
  wire				DFF;
  wire				RXONLY;
  wire				SSM;
  wire				SSI;
  wire				LSBFIRST;
  wire				SPE;
  wire [2:0]		        BR;
  wire				MSTR;
  wire				CPOL;
  wire				CPHA;
  // SPI_CR2 outputs
  wire				TXEIE;
  wire				RXNEIE;
  wire				ERRIE;
  wire				SSOE;
  wire				TXDMAEN;
  wire				RXDMAEN;
  // SPI_SR outputs
  wire				BSY;
  wire				OVR;
  wire				MODF;
  wire				CRCERR;
  wire				UDR;
  wire				CHSIDE;
  wire				TXE;
  wire		 		RXNE;
  // SPI_DR
  wire [15:0]                   TX_BUFFER;
  wire [15:0]                   RX_BUFFER;
  // SPI_I2S outputs
  wire				I2SMOD;
  wire				I2SE;
  wire [1:0]	                I2SCFG;
  wire				PCMSYNC;
  wire [1:0]	                I2SSTD;
  wire	                        CKPOL;
  wire [1:0]                    DATLEN;
  wire				CHLEN;
  // SPI_I2SPR outputs
  wire				MCKOE;
  wire				ODD;
  wire [7:0]		        I2SDIV;
  wire                          SCK;
  wire                          SPI_RESETN;
  wire [15:0]                   RX_BUFFER_OUT;
  wire [15:0]                   TX_BUFFER_OUT;
  wire                          RD_EN;
  wire                          WR_EN;
  wire                          RD_EN_TX;
  wire                          WR_EN_TX;
  wire                          READ_RX_BUFFER;
  wire                          SCK_OUT;
  wire                          NSS_OUT;

   
  module_apb_interface apb_slave(
    // apb slave inputs
    .PCLK(PCLK),
    .PRESETN(PRESETN),
    .PADDR(PADDR),
    .PSEL(PSEL),
    .PENABLE(PENABLE),
    .PWDATA(PWDATA),
    .PWRITE(PWRITE),
    // apb slave outputs
    .PREADY(PREADY),
    .PRDATA(PRDATA),
    .PSLVERR(PSLVERR),
    // register flags outputs
    // SPI_CR1 outputs
    .EMPTY(APB_OUT),
    .FULL(APB_IN),
    .BIDIMODE(BIDIMODE),
    .BIDIOE(BIDIOE),
    .CRCEN(CRCEN),
    .CRCNEXT(CRCNEXT),
    .DFF(DFF),
    .RXONLY(RXONLY),
    .SSM(SSM),
    .SSI(SSI),
    .LSBFIRST(LSBFIRST),
    .SPE(SPE),
    .BR(BR),
    .MSTR(MSTR),
    .CPOL(CPOL),
    .CPHA(CPHA),
    // SPI_CR2 outputs
    .TXEIE(TXEIE),
    .RXNEIE(RXNEIE),
    .ERRIE(ERRIE),
    .SSOE(SSOE),
    .TXDMAEN(TXDMAEN),
    .RXDMAEN(RXDMAEN),
    // SPI_SR outputs
    .BSY(BSY),
    .OVR(OVR),
    .MODF(MODF),
    .CRCERR(CRCERR),
    .UDR(UDR),
    .CHSIDE(CHSIDE),
    .TXE(TXE),
    .RXNE(RXNE),
    // SPI_DR
    .TX_BUFFER(TX_BUFFER),
    .RX_BUFFER(RX_BUFFER),
    // SPI_I2S outputs
    .I2SMOD(I2SMOD),
    .I2SE(I2SE),
    .I2SCFG(I2SCFG),
    .PCMSYNC(PCMSYNC),
    .I2SSTD(I2SSTD),
    .CKPOL(CKPOL),
    .DATLEN(DATLEN),
    .CHLEN(CHLEN),
    // SPI_I2SPR outputs
    .MCKOE(MCKOE),
    .ODD(ODD),
    .SPI_RESETN(SPI_RESETN),
    .I2SDIV(I2SDIV),
    .APB_W_EN(WR_EN_TX),
    .APB_R_EN(RD_EN_TX)
    );
 
  // SPI master instantiation
  SPI master_slave(
    .SCK_IN(SCK),
    .SPI_RESETN(SPI_RESETN),
    .MISO_IN(MISO_IN),
    .MOSI_IN(MOSI_IN),
    .RXONLY(RXONLY),
    .SPE(SPE),
    .SSOE(SSOE),
    .SSI(SSI),
    .SSM(SSM),
    .DFF(DFF),
    .TX_BUFFER(TX_BUFFER_OUT),  
    .LSBFIRST(LSBFIRST),
    .MSTR(MSTR),
    .SCK_OUT(SCK_OUT),
    .NSS_IN(NSS_OUT),
    .NSS_OUT(NSS_OUT),
    .RX_BUFFER(RX_BUFFER_OUT),
    .WR_EN(WR_EN),
    .RD_EN(RD_EN),
    .MISO_OUT(MISO_OUT),
    .MOSI_OUT(MOSI_OUT),
    .FULL_TXE(FULL),
    .EMPTY_TXE(APB_OUT)
  );
 
  SPI_CLOCK_GEN  generater(
    .PCLK(PCLK),
    .PRESETN(PRESETN),
    .CPOL(CPOL),
    .CPHA(CPHA),
    .BR(BR),
    .SCK(SCK)
  );

  // Fifo instantiation for TXE flag update 
  A_fifo  TXE_flag(
    .WCLK(PCLK),
    .W_RESETN(PRESETN),
    .RCLK(SCK),
    .R_RESETN(PRESETN),
    .WR_EN(WR_EN_TX),
    .DATA_IN(TX_BUFFER),
    .RD_EN(RD_EN),
    .FULL(FULL),
    .EMPTY(APB_OUT),
    .DATA_OUT(TX_BUFFER_OUT)
  );

  // FIFO instantiation for RXNE flag update
  A_fifo  RXNE_flag(
    .WCLK(SCK),
    .W_RESETN(PRESETN),
    .RCLK(PCLK),
    .R_RESETN(PRESETN),
    .WR_EN(WR_EN ),
    .DATA_IN(RX_BUFFER_OUT),
    .RD_EN(RD_EN_TX),
    .FULL(APB_IN),
    .EMPTY(EMPTY),
    .DATA_OUT(RX_BUFFER)
  );

  
endmodule
