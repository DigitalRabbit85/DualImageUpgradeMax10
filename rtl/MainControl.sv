`include "inc_define.vh"
module MainControl 
#( parameter NUMBER = 256 )
(
input clk,
input reset,

input start_rx,
input [7:0] cmd_rx, len_rx,
output logic start_tx,
output logic [7:0] cmd_tx, len_tx,

input [7:0] rd_data,
output logic [clogb2(NUMBER)-1:0] rd_addr,
output logic rd_clock,

output logic [7:0] wr_data,
output logic [clogb2(NUMBER)-1:0] wr_addr,
output logic wr_clock,
output logic we,

output logic start_setimg,
output logic start_getimg,
output logic [1:0] setimg,
input done_getimg,
input [3:0] getimg
`ifdef boot
,

output start_rdsr,
output start_rdcr,
output start_wrcr,
input [31:0] rd_data_csr,
output [31:0] wr_data_csr,
input done_csr,

output start_addr,
output [23:0] addr_data,
output start_rddata,
input [31:0] rd_data_data,
output start_wrdata,
output [31:0] wr_data_data,
input done_data
`endif
);

wire start_rd_ram, done_rd_ram;
wire start_wr_ram, done_wr_ram;
wire [clogb2(NUMBER)-1:0] start_rd_addr,  start_wr_addr;
wire [31:0] rd_word, wr_word;

defparam StateMachine.NUMBER = NUMBER;
StateMachine StateMachine
(
	.clk (clk), .reset (reset),
	.start_rx (start_rx),
	.cmd_rx (cmd_rx), .len_rx (len_rx),
	.start_tx (start_tx),
	.cmd_tx (cmd_tx), .len_tx (len_tx),

	.start_rd_ram (start_rd_ram),
	.done_rd_ram (done_rd_ram),
	.start_rd_addr (start_rd_addr),
	.rd_word (rd_word),
	
	.start_wr_ram (start_wr_ram),
	.done_wr_ram (done_wr_ram), 
	.start_wr_addr (start_wr_addr), 
	.wr_word (wr_word),

	.start_setimg (start_setimg),
	.start_getimg (start_getimg),
	.setimg (setimg),
	.done_getimg (done_getimg),
	.getimg (getimg)
`ifdef boot
	,
	
	.start_rdsr (start_rdsr),
	.start_rdcr (start_rdcr),
	.start_wrcr (start_wrcr),
	.rd_data_csr (rd_data_csr),
	.wr_data_csr (wr_data_csr),
	.done_csr (done_csr),
	
	.start_addr (start_addr),
 	.addr_data (addr_data),
 	.start_rddata (start_rddata),
 	.rd_data_data (rd_data_data),
 	.start_wrdata (start_wrdata),
 	.wr_data_data (wr_data_data),
 	.done_data (done_data)
`endif 	 	
);

defparam ReadBytes.NUMBER = NUMBER;
ReadBytes ReadBytes
(
	.clk (clk), .reset (reset),
	.start (start_rd_ram), .done (done_rd_ram),
	.addr (start_rd_addr), .word (rd_word),
	.rd_data (rd_data), 
	.rd_addr (rd_addr),
	.rd_clock (rd_clock)
);

defparam WriteBytes.NUMBER = NUMBER;
WriteBytes WriteBytes
(
	.clk (clk), .reset (reset),
	.start (start_wr_ram), .done (done_wr_ram),
	.addr (start_wr_addr), .word (wr_word),
	.wr_data (wr_data),
	.wr_addr (wr_addr),
	.wr_clock (wr_clock),
	.we (we)
);

endmodule