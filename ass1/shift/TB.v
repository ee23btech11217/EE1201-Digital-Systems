`timescale 1ns/1ns

module tbshiftreg;

    reg din;
    reg clk, res;
    wire [3:0] dout;

    // Instantiate the full adder 8-bit module
    shiftreg dut (
        .din(din),
        .clk(clk),
        .res(res),
        .dout(dout[3:0])
    );

    // Clock generation
    always #5 clk = ~clk;

    // Stimulus
    initial begin
        $dumpfile("full_adder_8bit_tb.vcd"); // Dump VCD file
        $dumpvars(0, tbshiftreg); // Dump variables

        // Reset
        res = 1;
        clk = 0;
        din = 0;
        #3;
        res = 0;
        din = 1;
        #8;

        din = 0; // Example input data
        #15;

        // More test data
        din = 1; // Example input data
        #6;

        din = 0; // Example input data
        #10;

        // Add more test data as needed

        $finish; // End simulation
    end

endmodule
