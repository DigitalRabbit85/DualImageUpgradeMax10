`include "inc_define.vh"
module tb_imagecontrol;

parameter real parClock = 10_000_000; //Hz 
localparam realtime parPeriod = 1/parClock * 1_000_000_000;

logic clk, reset;
logic start_setimg, start_getimg;
logic [1:0] setimg; wire [3:0] getimg;
wire done_getimg;

ImageControl ImageControl(
	.clk (clk), .reset (reset),
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

tb_RSU_Block tb_RSU_Block(
  .RU_CLK (RU_CLK),
  .RU_SHIFTnLD (RU_SHIFTnLD),
  .RU_CUPTnUPDT (RU_CAPTnUPDT),
  .RU_DIN (RU_DIN), .RU_DOUT (RU_DOUT)
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
  start_setimg = 0; start_getimg = 0;
  setimg = 2'b11;
  repeat (10) @(posedge clk);
  start_setimg = 1; @(posedge clk); start_setimg = 0;
  repeat (100) @(posedge clk);
  start_getimg = 1; @(posedge clk); start_getimg = 0;
  repeat (100) @(posedge clk);
  $stop;$stop;$stop;
end

endmodule