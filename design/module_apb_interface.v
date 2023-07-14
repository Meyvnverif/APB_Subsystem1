//===============================================================//
// Design    Name     : module apb interafce
// Designer  Name     : Purushothama K M
//===============================================================//
module module_apb_interface(
  // apb slave inputs
  input			    PCLK,
  input			    PRESETN,
  input[31:0]		    PADDR,
  input			    PSEL,
  input			    PENABLE,
  input [31:0]  	    PWDATA,
  input 		    PWRITE,
  // apb slave outputs
  output  		    PREADY,
  output reg [31:0]	    PRDATA,
  output 		    PSLVERR,
  // register flags outp    uts
  // SPI_CR1 outputs
  input                     EMPTY,
  input                     FULL,
  output                    BIDIMODE,
  output		    BIDIOE,
  output		    CRCEN,
  output		    CRCNEXT,
  output		    DFF,
  output		    RXONLY,
  output                    SSM,
  output		    SSI,
  output		    LSBFIRST,
  output		    SPE,
  output [2:0]		    BR,
  output		    MSTR,
  output		    CPOL,
  output		    CPHA,
  // SPI_CR2 outputs
  output		    TXEIE,
  output		    RXNEIE,
  output		    ERRIE,
  output		    SSOE,
  output		    TXDMAEN,
  output		    RXDMAEN,
  // SPI_SR outputiiis
  output		    BSY,
  output		    OVR,
  output		    MODF,
  output		    CRCERR,
  output		    UDR,
  output		    CHSIDE,
  output 		    TXE,
  output 		    RXNE,
  // SPI_DR
  output [15:0]             TX_BUFFER,
  input [15:0]              RX_BUFFER,
  // SPI_I2S outputs
  output		    I2SMOD,
  output		    I2SE,
  output [1:0]		    I2SCFG,
  output		    PCMSYNC,
  output [1:0]		    I2SSTD,
  output		    CKPOL,
  output [1:0]		    DATLEN,
  output		    CHLEN,
  // SPI_I2SPR outputs
  output		    MCKOE,
  output		    ODD,
  output reg                SPI_RESETN,
  output [7:0]		    I2SDIV,
  output                    APB_W_EN,
  output                    APB_R_EN
  );
 
  wire                      WRITE_SPI_DR_TX;
  wire                      READ_SPI_DR_TX;
  wire                      WRITE_SPI_DR_RX;
  wire                      READ_SPI_DR_RX;
 
  reg [15:0]		    SPI_CR1;
  reg [15:0]		    SPI_CR2;
  reg [15:0]		    SPI_SR;
  reg [15:0]		    SPI_DR_TX;
  reg [15:0]                SPI_DR_RX;
  reg [15:0]		    SPI_CRCPR;
  reg [15:0] 		    SPI_RXCRCR;
  reg [15:0]		    SPI_TXCRCR;
  reg [15:0]		    SPI_I2SCFGR;
  reg [15:0] 		    SPI_I2SPR;

  wire                      SPI_WRITE; // spi write
  wire                      SPI_READ;  // spi read
  wire                      SEL_SPI_CR1; // select spi cr1
  wire                      READ_SPI_CR1;
  wire                      WRITE_SPI_CR1;
  wire                      SEL_SPI_CR2;
  wire                      READ_SPI_CR2;
  wire                      WRITE_SPI_CR2;
  wire                      SEL_SPI_SR;
  wire                      READ_SPI_SR;
  wire                      WRITE_SPI_SR;
  wire                      SEL_SPI_DR_TX;
  wire                      SEL_SPI_DR_RX;
  wire                      SEL_SPI_CRCPR;
  wire                      READ_SPI_CRCPR;
  wire                      WRITE_SPI_CRCPR;
  wire                      SEL_SPI_RXCRCR;
  wire                      READ_SPI_RXCRCR;
  wire                      WRITE_SPI_RXCRCR;
  wire                      SEL_SPI_TXCRCR;
  wire                      READ_SPI_TXCRCR;
  wire                      WRITE_SPI_TXCRCR;
  wire                      SEL_SPI_I2SCFGR;
  wire                      READ_SPI_I2SCFGR;
  wire                      WRITE_SPI_I2SCFGR;
  wire                      SEL_SPI_I2SPR;
  wire                      READ_SPI_I2SPR;
  wire                      WRITE_SPI_I2SPR;

  wire [15:0]               SPI_CR1_WRITE;
  wire [15:0]		    SPI_CR2_WRITE;
  wire [15:0]		    SPI_SR_WRITE;
  wire [15:0]		    SPI_DR_TX_WRITE;
  wire [15:0]		    SPI_DR_RX_WRITE;
  wire [15:0]		    SPI_CRCPR_WRITE;
  wire [15:0] 		    SPI_RXCRCR_WRITE;
  wire [15:0]		    SPI_TXCRCR_WRITE;
  wire [15:0]		    SPI_I2SCFGR_WRITE;
  wire [15:0] 		    SPI_I2SPR_WRITE;

  wire [15:0]               SPI_CR1_READ;
  wire [15:0]		    SPI_CR2_READ;
  wire [15:0]		    SPI_SR_READ;
  wire [15:0]		    SPI_DR_TX_READ;
  wire [15:0]               SPI_DR_RX_READ;
  wire [15:0]		    SPI_CRCPR_READ;
  wire [15:0] 		    SPI_RXCRCR_READ;
  wire [15:0]		    SPI_TXCRCR_READ;
  wire [15:0]		    SPI_I2SCFGR_READ;
  wire [15:0] 		    SPI_I2SPR_READ;

  wire [15:0]               PRDATA_REG;
  wire [15:0]               SPI_DR_RX_TEMP;
    
  // spi registers initi    alising
  parameter 		    SPI_CR1_ADD       = 16'h00 ;      
  parameter 		    SPI_CR2_ADD       = 16'h04 ;
  parameter 		    SPI_SR_ADD        = 16'h08 ;
  parameter 		    SPI_DR_TX_ADD     = 16'h0c;
  parameter 		    SPI_CRCPR_ADD     = 16'h10;
  parameter  		    SPI_RXCRCR_ADD    = 16'h14;
  parameter 		    SPI_TXCRCR_ADD    = 16'h18;
  parameter 		    SPI_I2SCFGR_ADD   = 16'h1c;
  parameter  		    SPI_I2SPR_ADD     = 16'h20;
  parameter                 SPI_DR_RX_ADD     = 16'h24;

  // assign statements for flags generation
  // assigning SPI_CR1 register
  
  assign PSLVERR           = ((( PSEL == 0) || (PENABLE == 0) || ( PREADY == 0)) || (PADDR == 'bx)) ? 'b1 : 'b0;
  assign PREADY             = (PSEL == 1) ? 1'b1:1'b0;
  assign BIDIMODE           = SPI_CR1[15];
  assign BIDIOE             = SPI_CR1[14];
  assign CRCEN	            = SPI_CR1[13];
  assign CRCNEXT            = SPI_CR1[12];
  assign DFF	            = SPI_CR1[11];
  assign RXONLY	            = SPI_CR1[10];
  assign SSM	            = SPI_CR1[9] ;
  assign SSI	            = SPI_CR1[8] ;
  assign LSBFIRST           = SPI_CR1[7] ;
  assign SPE	            = SPI_CR1[6] ;
  assign BR	            = SPI_CR1[5:3];
  assign MSTR               = SPI_CR1[2] ;
  assign CPOL               = SPI_CR1[1] ;
  assign CPHA               = SPI_CR1[0] ;

  // assign statements SPI_CR2 registers
  assign TXEIE              = SPI_CR2[7] ;
  assign RXNEIE             = SPI_CR2[6] ;
  assign ERRIE	            = SPI_CR2[5] ;
  assign SSOE	            = SPI_CR2[2] ;
  assign TXDMAEN            = SPI_CR2[1] ;
  assign RXDMAEN            = SPI_CR2[0] ;

  // assign statement for spi_sr registers
  assign BSY	            = SPI_SR[7]  ;
  assign OVR	            = SPI_SR[6]  ;
  assign MODF	            = SPI_SR[5]  ;
  assign CRCERR             = SPI_SR[4]  ;
  assign UDR	            = SPI_SR[3]  ;
  assign CHSIDE             = SPI_SR[2]  ;
  assign TXE                = EMPTY == 1 ? SPI_SR[1] : EMPTY;
  assign RXNE               = FULL  == 0 ? SPI_SR[0] : FULL ;

  // assign statements for spi_dr_tx
  assign TX_BUFFER          = SPI_DR_TX;
  // assign statements for spi_i2scfgr
  assign I2SMOD             = SPI_I2SCFGR[11];
  assign I2SE	            = SPI_I2SCFGR[10];
  assign I2SCFG             = SPI_I2SCFGR[9:8];
  assign PCMSYNC            = SPI_I2SCFGR[7] ;
  assign I2SSTD	            = SPI_I2SCFGR[5:4];
  assign CKPOL	            = SPI_I2SCFGR[3] ;
  assign DATLEN             = SPI_I2SCFGR[2:1];
  assign CHLEN	            = SPI_I2SCFGR[0] ;
   
  // assign statements for spi_i2spr
  assign MCKOE              = SPI_I2SPR[9];
  assign ODD	            = SPI_I2SPR[8];
  assign I2SDIV	            = SPI_I2SPR[7:0];
  
  assign SPI_WRITE          = PENABLE & PSEL & PWRITE;
  assign SPI_READ           = PENABLE & PSEL & (~PWRITE);
  
  assign SEL_SPI_CR1        = (PADDR == SPI_CR1_ADD) ;
  assign WRITE_SPI_CR1      = SPI_WRITE & SEL_SPI_CR1;
  assign READ_SPI_CR1       = SPI_READ & SEL_SPI_CR1 ;
  assign SEL_SPI_CR2        = (PADDR == SPI_CR2_ADD) ;
  assign WRITE_SPI_CR2      = SPI_WRITE & SEL_SPI_CR2;
  assign READ_SPI_CR2       = SPI_READ & SEL_SPI_CR2 ;
  assign SEL_SPI_SR         = (PADDR == SPI_SR_ADD) ;
  assign WRITE_SPI_SR       = SPI_WRITE & SEL_SPI_SR;
  assign READ_SPI_SR        = SPI_READ & SEL_SPI_SR ;
  assign SEL_SPI_DR_TX      = (PADDR == SPI_DR_TX_ADD) ;
  assign WRITE_SPI_DR_TX    = SPI_WRITE & SEL_SPI_DR_TX;
  assign READ_SPI_DR_TX     = SPI_READ & SEL_SPI_DR_TX ;
  assign SEL_SPI_DR_RX      = (PADDR == SPI_DR_RX_ADD) ;
  assign WRITE_SPI_DR_RX    = SPI_WRITE & SEL_SPI_DR_RX;
  assign READ_SPI_DR_RX     = SPI_READ & SEL_SPI_DR_RX ;
  assign SEL_SPI_CRCPR      = (PADDR == SPI_CRCPR_ADD) ;
  assign WRITE_SPI_CRCPR    = SPI_WRITE & SEL_SPI_CRCPR;
  assign READ_SPI_CRCPR     = SPI_READ & SEL_SPI_CRCPR ;
  assign SEL_SPI_RXCRCR     = (PADDR == SPI_RXCRCR_ADD) ;
  assign WRITE_SPI_RXCRCR   = SPI_WRITE & SEL_SPI_RXCRCR;
  assign READ_SPI_RXCRCR    = SPI_READ & SEL_SPI_RXCRCR ;
  assign SEL_SPI_TXCRCR     = (PADDR == SPI_TXCRCR_ADD) ;
  assign WRITE_SPI_TXCRCR   = SPI_WRITE & SEL_SPI_TXCRCR;
  assign READ_SPI_TXCRCR    = SPI_READ & SEL_SPI_TXCRCR;
  assign SEL_SPI_I2SCFGR    = (PADDR == SPI_I2SCFGR_ADD) ;
  assign WRITE_SPI_I2SCFGR  = SPI_WRITE & SEL_SPI_I2SCFGR;
  assign READ_SPI_I2SCFGR   = SPI_READ & SEL_SPI_I2SCFGR ;
  assign SEL_SPI_I2SPR      = (PADDR == SPI_I2SPR_ADD) ;
  assign WRITE_SPI_I2SPR    = SPI_WRITE & SEL_SPI_I2SPR;
  assign READ_SPI_I2SPR     = SPI_READ & SEL_SPI_I2SPR ;

  assign SPI_CR1_WRITE      = WRITE_SPI_CR1       ? PWDATA : SPI_CR1;
  assign SPI_CR2_WRITE      = WRITE_SPI_CR2       ? PWDATA : SPI_CR2;
  assign SPI_SR_WRITE       = WRITE_SPI_SR        ? PWDATA : SPI_SR;
  assign SPI_DR_TX_WRITE    = WRITE_SPI_DR_TX     ? PWDATA : SPI_DR_TX;
  assign SPI_DR_RX_WRITE    = WRITE_SPI_DR_RX     ? (RX_BUFFER !== 'bx) ? RX_BUFFER : PWDATA : 'b0;
  assign SPI_CRCPR_WRITE    = WRITE_SPI_CRCPR     ? PWDATA : SPI_CRCPR;
  assign SPI_RXCRCR_WRITE   = WRITE_SPI_RXCRCR    ? PWDATA : SPI_RXCRCR;
  assign SPI_TXCRCR_WRITE   = WRITE_SPI_TXCRCR    ? PWDATA : SPI_TXCRCR;
  assign SPI_I2SCFGR_WRITE  = WRITE_SPI_I2SCFGR   ? PWDATA : SPI_I2SCFGR;
  assign SPI_I2SPR_WRITE    = WRITE_SPI_I2SPR     ? PWDATA : SPI_I2SPR;

  assign SPI_CR1_READ       = SPI_CR1;
  assign SPI_CR2_READ       = {8'b0,SPI_CR2[7:0]};
  assign SPI_SR_READ        = {8'b0,2'b10};
  assign SPI_DR_TX_READ     = SPI_DR_TX; 
  assign SPI_DR_RX_READ     = SPI_DR_RX;  
  assign SPI_CRCPR_READ     = SPI_CRCPR;
  assign SPI_RXCRCR_READ    = SPI_RXCRCR;
  assign SPI_TXCRCR_READ    = SPI_TXCRCR;
  assign SPI_I2SCFGR_READ   = {4'b0,SPI_I2SCFGR[11:0]};
  assign SPI_I2SPR_READ     = {6'b0,SPI_I2SPR[9:0]};

  assign PRDATA_REG = (READ_SPI_CR1 == 1) ? SPI_CR1_READ : (READ_SPI_CR2 == 1) ? SPI_CR2_READ : (READ_SPI_SR == 1) ? SPI_SR_READ : (READ_SPI_DR_TX == 1) ? SPI_DR_TX_READ : (READ_SPI_CRCPR == 1) ? SPI_CRCPR_READ : (READ_SPI_RXCRCR ==1) ? SPI_RXCRCR_READ : (READ_SPI_TXCRCR ==1) ? SPI_TXCRCR_READ : (READ_SPI_I2SCFGR == 1) ? SPI_I2SCFGR_READ : (READ_SPI_I2SPR == 1) ? SPI_I2SPR_READ : (READ_SPI_DR_RX == 1) ? SPI_DR_RX_READ : 16'h0 ;

  // APB WRITE 
  always@(posedge PCLK or negedge PRESETN) begin
    if(PRESETN == 0) begin
      SPI_RESETN   <= 1'b0;
      SPI_CR1	  <= 16'h0000;
      SPI_CR2	  <= 16'h0000;
      SPI_SR   	  <= 16'h0002;
      SPI_DR_TX	  <= 16'h0000;
      SPI_DR_RX   <= 16'h0000;
      SPI_CRCPR   <= 16'h0007;
      SPI_RXCRCR  <= 16'h0000;
      SPI_TXCRCR  <= 16'h0000;
      SPI_I2SCFGR <= 16'h0000;
      SPI_I2SPR	  <= 16'h0002;
    end else begin 
      SPI_RESETN           <= 1'b1;
      SPI_CR1             <= SPI_CR1_WRITE;
      SPI_CR2             <= SPI_CR2_WRITE;
      SPI_SR              <= SPI_SR_WRITE;
      SPI_DR_TX           <= SPI_DR_TX_WRITE;
      SPI_DR_RX           <= SPI_DR_RX_WRITE;
      SPI_CRCPR           <= SPI_CRCPR_WRITE;
      SPI_RXCRCR          <= SPI_RXCRCR_WRITE;
      SPI_TXCRCR          <= SPI_TXCRCR_WRITE;
      SPI_I2SCFGR         <= SPI_I2SCFGR_WRITE;
      SPI_I2SPR           <= SPI_I2SPR_WRITE;
    end
  end

  // APB read 
  always@( posedge PCLK or negedge PRESETN ) begin
    if(PRESETN == 0) begin
      SPI_RESETN  <= 1'b0;
      PRDATA      <= 32'h0;
    end else begin
      SPI_RESETN  <= 1'b1;
      PRDATA     <= {16'h0,PRDATA_REG};
    end
  end

  
  assign APB_W_EN = (PWRITE == 1 & PSEL == 1 & PENABLE == 1  )? 1'b1:1'b0;
  assign APB_R_EN  = (PWRITE == 0 & PSEL == 1 & PENABLE == 1 )? 1'b1:1'b0;
    
endmodule
