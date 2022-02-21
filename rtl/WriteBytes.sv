`include "inc_define.vh"
module WriteBytes
#( parameter NUMBER = 256 )
(
input clk,
input reset,

input start,
input [clogb2(NUMBER)-1:0] addr,
input [31:0] word,
output logic done,

output logic [7:0] wr_data,
output logic [clogb2(NUMBER)-1:0] wr_addr,
output logic wr_clock,
output logic we
);

logic [3:0] cnt;

always_ff @ (posedge clk, posedge reset)
	if (reset) cnt <= '1;
	else if (start) cnt <= '0;
	else if (cnt != 4'hf) cnt <= cnt + 1'b1;

always_ff @ (posedge clk, posedge reset)	
	if (reset) wr_addr <= '0;
	else if (cnt == 4'd0) wr_addr <= addr;
	else if ((!cnt[0])&(cnt[3:1] <= 3'd4)) wr_addr <= wr_addr + 1'b1;
	
always_ff @ (posedge clk, posedge reset)	
	if (reset) wr_clock <= 1'b0;
	else if ((cnt[0])&(cnt[3:1] < 3'd4)) wr_clock <= 1'b1;
	else wr_clock <= 1'b0;	
	
logic [31:0] word_buf;

always_ff @ (posedge clk, posedge reset)
  if (reset) begin 
    word_buf <= '0;
    wr_data <= '0;  end
  else if (start) word_buf <= word;
  else if (!cnt[0]) begin
    wr_data <= word_buf[7:0];
    word_buf[31:0] <= {8'h00,word_buf[31:8]};
  end

always_ff @ (posedge clk, posedge reset)
  if (reset) we <= 1'b0;
  else if (cnt[3:1] < 3'd4) we <= 1'b1;
  else we <= 1'b0;

always_ff @ (posedge clk, posedge reset)
  if (reset) done <= 1'b0;
	else if (start) done <= 1'b0;
	else if (cnt[3:1] == 4'd4) done <= 1'b1;

endmodule