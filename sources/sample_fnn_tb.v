`timescale 1ns/1ps


module sample_fnn_tb;
reg signed [15:0] x1,x2;
wire signed [15:0] y;

sample_fnn uut(.x1(x1), .x2(x2), .y(y));

initial
begin
x1=13992;
x2=7408;

#50$finish;
end
initial $monitor($time, "Output=%d", y);


endmodule