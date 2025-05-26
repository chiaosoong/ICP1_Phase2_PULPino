saveNetlist outputs/pulpino_padstop.v

all_hold_analysis_views 
all_setup_analysis_views 

write_sdf -version 3.0 outputs/pulpino_padstop.sdf -map_file /usr/local-eit/cad2/cmpstm/oldmems/mem2010/SPHDL100909-40446@1.0/behaviour/verilog/SPHDL100909.verilog.map -precision 4 -min_view FF -max_view SS

getCTSMode -engine -quiet
rcOut -spf outputs/pulpino_padstop_ss.spf -rc_corner SS
rcOut -spef outputs/pulpino_padstop_ss.spef -rc_corner SS

getCTSMode -engine -quiet
rcOut -spf outputs/pulpino_padstop_ff.spf -rc_corner FF
rcOut -spef outputs/pulpino_padstop_ff.spef -rc_corner FF
