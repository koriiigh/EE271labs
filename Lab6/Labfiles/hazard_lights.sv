module hazard_lights (clk, reset, wind, lights); 

	input logic clk; 

	input logic reset; 

	input logic [1:0] wind; 

	output logic [2:0] lights; 

	  

	enum {LR, M, R, L} ps, ns;  

	  

	always_ff @(posedge clk) begin  

		 if (reset)  

			  ps <= LR;  

		 else  

			  ps <= ns;  

	end   

	always_comb begin 


        case (ps) 

            LR: begin 

                case (wind) 

                    2'b00: ns = M;   

                    2'b01: ns = R;   

                    2'b10: ns = L;

                    default: ns = LR;  

                endcase 

            end 

  

            M: begin 

                case (wind) 

                    2'b00: ns = LR;  

                    2'b01: ns = L;   

                    2'b10: ns = R;  

                    default: ns = M; 

                endcase 

            end 

  

            R: begin 

                case (wind) 

                    2'b00: ns = LR;  

                    2'b01: ns = M;   

                    2'b10: ns = L;  

                    default: ns = R; 

                endcase 

            end 

  

            L: begin 

                case (wind) 

                    2'b00: ns = LR;  

                    2'b01: ns = R;  

                    2'b10: ns = M;   

                    default: ns = L; 

                endcase 

            end 

        endcase 

    end 

  


    always_comb begin 

        case (ps) 

            LR: lights = 3'b101; 

            M : lights = 3'b010;

            R : lights = 3'b001; 

            L : lights = 3'b100;

        endcase 

    end 

endmodule 
 