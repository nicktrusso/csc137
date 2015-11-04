// AdderSubtractor.v
// csc137 Assignment #3
// 5-bit full adder/subtractor
// Nicholas Trusso

module AdderSubtractor(x,y,c0,s,c7,c8,e);
	input [7:0] x, y;
	input c0;
	output [7:0] s;
	output c7,c8,e;
	wire c1,c2,c3,c4,c5,c6;
	wire y0xor,y1xor,y2xor,y3xor,y4xor,y5xor,y6xor,y7xor;

	xor(y0xor,c0,y[0]);
	xor(y1xor,c0,y[1]);
	xor(y2xor,c0,y[2]);
	xor(y3xor,c0,y[3]);
	xor(y4xor,c0,y[4]);
	xor(y5xor,c0,y[5]);
	xor(y6xor,c0,y[6]);
	xor(y7xor,c0,y[7]);

	FullAdder fa0(x[0],y0xor,c0,s[0],c1);
	FullAdder fa1(x[1],y1xor,c1,s[1],c2);
	FullAdder fa2(x[2],y2xor,c2,s[2],c3);
	FullAdder fa3(x[3],y3xor,c3,s[3],c4);
	FullAdder fa4(x[4],y4xor,c4,s[4],c5);
	FullAdder fa5(x[5],y5xor,c5,s[5],c6);
	FullAdder fa6(x[6],y6xor,c6,s[6],c7);
	FullAdder fa7(x[7],y7xor,c7,s[7],c8);

	xor(e,c7,c8);
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
	reg [7:0] enter;
	reg [7:0] accumulator,x,y;	
	wire [7:0] s; 	//8-bit sum
	wire c7,c8,e; 
	reg c0;	//1 for subtraction, 0 for addition
	reg [7:0] addSub;
	AdderSubtractor addSubract(x,y,c0,s,c7,c8,e);
	
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
		$display("Enter + or -: ");
		addSub = $fgetc(STDIN);
		enter = $fgetc(STDIN);
		if(addSub == 43) c0 = 0;
		if(addSub == 45) c0 = 1;		
		#1;
		$display("x=%d  y=%d  c0=%d",x,y,c0);
		$display("Result= %d (%b) c7=%b  c8=%b  E=%b",s,s,c7,c8,e);
	end
endmodule 
