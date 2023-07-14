`include"double_ff_sync.v"
module A_fifo #(
  parameter                     DEPTH = 16,
  parameter                     WIDTH = 16
  )
  (
  input                         WCLK,
  input                         W_RESETN,
  input                         RCLK,
  input                         R_RESETN,
  input                         WR_EN,
  input [WIDTH-1:0]             DATA_IN,
  input                         RD_EN,
  output                        FULL,
  output                        EMPTY,
  output reg [WIDTH-1:0]        DATA_OUT
  );
  wire [3:0]                    SYNC_WR_POINTER;
  wire [3:0]                    SYNC_RD_POINTER;
  wire  [3:0]                   WR_POINTER;
  wire  [3:0]                   RD_POINTER;
  reg [3:0]                     WR_ADDRESS;
  reg [3:0]                     RD_ADDRESS;
  
  reg  [WIDTH-1:0] mem [DEPTH-1:0];
    
   //synchronising read pointer to write clock
  double_ff_sync WRITE_POINTER_0(
    .CLOCK(WCLK),
    .RESETN(W_RESETN),
    .d(RD_POINTER[0]),
    .q1(SYNC_RD_POINTER[0])
  );

  double_ff_sync WRITE_POINTER_1(
    .CLOCK(WCLK),
    .RESETN(W_RESETN),
    .d(RD_POINTER[1]),
    .q1(SYNC_RD_POINTER[1])
  );

  double_ff_sync WRITE_POINTER_2(
    .CLOCK(WCLK),
    .RESETN(W_RESETN),
    .d(RD_POINTER[2]),
    .q1(SYNC_RD_POINTER[2])
  );

  double_ff_sync WRITE_POINTER_3(
    .CLOCK(WCLK),
    .RESETN(W_RESETN),
    .d(RD_POINTER[3]),
    .q1(SYNC_RD_POINTER[3])
  );

  // synchronising write pointer to read clock
  double_ff_sync READ_POINTER_0(
    .CLOCK(RCLK),
    .RESETN(R_RESETN),
    .d(WR_POINTER[0]),
    .q1(SYNC_WR_POINTER[0])
  );

   double_ff_sync READ_POINTER_1(
    .CLOCK(RCLK),
    .RESETN(R_RESETN),
    .d(WR_POINTER[1]),
    .q1(SYNC_WR_POINTER[1])
  );

   double_ff_sync READ_POINTER_2(
    .CLOCK(RCLK),
    .RESETN(R_RESETN),
    .d(WR_POINTER[2]),
    .q1(SYNC_WR_POINTER[2])
  );

   double_ff_sync READ_POINTER_3(
    .CLOCK(RCLK),
    .RESETN(R_RESETN),
    .d(WR_POINTER[3]),
    .q1(SYNC_WR_POINTER[3])
  );

  always@(posedge WCLK or negedge W_RESETN) begin
    if(W_RESETN == 0) begin
      mem[WR_ADDRESS]        <= 8'b0;
      WR_ADDRESS             <= 4'b0;
    end else if(FULL != 1 && WR_EN == 1'b1) begin 
      mem[WR_ADDRESS]        <= DATA_IN;
      WR_ADDRESS             <= WR_ADDRESS + 'b1;
    end  else if(FULL == 1 && WR_ADDRESS == 4'b1111)
      WR_ADDRESS             <= WR_ADDRESS + 'b0;
  end

  always@(posedge RCLK or negedge R_RESETN) begin
    if(R_RESETN == 0) begin
      DATA_OUT          <= 8'b0;
      RD_ADDRESS        <= 4'b0;
    end else if(EMPTY != 1 && RD_EN == 1'b1) begin 
      DATA_OUT          <= mem[RD_ADDRESS];
      RD_ADDRESS        <= RD_ADDRESS + 'b1;
    end else if(EMPTY == 1 && RD_ADDRESS == 4'b1111)
      RD_ADDRESS        <= RD_ADDRESS + 'b0;
  end

  assign FULL  = ( SYNC_WR_POINTER == 4'hb) ? 1'b1:1'b0;
  assign EMPTY = (( SYNC_RD_POINTER == 4'hb) && (SYNC_RD_POINTER[3] == SYNC_WR_POINTER[3])) ? 1'b1:1'b0;
  assign WR_POINTER = (WR_EN == 1)  ? {WR_ADDRESS[3],WR_ADDRESS[3] ^ WR_ADDRESS[2],WR_ADDRESS[2] ^ WR_ADDRESS[1],WR_ADDRESS[1] ^ WR_ADDRESS[0]} : 4'b0000;
  assign RD_POINTER = (RD_EN == 1)  ? {RD_ADDRESS[3],RD_ADDRESS[3] ^ RD_ADDRESS[2],RD_ADDRESS[2] ^ RD_ADDRESS[1],RD_ADDRESS[1] ^ RD_ADDRESS[0]} : 4'b0000;
  
endmodule  
