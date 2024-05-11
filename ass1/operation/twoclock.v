module array_sum(
    input [79:0] num1,
    input [79:0] num2,
    output reg [15:0] sum,
    input clk,
    input res
);

integer i;
reg [15:0] products [9:0]; // Array to store products
reg [15:0] temp_sum;       // Intermediate sum register

always @(res == 1)
begin
sum <=0;
temp_sum <=0;
end


always @(negedge clk) begin
        for (i = 0; i < 10; i = i + 1) begin
            products[i] <= num1[i*8 +: 8] * num2[i*8 +: 8]; // Store products in array
        end
end

always @(negedge clk) begin
    sum <= temp_sum; // Assign temporary sum to the output sum on posedge of clock
    temp_sum <= products[0] + products[1] + products[2] + products[3] + products[4] + 
                products[5] + products[6] + products[7] + products[8] + products[9]; // Sum products on posedge of clock
end

endmodule
