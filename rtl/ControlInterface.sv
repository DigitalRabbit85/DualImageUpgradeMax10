module ControlInterface (
input clk,
input reset,

input start_rdsr,
input start_rdcr,
input start_wrcr,

output logic [31:0] rd_data,
input [31:0] wr_data,

output logic Addr,
output logic Read,
input [31:0] ReadData,
output logic Write,
output logic [31:0] WriteData,

output logic done
);

always_ff @ (posedge clk, posedge reset)
	if (reset) Addr <= 1'b0;
	else if (start_rdsr) Addr <= 1'b0;
	else if (start_rdcr | start_wrcr) Addr <= 1'b1;
	
always_ff @ (posedge clk, posedge reset)
	if (reset) Read <= 1'b0;
	else if (start_rdsr | start_rdcr) Read <= 1'b1;
	else Read <= 1'b0;

always_ff @ (posedge clk, posedge reset)
	if (reset) Write <= 1'b0;
	else if (start_wrcr) Write <= 1'b1;
	else Write <= 1'b0;
	
logic latch_read;	
	
always_ff @ (posedge clk, posedge reset)	
	if (reset) latch_read <= 1'b0;
	else latch_read <= Read;
	
always_ff @ (negedge clk, posedge reset)
	if (reset) rd_data <= '0;
	else if (latch_read) rd_data <= ReadData;
	
always_ff @ (posedge clk, posedge reset)	
	if (reset) WriteData <= '0;
	else if (start_wrcr) WriteData <= wr_data;	
	
always_ff @ (posedge clk, posedge reset)	
	if (reset) done <= 1'b0;
	else if (start_rdsr | start_rdcr | start_wrcr) done <= 1'b0;
	else if (latch_read) done <= 1'b1;
	else done <= 1'b0;
	

endmodule