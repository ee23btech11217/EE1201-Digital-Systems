`timescale 1ns / 1ps

module tb_array_sum;

// Inputs and outputs
reg [79:0] num1; // Packed array to hold 10 8-bit numbers
reg [79:0] num2; // Packed array to hold 10 8-bit numbers
wire [15:0] sum; // Output sum
reg res;

// Clock signal
reg clk = 0; // Clock signal
always #25 clk = ~clk; // Toggle clock every 5 time units

// Internal variables
integer i; // Integer variable for loop indexing

// Instantiate the array_sum module
array_sum sum_module(
    .num1(num1),
    .num2(num2),
    .sum(sum),
    .clk(clk),
    .res(res)
    
);

// Initial block for testbench
initial begin
    // Open VCD file for dumping waveform
    $dumpfile("twoclock.vcd");
    $dumpvars(0, tb_array_sum);

    // First test case
    num1 = {8'b00000010, 8'b00000100, 8'b00000110, 8'b00001000, 8'b00001010, 8'b00001100, 8'b00001110, 8'b00010000, 8'b00010010, 8'b00010100};
    num2 = {8'b00000001, 8'b00000011, 8'b00000101, 8'b00000111, 8'b00001001, 8'b00001011, 8'b00001101, 8'b00001111, 8'b00010001, 8'b00010011};
    res=1;
    #1
    res=0;
    #130
    // Second test case
    num1 = {8'b00000101, 8'b00000100, 8'b00000011, 8'b00000010, 8'b00000001, 8'b00000001, 8'b00000010, 8'b00000011, 8'b00000100, 8'b00000101};
    num2 = {8'b00000001, 8'b00000010, 8'b00000011, 8'b00000100, 8'b00000101, 8'b00000110, 8'b00000111, 8'b00001000, 8'b00001001, 8'b00001010};
    
    #300
    $finish;
end

endmodule