set_param project.enableReportConfiguration 0
load_feature core
current_fileset
xsim {sample_fnn_tb_sim} -wdb {F:/codes/Verilog/Non_project_mode/sample_fnn/sim_outputs/sample_fnn.wdb} -autoloadwcfg -tclbatch {F:/codes/Verilog/Non_project_mode/sample_fnn/sim_outputs/view_wave.tcl}
