`include "inc_define.vh"
module tb_write_bytes;

parameter real parClock = 10_000_000; //Hz 
localparam realtime parPeriod = 1/parClock * 1_000_000_000;
parameter NUMBER = 256;

logic clk, reset;
logic start;
wire done;
logic [7:0] start_addr;
logic [31:0] word;
wire [7:0] wr_data;
wire [7:0] wr_addr;
wire wr_clock;

defparam WriteBytes.NUMBER = NUMBER;
WriteBytes WriteBytes
(
	.clk (clk), .reset (reset),
	.start (start), .done (done),
	.addr (start_addr), .word (word),
	.wr_data (wr_data),
	.wr_addr (wr_addr),
	.wr_clock (wr_clock),
	.we (we)
);

initial
begin
  clk = 0;
  forever #(parPeriod/2) clk = !clk;
end

initial
begin
  reset = 1; start = 0;
  repeat (2) @(posedge clk);
  reset = 0;
  repeat (2) @(posedge clk);
  start = 1;
  @(posedge clk);
  start = 0;
end

initial
begin
  start_addr = 8'h71;
  word = 32'h91_4f_02_b5;
end

initial
begin
  repeat (30) @(posedge clk);
  $stop;$stop;$stop;
end

endmodule