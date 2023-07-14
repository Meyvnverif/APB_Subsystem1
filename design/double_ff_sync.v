//================================================================//
// Design Name     : double synch
// Designer Name   : Purushothama K M
//================================================================//
module double_ff_sync(
  input				CLOCK,
  input				RESETN,
  input				d,
  output reg		q1
  );
  reg				q0;
  always@(posedge CLOCK or negedge RESETN) begin
	if(RESETN == 1'b0) begin
	  q0		<= 1'b0;
	  q1		<= 1'b0;
	end else begin
	  q0	<= d;
	  q1	<= q0;
	end
  end

endmodule

