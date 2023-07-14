module SPI_CLOCK_GEN(
  input             PCLK,
  input             PRESETN,
  input	            CPOL,
  input             CPHA,
  input	[2:0]       BR,
  output reg	    SCK
  );
  reg               CLK;
  wire              CLK_BAR;
  reg [7:0]         COUNT;

  assign CLK_BAR = ~ CLK;
  always@(posedge PCLK or negedge PRESETN) begin
    if(PRESETN == 0)
      COUNT       <= 8'b0;
    else 
      COUNT       <= COUNT + 1'b1;
  end

  always@(*) begin
    case({CPOL,CPHA})
      2'b00 : SCK = CLK;
      2'b01 : SCK = CLK_BAR;
      2'b10 : SCK = CLK_BAR;
      2'b11 : SCK = CLK;
      default:SCK = 1'b1;
    endcase
  end 
 
  always@(*) begin
    case(BR)
      3'b000 : CLK = COUNT[0];
      3'b001 : CLK = COUNT[1];
      3'b010 : CLK = COUNT[2];
      3'b011 : CLK = COUNT[3];
      3'b100 : CLK = COUNT[4];
      3'b101 : CLK = COUNT[5];
      3'b110 : CLK = COUNT[6];
      3'b111 : CLK = COUNT[7];
      default: CLK = 1'b0;
    endcase
  end
endmodule  
