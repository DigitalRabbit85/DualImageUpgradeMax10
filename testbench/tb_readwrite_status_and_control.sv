`include "inc_define.vh"
module tb_readwrite_status_and_control;

real x_real;
int x_int;
  
parameter real parClock = 50_000_000; //Hz
localparam [7:0] parRDSR = 8'h52,	 //ASCII - R
				 parRDCR = 8'h45,    //ASCII - E
				 parWRCR = 8'h47;    //ASCII - G
localparam realtime parPeriod = 1/parClock * 1_000_000_000;

logic clk, reset;
logic start_rx;
logic [7:0] cmd_rx, len_rx;
wire start_tx;
wire [7:0] cmd_tx, len_tx;

wire start_rd_ram, start_wr_ram;
wire [7:0] start_rd_addr, start_wr_addr;
wire [31:0] rd_word, wr_word;
wire done_rd_ram, done_wr_ram;

wire start_rdsr, start_rdcr, start_wrcr;
logic [31:0] rd_data_csr;
wire [31:0] wr_data_csr;
logic done_csr;

defparam StateMachine.NUMBER = 256;
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

	.done_getimg (1'b0),

	.start_rdsr (start_rdsr),
	.start_rdcr (start_rdcr),
	.start_wrcr (start_wrcr),
	.rd_data_csr (rd_data_csr),
	.wr_data_csr (wr_data_csr),
	.done_csr (done_csr),

	.done_data (1'b0)
);

logic [7:0] rd_data = '0;
wire [7:0] rd_addr;
wire rd_clock;

defparam ReadBytes.NUMBER = 256;
ReadBytes ReadBytes
(
	.clk (clk), .reset (reset),
	.start (start_rd_ram), .done (done_rd_ram),
	.addr (start_rd_addr), .word (rd_word),
	.rd_data (rd_data), 
	.rd_addr (rd_addr),
	.rd_clock (rd_clock)
);

wire [7:0] wr_data;
wire [7:0] wr_addr;
wire wr_clock;

defparam WriteBytes.NUMBER = 256;
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

always_ff @ (posedge rd_clock) rd_data <= {$random} % (2**8);

initial
begin
	clk = 0;
	forever #(parPeriod/2) clk = !clk;
end

initial
begin
	reset = 1;
	repeat (2) @(posedge clk);
	reset = 0;
end

initial
begin

	{start_rx, cmd_rx, len_rx} = 17'd0;
	rd_data_csr = '0;
	done_csr = 0;

	repeat (4) @(posedge clk);

	cmd_rx = parRDSR;
	len_rx = 1;
	repeat (1) @(posedge clk);
	start_rx = 1; 
	repeat (1) @(posedge clk);
	start_rx = 0;

	repeat (5) @(posedge clk);

	rd_data_csr[7:0] = {$random} % (2**8);
	rd_data_csr[15:8] = {$random} % (2**8);
	rd_data_csr[23:16] = {$random} % (2**8);
	rd_data_csr[31:24] = {$random} % (2**8);
	done_csr = 1; 
	repeat (1) @(posedge clk);
	done_csr = 0;

	repeat (17) @(posedge clk);

	cmd_rx = parRDCR;
	len_rx = 1;
	repeat (1) @(posedge clk);
	start_rx = 1; 
	repeat (1) @(posedge clk);
	start_rx = 0;

	repeat (5) @(posedge clk);

	rd_data_csr[7:0] = {$random} % (2**8);
	rd_data_csr[15:8] = {$random} % (2**8);
	rd_data_csr[23:16] = {$random} % (2**8);
	rd_data_csr[31:24] = {$random} % (2**8);
	done_csr = 1; 
	repeat (1) @(posedge clk);
	done_csr = 0;

	repeat (17) @(posedge clk);

	cmd_rx = parWRCR;
	len_rx = 4;
	repeat (1) @(posedge clk);
	start_rx = 1; 
	repeat (1) @(posedge clk);
	start_rx = 0;

	repeat (20) @(posedge clk);

	$stop;$stop;$stop;

end

endmodule