`include "inc_define.vh"
module tb_read_cfm;

real x_real;
int x_int;
  
parameter real parClock = 50_000_000; //Hz
localparam [7:0] parADDR = 8'h41,
				 parRDDATA = 8'h56;
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

wire start_addr, start_rddata;
logic [31:0] rd_data_data;
logic done_data;

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

	.start_addr (start_addr),
	.start_rddata (start_rddata),
	.rd_data_data (rd_data_data),
	.done_data (done_data),

	.done_csr (1'b0)
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

logic tb_addr;

/*always_ff @ (posedge rd_clock) 
	if ((tb_addr)&(rd_addr == 8'd0))  rd_data = 8'h00;
	else if ((tb_addr)&(rd_addr == 8'd1))  rd_data = 8'hAC;
	else if ((tb_addr)&(rd_addr == 8'd2))  rd_data = 8'h00;
	else if ((tb_addr)&(rd_addr == 8'd3))  rd_data = 8'h10;
	else rd_data <= {$random} % (2**8);*/
always_ff @ (posedge rd_clock) 
	if (rd_addr == 8'd0)  rd_data = 8'h00;
	else if (rd_addr == 8'd1)  rd_data = 8'hAC;
	else if (rd_addr == 8'd2)  rd_data = 8'h00;
	else if (rd_addr == 8'd3)  rd_data = 8'h10;

logic [31:0] tb_rd_data_data;

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
	rd_data_data = '0;
	done_data = 0;
	tb_addr = 0;

	repeat (4) @(posedge clk);

	cmd_rx = parADDR;
	len_rx = 4;
	repeat (1) @(posedge clk);
	start_rx = 1; 
	repeat (1) @(posedge clk);
	start_rx = 0;
	tb_addr = 1;

	repeat (16) @(posedge clk);

	cmd_rx = parRDDATA;
	len_rx = 1;
	repeat (1) @(posedge clk);
	start_rx = 1; 
	repeat (1) @(posedge clk);
	start_rx = 0;
	tb_addr = 0;

	repeat (4) begin
		@(posedge start_rddata);
		repeat (5) @(posedge clk);
		rd_data_data[7:0] = {$random} % (2**8);
		rd_data_data[15:8] = {$random} % (2**8);
		rd_data_data[23:16] = {$random} % (2**8);
		rd_data_data[31:24] = {$random} % (2**8);
		done_data = 1;
		@(posedge clk);
		done_data = 0;
	end

	repeat (20) @(posedge clk);

	$stop;$stop;$stop;
end

endmodule