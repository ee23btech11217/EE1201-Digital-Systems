`timescale 1ns/1ns

module top_module_tb;

    reg r0, r1, r2, L, clk;
    wire Q0, Q1, Q2;

    // Instantiate the top module
    top_module dut (
        .r0(r0),
        .r1(r1),
        .r2(r2),
        .L(L),
        .clk(clk),
        .Q0(Q0),
        .Q1(Q1),
        .Q2(Q2)
    );

    // Clock generation
    always #5 clk = ~clk;

    // Stimulus
    initial begin
        $dumpfile("top_module_tb.vcd"); // Dump VCD file
        $dumpvars(0, top_module_tb); // Dump variables

        // Initialize inputs
        r0 = 0;
        r1 = 1;
        r2 = 0;
        L = 0;
        clk = 0;
        
        // Apply some test values
        #10; // Wait for some time
        r0 = 1; // Change inputs
        L = 1;
        #10;
        r1 = 0;
        #10;
        L = 0;
        #10;

        // Add more test scenarios as needed

        $finish; // End simulation
    end

endmodule
