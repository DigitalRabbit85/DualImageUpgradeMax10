`include "inc_define.vh"
module StateMachine 
#( parameter NUMBER = 256 )
(
input clk,
input reset,

input start_rx,
input [7:0] cmd_rx, len_rx,
output logic start_tx,
output logic [7:0] cmd_tx, len_tx,

output logic start_rd_ram,
input done_rd_ram,
output logic [clogb2(NUMBER)-1:0] start_rd_addr,
input [31:0] rd_word,  

output logic start_wr_ram,
input done_wr_ram,
output logic [clogb2(NUMBER)-1:0] start_wr_addr,
output logic [31:0] wr_word,

output logic start_setimg,
output logic start_getimg,
output logic [1:0] setimg,
input done_getimg,
input [3:0] getimg
`ifdef boot
,

output logic start_rdsr,
output logic start_rdcr,
output logic start_wrcr,
input [31:0] rd_data_csr,
output logic [31:0] wr_data_csr,
input done_csr,

output logic start_addr,
output logic [23:0]	addr_data,
output logic start_rddata,
input [31:0] rd_data_data,
output logic start_wrdata,
output logic [31:0] wr_data_data,
input done_data
`endif
);

localparam [7:0] parSETIMG = 8'h53,  //ASCII - S
                 parGETIMG = 8'h43,  //ASCII - C
				 parRDSR = 8'h52,	 //ASCII - R //new
				 parRDCR = 8'h45,    //ASCII - E //new
				 parWRCR = 8'h47,    //ASCII - G //new
				 parADDR = 8'h41,    //ASCII - A //new
				 parRDDATA = 8'h56,  //ASCII - V //new
				 parWRDATA = 8'h4B/*,	 //ASCII - K //new
				 parFAIL = 8'h0F*/;

enum {
	IDLE_ST,
	RX_CMD_ST,
	SETIMG_ST,
	SETIMG_WAIT_RD_RAM_ST,
	SETIMG_START_ST,
	GETIMG_ST,
	GETIMG_START_ST,
	TX_CMD_ST,
	GETIMG_START_TX_RAM_ST,
	GETIMG_WAIT_TX_RAM_ST,
	GETIMG_DONE_TX_ST,
	CLR_FL_ST
`ifdef boot	
	,
	
	RDSR_START_ST,
	RDCR_START_ST,	
	WRCR_START_RD_RAM_ST,
	WRCR_WAIT_RD_RAM_ST,
	WRCR_START_ST,
	RDSRCR_START_TX_RAM_ST,
	RDSRCR_WAIT_TX_RAM_ST,
	RDSRCR_DONE_TX_ST,

	ADDR_START_RD_RAM_ST,
	ADDR_WAIT_RD_RAM_ST,
	ADDR_START_ST,

	RDDATA_FLASH_ST,	
	RDDATA_START_FLASH_ST,
	RDDATA_START_WR_RAM_ST,
	RDDATA_WAIT_WR_RAM_ST,
	RDDATA_CHECK_WR_RAM_ST,
	RDDATA_TX_ST,

	WRDATA_FLASH_ST,
	WRDATA_START_RD_RAM_ST,
	WRDATA_WAIT_RD_RAM_ST,	
	WRDATA_START_FLASH_ST,	
	WRDATA_CHECK_ST,
	WRDATA_START_WR_RAM_ST,
	WRDATA_WAIT_WR_RAM_ST,
	WRDATA_TX_ST
`endif	
	} state, next;
		   
logic fl_rx, fl_tx, clr_fl;
wire set_fl_tx;

`ifdef boot
assign set_fl_tx = done_getimg | done_csr | done_data;
`else
assign set_fl_tx = done_getimg;
`endif

always_ff @ (posedge clk, posedge reset)
  if (reset) begin
    fl_rx <= 1'b0;
	fl_tx <= 1'b0; end
  else begin
  
    if (start_rx) fl_rx <= 1'b1;
    else if (clr_fl) fl_rx <= 1'b0;
      
    if (set_fl_tx) fl_tx <= 1'b1;
    else if (clr_fl) fl_tx <= 1'b0;
	
  end
	
