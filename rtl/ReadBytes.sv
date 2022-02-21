`include "inc_define.vh"
module ReadBytes 
#( parameter NUMBER = 256 )
(
input clk,
input reset,

input start,
input [clogb2(NUMBER)-1:0] addr,
output logic [31:0] word,
output logic done,

input [7:0] rd_data,
output logic [clogb2(NUMBER)-1:0] rd_addr,
output logic rd_clock
);

logic [3:0] cnt;

always_ff @ (posedge clk, posedge reset)  
  if (reset) cnt <= '1;
  else if (start) cnt <= '0;
  else if (cnt != 4'hf) cnt <= cnt + 1'b1;
    
always_ff @ (posedge clk, posedge reset)    
  if (reset) rd_addr <= '0;
  else if (start) rd_addr <= addr;
  else if ((cnt[0])&(cnt[3:1] < 3'd4)) 
    rd_addr <= rd_addr + 1'b1;
    
always_ff @ (posedge clk, posedge reset)    
  if (reset) rd_clock <= 1'b0;
  else if ((!cnt[0])&(cnt[3:1] < 3'd4)) rd_clock <= 1'b1;
  else rd_clock <= 1'b0;

always_ff @ (posedge clk, posedge reset)	  
  if (reset) word <= '0;
  else if ((!cnt[3])&(cnt[0])) begin
    word[31:24] <= rd_data;
    word[23:0] <= word[31:8];
  end
  
always_ff @ (posedge clk, posedge reset)  
	if (reset) done <= 1'b0;
	else if (start) done <= 1'b0;
	else if (cnt[3:1] == 4'd4) done <= 1'b1;

endmodule