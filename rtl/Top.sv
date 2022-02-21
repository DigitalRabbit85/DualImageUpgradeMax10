`include "inc_define.vh"
module Top 
#(  
	parameter int CLOCK = 50_000_000,
	parameter int BAUD = 115_200,
	parameter PARITY = "NO",
	parameter FIRST_BIT = "LSB",
	parameter NUMBER = 256,
	parameter RX_TIMEOUT = 10,
	parameter TX_PAUSE = 0 
)
(
input           inclk,        //pin 27
input           rxd_uart,     //pin 114 - J9-38
output          txd_uart,     //pin 113 - J9-32
output  [4:0]   led          //pins 141,140,135,134,132
);

`ifdef image0
assign led[0] = 1'b0;
assign led[1] = 1'b1;
assign led[2] = 1'b1;
assign led[3] = 1'b0;
`elsif image1
assign led[0] = 1'b1;
assign led[1] = 1'b0;
assign led[2] = 1'b0;
assign led[3] = 1'b1;
`endif
assign led[4] = 1'b1;

///// RESET /////

wire reset;

Reset Reset( 
  .clk (inclk), .reset (reset));

///// RECEIVER /////

wire [7:0] cmd_rx;
wire [clogb2(NUMBER)-1:0] len_rx;
wire [7:0] wr_rx_data;
wire [clogb2(NUMBER)-1:0] wr_rx_addr;
wire wr_rx_clock;
wire we_rx;
wire rx_done;

defparam Receiver.CLOCK = CLOCK;
defparam Receiver.BAUD = BAUD;
defparam Receiver.PARITY = PARITY;
defparam Receiver.FIRST_BIT = FIRST_BIT;
defparam Receiver.NUMBER = NUMBER;
defparam Receiver.TIMEOUT = RX_TIMEOUT;
Receiver Receiver
(
  .clk (inclk), .reset (reset),
  .rxd (rxd_uart),
  .cmd_rx (cmd_rx), .len_rx (len_rx),
  .wr_data (wr_rx_data), 
  .wr_addr (wr_rx_addr), 
  .wr_clock (wr_rx_clock),
  .we (we_rx),
  .rx_done (rx_done)
);

///// TRANSMITTER /////

wire start_tx;
wire [7:0] cmd_tx;
wire [clogb2(NUMBER)-1:0] len_tx;
wire [7:0] rd_tx_data;
wire [clogb2(NUMBER)-1:0] rd_tx_addr;
wire rd_tx_clock;

defparam Transmitter.CLOCK = CLOCK;
defparam Transmitter.BAUD = BAUD;
defparam Transmitter.PARITY = PARITY;
defparam Transmitter.FIRST_BIT = FIRST_BIT;
defparam Transmitter.NUMBER = NUMBER;
defparam Transmitter.PAUSE = TX_PAUSE;
Transmitter Transmitter
(
  .clk (inclk), .reset (reset),
  .txd (txd_uart),
  .start (start_tx),
  .cmd_tx (cmd_tx), .len_tx (len_tx), 
  .rd_data (rd_tx_data),
  .rd_addr (rd_tx_addr),
  .rd_clock (rd_tx_clock)
);

///// MEMORY /////

wire [7:0] rd_rx_data;
wire [clogb2(NUMBER)-1:0] rd_rx_addr;
wire rd_rx_clock;
wire [7:0] wr_tx_data;
wire [clogb2(NUMBER)-1:0] wr_tx_addr;
wire wr_tx_clock;
wire we_tx;

defparam Memory.NUMBER = NUMBER;
Memory Memory
(
  .wr_rx_data (wr_rx_data),
  .wr_rx_addr (wr_rx_addr),
  .wr_rx_clock (wr_rx_clock),
  .we_rx (we_rx),
  .rd_rx_data (rd_rx_data),
  .rd_rx_addr (rd_rx_addr),
  .rd_rx_clock (rd_rx_clock),

  .wr_tx_data (wr_tx_data),
  .wr_tx_addr (wr_tx_addr),
  .wr_tx_clock (wr_tx_clock),
  .we_tx (we_tx),
  .rd_tx_data (rd_tx_data),
  .rd_tx_addr (rd_tx_addr),
  .rd_tx_clock (rd_tx_clock)
);

///// MAIN CONTROL  /////

wire start_setimg, start_getimg;
wire [1:0] setimg;
wire [3:0] getimg;
wire done_getimg;
wire start_rx = rx_done;

wire start_rdsr, start_rdcr, start_wrcr;
wire [31:0] rd_data_csr, wr_data_csr;
wire done_csr, done_data;
wire start_addr;
wire [23:0] rw_addr_data;
wire start_rddata, start_wrdata;
wire [31:0] rd_data_data, wr_data_data;

defparam MainControl.NUMBER = NUMBER;
MainControl MainControl
(
  .clk (inclk), .reset (reset),
  .start_rx (start_rx), 
  .cmd_rx (cmd_rx), .len_rx (len_rx),
  .start_tx (start_tx), 
  .cmd_tx (cmd_tx), .len_tx (len_tx),
  .rd_data (rd_rx_data),
  .rd_addr (rd_rx_addr),
  .rd_clock (rd_rx_clock),
  .wr_data (wr_tx_data),
  .wr_addr (wr_tx_addr),
  .wr_clock (wr_tx_clock),
  .we (we_tx),
  .start_setimg (start_setimg), 
  .start_getimg (start_getimg),
  .setimg (setimg), .getimg (getimg),
  .done_getimg (done_getimg)
`ifdef boot
  ,  
  .start_rdsr (start_rdsr),   
  .start_rdcr (start_rdcr),
  .start_wrcr (start_wrcr),
  .rd_data_csr (rd_data_csr),
  .wr_data_csr (wr_data_csr),
  .done_csr (done_csr),
  
  .start_addr (start_addr),
  .addr_data (rw_addr_data),
  .start_rddata (start_rddata),
  .rd_data_data (rd_data_data),
  .start_wrdata (start_wrdata),
  .wr_data_data (wr_data_data),
 	.done_data (done_data)
`endif 	
);