`ifdef image1
logic [7:0] cnt_word;		   
logic [7:0] num_byte;
wire [7:0] num_word = (num_byte == '0) ? 8'd64 : num_byte[7:2];
`endif
		   
always_ff @ (posedge clk, posedge reset)
  if (reset) state <= IDLE_ST;
  else state <= next;		   
		   
always_comb
  case (state)
    IDLE_ST: 
		if (fl_rx) next = RX_CMD_ST;
	    else if (fl_tx) next = TX_CMD_ST;
	    else next = IDLE_ST;
    RX_CMD_ST:
		if (cmd_rx == parSETIMG) next = SETIMG_ST;
		else if (cmd_rx == parGETIMG) next = GETIMG_ST;
`ifdef boot
		else if (cmd_rx == parRDSR) next = RDSR_START_ST;
		else if (cmd_rx == parRDCR) next = RDCR_START_ST;
		else if (cmd_rx == parWRCR) next = WRCR_START_RD_RAM_ST;
		else if (cmd_rx == parADDR) next = ADDR_START_RD_RAM_ST;
		else if (cmd_rx == parRDDATA) next = RDDATA_FLASH_ST;
		else if (cmd_rx == parWRDATA) next = WRDATA_FLASH_ST;
`endif		
		else next = CLR_FL_ST;
    SETIMG_ST: 
		next = SETIMG_WAIT_RD_RAM_ST;
	SETIMG_WAIT_RD_RAM_ST: 
		if (done_rd_ram) next = SETIMG_START_ST; 
		else next = SETIMG_WAIT_RD_RAM_ST;
	SETIMG_START_ST: 
		next = CLR_FL_ST;
	GETIMG_ST: 
		next = GETIMG_START_ST;
	GETIMG_START_ST: 
		next = CLR_FL_ST;
	TX_CMD_ST:
		if (cmd_tx == parGETIMG) next = GETIMG_START_TX_RAM_ST;
`ifdef boot
		else if (cmd_tx == parRDSR) next = RDSRCR_START_TX_RAM_ST;
		else if (cmd_tx == parRDCR) next = RDSRCR_START_TX_RAM_ST;
		else if (cmd_tx == parRDDATA) next = RDDATA_START_WR_RAM_ST;
		else if (cmd_tx == parWRDATA) next = WRDATA_CHECK_ST;
`endif		
		else next = CLR_FL_ST;
	GETIMG_START_TX_RAM_ST: 
		next = GETIMG_WAIT_TX_RAM_ST; 
	GETIMG_WAIT_TX_RAM_ST: 
		if (done_wr_ram) next = GETIMG_DONE_TX_ST; 
		else next = GETIMG_WAIT_TX_RAM_ST;
	GETIMG_DONE_TX_ST: 
		next = CLR_FL_ST;
