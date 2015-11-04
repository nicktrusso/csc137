// 5bitAdder.v
// csc137 Assignment #2
// 5-bit full adder...can be scaled to n-bit adder
// Nicholas Trusso

module Adder(x,y,s,c);
	input [7:0] x, y;
	output [7:0] s;
	output c;
	wire c1,c2,c3,c4,c5,c6,c7;

	HalfAdder ha(x[0],y[0],s[0],c1);  //no carry in bit, half adder is sufficient
	FullAdder fa1(x[1],y[1],c1,s[1],c2);
	FullAdder fa2(x[2],y[2],c2,s[2],c3);
	FullAdder fa3(x[3],y[3],c3,s[3],c4);
	FullAdder fa4(x[4],y[4],c4,s[4],c5);
	FullAdder fa5(x[5],y[5],c5,s[5],c6);
	FullAdder fa6(x[6],y[6],c6,s[6],c7);
	FullAdder fa7(x[7],y[7],c7,s[7],c);
endmodule

module FullAdder(x,y,z,s,c); //z is the carry in bit
	input x,y,z;
	output s,c;
	wire xor1,and1,and2;
	
	HalfAdder h1(x,y,xor1,and1);
	HalfAdder h2(xor1,z,s,and2);
	or(c,and1,and2);	
endmodule

module HalfAdder(x,y,s,c);
	input x,y;
	output s,c;
	xor(s,x,y);
	and(c,x,y);
endmodule

module TestMod;

	parameter STDIN = 32'h8000_0000; //I/O address of keyboard input channel 
	reg [3:0] enter;
	reg [7:0] accumulator,x,y;	
	wire [7:0] s; 	//8-bit sum
	wire c; 	//carry out bit
	Adder add(x,y,s,c);
	
	initial begin
		accumulator = 0;
		$display("Enter two digit number(x): ");
		accumulator = accumulator*10+$fgetc(STDIN);
		accumulator = accumulator*10+$fgetc(STDIN);
		accumulator = accumulator - 16;
		enter = $fgetc(STDIN);
		x = accumulator;
		accumulator = 0;
		$display("Enter two digit number(x): ");
		accumulator = accumulator*10+$fgetc(STDIN);
		accumulator = accumulator*10+$fgetc(STDIN);
		accumulator = accumulator - 16;
		enter = $fgetc(STDIN);
		y = accumulator;
		#1;
		$display("x=%d (%b)  y=%d (%b)",x,x,y,y);
		$display("s=%d   c=%b",s,c);
	end
endmodule 
