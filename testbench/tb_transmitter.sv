`include "inc_define.vh"
module tb_transmitter;

parameter real parClock = 10_000_000; //Hz  
parameter real parUartSpeed = 1_000_000; // bit/s

parameter int CLOCK = 10_000_000;
parameter int BAUD = 1_000_000;
parameter PARITY = "NO";
parameter FIRST_BIT = "LSB";
parameter NUMBER = 256;
parameter RX_TIMEOUT = 2;
parameter TX_PAUSE = 2;

logic clk, reset;
wire txd;
logic start;
logic [7:0] cmd_tx, len_tx;
logic [7:0] rd_data;
wire [$clog2(NUMBER)-1:0] rd_addr;
wire rd_clock;

defparam Transmitter.CLOCK = CLOCK;
defparam Transmitter.BAUD = BAUD;
defparam Transmitter.PARITY = PARITY;
defparam Transmitter.FIRST_BIT = FIRST_BIT;
defparam Transmitter.NUMBER = NUMBER;
defparam Transmitter.PAUSE = TX_PAUSE;
Transmitter Transmitter (
	.clk (clk), .reset (reset),
	.txd (txd),
	.start (start),
	.cmd_tx (cmd_tx), .len_tx (len_tx), 
	.rd_data (rd_data), .rd_addr (rd_addr), .rd_clock (rd_clock)
);

localparam realtime parPeriod = 1/parClock * 1_000_000_000;
localparam realtime tb_bit = (1/parUartSpeed) * 1_000_000_000;

reg [7:0] ram [NUMBER-1:0];

initial
	for(int i=0; i<NUMBER; i++) ram[i] = {$random} % 256;
	
always_ff @ (posedge rd_clock)
	rd_data <= ram[rd_addr];	

initial
begin
  clk = 0;
  forever #(parPeriod/2) clk = !clk;
end

initial
begin
	reset = 1;
	#100 reset = 0;
end

initial
begin
	cmd_tx = 8'h43; len_tx = 3; start = 0;
	repeat (20) @(posedge clk);
	start = 1; @(posedge clk) start = 0;
	
	repeat (1000) @(posedge clk);
	$stop;$stop;$stop;
end

logic [9:0] tb_shift;
time start_time, stop_time;
initial
begin
	tb_shift = 0;
	start_time = 0; stop_time = 0;
	#10;
	forever begin
		@(negedge txd)		
		start_time = $time;
		$display("Interval = %d ns", start_time - stop_time);
		#(tb_bit/2);
		for(int i=0; i<9; i++) begin
			tb_shift = {tb_shift[8:0],txd};
			#(tb_bit);
		end
		tb_shift = {tb_shift[8:0],txd};
		#(tb_bit/2);
		stop_time = $time;
		$display("Sent byte = %h, for %d ns",funcReverse(tb_shift[8:1]),stop_time - start_time);
	end
end

endmodule