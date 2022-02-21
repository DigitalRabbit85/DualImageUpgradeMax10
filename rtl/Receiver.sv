`include "inc_define.vh"
module Receiver 
#(
	parameter int CLOCK = 50_000_000,
	parameter int BAUD = 115_200,
	parameter PARITY = "NO",
	parameter FIRST_BIT = "LSB",
	parameter NUMBER = 256,
	parameter TIMEOUT = 10
)
(
input clk,
input reset,
input rxd,
output rx_done,
output [7:0] cmd_rx,
output [7:0] len_rx,
output [7:0] wr_data,
output [clogb2(NUMBER)-1:0] wr_addr,
output wr_clock,
output we,

output single_done
);

///// SIGNALS /////

wire [7:0] rx_data;
//wire single_done;
wire single_busy;
wire timeout;

///// RECEIVE SINGLE BYTE /////

defparam SingleRxUART.CLOCK = CLOCK;
defparam SingleRxUART.BAUD = BAUD;
defparam SingleRxUART.PARITY = PARITY;
defparam SingleRxUART.FIRST_BIT = FIRST_BIT;
SingleRxUART SingleRxUART
(
  .clk (clk), .reset (reset),
  .rxd (rxd),
  .rx_data (rx_data), 
  .parity_err (),
  .done (single_done),
  .busy (single_busy)
);

///// RECEIVE PACKET /////

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

///// TIMEOUT CONTROL /////

defparam RxUART_timeout.CLOCK = CLOCK;
defparam RxUART_timeout.BAUD = BAUD;
defparam RxUART_timeout.PARITY = PARITY;
defparam RxUART_timeout.TIMEOUT = TIMEOUT;
RxUART_timeout RxUART_timeout
(
  .clk (clk), .reset (reset),
  .rx_done (single_done), .rx_busy (single_busy),
  .timeout (timeout)
);

endmodule