module tb_RSU_Block(

input RU_CLK,
input RU_SHIFTnLD,
input RU_CUPTnUPDT,
input RU_DIN,
input RU_DOUT

);

parameter [3:0] msm_cs = 4'b1001;
parameter [0:0] ru_wd_en = 1'b1;  
parameter [28:0] wd_timeout_value = 29'h034A1B5;

logic [40:0] shift_reg;
logic [38:0] input_reg;
wire [33:0] current_state = {msm_cs,ru_wd_en,wd_timeout_value};
wire [31:0] prev1_state = 32'd0;
wire [31:0] prev2_state = 32'd0;
logic en, sel;

assign RU_DOUT = shift_reg[0];
 
always_ff @ (posedge RU_CLK)
  casex ({RU_SHIFTnLD,RU_CUPTnUPDT,shift_reg[40],shift_reg[39]})
    4'b00xx:begin input_reg <= shift_reg[38:0]; en <= shift_reg[12]; sel <= shift_reg[13]; end
    4'b0100:shift_reg <= {7'd0,current_state};
    4'b0101:shift_reg <= {9'd0,prev1_state};
    4'b0110:shift_reg <= {9'd0,prev2_state};
    4'b0111:shift_reg <= {2'b00,input_reg};
    4'b1xxx:shift_reg <= {RU_DIN,shift_reg[40:1]};
    default:;
  endcase
  
endmodule