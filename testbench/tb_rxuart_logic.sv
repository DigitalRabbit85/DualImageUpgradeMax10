`include "inc_define.vh"
module tb_rxuart_logic;

parameter real parClock = 10_000_000; //Hz 
localparam realtime parPeriod = 1/parClock * 1_000_000_000;
parameter NUMBER = 256;

logic clk, reset;
logic [7:0] rx_data;
logic single_done, timeout;

defparam RxUART_logic.NUMBER = NUMBER;
RxUART_logic RxUART_logic
(
  .clk (clk), .reset (reset),
  .rx_data (rx_data),
  .rx_done (single_done),
  .timeout (timeout),
  .pck_done (rx_done),
  .cmd_rx (cmd_rx),
  .len_rx (len_rx),
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

logic [7:0] crc;

initial
begin
	reset = 1; rx_data = 0; single_done = 0; timeout = 0;
	repeat (2) @(posedge clk);
	reset = 0;
	repeat (2) @(posedge clk);

	single_done = 1; rx_data = 8'h74; crc = rx_data;
	@(posedge clk) single_done = 0;
	repeat (4) @(posedge clk);

	single_done = 1; rx_data = 8'h03; crc += rx_data;
	@(posedge clk) single_done = 0;
	repeat (4) @(posedge clk);

	single_done = 1; rx_data = 8'h5A; crc += rx_data;
	@(posedge clk) single_done = 0;
	repeat (4) @(posedge clk);

	single_done = 1; rx_data = 8'h18; crc += rx_data;
	@(posedge clk) single_done = 0;
	repeat (4) @(posedge clk);

	single_done = 1; rx_data = 8'hF0; crc += rx_data;
	@(posedge clk) single_done = 0;
	repeat (4) @(posedge clk);

	single_done = 1; rx_data = ~crc;
	@(posedge clk) single_done = 0;
	repeat (4) @(posedge clk);

	$stop;$stop;$stop;
end

endmodule