module User_Input(out, clk, reset, button);
	input logic button;
	logic button0, buttonF;
	input logic clk, reset;
	output logic out;
	enum{off, on} ps,ns;
	
		always_comb begin
			case(ps)
				on : if(buttonF)
					ns = on;
				 else
					ns = off;
				
				
				off: if (buttonF)
						ns = on;
					 else
						ns = off;
				
			endcase
		end
			
		always_ff @(posedge clk) begin  

		 if (reset)  

			  ps <= off;  

		 else  

			  ps <= ns;  

	end
	always_ff @(posedge clk) begin 
		if(reset) begin
			buttonF<=0;
			button0<=0;
		end else begin
			buttonF<=button0;
			button0<=button;
			end
		

	end
	assign out = (ps==on & ns==off); 
	
endmodule

module User_Input_testbench();
	logic button;
	logic CLOCK_50, reset;
	logic out;
	
	parameter CLOCK_PERIOD = 20;
	initial begin 
		 CLOCK_50 = 0; 
		 forever #(CLOCK_PERIOD/2) CLOCK_50 = ~CLOCK_50; 
	end 
	
	User_Input dut(.out, .clk(CLOCK_50), .reset, .button);
	
	
	initial begin
	 reset<=1;
	 button<=0;
	 repeat(3) @(posedge CLOCK_50); 
	 reset<=0;
	 button<=1;
	 repeat(4) @(posedge CLOCK_50); 
	 button<=0;
	 repeat(4) @(posedge CLOCK_50); 
	 button<=1;
	 repeat(4)@(posedge CLOCK_50); 
	 button<=1;
	 @(posedge CLOCK_50); 
	 reset<=1;
	 @(posedge CLOCK_50);
	 $stop;
	 end
	endmodule


	