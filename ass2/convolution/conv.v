module convolve(
    input  [3:0] x [0:7],
    input  [3:0] h [0:7],
    output reg [8:0] y [0:15]
);

integer i, j; 

always @(*) begin
    // clear y
    for (i = 0; i < 16; i = i + 1) begin
        y[i] = 0;
    end
    // convolve
    for (i = 0; i < 8; i = i + 1) begin
        for (j = 0; j < 8; j = j + 1) begin
            y[i+j] = y[i+j] + x[i] * h[j]; 
        end
    end
end
endmodule
