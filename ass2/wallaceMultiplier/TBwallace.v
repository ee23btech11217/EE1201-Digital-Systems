`timescale 1ns / 1ps

module TBwallace;

    reg [3:0] x;
    reg [3:0] y;
    wire [7:0] result;

    // Instantiate DUT (Device Under Test)
    wallace dut (
        .x(x),
        .y(y),
        .result(result)
    );

    // Testbench stimulus
    initial begin

        $dumpfile("wallace.vcd");
        $dumpvars(0, TBwallace);
        
        // Test case 1: x = 5 (0101), y = 3 (0011)
        x = 4'b0101;
        y = 4'b0011;
        #20; // Wait for 20 time units

        // Test case 2: x = 7 (0111), y = 6 (0110)
        x = 4'b0111;
        y = 4'b0110;
        #20;

        // Test case 3: x = 9 (1001), y = 11 (1011)
        x = 4'b1001;
        y = 4'b1011;
        #20;

        // Test case 4: x = 0 (0000), y = 0 (0000)
        x = 4'b0000;
        y = 4'b0000;
        #20;

        // Test case 5: x = 15 (1111), y = 0 (0000)
        x = 4'b1111;
        y = 4'b0000;
        #20;

        // Test case 6: x = 0 (0000), y = 15 (1111)
        x = 4'b0000;
        y = 4'b1111;
        #20;

        $finish;
    end

endmodule
