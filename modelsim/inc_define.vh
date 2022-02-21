`timescale 1ns/1ns;

`define image0
//`define image1

`define SIM

//localparam int width_reverse = 8;

function automatic int clogb2 (input int number);
    int calc;
    begin
      for (int i = 0; 2**i < number; i++)
        calc = i + 1;
        clogb2 = (number == 0) ? 0 :
                  (number == 1) ? 1 : calc;
    end
endfunction

/*function automatic [width_reverse-1:0] funcReverse (input [width_reverse-1:0] in_word);
  int i;
  begin
    for (i=0; i<width_reverse; i=i+1)
      funcReverse[i] = in_word[width_reverse-(i+1)];
  end
endfunction*/

function automatic [7:0] funcReverse8bit (input [7:0] in_word);
  int i;
  begin
    for (i=0; i<8; i=i+1)
      funcReverse8bit[i] = in_word[7-i];
  end
endfunction

function automatic [31:0] funcReverse32bit (input [31:0] in_word);
  int i;
  begin
    for (i=0; i<32; i=i+1)
      funcReverse32bit[i] = in_word[31-i];
  end
endfunction