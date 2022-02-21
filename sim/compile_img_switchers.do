do compile_max10.do
vlog -sv $dir_tb/tb_img_switchers.sv
vlog $dir_rtl/MyLoadImageMax10_test.v
vlog -sv $dir_rtl/ImageControl_v3.sv
vlog -sv $dir_tb/tb_RSU_Block.sv