`ifdef boot
	RDSR_START_ST:
		next = CLR_FL_ST;
	RDCR_START_ST:
		next = CLR_FL_ST;
	WRCR_START_RD_RAM_ST: 
		next = WRCR_WAIT_RD_RAM_ST;
	WRCR_WAIT_RD_RAM_ST: 
		if (done_rd_ram) next = WRCR_START_ST; 
		else next = WRCR_WAIT_RD_RAM_ST;
	WRCR_START_ST: 
		next = CLR_FL_ST;
	RDSRCR_START_TX_RAM_ST: 
		next = RDSRCR_WAIT_TX_RAM_ST;
	RDSRCR_WAIT_TX_RAM_ST: 
		if (done_wr_ram) next = RDSRCR_DONE_TX_ST; 
		else next = RDSRCR_WAIT_TX_RAM_ST;
	RDSRCR_DONE_TX_ST: 
		next = CLR_FL_ST;

	ADDR_START_RD_RAM_ST: 
		next = ADDR_WAIT_RD_RAM_ST;
	ADDR_WAIT_RD_RAM_ST: 
		if (done_rd_ram) next = ADDR_START_ST; 
		else next = ADDR_WAIT_RD_RAM_ST;		
	ADDR_START_ST: 
		next = CLR_FL_ST;

	RDDATA_FLASH_ST:
		next = RDDATA_START_FLASH_ST;
	RDDATA_START_FLASH_ST:
	  next = CLR_FL_ST;
	RDDATA_START_WR_RAM_ST:
	  next = RDDATA_WAIT_WR_RAM_ST;
	RDDATA_WAIT_WR_RAM_ST: 
		if (done_wr_ram) next = RDDATA_CHECK_WR_RAM_ST; 
		else next = RDDATA_WAIT_WR_RAM_ST;  
	RDDATA_CHECK_WR_RAM_ST:
	  if (cnt_word < num_word) next = RDDATA_START_FLASH_ST;
	  else next = RDDATA_TX_ST;	
	RDDATA_TX_ST:
		next = CLR_FL_ST;
		
	WRDATA_FLASH_ST:
		next = WRDATA_START_RD_RAM_ST;
	WRDATA_START_RD_RAM_ST:
		next = WRDATA_WAIT_RD_RAM_ST;
	WRDATA_WAIT_RD_RAM_ST:
		if (done_rd_ram) next = WRDATA_START_FLASH_ST; 
		else next = WRDATA_WAIT_RD_RAM_ST;
	WRDATA_START_FLASH_ST:
		next = CLR_FL_ST;		
	WRDATA_CHECK_ST:
	 if (cnt_word < num_word) next = WRDATA_START_RD_RAM_ST;
	 else next = WRDATA_START_WR_RAM_ST;	   
	WRDATA_START_WR_RAM_ST:
	   next = WRDATA_WAIT_WR_RAM_ST;
	WRDATA_WAIT_WR_RAM_ST:
		if (done_wr_ram) next = WRDATA_TX_ST; 
		else next = WRDATA_WAIT_WR_RAM_ST;
	WRDATA_TX_ST:
	   next = CLR_FL_ST;	
`endif	   
	
	CLR_FL_ST: next = IDLE_ST;
	default: 
		next = IDLE_ST;
  endcase    

always_ff @ (posedge clk, posedge reset)
  if (reset) begin
    cmd_tx <= '0;
    start_rd_ram <= 1'b0;
	start_wr_ram <= 1'b0;
    start_rd_addr <= '0;
	start_wr_addr <= '0;
	start_setimg <= 1'b0;
	start_getimg <= 1'b0;
	setimg <= 2'b00;
	wr_word <= '0;	
	start_tx <= 1'b0;
	len_tx <= '0;
	clr_fl <= 1'b0;
`ifdef boot
	start_rdsr <= 1'b0;
	start_rdcr <= 1'b0;
	start_wrcr <= 1'b0;
	wr_data_csr <= '0;
	wr_data_data <= '0;
	start_addr <= 1'b0;
	addr_data <= '0;
	num_byte <= '0;
	start_rddata <= 1'b0;
	start_wrdata <= 1'b0;
	cnt_word <= '0;
`endif	
  end
  else begin
	case (next)
		IDLE_ST:begin 
		    start_setimg <= 1'b0; 
		    start_getimg <= 1'b0; 
		    start_tx <= 1'b0;
		    //start_rdsr <= 1'b0;
		    clr_fl <= 1'b0; end
		RX_CMD_ST:
		    cmd_tx <= cmd_rx;
		SETIMG_ST:begin 
		    start_rd_ram <= 1'b1; 
		    start_rd_addr <= '0; end
		SETIMG_WAIT_RD_RAM_ST: begin 
		    start_rd_ram <= 1'b0; end
		SETIMG_START_ST: begin 
		    start_setimg <= 1'b1; 
		    setimg <= rd_word[1:0]; end
		GETIMG_ST:;
		GETIMG_START_ST: begin 
	 	    start_getimg <= 1'b1; end
		TX_CMD_ST:;
		GETIMG_START_TX_RAM_ST: begin 
		    wr_word <= {24'd0,4'h0,getimg}; 
		    start_wr_ram <= 1'b1; 
		    start_wr_addr <= '0; end
		GETIMG_WAIT_TX_RAM_ST: 
		    start_wr_ram <= 1'b0;
		GETIMG_DONE_TX_ST: begin 
		    len_tx <= 8'd1; 
		    start_tx <= 1'b1; end
