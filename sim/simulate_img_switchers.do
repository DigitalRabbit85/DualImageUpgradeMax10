vsim -novopt work.tb_img_switchers

#########################################################
add wave -noupdate -divider {tb_img_switchers}
add wave -noupdate -group {tb_img_switchers} -radix hexadecimal -format Logic /tb_img_switchers/*

#########################################################
add wave -noupdate -divider {ImageControl_v3}
add wave -noupdate -group {ImageControl_v3} -radix hexadecimal -format Logic /tb_img_switchers/ImageControl_v3/*

