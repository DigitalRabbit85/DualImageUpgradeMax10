`include "inc_define.vh"
module tb_rxuart_timeout;

parameter real parClock = 10_000_000; //Hz 
localparam realtime parPeriod = 1/parClock * 1_000_000_000;
parameter real parUartSpeed = 1_000_000; // bit/s
localparam realtime tb_bit = (1/parUartSpeed) * 1_000_000_000;

parameter int CLOCK = 10_000_000;
parameter int BAUD = 1_000_000;
parameter FIRST_BIT = "LSB";
parameter PARITY = "NO";
parameter RX_TIMEOUT = 2;

logic clk, reset;
wire single_done, single_busy, timeout;
logic rxd_uart;

defparam SingleRxUART.CLOCK = CLOCK;
defparam SingleRxUART.BAUD = BAUD;
defparam SingleRxUART.PARITY = PARITY;
defparam SingleRxUART.FIRST_BIT = FIRST_BIT;
SingleRxUART SingleRxUART
(
  .clk (clk), .reset (reset),
  .rxd (rxd_uart),
  .rx_data (), 
  .parity_err (),
  .done (single_done),
  .busy (single_busy)
);

defparam RxUART_timeout.CLOCK = CLOCK;
defparam RxUART_timeout.BAUD = BAUD;
defparam RxUART_timeout.PARITY = PARITY;
defparam RxUART_timeout.TIMEOUT = RX_TIMEOUT;
RxUART_timeout RxUART_timeout
(
  .clk (clk), .reset (reset),
  .rx_done (single_done), .rx_busy (single_busy),
  .timeout (timeout)
);

initial
begin
  clk = 0;
  forever #(parPeriod/2) clk = !clk;
end

task SendUartByte(input logic [7:0] data, input string first, input real baud, input string parity);
  logic [7:0] shift;  
  realtime takt;
  int num = 8;
  begin
    $display("Send data = %h",data);
    
    takt = (1/baud) * 1_000_000_000;
    shift = data;    
      
    rxd_uart = 0;
    #takt;
    
    if (first == "MSB") for(int i=num; i>0; i--) begin
      rxd_uart = shift[num-1];
      #takt;
      shift = {shift[6:0],1'b1}; end
    if (first == "LSB") for(int i=0; i<num; i++) begin
      rxd_uart = shift[0];
      #takt;
      shift = {1'b1,shift[7:1]}; end
      
    if (parity == "ODD") begin rxd_uart = ~(^data); #takt; end
    else if (parity == "EVEN") begin rxd_uart = (^data); #takt; end  
    
    rxd_uart = 1;
    #takt;
        
  end
endtask  

initial
begin
	reset = 1;
	repeat (2) @(posedge clk);
	reset = 0;
	repeat (50) @(posedge clk);
	SendUartByte(8'h53,"LSB",parUartSpeed,"NO");
	repeat (10) #tb_bit;
	SendUartByte(8'h9B,"LSB",parUartSpeed,"NO");
	repeat (30) #tb_bit;
	SendUartByte(8'h46,"LSB",parUartSpeed,"NO");
	repeat (10) #tb_bit;

	$stop;$stop;$stop;

end

endmodule