///// IMAGE CONTROL /////

wire RU_CLK; 
wire RU_DIN, RU_DOUT;
wire RU_SHIFTnLD, RU_CAPTnUPDT;
wire RU_nCONFIG, RU_nRSTIMER;

ImageControl ImageControl(
	.clk (inclk), .reset (reset),
	.start_setimg (start_setimg),
	.start_getimg (start_getimg),
	.setimg (setimg), .getimg (getimg),
	.done_getimg (done_getimg),	
	.RU_CLK (RU_CLK),
	.RU_DIN (RU_DIN), .RU_DOUT (RU_DOUT),
	.RU_SHIFTnLD (RU_SHIFTnLD),
	.RU_CAPTnUPDT (RU_CAPTnUPDT),
	.RU_nCONFIG (RU_nCONFIG),
	.RU_nRSTIMER (RU_nRSTIMER)
);

`ifndef SIM
fiftyfivenm_rublock RuBlock(
    .clk (RU_CLK),
    .shiftnld (RU_SHIFTnLD),
    .captnupdt (RU_CAPTnUPDT),
    .regin (RU_DIN), .regout (RU_DOUT),
    .rsttimer (RU_nRSTIMER),
    .rconfig (RU_nCONFIG)    
);
`else
tb_RSU_Block tb_RSU_Block(
  .RU_CLK (RU_CLK),
  .RU_SHIFTnLD (RU_SHIFTnLD),
  .RU_CUPTnUPDT (RU_CAPTnUPDT),
  .RU_DIN (RU_DIN), .RU_DOUT (RU_DOUT)
);
`endif

wire Addr_Csr;
wire Read_Csr, Write_Csr;
wire [31:0] ReadData_Csr, WriteData_Csr;
wire [16:0] Addr_Data;
wire Read_Data, Write_Data;
wire [31:0] ReadData_Data, WriteData_Data;
wire WaitRequest, ReadDataValid;
wire [3:0] BurstCount;

`ifdef boot
FlashControl FlashControl
(
	.clk (inclk), .reset (reset),
	
	.start_rdsr (start_rdsr),
	.start_rdcr (start_rdcr),
	.start_wrcr (start_wrcr),
	.rd_data_csr (rd_data_csr),
	.wr_data_csr (wr_data_csr),
	.done_csr (done_csr),
	
	.start_rddata (start_rddata),
	.start_wrdata (start_wrdata),
	.start_addr (start_addr),
	.rw_addr_data (rw_addr_data),
	.rd_data_data (rd_data_data),
	.wr_data_data (wr_data_data),	
	.done_data (done_data),
	
	.Addr_Csr (Addr_Csr),
	.Read_Csr (Read_Csr),
	.Write_Csr (Write_Csr),
	.ReadData_Csr (ReadData_Csr),
	.WriteData_Csr (WriteData_Csr),
	
	.Addr_Data (Addr_Data),
	.Read_Data (Read_Data),
	.ReadData_Data (ReadData_Data),
	.Write_Data (Write_Data),
	.WriteData_Data (WriteData_Data),
	.WaitRequest (WaitRequest),
	.ReadDataValid (ReadDataValid),
	.BurstCount (BurstCount)	
);
`endif

`ifdef boot
	`ifndef SIM
OnChipFlash OnChipFlash(
	.clock (inclk),
	.reset_n (!reset),
	
	.avmm_data_addr (Addr_Data),
	.avmm_data_read (Read_Data),
	.avmm_data_writedata (WriteData_Data),
	.avmm_data_write (Write_Data),
	.avmm_data_readdata (ReadData_Data),
	.avmm_data_waitrequest (WaitRequest),
	.avmm_data_readdatavalid (ReadDataValid),
	.avmm_data_burstcount (BurstCount),
	
	.avmm_csr_addr (Addr_Csr),
	.avmm_csr_read (Read_Csr),
	.avmm_csr_writedata (WriteData_Csr),
	.avmm_csr_write (Write_Csr),
	.avmm_csr_readdata (ReadData_Csr)
);	
	`else	//SIM
tb_OnChipFlash tb_OnChipFlash(
	.Clock (inclk),
	.Resetn (!reset),
	
	.Addr_Csr (Addr_Csr),
	.Read_Csr (Read_Csr),
	.Write_Csr (Write_Csr),
	.ReadData_Csr (ReadData_Csr),
	.WriteData_Csr (WriteData_Csr),
	
	.Addr_Data (Addr_Data),
	.Read_Data (Read_Data),
	.Write_Data (Write_Data),
	.ReadData_Data (ReadData_Data),
	.WriteData_Data (WriteData_Data),
	.ReadDataValid (ReadDataValid),
	.WaitRequest (WaitRequest)
);
	`endif	//SIM
`endif	//boot

endmodule