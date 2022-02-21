`include "inc_define.vh"
module DualPortDualClock_ram
#(
  parameter DATA_WIDTH=32, 
  parameter ADDR_WIDTH=8
)
(
	input [(DATA_WIDTH-1):0] wr_data,
	input [(ADDR_WIDTH-1):0] rd_addr, wr_addr,
	input we, rd_clock, wr_clock,
	output reg [(DATA_WIDTH-1):0] rd_data
);
	
	reg [(DATA_WIDTH-1):0] ram [2**ADDR_WIDTH-1:0];
	
	//initial
	//	for(int i=0; i<2**ADDR_WIDTH; i++) ram[i] = '0;
	
	always_ff @ (posedge wr_clock)
		if (we) ram[wr_addr] <= wr_data;
	
	always_ff @ (posedge rd_clock)
		rd_data <= ram[rd_addr];
	
endmodule