`timescale 1ns/1ps


module sample_fnn(
input signed [15:0] x1,x2,
output signed [15:0] y
);

wire signed [15:0] w11, w21,w12,w22,w13,w23;//weight between input and hidden layer 
wire signed [15:0] b1,b2,b3; //biases at the hidden layer
wire signed [15:0] v1,v2,v3; // weights between hidden layer and output
wire signed [15:0] c; // bias at the output layer

assign w11 = -16'sd2391;
assign w12 = -16'sd1246;
assign w13 = -16'sd15881;
assign w21 = 16'sd13074;
assign w22 = 16'sd11277;
assign w23 = -16'sd4888;


assign b1 = 16'sd1624;
assign b2 = 16'sd4006;
assign b3 = 16'sd0;

assign v1 = -16'sd11882;
assign v2 = 16'sd13314;
assign v3 = 16'sd18166;

assign c= 16'sd5844;

wire signed [32:0] m11,m21,m12,m22,m13,m23,m1,m2,m3;
wire signed [15:0]a1,a2,a3;

assign m11 = (w11*x1) + 33'h000010000;
assign m21 = (w21*x2) + 33'h000010000;
assign m12 = (w12*x1) + 33'h000010000;
assign m22 = (w22*x2) + 33'h000010000;
assign m13 = (w13*x1) + 33'h000010000;
assign m23 = (w23*x2) + 33'h000010000;

assign a1 = (m11>>17) + (m21>>17) +b1;
assign a2 = (m12>>17) + (m22>>17) +b2;
assign a3 = (m13>>17) + (m23>>17) +b3;

function signed [15:0] relu;
	input signed [15:0] z;
		if(z<=0)
			relu = 16'sd0;
		else
			relu = z;
endfunction

wire signed [15:0]a_1= relu(a1);
wire signed [15:0]a_2 = relu(a2);
wire signed [15:0]a_3 = relu(a3);
initial 
begin
$monitor($time, "a_1=%d", a_1);
$monitor($time, "a_2=%d", a_2);
$monitor($time, "a_3=%d", a_3);
end


wire signed  [15:0] a;

assign m1 = (v1*a_1) + 33'h000010000;
assign m2 = (v2*a_2) + 33'h000010000;
assign m3 = (v3*a_3) + 33'h000010000;

assign a = (m1>>17) + (m2>>17) +(m3>>17) + c;


assign y = relu(a); 

endmodule 