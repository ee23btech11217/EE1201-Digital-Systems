module convolve_tb;

    // Define constants for easier readability
    localparam INTEGER_BITS = 4; // Number of bits in the inputs
    localparam FRAC_BITS = 0;     // No fractional bits assumed for simplicity

    // Inputs
    reg [3:0] x [0:7];
    reg [3:0] h [0:7];
    
    // Output
    wire [8:0] y [0:15];

    // Instantiate the convolve module
    convolve dut (
        .x(x),
        .h(h),
        .y(y)
    );

    // Define integer i outside the initial block
    integer i;

    // Stimulus
    initial begin
        // Initialize inputs
        
        $display("Input x:");
        for (i = 0; i < 8; i = i + 1) begin
            x[i] = $urandom_range(16);
            $display("x[%0d] = %d", i, x[i]);
        end

        $display("Input h:");
        for (i = 0; i < 8; i = i + 1) begin
            h[i] = $urandom_range(16);
            $display("h[%0d] = %d", i, h[i]);
        end

        // Wait for some time to observe the output
        #10;

        // Display output
        $display("Output y:");
        for (i = 0; i < 16; i = i + 1)
            $display("y[%0d] = %d", i, y[i]);

        // End simulation
        $finish;
    end

endmodule
