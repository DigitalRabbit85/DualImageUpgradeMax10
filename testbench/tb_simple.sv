module tb_simple;
  
//parameter real parClock = 50_000_000; //Hz  
//parameter real parUartSpeed = 115_200; // bit/s
parameter real parClock = 100_000_000; //Hz  
parameter real parUartSpeed = 10_000_000; // bit/s

//parameter int CLOCK = 50_000_000;
//parameter int BAUD = 115_200;
parameter int CLOCK = 100_000_000;
parameter int BAUD = 10_000_000;
parameter PARITY = "NO";
parameter FIRST_BIT = "LSB";
parameter NUMBER = 256;
parameter RX_TIMEOUT = 10;

logic inclk;
logic rxd_uart;
wire txd_uart;
wire [4:0] led;

localparam [7:0] parSETIMG = 8'h53,  //ASCII - S
                 parGETIMG = 8'h43;  //ASCII - C
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
  $display("System Clock in Hz = %d",parClock);
  $display("System Clock in ns = %f",parPeriod);
  $display("UART baud in Bit/s = %d",parUartSpeed);
  $display("UART baud in ns = %f",tb_bit);
end

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

task SendUartPacket(input [7:0] length);
  logic [7:0] crc, data;
  begin
    data = {$random} % 256; SendUartByte(data,"LSB",parUartSpeed,"NO"); crc = data;
    data = length; SendUartByte(data,"LSB",parUartSpeed,"NO"); crc = crc + data;
    repeat (length) begin data = {$random} % 256; SendUartByte(data,"LSB",parUartSpeed,"NO"); crc = crc + data; end
    data = ~crc; SendUartByte(data,"LSB",parUartSpeed,"NO");
  end
endtask

logic [7:0] tmp;

initial
begin
  rxd_uart = 1;
  #575;
  repeat (10) #tb_bit;
  /*for(int i=0; i<5; i++) #tb_bit;
  SendUartByte(8'h3A,"LSB",parUartSpeed,"NO");
  SendUartByte(8'h00,"LSB",parUartSpeed,"NO");
  SendUartByte(8'h03,"LSB",parUartSpeed,"NO");
  for(int i=0; i<30; i++) #tb_bit;  
  SendUartByte(8'h3A,"LSB",parUartSpeed,"NO");
  SendUartByte(8'h00,"LSB",parUartSpeed,"NO");
  SendUartByte(8'h93,"LSB",parUartSpeed,"NO");
  for(int i=0; i<30; i++) #tb_bit;*/
  
  /*repeat (256) begin
    tmp = {$random} % 256;
    SendUartByte(tmp,"LSB",parUartSpeed,"NO");
  end*/
  
  //SendUartPacket(3);
  
  SendUartByte(parSETIMG,"LSB",parUartSpeed,"NO");
  repeat (10) #tb_bit;
  SendUartByte(8'h04,"LSB",parUartSpeed,"NO");
  repeat (10) #tb_bit;
  SendUartByte(8'h93,"LSB",parUartSpeed,"NO");
  repeat (30) #tb_bit;
  SendUartByte(parGETIMG,"LSB",parUartSpeed,"NO");
  
  repeat (150) #tb_bit;  
  
  $stop;$stop;$stop;
end

endmodule