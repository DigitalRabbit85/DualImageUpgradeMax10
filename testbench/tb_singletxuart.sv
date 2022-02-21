`include "inc_define.vh"
module tb_singletxuart;
  
parameter real parClock = 8_000_000; //Hz  
parameter real parUartSpeed = 1_000_000; // bit/s

parameter int CLOCK = 8_000_000;
parameter int BAUD = 1_000_000;
parameter PARITY = "NO";
parameter FIRST_BIT = "LSB";

logic [7:0] tx_data;
logic clk, reset, single_start;
wire txd;

defparam SingleTxUART.CLOCK = CLOCK;
defparam SingleTxUART.BAUD = BAUD;
defparam SingleTxUART.PARITY = PARITY;
defparam SingleTxUART.FIRST_BIT = FIRST_BIT;
SingleTxUART SingleTxUART
(
	.clk (clk), .reset (reset),
	.start (single_start), .tx_data (tx_data),
	.busy (),
	.txd (txd)
);

localparam realtime parPeriod = 1/parClock * 1_000_000_000;
localparam realtime tb_bit = (1/parUartSpeed) * 1_000_000_000;

initial
begin
  clk = 0;
  forever #(parPeriod/2) clk = !clk;
end

initial
begin
	reset = 1;
	#50 reset = 0;
end

initial
begin
	tx_data = 8'h43; single_start = 0;
	repeat (10) @(posedge clk);
	single_start = 1; @(posedge clk) single_start = 0;
	
	repeat (200) @(posedge clk);
	$stop;$stop;$stop;
end

endmodule