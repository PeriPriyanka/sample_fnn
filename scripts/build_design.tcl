
# Find the directory containing this Tcl script
set script_dir [file dirname [file normalize [info script]]]


# parent directory
set parent_dir [file normalize [file join $script_dir ..]]


# Create a folder for generated reports and checkpoints
set output_dir [file join $parent_dir synth_outputs]
file mkdir $output_dir


# Read the Verilog design
set source_dir [file join $parent_dir sources]


read_verilog [file join $source_dir sample_fnn.v]


# Run synthesis directly, without creating a project
synth_design -top sample_fnn -part xczu7eg-ffvc1156-1-i


# Save the synthesized design
write_checkpoint -force [file join $output_dir sample_fnn.dcp]


# Generate a resource utilization report
report_utilization -file [file join $output_dir utilization.rpt]


# Generate a timing summary report
report_timing_summary -file [file join $output_dir timing_summary.rpt]


puts "Non-Project Mode synthesis completed."
