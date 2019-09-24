gmake clobber
./run_c.sh
vlog part3.sv
vlog /usr/local/synopsys/syn/dw/sim_ver/DW_sqrt.v
vlog part3_tb.sv
vsim tb_part3 +acc
