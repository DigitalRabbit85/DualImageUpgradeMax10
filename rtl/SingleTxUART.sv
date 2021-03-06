`include "inc_define.vh"
module SingleTxUART 
#(
	parameter int CLOCK = 50_000_000,
	parameter int BAUD = 115_200,
	parameter PARITY = "NO",
	parameter FIRST_BIT = "LSB"
)	
(
	input clk, reset,
	output logic txd,
  input start,
  input [7:0] tx_data,
  output logic busy
);

///// PARAMETERS /////

localparam real factor_real = CLOCK/BAUD;
localparam int factor_int = factor_real;

///// MAKE WORD /////

wire parity_bit;
wire [7:0] tx_data_;
wire [10:0] data_wire;
logic [10:0] data_buf;

generate
  if (PARITY == "ODD") 
    assign parity_bit = ~(^(tx_data));
  if (PARITY == "EVEN") 
    assign parity_bit = ^(tx_data);
endgenerate

generate
  if (FIRST_BIT == "MSB") 
    assign tx_data_ = tx_data;
  if (FIRST_BIT == "LSB") 
    assign tx_data_ = funcReverse8bit(tx_data);
endgenerate

generate
  if (PARITY == "NO") 
    assign data_wire = {1'b0,tx_data_,1'b1};
  if ((PARITY == "ODD")|(PARITY == "EVEN")) 
    assign data_wire = {1'b0,tx_data_,parity_bit,1'b1};
endgenerate

always_ff @ (posedge clk, posedge reset)
  if (reset) data_buf <= '0;  
  else if (start) data_buf <= data_wire;

///// COUNT WORD /////

logic [clogb2(factor_int)-1:0] len_bit;
wire clr_len_bit = (len_bit == factor_int-1);
logic [3:0] cnt_bit;
wire [3:0] width_word;

always_ff @ (posedge clk, posedge reset)  
  if (reset) len_bit <= '0;
  else if (start) len_bit <= '0;
  else if (clr_len_bit) len_bit <= '0;
  else if (busy) len_bit <= len_bit + 1'b1;
  
generate
  if (PARITY == "NO") 
    assign width_word = 4'd10;
  if ((PARITY == "ODD")|(PARITY == "EVEN")) 
    assign width_word = 4'd11;
endgenerate  
  
always_ff @ (posedge clk, posedge reset)  
  if (reset) cnt_bit <= '0;
  else if (start) cnt_bit <= width_word-1;
  else if ((cnt_bit != '0)&(clr_len_bit)) cnt_bit <= cnt_bit - 1'b1;
    
///// MUX OUT /////    
  
always_ff @ (posedge clk, posedge reset)  
  if (reset) busy <= 1'b0;
  else if (start) busy <= 1'b1;
  else if ((cnt_bit == '0) & (clr_len_bit)) busy <= 1'b0;  
    
always_ff @(posedge clk, posedge reset)
  if (reset) txd <= 1'b1;
  else if ((busy)&(!start)) txd <= data_buf[cnt_bit];
  else txd <= 1'b1;
  
endmodule
