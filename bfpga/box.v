//https://excamera.com/sphinx/vhdl-clock.html
// clock on ping 21 is 12Mhz (12000000)


module top(input clk, output D1, output D2, output D3, output D4, output D5, output J3_10, output J3_11);
   wire       sysclk;							
   wire       locked;							
   pll myPLL (.clock_in(clk), .clock_out(sysclk), .locked(locked));	

   // from this pll we can get a bunch of clocks worked out. 
   // 27-bit counter: 100.5MHz / 2^27 ~ 0.749Hz 
   localparam SYS_CNTR_WIDTH = 27;
   
   reg [SYS_CNTR_WIDTH-1:0] syscounter;
   always @(posedge sysclk)
     syscounter <= syscounter + 1;				
 
   reg ready = 0;
   reg [23:0]     divider;
   reg [3:0]      rot;
   reg 		  clock_test;
   reg [1:0] 	  clock_on;

   reg [7:0]    slider = 8'b11001100;
   

   //assign J3_10 = syscounter[SYS_CNTR_WIDTH-1];
   assign J3_10 = syscounter[3]; // // 100.5MHz / 2^4 = 6.29MHz

   if (J3_10)
   begin
     J3_11 = slider[7];
     slider = {slider[6:0], slider[7]};
   end

   assign D5 = syscounter[SYS_CNTR_WIDTH-1]; // slowest
   assign D4 = syscounter[SYS_CNTR_WIDTH-2];
   assign D3 = syscounter[SYS_CNTR_WIDTH-3];
   assign D2 = syscounter[SYS_CNTR_WIDTH-2];
   assign D1 = syscounter[SYS_CNTR_WIDTH-3];
  
   
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
	
	   if (clock_test % 200)
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
   
//   assign D1 = rot[0];
//   assign D2 = rot[1];
//   assign D3 = rot[2];
//   assign D4 = rot[3];



//(divider < 12000000/2) ? 1 : 0;
    
   
endmodule // top
