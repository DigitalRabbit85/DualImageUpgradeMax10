module tb_readdata;

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
                  parRDSR = 8'h52,    //ASCII - R
				          parRDCR = 8'h45,    //ASCII - E
				          parWRCR = 8'h47,    //ASCII - G
				          parADDR = 8'h41,    //ASCII - A
				          parRDDATA = 8'h56,
				          parWRDATA = 8'h4B;  //ASCII - K
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

wire [7:0] tb_cmd_rx, tb_len_rx;
wire tb_rx_done;

Receiver tb_receiver
(
  .clk (inclk), .reset (tb_readdata.Top.reset),
  .rxd (txd_uart),
  .cmd_rx (tb_cmd_rx), .len_rx (tb_len_rx),
  .wr_data (/*wr_rx_data*/), 
  .wr_addr (/*wr_rx_addr*/), 
  .wr_clock (/*wr_rx_clock*/),
  .we (/*we_rx*/),
  .rx_done (tb_rx_done)
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

task SendReadData(input logic [7:0] count);
	begin
    SendUartByte(parRDDATA,"LSB",parUartSpeed,"NO");
    SendUartByte(1,"LSB",parUartSpeed,"NO");
    SendUartByte(count,"LSB",parUartSpeed,"NO");
    SendUartByte(~(parRDDATA + 8'd1 + count),"LSB",parUartSpeed,"NO");
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
  
  SendReadData(0);
  repeat (10) #tb_bit;  
  repeat (200) #tb_bit;  
  
  SendAddr(24'h00_00_10, 8'd8);
  repeat (10) #tb_bit;  
  repeat (100) #tb_bit;

  SendReadData(0);
  repeat (10) #tb_bit;  
  repeat (200) #tb_bit;
  
  SendAddr(24'h00_01_00, 8'd64);
  repeat (10) #tb_bit;  
  repeat (100) #tb_bit;

  SendReadData(0);
  repeat (10) #tb_bit;  
  repeat (1600) #tb_bit;
  
  SendAddr(24'h00_04_00, 8'd0);
  repeat (10) #tb_bit;  
  repeat (100) #tb_bit;

  SendReadData(0);
  repeat (10) #tb_bit;  
  repeat (6400) #tb_bit;
  
  $stop;$stop;$stop;
end

logic [7:0] temp1, temp2, temp3, temp4;

initial
begin
	for(int i=0; i<131072; i++) begin 
		temp1 = {$random} % (2**8);
		temp2 = {$random} % (2**8);
		temp3 = {$random} % (2**8);
		temp4 = {$random} % (2**8);
		tb_readdata.Top.tb_OnChipFlash.flash[i] = {temp1,temp2,temp3,temp4};
	end
end	

endmodule