`ifdef boot
		RDSR_START_ST: begin
		    start_rdsr <= 1'b1; end
		RDCR_START_ST: begin
		    start_rdcr <= 1'b1; end
		WRCR_START_RD_RAM_ST: begin 
		    start_rd_ram <= 1'b1; 
		    start_rd_addr <= '0; end
		WRCR_WAIT_RD_RAM_ST: begin 
		    start_rd_ram <= 1'b0; end
		WRCR_START_ST: begin 
		    start_wrcr <= 1'b1; 
		    wr_data_csr <= rd_word[31:0]; end
		RDSRCR_START_TX_RAM_ST: begin 
		    wr_word <= rd_data_csr; 
		    start_wr_ram <= 1'b1; 
		    start_wr_addr <= '0; end
		RDSRCR_WAIT_TX_RAM_ST: 
		    start_wr_ram <= 1'b0;
		RDSRCR_DONE_TX_ST: begin 
		    len_tx <= 8'd4; 
		    start_tx <= 1'b1; end

		ADDR_START_RD_RAM_ST:begin 
		    start_rd_ram <= 1'b1; 
		    start_rd_addr <= '0; end
		ADDR_WAIT_RD_RAM_ST: begin 
		    start_rd_ram <= 1'b0; end
		ADDR_START_ST: begin 
		    start_addr <= 1'b1; 
		    addr_data <= rd_word[23:0];
		    num_byte <= rd_word[31:24]; end			

		RDDATA_FLASH_ST: begin			
			cnt_word <= '0; end
		RDDATA_START_FLASH_ST: begin
			start_rddata <= 1'b1; end
		RDDATA_START_WR_RAM_ST: begin
			wr_word <= funcReverse32bit(rd_data_data);
			start_wr_ram <= 1'b1;
			start_wr_addr <= {cnt_word[5:0],2'b00};
			cnt_word <= cnt_word + 1'b1; end
		RDDATA_WAIT_WR_RAM_ST: begin
			start_wr_ram <= 1'b0; end
		RDDATA_CHECK_WR_RAM_ST:;	 
		RDDATA_TX_ST: begin
			len_tx <= {cnt_word[5:0],2'b00};
			start_tx <= 1'b1; end
		
		WRDATA_FLASH_ST: begin
			cnt_word <= '0; end	
		WRDATA_START_RD_RAM_ST: begin
			start_rd_ram <= 1'b1;		
			start_rd_addr <= {cnt_word[5:0],2'b00};
			cnt_word <= cnt_word + 1'b1; end	
		WRDATA_WAIT_RD_RAM_ST: begin
			start_rd_ram <= 1'b0; end			
  		WRDATA_START_FLASH_ST: begin
  			start_wrdata <= 1'b1;
			wr_data_data <= funcReverse32bit(rd_word[31:0]); end			
		WRDATA_CHECK_ST:;		  
		WRDATA_START_WR_RAM_ST: begin
		  wr_word <= '0;
		  start_wr_ram <= 1'b1; end
		WRDATA_WAIT_WR_RAM_ST: begin
		  start_wr_ram <= 1'b0; end
		WRDATA_TX_ST: begin
		  start_tx <= 1'b1;
		  len_tx <= 8'd1; end		 
`endif		  
		
		CLR_FL_ST: begin 
		    clr_fl <= 1'b1;
		    start_setimg <= 1'b0; 
		    start_getimg <= 1'b0; 
		    start_tx <= 1'b0;
`ifdef boot
		    start_rdsr <= 1'b0;
			start_rdcr <= 1'b0;
			start_wrcr <= 1'b0;
			start_addr <= 1'b0;
			start_rddata <= 1'b0;
			start_wrdata <= 1'b0; 
`endif			
		end
    endcase
  end
	   
endmodule
