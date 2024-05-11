module array_sum(
    input [79:0] num1,
    input [79:0] num2,
    output reg [15:0] sum,
    input clk,
    input res
);

integer i;

always @(res == 1)
sum <=0;

always @(negedge clk) begin
    sum = 16'b0; 
    
    for (i = 0; i < 10; i = i + 1) begin
        sum = sum + num1[i*8 +: 8] * num2[i*8 +: 8]; // Accumulate products
    end
end

endmodule
