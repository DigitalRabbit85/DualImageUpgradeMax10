`include "inc_define.vh"
module Memory 
#(
  parameter NUMBER = 256
)
(

input [7:0] wr_rx_data,
input [clogb2(NUMBER)-1:0] wr_rx_addr,
input wr_rx_clock,
input we_rx,
output [7:0] rd_rx_data,
input [clogb2(NUMBER)-1:0] rd_rx_addr,
input rd_rx_clock,

input [7:0] wr_tx_data,
input [clogb2(NUMBER)-1:0] wr_tx_addr,
input wr_tx_clock,
input we_tx,
output [7:0] rd_tx_data,
input [clogb2(NUMBER)-1:0] rd_tx_addr,
input rd_tx_clock

);

defparam RxRAM.DATA_WIDTH = 8;
defparam RxRAM.ADDR_WIDTH = clogb2(NUMBER);
DualPortDualClock_ram RxRAM
(
	.wr_data (wr_rx_data),
	.rd_addr (rd_rx_addr), .wr_addr (wr_rx_addr),
	.we (we_rx), .rd_clock (rd_rx_clock), .wr_clock (wr_rx_clock),
	.rd_data (rd_rx_data)
);

defparam TxRAM.DATA_WIDTH = 8;
defparam TxRAM.ADDR_WIDTH = clogb2(NUMBER);
DualPortDualClock_ram TxRAM
(
	.wr_data (wr_tx_data),
	.rd_addr (rd_tx_addr), .wr_addr (wr_tx_addr),
	.we (we_tx), .rd_clock (rd_tx_clock), .wr_clock (wr_tx_clock),
	.rd_data (rd_tx_data)
);

endmodule