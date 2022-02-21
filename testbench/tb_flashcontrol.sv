`include "inc_define.vh"
module tb_flashcontrol;

parameter real parClock = 50_000_000; //Hz
localparam realtime parPeriod = 1/parClock * 1_000_000_000;

logic clk, reset;
logic start_rdsr, start_rdcr, start_wrcr;
logic start_addr, start_rddata, start_wrdata;
wire [31:0] rd_data_csr, rd_data_data;
logic [31:0] rw_addr_data, wr_data_csr, wr_data_data;
wire Addr_Csr, Read_Csr, Write_Csr;
wire Read_Data, Write_Data;
wire [16:0] Addr_Data;
wire [31:0] ReadData_Csr, WriteData_Csr;
wire [31:0] ReadData_Data, WriteData_Data;
wire done_csr, done_data;

ControlInterface ControlInterface(
  .clk (clk),
  .reset (reset),
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
  .clk (clk),
  .reset (reset),
  .start_addr (start_addr),
  .start_wrdata (start_wrdata),
  .start_rddata (start_rddata),
  .rw_addr (rw_addr_data),
  .rd_data (rd_data_data),
  .wr_data (wr_data_data),
  .Addr (Addr_Data),
  .Read (Read_Data),
  .Write (Write_Data),
  .ReadData (ReadData_Data),
  .WriteData (WriteData_Data),
  .WaitRequest (WaitRequest),
  .ReadDataValid (ReadDataValid),
  .BurstCount (BurstCount),
  .done (done_data)
);

tb_OnChipFlash tb_OnChipFlash(
	.Clock (clk),
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
  start_rdsr = 0; start_rdcr = 0; start_wrcr = 0;
  start_addr = 0; start_rddata = 0; start_wrdata = 0;
  wr_data_csr = '0;
  wr_data_data = '0;
  rw_addr_data = '0;
  repeat (4) @(posedge clk);
  
  start_rdsr = 1;
  @(posedge clk);
  start_rdsr = 0;
  
  repeat (4) @(posedge clk);
  
  start_rdcr = 1;
  @(posedge clk);
  start_rdcr = 0;
  
  repeat (3) @(posedge clk);
  wr_data_csr = 32'h90_f5_01_D3;  
  @(posedge clk);
  start_wrcr = 1;
  @(posedge clk);
  start_wrcr = 0;
  
  repeat (15) @(posedge clk);
  
  rw_addr_data = 32'h00_01_54_C3;
  @(posedge clk);
  start_addr = 1;
  @(posedge clk);
  start_addr = 0;
  repeat (1) @(posedge clk);
  
  @(posedge clk);
  start_rddata = 1;
  @(posedge clk);
  start_rddata = 0;
  
  repeat (6) @(posedge clk);
  @(posedge clk);
  start_rddata = 1;
  @(posedge clk);
  start_rddata = 0;
  
  repeat (6) @(posedge clk);
  @(posedge clk);
  start_rddata = 1;
  @(posedge clk);
  start_rddata = 0;
  
  repeat (15) @(posedge clk);
  
  rw_addr_data = 32'h00_01_AB_71;
  @(posedge clk);
  start_addr = 1;
  @(posedge clk);
  start_addr = 0;
  repeat (3) @(posedge clk);
  
  wr_data_data = 32'hA1_77_CD_85;
  @(posedge clk);
  start_wrdata = 1;
  @(posedge clk);
  start_wrdata = 0;
  
  repeat (20) @(posedge clk);
  
  /*wr_data_data = 32'hC0_FF_00_3;
  @(posedge clk);
  start_wrdata = 1;
  @(posedge clk);
  start_wrdata = 0;*/
  
  repeat (20) @(posedge clk);
  
  /*wr_data_data = 32'h91_B2_74_89;
  @(posedge clk);
  start_wrdata = 1;
  @(posedge clk);
  start_wrdata = 0;*/
  
  repeat (50) @(posedge clk);
  
  
  $stop;$stop;$stop;
  
end

endmodule