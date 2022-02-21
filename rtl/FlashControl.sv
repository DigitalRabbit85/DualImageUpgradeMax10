`include "inc_define.vh"
module FlashControl
(
	input clk,
	input reset,
	
	input start_rdsr,
	input start_rdcr,
	input start_wrcr,
	output [31:0] rd_data_csr,
	input [31:0] wr_data_csr,
	output done_csr,
	
	input start_rddata,
	input start_wrdata,
	input start_addr,
	input [23:0] rw_addr_data,
	output [31:0] rd_data_data,
	input [31:0] wr_data_data,
	output done_data,
	
	output Addr_Csr,
	output Read_Csr,
	output Write_Csr,
	input [31:0] ReadData_Csr,
	output [31:0] WriteData_Csr,
	
	output [16:0] Addr_Data,
	output Read_Data,
	input [31:0] ReadData_Data,
	output Write_Data,
	output [31:0] WriteData_Data,
	input WaitRequest,
	input ReadDataValid,
	output [3:0] BurstCount	
);

ControlInterface ControlInterface(
  .clk (clk), .reset (reset),
  .start_rdsr (start_rdsr),
  .start_rdcr (start_rdcr),
  .start_wrcr (start_wrcr),  
  
  .rd_data (rd_data_csr),
  .wr_data (wr_data_csr),
  
  .Addr (Addr_Csr),
  .Read (Read_Csr),
  .ReadData (ReadData_Csr),
  .Write (Write_Csr),
  .WriteData (WriteData_Csr),
  
  .done (done_csr)
);

DataInterface DataInterface(
  .clk (clk), .reset (reset),
  
  .start_wrdata (start_wrdata),
  .start_rddata (start_rddata), 
  .start_addr (start_addr),
  
  .rw_addr (rw_addr_data),
  .rd_data (rd_data_data),
  .wr_data (wr_data_data),
  
  .Addr (Addr_Data),
  .Read (Read_Data),
  .ReadData (ReadData_Data),
  .Write (Write_Data),
  .WriteData (WriteData_Data),
  .WaitRequest (WaitRequest),
  .ReadDataValid (ReadDataValid),
  .BurstCount (BurstCount),
  
  .done (done_data)
);

endmodule