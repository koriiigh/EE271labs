module FredHouseMarket (HEX0, HEX1, HEX2, HEX3, HEX4, HEX5, SW, LEDR); 

// Lab #3 signals 
	input logic [9:0] SW;
	logic stolen;
	logic discounted;
	output logic [9:0] LEDR;
	output logic [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5;
	 
 
	
	Nordstrom upc(.LEDR, .SW);
	 
	// Instantiate Fred's 6-digit display 
	fred_display display(.HEX0, .HEX1, .HEX2, .HEX3, .HEX4, .HEX5, .upc_code(SW[9:7]) 
	); 
  

endmodule 
module FredHouseMarket_testbench();
logic [9:0] SW; 
logic  [9:0] LEDR; 
logic  [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5; 
 
// DUT 
FredHouseMarket dut(.HEX0, .HEX1, .HEX2, .HEX3, .HEX4, .HEX5, .SW, .LEDR); 
 
integer i; 
initial begin 
	 
    for(i = 0; i < 16; i++) begin 

        SW[9:7] = i;
        SW[0]   = i[0];
        #10; 
    end
end 
  

endmodule