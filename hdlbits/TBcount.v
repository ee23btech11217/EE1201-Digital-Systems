`timescale 1ns / 1ps

module ripple_tb;

    // Inputs
    reg clk;
    reg rst;

    // Outputs
    wire Q2;
    wire Q1;
    wire Q0;

    // Instantiate the ripple module
    ripple ripple_inst (
        .clk(clk),
        .rst(rst),
        .Q2(Q2),
        .Q1(Q1),
        .Q0(Q0)
    );

    // Clock generation
    always #5 clk = ~clk;

    // Initial values
    initial begin
        clk = 0;
        rst = 0;

        // Apply reset
        #10 rst = 1;

        // Release reset
        #10 rst = 0;

        // Run for 50 clock cycles
        #200 $finish;
    end

    // Display outputs
    always @(posedge clk) begin
        $display("Q2=%b, Q1=%b, Q0=%b", Q0, Q1, Q2);
    end

endmodule
