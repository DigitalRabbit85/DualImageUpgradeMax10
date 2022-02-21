`include "inc_define.vh"
module Reset 
( 				
input clk, 
output reset );

logic [4:0] cnt = '0;

always_ff @ (posedge clk)
  if (cnt < 4'hf) cnt <= cnt + 1'b1;   
assign reset = (cnt < 4'ha);
					
endmodule


