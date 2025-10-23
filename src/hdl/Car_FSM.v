`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 16.09.2025 22:11:32
// Design Name: 
// Module Name: Car_FSM
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

//module declaration with required inputs and outputs

module Car_FSM(
    input left, right, clk, rst,
    output reg [2:0] left_lights, right_lights
);
reg div_clk; //div_clk will be used to covert the inbuilt clock frequency to required frequency
reg [0:25] delay;
reg [0:2] curr_state, next_state;
//states declaration. In total 7 states are being used
parameter s0 =3'b000, s1 =3'b001, s2 =3'b010, s3 =3'b011, s4 = 3'b100, s5 = 3'b101, s6 = 3'b110;

//frequency divider to reduce inbuilt frequency (100 MHz) into required frequency
always @(posedge clk, posedge rst) begin
    if(rst) begin
        delay <= 0;
        div_clk <= 1'b0;
    end
    else if (delay == 26'd25_000_000 - 1) begin  // this will gives us 2Hz frequency. 
        delay <= 0;
        div_clk <= ~div_clk;   
    end
    else    
        delay <= delay + 1;    
end    

// this is to assign curr_state value using next_state
always @(posedge div_clk, posedge rst) begin
    if(rst)
        curr_state <= s0;
    else
        curr_state <= next_state;
end

always @(*) begin
    //to determine what the next state should be based on current state value
    case(curr_state)
        s0: begin           //this is the base node
            if (left == 1 && right == 0) begin
                next_state <= s1;          
            end   
            else if(left == 0 && right == 1) begin
                next_state <= s4; 
            end
            else 
                next_state <= s0;
        end
        s1: begin 
            if (left == 1 && right == 0) begin
                next_state <= s2;          
            end   
            else 
                next_state <= s0;
        end           
        s2: begin 
            if (left == 1 && right == 0) begin
                next_state <= s3;          
            end   
            else 
                next_state <= s0;
        end    
        s3: next_state <= s0; 		
        s4: begin 
            if (left == 0 && right == 1) begin
                next_state <= s5;          
            end   
            else 
                next_state <= s0;
            end
        s5: begin 
            if (left == 0 && right == 1) begin
                next_state <= s6;          
            end   
            else 
                next_state <= s0;
            end   
        s6: next_state <= s0;        	
    endcase
end   

always @(*) begin
    //telling which lights to be turned on based on current state
    case(curr_state)
        s0: begin
            left_lights <= 3'b000;
            right_lights <= 3'b000;
        end
        s1: begin
            left_lights <= 3'b001;
            right_lights <= 3'b000;     
        end
        s2: begin
            left_lights <= 3'b011;
            right_lights <= 3'b000;
        end
        s3: begin
            left_lights <= 3'b111;
            right_lights <= 3'b000;       
        end
        s4: begin
            left_lights <= 3'b000;
            right_lights <= 3'b100;       
        end
        s5: begin
            left_lights <= 3'b000;
            right_lights <= 3'b110;       
        end
        s6: begin
            left_lights <= 3'b000;
            right_lights <= 3'b111;       
        end
    endcase
end
endmodule
