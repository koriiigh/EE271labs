module fred_display (HEX0, HEX1, HEX2, HEX3, HEX4, HEX5, upc_code);


	input logic [2:0] upc_code;
	output logic [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5;
 
always_comb begin 

    case (upc_code) 
        3'b000: begin 
            // GOLD
            HEX5 = 7'b1000010; // G
            HEX4 = 7'b1000000; // O
            HEX3 = 7'b1000111; // L
            HEX2 = 7'b0100001; // D 
            // HEX1 & HEX0 blank
            HEX1 = 7'b1111111; 
            HEX0 = 7'b1111111; 
        end 
 
        3'b001: begin 
            HEX5 = 7'b1000110; // C 
            HEX4 = 7'b1000000; // O 
            HEX3 = 7'b0001110; // f
            HEX2 = 7'b0001110; // F
            HEX1 = 7'b0000110; // E
            HEX0 = 7'b0000110; //E
        end 
 
        3'b010: begin 
            HEX5 = 7'b0001110; //f
            HEX4 = 7'b1001111; // i
            HEX3 = 7'b0010010; // s
            HEX2 = 7'b0001001; //  h
            HEX1 = 7'b1111111; //  
            HEX0 = 7'b1111111; //  
        end
 
        3'b101: begin 
            HEX5 = 7'b1000111; // L
            HEX4 = 7'b0010010; // S
            HEX3 = 7'b0100001; // D
            HEX2 = 7'b1111111; 
            HEX1 = 7'b1111111; 
            HEX0 = 7'b1111111; 
        end 
 
        3'b110: begin 
            HEX5 = 7'b1001000; // n
            HEX4 = 7'b1000000; // 0
            HEX3 = 7'b1000000; //o
            HEX2 = 7'b0100001; //d
            HEX1 = 7'b1000111; //l
            HEX0 = 7'b0000110; //e
        end 
		  3'b111: begin 
            HEX5 = 7'b0100001; // d
            HEX4 = 7'b0101111; // r
            HEX3 = 7'b1000001; //u
            HEX2 = 7'b1000010; //g
            HEX1 = 7'b1111111; //
            HEX0 = 7'b1111111; //
			end
			default:  begin 
            HEX5 = 7'bx; 
            HEX4 = 7'bx; 
            HEX3 = 7'bx; 
            HEX2 = 7'bx; 
            HEX1 = 7'bx; 
            HEX0 = 7'bx;
        end 
    endcase 
end 
 
  

endmodule 