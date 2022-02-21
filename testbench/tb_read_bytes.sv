`include "inc_define.vh"
module tb_read_bytes;

parameter real parClock = 10_000_000; //Hz 
localparam realtime parPeriod = 1/parClock * 1_000_000_000;
parameter NUMBER = 256;

logic clk, reset;
logic start;
wire done;
logic [7:0] start_addr;
wire [31:0] word;
logic [7:0] rd_data;
wire [7:0] rd_addr;
wire rd_clock;

reg [7:0] ram [NUMBER-1:0];

initial
	for(int i=0; i<NUMBER; i++) ram[i] = {$random} % 256;
	
always_ff @ (posedge rd_clock)
	rd_data <= ram[rd_addr];
	
initial
  	rd_data = '0;

defparam ReadBytes.NUMBER = NUMBER;
ReadBytes ReadBytes
(
	.clk (clk), .reset (reset),
	.start (start), .done (done),
	.addr (start_addr), .word (word),
	.rd_data (rd_data), 
	.rd_addr (rd_addr),
	.rd_clock (rd_clock)
);

initial
begin
  clk = 0;
  forever #(parPeriod/2) clk = !clk;
end

initial
begin
  reset = 1; start = 0;
  repeat (5) @(posedge clk);
  reset = 0;
  repeat (5) @(posedge clk);
  start = 1;
  @(posedge clk);
  start = 0;
end

initial
begin
  start_addr = 8'h37;
end

initial
begin
  repeat (100) @(posedge clk);
  $stop;$stop;$stop;
end

endmodule