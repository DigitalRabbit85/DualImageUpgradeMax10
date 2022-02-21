module ImageControl (
input clk,
input reset,

input start_setimg,
input start_getimg,
input [1:0] setimg,
output done_getimg,
output [3:0] getimg,

output RU_CLK,
output RU_DIN,
input RU_DOUT,
output RU_SHIFTnLD,
output RU_CAPTnUPDT,
output RU_nCONFIG,
output RU_nRSTIMER
);

logic [7:0] cnt_setimg;

always_ff @ (posedge clk, posedge reset)
  if (reset) cnt_setimg <= '1;
  else if (start_setimg) cnt_setimg <= '0;
  else if (cnt_setimg != '1) cnt_setimg <= cnt_setimg + 1'b1;

logic [7:0] cnt_getimg;
    
always_ff @ (posedge clk, posedge reset)
  if (reset) cnt_getimg <= '1;    
  else if (start_getimg) cnt_getimg <= '0;
  else if (cnt_getimg != '1) cnt_getimg <= cnt_getimg + 1'b1;

wire RU_SHIFTnLD_setimg, RU_SHIFTnLD_getimg;

assign RU_CLK = !clk;
assign RU_SHIFTnLD_setimg = (cnt_setimg < 8'h29);
assign RU_SHIFTnLD_getimg = (cnt_getimg < 8'h2)|
                            ((cnt_getimg >= 8'h03)
                            &(cnt_getimg < 8'h2A));
assign RU_SHIFTnLD = RU_SHIFTnLD_setimg | RU_SHIFTnLD_getimg;
assign RU_CAPTnUPDT = !((cnt_setimg >= 8'h00)&(cnt_setimg < 8'h2A));    

logic [40:0] din_reg;
logic [38:0] dout_reg;
wire ena_dout;

always_ff @ (posedge clk, posedge reset)
  if (reset) din_reg <= '0;
  else if (start_setimg) din_reg <= {27'd0,setimg,12'd0};
  else din_reg <= {1'b0,din_reg[40:1]};
assign RU_DIN = din_reg[0];    
  
always_ff @ (posedge clk, posedge reset)  
	if (reset) dout_reg <= '0;
	else if (ena_dout) dout_reg <= {RU_DOUT,dout_reg[38:1]};
assign ena_dout = (cnt_getimg < 8'h29);
assign getimg = dout_reg[33:30];

assign RU_nCONFIG = (cnt_setimg >= 8'h30)&(cnt_setimg < 8'h40);
assign done_getimg = (cnt_getimg == 8'h2A);

endmodule