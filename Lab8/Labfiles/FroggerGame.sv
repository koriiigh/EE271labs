module FroggerGame (clk, reset, moveUp, moveDown, moveLeft, moveRight, difficulty, RedPixels, GrnPixels, HEX0);	 
	 input  logic clk;
    input  logic reset;
    input  logic moveUp;
    input  logic moveDown;
    input  logic moveLeft;
    input  logic moveRight;
	 input  logic [1:0] difficulty;

    output logic [15:0][15:0] RedPixels;
    output logic [15:0][15:0] GrnPixels;
	 output logic [6:0] HEX0;
    logic [15:0] lane1, lane2, lane3, lane4;
    logic [15:0] lane5, lane6, lane7;
    logic [15:0] lane10, lane11, lane12, lane13, lane14, lane15_reg;

    CarController carGen(
        .clk     (clk),
        .reset   (reset),
		  .difficulty (difficulty),
        .lane1   (lane1),
        .lane2   (lane2),
        .lane3   (lane3),
        .lane4   (lane4),
        .lane5   (lane5),
        .lane6   (lane6),
        .lane7   (lane7),
        .lane10  (lane10),
        .lane11  (lane11),
        .lane12  (lane12),
        .lane13  (lane13),
        .lane14  (lane14),
        .lane15  (lane15_reg)
    );
	 

    logic Midreset;
    logic frogAtBottom;
    VictoryCounter vmod (.clk , .reset, .frogAtBottom, .Midreset, .scoreSeg (HEX0));

    logic [3:0] frogRow, frogCol;

    always_ff @(posedge clk) begin
        if (reset) begin
            frogRow <= 4'd0;
            frogCol <= 4'd7;  
        end
        else if (Midreset) begin
            frogRow <= 4'd0;
            frogCol <= 4'd7;
        end
        else begin
            // Movement
            if (moveUp    && frogRow > 4'd0)   frogRow <= frogRow - 4'd1;
            if (moveDown  && frogRow < 4'd15)  frogRow <= frogRow + 4'd1;
            if (moveLeft  && frogCol > 4'd0)   frogCol <= frogCol - 4'd1;
            if (moveRight && frogCol < 4'd15)  frogCol <= frogCol + 4'd1;

            // Collision Check
            case (frogRow)
                4'd1 :  if (lane1[frogCol])  begin frogRow<=4'd0; frogCol<=4'd7; end
                4'd2 :  if (lane2[frogCol])  begin frogRow<=4'd0; frogCol<=4'd7; end
                4'd3 :  if (lane3[frogCol])  begin frogRow<=4'd0; frogCol<=4'd7; end
                4'd4 :  if (lane4[frogCol])  begin frogRow<=4'd0; frogCol<=4'd7; end

                4'd5 :  if (lane5[frogCol])  begin frogRow<=4'd0; frogCol<=4'd7; end
                4'd6 :  if (lane6[frogCol])  begin frogRow<=4'd0; frogCol<=4'd7; end
                4'd7 :  if (lane7[frogCol])  begin frogRow<=4'd0; frogCol<=4'd7; end

                4'd10: if (lane10[frogCol]) begin frogRow<=4'd0; frogCol<=4'd7; end
                4'd11: if (lane11[frogCol]) begin frogRow<=4'd0; frogCol<=4'd7; end
                4'd12: if (lane12[frogCol]) begin frogRow<=4'd0; frogCol<=4'd7; end
                4'd13: if (lane13[frogCol]) begin frogRow<=4'd0; frogCol<=4'd7; end
                4'd14: if (lane14[frogCol]) begin frogRow<=4'd0; frogCol<=4'd7; end
                4'd15: if (lane15_reg[frogCol]) begin frogRow<=4'd0; frogCol<=4'd7; end
            endcase
        end
    end

    assign frogAtBottom = (frogRow == 4'd15);

    always_comb begin
        RedPixels = '0;
        GrnPixels = '0;

        RedPixels[1]  = lane1;
        RedPixels[2]  = lane2;
        RedPixels[3]  = lane3;
        RedPixels[4]  = lane4;

        RedPixels[5]  = lane5;
        RedPixels[6]  = lane6;
        RedPixels[7]  = lane7;

        RedPixels[10] = lane10;
        RedPixels[11] = lane11;
        RedPixels[12] = lane12;
        RedPixels[13] = lane13;
        RedPixels[14] = lane14;
        RedPixels[15] = lane15_reg;

        GrnPixels[frogRow][frogCol] = 1'b1;
    end

endmodule


module FroggerGame_testbench();
	   logic CLOCK_50;
      logic reset;
      logic moveUp;
      logic moveDown;
      logic moveLeft;
      logic moveRight;

     logic [15:0][15:0] RedPixels;
     logic [15:0][15:0] GrnPixels;
	  logic [6:0] HEX0;
	  
	  
	  FroggerGame dut(.clk(CLOCK_50), .reset, .moveUp, .moveDown, .moveLeft, .moveRight, .RedPixels, .GrnPixels, .HEX0);
	  
  parameter CLOCK_PERIOD = 20;
	initial begin 
		 CLOCK_50 = 0; 
		 forever #(CLOCK_PERIOD/2) CLOCK_50 = ~CLOCK_50; 
	end
	
	
	initial begin
    
    @(posedge CLOCK_50);
    reset = 1; 
//    LEDR9 = 0; LEDR1 = 0; L = 0; R = 0;
    repeat(4) @(posedge CLOCK_50);
    reset = 0;
    @(posedge CLOCK_50);
    moveUp = 0; moveDown = 0; moveLeft = 0; moveRight = 0;
    repeat(4) @(posedge CLOCK_50);

    moveUp = 0; moveDown =0 ; moveLeft = 1; moveRight = 0;
    @(posedge CLOCK_50);
	 moveUp = 0; moveDown =0 ; moveLeft = 1; moveRight = 0;
    @(posedge CLOCK_50);
	 moveUp = 0; moveDown = 0; moveLeft = 1; moveRight = 0;
    @(posedge CLOCK_50);
	 moveUp = 0; moveDown = 0; moveLeft = 0; moveRight = 1;
    @(posedge CLOCK_50);
	 moveUp = 0; moveDown = 0; moveLeft = 0; moveRight = 1;
    @(posedge CLOCK_50);
	 moveUp = 0; moveDown = 0; moveLeft = 0; moveRight = 1;
    @(posedge CLOCK_50);
	 repeat(4) @(posedge CLOCK_50);
	 moveUp = 0; moveDown = 0; moveLeft = 1; moveRight = 1;
    @(posedge CLOCK_50);
	 
	 repeat(4) @(posedge CLOCK_50);

    
    
    reset = 1;
    repeat(4) @(posedge CLOCK_50);
    reset = 0;
    repeat(4) @(posedge CLOCK_50);
    
    $stop;
  end
endmodule



