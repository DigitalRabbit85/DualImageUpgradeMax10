`include "inc_define.vh"
module tb_srcr;

real x_real;
int x_int;
  
parameter real parClock = 50_000_000; //Hz  
parameter real parUartSpeed = 115_200; // bit/s
//parameter real parClock = 100_000_000; //Hz  
//parameter real parUartSpeed = 10_000_000; // bit/s

parameter int CLOCK = 50_000_000;
parameter int BAUD = 115_200;
//parameter int CLOCK = 100_000_000;
//parameter int BAUD = 10_000_000;
parameter PARITY = "NO";
parameter FIRST_BIT = "LSB";
parameter NUMBER = 256;
parameter RX_TIMEOUT = 2/*10*/;

logic inclk;
logic rxd_uart;
wire txd_uart;
wire [4:0] led;

localparam [7:0] parSETIMG = 8'h53,  //ASCII - S
                 parGETIMG = 8'h43,  //ASCII - C
                 parRDSR = 8'h52,	 //ASCII - R
				 parRDCR = 8'h45,    //ASCII - E
				 parWRCR = 8'h47;    //ASCII - G
localparam realtime parPeriod = 1/parClock * 1_000_000_000;
localparam realtime tb_bit = (1/parUartSpeed) * 1_000_000_000;

defparam Top.CLOCK = CLOCK;
defparam Top.BAUD = BAUD;
defparam Top.PARITY = PARITY;
defparam Top.FIRST_BIT = FIRST_BIT;
defparam Top.NUMBER = NUMBER;
defparam Top.RX_TIMEOUT = RX_TIMEOUT;
Top Top
(
  .inclk (inclk),
  .rxd_uart (rxd_uart),
  .txd_uart (txd_uart),
  .led (led)
);

initial
begin
  inclk = 0;
  forever #(parPeriod/2) inclk = !inclk;
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

task SendReadSR;
  begin
    SendUartByte(parRDSR,"LSB",parUartSpeed,"NO");
    SendUartByte(1,"LSB",parUartSpeed,"NO");
    SendUartByte(8'h00,"LSB",parUartSpeed,"NO");
    SendUartByte(~(parRDSR + 8'd1 + 8'h00),"LSB",parUartSpeed,"NO");
  end
endtask

task SendReadCR;
  begin
    SendUartByte(parRDCR,"LSB",parUartSpeed,"NO");
    SendUartByte(1,"LSB",parUartSpeed,"NO");
    SendUartByte(8'h00,"LSB",parUartSpeed,"NO");
    SendUartByte(~(parRDCR + 8'd1 + 8'h00),"LSB",parUartSpeed,"NO");
  end
endtask

task SendWriteCR (input logic [31:0] data);
  begin
    SendUartByte(parWRCR,"LSB",parUartSpeed,"NO");
    SendUartByte(4,"LSB",parUartSpeed,"NO");
    SendUartByte(data[7:0],"LSB",parUartSpeed,"NO");
	SendUartByte(data[15:8],"LSB",parUartSpeed,"NO");
	SendUartByte(data[23:16],"LSB",parUartSpeed,"NO");
	SendUartByte(data[31:24],"LSB",parUartSpeed,"NO");
    SendUartByte(~(parWRCR + 8'd4 + data[7:0] + data[15:8] + data[23:16] + data[31:24]),"LSB",parUartSpeed,"NO");
  end
endtask

initial
begin
  rxd_uart = 1;
  #575;
  repeat (10) #tb_bit;
  
  SendReadSR();
  repeat (50) #tb_bit;
  
  SendReadCR();
  repeat (50) #tb_bit;
  
  SendWriteCR(32'h91_01_F3_01);
  repeat (10) #tb_bit;
  
  //$stop;
  
  //  SendGetImg;
  
  repeat (100) #tb_bit;  
  
  $stop;$stop;$stop;
end

endmodule