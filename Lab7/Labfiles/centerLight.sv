module centerLight (clk, reset, L, R, NL, NR, Midreset, lightOn);
	input logic clk, reset;
	// L is true when left key is pressed, R is true when the right key
	// is pressed, NL is true when the light on the left is on, and NR
	// is true when the light on the right is on.
	input logic L, R, NL, NR, Midreset;
	// when lightOn is true, the center light should be on.
	output logic lightOn;
	// Your code goes here!!
	enum{on, off} ps,ns;
	
	always_comb begin
			case(ps)
				on : if(~L & R | ~R & L)
					ns = off;
				 else
					ns = on;
				
				
				off: if (L & NR & ~R | R & NL & ~L)
						ns = on;
					 else
						ns = off;
				
			endcase
		end
		
		always_comb begin
			case(ps)
				on : lightOn = 1;
				
				
				off: lightOn = 0;
			endcase
		end
		
		always_ff @(posedge clk) begin  

		 if (reset | Midreset)  

			  ps <= on;  

		 else  

			  ps <= ns;  

	end


endmodule

module centerLight_testbench();
	logic L, R, NL, NR;
	logic clk, reset;
	logic lightOn;
	
	parameter CLOCK_PERIOD = 20;
	initial begin 
		 clk = 0; 
		 forever #(CLOCK_PERIOD/2) clk = ~clk; 
	end 
	
	centerLight dut(.clk, .reset, .L, .R, .NL, .NR, .lightOn);
	
	  initial begin 

    reset <= 1; L <= 0; R <= 0; NL <= 0; NR <= 0; 

    repeat(2) @(posedge clk); 

    reset <= 0; 

    repeat(2) @(posedge clk); 

    repeat(3) @(posedge clk); 

    L <= 1; 

    repeat(2) @(posedge clk); 

    L <= 1; 

    repeat(2) @(posedge clk); 

    L <= 1; NR <= 1; 

    repeat(2) @(posedge clk); 

    L <= 0; NR <= 0; 

    repeat(2) @(posedge clk); 

    R <= 1; 

    repeat(2) @(posedge clk); 

    R <= 0; 

    repeat(2) @(posedge clk); 

    reset <= 1; 

    @(posedge clk); 

    reset <= 0; 

    @(posedge clk); 

    $stop; 

  end 

endmodule 