module sample_fnn_tb;
reg clk;
wire signed [15:0] out;

sample_fnn uut(.clk(clk), .out(out));

endmodule