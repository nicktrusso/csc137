//
//Decoder 2x4
//Nick Trusso 9/17/2015 
//
module decoder2x4(s0,s1,o0,o1,o2,o3);
  input s0, s1;
  output o0,o1,o2,o3;
  
  wire s1_inv, s0_inv;
  
  not(s1_inv,s1);
  not(s0_inv,s0);
  and(o0,s1_inv,s0_inv);
  and(o1,s1_inv,s0);
  and(o2,s1,s0_inv);
  and(o3,s1,s0);
endmodule


module main;
    //variables
    reg s0, s1;
    wire o0,o1,o2,o3;
    
    //create instance
    decoder2x4 decoder(s0,s1,o0,o1,o2,o3);
    
    initial begin
        $display("Time\ts1\ts0\to0\to1\to2\to3");
        $display("--------------------------------------------------------");
        $monitor("%0d\t%b\t%b\t%b\t%b\t%b\t%b",$time,s1,s0,o0,o1,o2,o3);
    end
    
    initial begin
        //assign variables
        s0 = 0; s1 = 0;
        #1
        s0 = 1; s1 = 0;
        #1
        s0 = 0; s1 = 1;
        #1
        s0 = 1; s1 = 1;
    end
endmodule
