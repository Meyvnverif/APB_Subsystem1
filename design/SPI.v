//===============================================================================//
// Design Name      : SPI master
// Designer Name    : Purushothama K M
// ==============================================================================//
module SPI (
  input                          SCK_IN,
  input                          SPI_RESETN,
  input                          MISO_IN,
  input                          MOSI_IN,
  input                          RXONLY,
  input                          SPE,
  input                          SSOE,
  input				 SSI,
  input	                         SSM,
  input	                         DFF,
  input [15:0]                   TX_BUFFER,  
  input                          LSBFIRST,
  input	                         MSTR,
  output                         SCK_OUT,
  input                          NSS_IN,
  output                         NSS_OUT,
  output [15:0]                  RX_BUFFER,
  output                         WR_EN,
  output                         RD_EN,
  output                         MISO_OUT,
  output                         MOSI_OUT,
  input                          FULL_TXE,
  input                          EMPTY_TXE
  );
  reg [15:0]                     SHIFT_REGISTER_DFF_TX;
  reg [15:0]                     SHIFT_REGISTER_DFF_RX;
  reg [7:0]                      SHIFT_REGISTER_TX;
  reg [7:0]                      SHIFT_REGISTER_RX;
  reg [3:0]                      COUNT;
  reg                            MOSI;
  wire                           MISO;
  wire                           SCK;
  wire                           NSS;

  assign  MISO        = (MSTR == 1) ? MISO_IN : MOSI_IN;
  assign  MOSI_OUT    = (MSTR == 1) ? MOSI:1'bx;
  assign  MISO_OUT    = (MSTR == 0) ? MOSI:'bx;
  assign  WR_EN       = (RX_BUFFER != 'bx) ? 1'b1:1'b0;
  assign  RD_EN       = ((EMPTY_TXE != 1) && (FULL_TXE == 1 | FULL_TXE == 0)) ? 1'b1:1'b0;
  assign  SCK         = (MSTR == 1) ? SCK_IN : SCK_OUT;
  assign  NSS         = (MSTR == 0) ? NSS_OUT : 1'b1; 
  assign  RX_BUFFER   = (((MISO == 1'b0) | (MISO == 1'b1)) & COUNT == 3'b111) ? DFF ? SHIFT_REGISTER_DFF_RX : SHIFT_REGISTER_RX : 8'bx;
  assign  NSS_OUT     = (MSTR == 1) ? (SSM == 1 ) ?  SSI : (SSOE == 1 ) ? 1'b0 : 1'b1 : 1'b1;
  assign  SCK_OUT     = (MSTR == 1) ? (NSS == 0) ? SCK : 1'b0 : 1'b0 ;
  
  
  // Transmission in spi in bidi mode off
  always@(posedge SCK or negedge SPI_RESETN) begin
    if(SPI_RESETN == 0) begin 
      MOSI                                     <= 1'b0;
      SHIFT_REGISTER_TX                        <= 'b0;
      SHIFT_REGISTER_DFF_TX                    <= 'b0;
      COUNT                                    <= 'b0;
    end else if(SPE == 1'b1) begin
      if ((MSTR == 1'b1) || ((MSTR == 1'b0) && (NSS_IN == 1'b0))) begin
	if((LSBFIRST == 1'b1) && ((RXONLY == 1'b0) )) begin
	  if((DFF == 0) && ((TX_BUFFER != 'b0) || (TX_BUFFER != 'b1)))begin
            COUNT			       <= 'b000;
	    MOSI			       <= TX_BUFFER[0];
	    SHIFT_REGISTER_TX                  <= {1'b0,TX_BUFFER[7:1]};
	    if(COUNT != 'b111 ) begin
	      COUNT			       <= COUNT + 4'b1;
              MOSI			       <= SHIFT_REGISTER_TX[0];
	      SHIFT_REGISTER_TX                <= SHIFT_REGISTER_TX >> 1;
            end else if(COUNT == 'b111) begin
	      COUNT                            <= 'b0;
	    end
	  end if((DFF == 1) && ((TX_BUFFER != 'b0) || (TX_BUFFER != 'b1))) begin
	    COUNT			       <= 'b000;
	    MOSI			       <= TX_BUFFER[0];
	    SHIFT_REGISTER_DFF_TX              <= {1'b0,TX_BUFFER[15:1]};
	    if(COUNT != 'b1111 ) begin
	      COUNT			       <= COUNT + 4'b1;
              MOSI			       <= SHIFT_REGISTER_DFF_TX[0];
	      SHIFT_REGISTER_DFF_TX            <= SHIFT_REGISTER_DFF_TX >> 1;
            end else  if(COUNT == 'b1111) begin
	      COUNT                            <= 'b0;
	    end
	  end
	end else if((LSBFIRST == 1'b0) && ((RXONLY == 1'b0) )) begin
	  if((DFF == 0) && ((TX_BUFFER != 'b0) || (TX_BUFFER != 'b1))) begin
	    COUNT			       <= 'b000;
	    MOSI			       <= TX_BUFFER[7];
	    SHIFT_REGISTER_TX                  <= {TX_BUFFER[6:0],1'b0};
	    if(COUNT != 'b111 ) begin
	      COUNT	                       <= COUNT + 4'b1;
	      MOSI                             <= SHIFT_REGISTER_TX[7];
              SHIFT_REGISTER_TX		       <= SHIFT_REGISTER_TX << 1;
	    end else if(COUNT == 'b111) begin
	      COUNT                            <= 3'b0;
	    end
	  end else if((DFF == 1) && ((TX_BUFFER != 'b0) || (TX_BUFFER != 'b1))) begin
            COUNT                              <= 'b000;
            MOSI                               <= TX_BUFFER[15];
            SHIFT_REGISTER_DFF_TX              <= {TX_BUFFER[14:0],1'b0};
            if(COUNT != 'b1111 ) begin
              COUNT	                       <= COUNT + 4'b1;
              MOSI	                       <= SHIFT_REGISTER_DFF_TX[15];
              SHIFT_REGISTER_DFF_TX            <= SHIFT_REGISTER_DFF_TX << 1;
            end else if(COUNT == 'b111) begin
              COUNT                   <= 'b0;
            end
	  end
        end
      end
    end 
  end

  // Receive in bidimode off state
  always@(posedge SCK or negedge SPI_RESETN) begin
    if(SPI_RESETN == 0) begin
      SHIFT_REGISTER_RX                        <= 'b0;
      SHIFT_REGISTER_DFF_RX                    <= 'b0;
      COUNT                                    <= 'b0;
    end else if(SPE == 1'b1) begin 
      if(MSTR == 1'b1) begin
	if((LSBFIRST == 1'b1) && (RXONLY == 1'b0)) begin
	  if((DFF == 0)  && ((MISO != 'b0) || (MISO != 'b1))) begin
            COUNT                              <= 'b000;
            SHIFT_REGISTER_RX                  <= {MISO,7'b0};
	    if(COUNT != 'b111 ) begin
	      COUNT	                       <= COUNT + 4'b1;
              SHIFT_REGISTER_RX		       <= SHIFT_REGISTER_RX >> 1;
              SHIFT_REGISTER_RX[7]	       <= MISO; 
	    end
	  end else if((DFF == 1) && ((MISO != 'b0) || (MISO != 'b1))) begin
	    COUNT                       <= 'b000;
	    SHIFT_REGISTER_DFF_RX              <= {MISO,15'b0};
	    if(COUNT != 'b1111 ) begin
              COUNT	                <= COUNT + 4'b1;
              SHIFT_REGISTER_DFF_RX            <= SHIFT_REGISTER_DFF_RX >> 1;
              SHIFT_REGISTER_DFF_RX[15]        <= MISO; 
	    end 
          end
        end else if((LSBFIRST == 1'b0) && ((RXONLY == 4'b1) || (RXONLY == 1'b0))) begin    
          if(((DFF == 0) || (DFF == 1)) && ((MISO != 'b0) || (MISO != 'b1))) begin
            COUNT                              <= 'b000;
            SHIFT_REGISTER_RX[0]               <= MISO;
	    if(COUNT != 'b111 ) begin
	      COUNT	                       <= COUNT + 4'b1;
              SHIFT_REGISTER_RX                <= SHIFT_REGISTER_RX << 1;
              SHIFT_REGISTER_RX[0]	       <= MISO; 
	    end else if(COUNT == 3'b111) begin
	      COUNT                            <= 'b0;
	    end
          end else if((DFF == 1) && ((MISO != 'b0) || (MISO != 'b1))) begin
	    COUNT                              <= 'b000;
	    SHIFT_REGISTER_DFF_RX              <= {15'b0,MISO};
	    if(COUNT != 'b1111 ) begin
              COUNT	                       <= COUNT + 4'b1;
              SHIFT_REGISTER_DFF_RX            <= SHIFT_REGISTER_DFF_RX << 1;
              SHIFT_REGISTER_DFF_RX[0]	       <= MISO; 
	    end else if(COUNT == 'b1111) begin
              COUNT                     <= 3'b0;
	    end
	  end
	end
      end
    end
  end
endmodule
