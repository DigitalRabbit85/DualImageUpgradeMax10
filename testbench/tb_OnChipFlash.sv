module tb_OnChipFlash (

input Clock,
input Resetn,

input Addr_Csr,
input Read_Csr,
input Write_Csr,
output logic [31:0] ReadData_Csr,
input [31:0] WriteData_Csr,

input [16:0] Addr_Data,
input Read_Data,
input Write_Data,
output [31:0] ReadData_Data,
input [31:0] WriteData_Data,
output ReadDataValid,
output WaitRequest

);

parameter [31:0] parRDSR = 32'hA1_43_B5_CD;
parameter [31:0] parRDCR = 32'h80_CA_33_43;

logic [31:0] WRCR;
logic fl_rd;

logic [31:0] flash [0:131071];
//logic [31:0] flash [0:7];
logic [4:0] read_shift;

/*initial
	for(int i=0; i<131072; i++) flash[i] = {$random} % (2**32);*/

logic [7:0]	temp1, temp2, temp3, temp4;
initial
begin
  for(int i=0; i<131072; i++) begin
    temp1 = {$random} % (2**8);
    temp2 = {$random} % (2**8);
    temp3 = {$random} % (2**8);
    temp4 = {$random} % (2**8);
    flash[i] = {temp1, temp2, temp3, temp4};
  end
end	

always_ff @ (negedge Clock, negedge Resetn)
	if (!Resetn) WRCR <= '0;
	else if (Write_Csr & Addr_Csr) WRCR <= WriteData_Csr;
	
always_ff @ (negedge Clock, negedge Resetn)	
	if (!Resetn) fl_rd <= 1'b0;	
	else if (Read_Csr) fl_rd <= 1'b1;	
	else fl_rd <= 1'b0;	
	
always_ff @ (posedge Clock, negedge Resetn)	
	if (!Resetn) ReadData_Csr <= '0;
	else if (fl_rd & !Addr_Csr) ReadData_Csr <= parRDSR;
	else if (fl_rd & Addr_Csr) ReadData_Csr <= parRDCR;
	else ReadData_Csr <= '0;
	
always_ff @ (posedge Clock, negedge Resetn)	
	if (!Resetn) read_shift <= '0;
	else read_shift <= {read_shift[3:0],Read_Data};
assign ReadData_Data = (read_shift[4]) ? flash[Addr_Data] : '0;

assign ReadDataValid = read_shift[4];

logic [15:0] shift_writerequest;
//logic [31:0] write_reg;
logic [23:0] write_reg;

always_ff @ (negedge Clock, negedge Resetn)
	if (!Resetn) write_reg <= '0;
	//else write_reg <= {write_reg[30:0],Write_Data};
	else write_reg <= {write_reg[22:0],Write_Data};

always_ff @ (posedge Clock, negedge Resetn)
	if (!Resetn) shift_writerequest <= '0;
	else shift_writerequest <= {shift_writerequest[14:0],(Write_Data)&(!write_reg[/*31*/23])};
assign WaitRequest = (!(&shift_writerequest[15:0]))&(Write_Data);
	
endmodule