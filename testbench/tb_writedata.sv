module tb_writedata;

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

localparam [7:0]  parSETIMG = 8'h53,  //ASCII - S
                  parGETIMG = 8'h43,  //ASCII - C
                  parRDSR = 8'h52,	 //ASCII - R
				          parRDCR = 8'h45,    //ASCII - E
				          parWRCR = 8'h47,    //ASCII - G
				          parADDR = 8'h41,    //ASCII - A
				          parRDDATA = 8'h56,
				          parWRDATA = 8'h4B;	 //ASCII - K
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

task SendAddr (input logic [23:0] addr, input logic [7:0] data);
  begin
    SendUartByte(parADDR,"LSB",parUartSpeed,"NO");
    SendUartByte(4,"LSB",parUartSpeed,"NO");
    SendUartByte(addr[7:0],"LSB",parUartSpeed,"NO");
	  SendUartByte(addr[15:8],"LSB",parUartSpeed,"NO");
	  SendUartByte(addr[23:16],"LSB",parUartSpeed,"NO");
	  SendUartByte(data[7:0],"LSB",parUartSpeed,"NO");
    SendUartByte(~(parADDR + 8'd4 + addr[7:0] + addr[15:8] + addr[23:16] + data[7:0]),"LSB",parUartSpeed,"NO");
  end
endtask

logic [7:0] wr_ram [0:255];

task init_wr_ram;
  logic [7:0] temp;
  begin
    for(int i=0; i<256; i++) begin
      temp = {$random} % (2**8);
      wr_ram[i] = temp;
    end
  end
endtask

task SendWriteData(logic [8:0] num);
  logic [7:0] sum = 0;
	begin
	  sum = 0;
	  SendUartByte(parWRDATA,"LSB",parUartSpeed,"NO");
    SendUartByte(num[7:0],"LSB",parUartSpeed,"NO");
    for(int i=0; i<num; i++) begin
      SendUartByte(wr_ram[i],"LSB",parUartSpeed,"NO");
      sum += wr_ram[i];
    end
	SendUartByte(~(parWRDATA + num[7:0] + sum),"LSB",parUartSpeed,"NO");
	end
endtask

initial
begin
  rxd_uart = 1;
  #575;
  repeat (10) #tb_bit;
  
  SendAddr(24'h00_00_01, 8'd4);
  repeat (10) #tb_bit;  
  repeat (100) #tb_bit;
  
  init_wr_ram;
  SendWriteData(4);
  repeat (10) #tb_bit;  
  repeat (200) #tb_bit;  
  
  SendAddr(24'h00_02_00, 8'd40);
  repeat (10) #tb_bit;  
  repeat (100) #tb_bit;
  
  SendWriteData(40);
  repeat (10) #tb_bit;  
  repeat (1000) #tb_bit;
  
  SendAddr(24'h00_00_00, 8'd0);
  repeat (10) #tb_bit;  
  repeat (100) #tb_bit;
  
  SendWriteData(256);
  repeat (10) #tb_bit;  
  repeat (1000) #tb_bit;  
  
  $stop;$stop;$stop;
end

endmodule