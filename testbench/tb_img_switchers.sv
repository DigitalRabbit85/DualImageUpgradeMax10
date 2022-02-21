`include "inc_define.vh"
module tb_img_switchers;

parameter real parClock = 100_000_000; //Hz  
parameter real parUartSpeed = 10_000_000; // bit/s

logic inclk, reset;

wire RU_CLK_new, RU_CLK_old, RU_CLK_new2;
wire RU_DIN_new, RU_DIN_old, RU_DIN_new2;
wire RU_DOUT_new, RU_DOUT_old, RU_DOUT_new2;
wire RU_SHIFTnLD_new, RU_SHIFTnLD_old, RU_SHIFTnLD_new2;
wire RU_CAPTnUPDT_new, RU_CAPTnUPDT_old, RU_CAPTnUPDT_new2;
wire RU_nCONFIG_new, RU_nCONFIG_old, RU_nCONFIG_new2;
wire RU_nRSTIMER_new, RU_nRSTIMER_old, RU_nRSTIMER_new2;

logic start_setimg_new, start_setimg_old, start_setimg_new2;
logic start_getimg_new, start_getimg_old, start_getimg_new2;

ImageControl_v2 ImageControl(
	.clk (inclk), .reset (reset),
	.start_setimg (start_setimg_new),
	.start_getimg (start_getimg_new),
	.setimg (2'b11/*setimg_new*/), .getimg (/*getimg_new*/),
	.done_getimg (done_getimg_new),	
	.RU_CLK (RU_CLK_new),
	.RU_DIN (RU_DIN_new), .RU_DOUT (RU_DOUT_new),
	.RU_SHIFTnLD (RU_SHIFTnLD_new),
	.RU_CAPTnUPDT (RU_CAPTnUPDT_new),
	.RU_nCONFIG (RU_nCONFIG_new),
	.RU_nRSTIMER (RU_nRSTIMER_new)
);

MyLoadImageMax10_test MyLoadImageMax10(
	.clk (inclk),
	.reset (reset),
	.start_change (start_setimg_old),
	.start_current (start_getimg_old),
	.sel_image (2'd2/*setimg_old*/),
	.cur_image (/*getimg_old*/),
	.done (done_getimg_old),
	.Clock (RU_CLK_old),
	.RuShiftNLd (RU_SHIFTnLD_old),
	.RuCaptNUpdt (RU_CAPTnUPDT_old),
	.RuDin (RU_DIN_old),
	.WatchdogKick (RU_nRSTIMER_old),
	.RuConfig (RU_nCONFIG_old),
	.RuDout (RU_DOUT_old)
);

ImageControl_v3 ImageControl_v3(
  .clk (inclk), .reset (reset),
	.start_setimg (start_setimg_new2),
	.start_getimg (start_getimg_new2),
	.setimg (2'b11), .getimg (),
	.done_getimg (done_getimg_new2),	
  .RU_CLK (RU_CLK_new2),
	.RU_DIN (RU_DIN_new2), .RU_DOUT (RU_DOUT_new2),
	.RU_SHIFTnLD (RU_SHIFTnLD_new2),
	.RU_CAPTnUPDT (RU_CAPTnUPDT_new2),
	.RU_nCONFIG (RU_nCONFIG_new2),
	.RU_nRSTIMER (RU_nRSTIMER_new2)

);

localparam realtime parPeriod = 1/parClock * 1_000_000_000;
localparam realtime tb_bit = (1/parUartSpeed) * 1_000_000_000;

initial
begin
  inclk = 0;
  forever #(parPeriod/2) inclk = !inclk;
end

initial
begin
	reset = 1;
	#100 reset = 0;
end

initial
begin
  start_setimg_new = 0; start_setimg_old = 0; start_setimg_new2 = 0;
  start_getimg_new = 0; start_getimg_old = 0; start_getimg_new2 = 0;
  
  repeat (20) @(posedge inclk); 
  start_setimg_new = 1; start_setimg_old = 1; start_setimg_new2 = 1;
  repeat (1) @(posedge inclk);
  start_setimg_new = 0; start_setimg_old = 0; start_setimg_new2 = 0;
  
  repeat (100) @(posedge inclk); 
  start_getimg_new = 1; start_getimg_old = 1; start_getimg_new2 = 1;
  repeat (1) @(posedge inclk);
  start_getimg_new = 0; start_getimg_old = 0; start_getimg_new2 = 0;
  
  repeat (100) @(posedge inclk); 
  $stop;$stop;$stop;
  
end

endmodule