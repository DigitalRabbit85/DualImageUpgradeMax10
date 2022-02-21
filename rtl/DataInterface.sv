module DataInterface (
input clk,
input reset,

input start_addr,
input start_wrdata,
input start_rddata,

input [23:0] rw_addr,
output logic [31:0] rd_data,
input [31:0] wr_data,

output logic [16:0] Addr,
output logic Read,
output logic Write,
input [31:0] ReadData,
output [31:0] WriteData,
input WaitRequest,
input ReadDataValid,
output [3:0] BurstCount,

output done
);

wire done_read, done_write;
wire incr_addr;

assign incr_addr = (done_read | done_write);

always_ff @ (posedge clk, posedge reset)
	if (reset) Addr <= '0;
	else if (start_addr) Addr <= rw_addr[16:0];
	else if (incr_addr) Addr <= Addr + 1'b1;

always_ff @ (posedge clk, posedge reset)	
	if (reset) Read <= 1'b0;
	else Read <= start_rddata;

always_ff @ (negedge clk, posedge reset)
  if (reset) rd_data <= '0;
  else if (ReadDataValid) rd_data <= ReadData;

logic read_buf;

always_ff @ (posedge clk, posedge reset)
  if (reset) read_buf <= 1'b0;
  else read_buf <= ReadDataValid;
assign done_read = (read_buf)&(!ReadDataValid);   

always_ff @ (posedge clk, posedge reset)
	if (reset) Write <= 1'b0;
	else if (start_wrdata) Write <= 1'b1;
	else if (!WaitRequest) Write <= 1'b0;
  
assign WriteData = (Write) ? wr_data : '0;

logic write_buf;

always_ff @ (posedge clk, posedge reset)
	if (reset) write_buf <= 1'b0;
	else write_buf <= Write;
assign done_write = (write_buf)&(!Write);

assign done = done_read | done_write;  
assign BurstCount = 4'd1;    

/*assign BurstCount = 4'd1;

logic write_buf;
wire done_write;

always_ff @ (posedge clk, posedge reset)
	if (reset) Addr <= '0;
	else if (start_addr) Addr <= rw_addr[16:0];
	else if (ReadDataValid | done_write) Addr <= Addr + 1'b1;
	
always_ff @ (posedge clk, posedge reset)	
	if (reset) Read <= 1'b0;
	else Read <= start_rddata;

always_ff @ (posedge clk, posedge reset)
	if (reset) Write <= 1'b0;
	else if (start_wrdata) Write <= 1'b1;
	else if (!WaitRequest) Write <= 1'b0;
	
always_ff @ (negedge clk, posedge reset)
  if (reset) rd_data <= '0;
  else if (ReadDataValid) rd_data <= ReadData;
  
assign WriteData = (Write) ? wr_data : '0;

always @ (posedge clk, posedge reset)
	if (reset) write_buf <= 1'b0;
	else write_buf <= Write;
assign done_write = (write_buf)&(!Write);
    
always_ff @ (posedge clk, posedge reset)    
  if (reset) done <= 1'b0;
  //else if (start_addr | start_rddata) done <= 1'b0;
  else if (ReadDataValid | done_write)  done <= 1'b1;
  else done <= 1'b0;*/

endmodule