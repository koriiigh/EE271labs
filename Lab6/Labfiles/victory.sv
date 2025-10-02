module victory (winner, clk ,reset ,LEDR9, LEDR1, L, R);
	input logic L,R, LEDR9, LEDR1;
	input logic clk,reset;
	output logic [6:0] winner;
	enum{off, PL, PR} ps,ns;
	
	always_comb begin
		case(ps)
			off: if (LEDR9 & L & ~R)
				ns = PL;
				
				else if (LEDR1 & ~L & R)
					ns = PR;
				else
					ns = off;
					
			PL: ns = PL;
			PR: ns = PR;
		endcase
		if (ns==PR) winner=7'b1111001;
		else if(ns==PL) winner=7'b0100100;
		else winner = 7'b1111111;
		end
		always_ff @(posedge clk) begin  

		 if (reset)  

			  ps <= off;  

		 else  

			  ps <= ns;  

	end
endmodule 
