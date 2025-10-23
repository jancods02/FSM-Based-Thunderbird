`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 16.09.2025 22:12:45
// Design Name: 
// Module Name: Test_Car_FSM
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module Test_Car_FSM();

reg LEFT, RIGHT, Clk, Reset;            //input declaration
wire [2:0] left_lights, right_lights;   //output declaration

//Instantiation of FSM module
Car_FSM C0(LEFT, RIGHT, Clk, Reset, left_lights, right_lights);

initial Clk = 0;
always #5 Clk = ~Clk;   //this generates clock with time period 10ns

initial begin
Reset = 0;      //to set the machine at state 0
// Below this inputs are changed to see state changes

#2    Reset = 1;
#2    Reset = 0; LEFT = 0; RIGHT = 0;
#40   LEFT = 1; RIGHT = 0;
#100  RIGHT = 1;
#100  LEFT = 0; RIGHT = 1;
#100  LEFT = 0; RIGHT = 0;

#50 $finish;
end

endmodule
