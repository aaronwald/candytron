
module top(input clk, output D1, output D2, output D3, output D4, output D5, output J3_10);
   
   reg ready = 0;
   reg [23:0]     divider;
   reg [3:0]      rot;
   reg 		  clock_test;
   reg [1:0] 	  clock_on;
   
   
   always @(posedge clk) begin
      if (ready) 
        begin
           if (divider == 12000000) 
             begin
                divider <= 0;
		clock_test <= 0;
		rot <= {rot[2:0], rot[3]};
             end
           else
	     begin
		divider <= divider + 1;
		clock_test <= clock_test + 1;
	     end
	
	   if (clock_test % 24)
	     begin
		if (clock_on)
		  clock_on <= 0;
		else
		  clock_on <= 1;
		
	     end
	   
	   
        end
      else 
        begin
           ready <= 1;
           rot <= 4'b0001;
           divider <= 0;
	   clock_on <= 1'b0;
	   clock_test <= 0;
        end
   end
   
   assign D1 = rot[0];
   assign D2 = rot[1];
   assign D3 = rot[2];
   assign D4 = rot[3];
   assign D5 = 1;
   assign J3_10 = clock_on;

//(divider < 12000000/2) ? 1 : 0;
    
   
endmodule // top
