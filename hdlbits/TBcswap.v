module tb_FA;

    // Parameters
    parameter CLK_PERIOD = 10; // Clock period in simulation steps
    
    // Signals
    reg clk = 0;
    reg a, b, cin;
    wire sum, cout;
    
    // Instantiate the unit under test (UUT)
    FA dut (
        .cin(cin),
        .clk(clk),
        .a(a),
        .b(b),
        .sum(sum),
        .cout(cout)
    );

    // Clock generation
    always #((CLK_PERIOD / 2)) clk = ~clk;

    // Test stimulus
    initial begin
        $dumpfile("FA.vcd");
        $dumpvars(0, tb_FA);        
        // Test case 1: a=0, b=0, cin=0
        a = 0; b = 0; cin = 0;
        #20;
        
        // Test case 2: a=1, b=0, cin=0
        a = 1; b = 0; cin = 0;
        #20;
        
        // Test case 3: a=0, b=1, cin=0
        a = 0; b = 1; cin = 0;
        #20;
        
        // Test case 4: a=1, b=1, cin=0
        a = 1; b = 1; cin = 0;
        #20;
        
        // Test case 5: a=0, b=0, cin=1
        a = 0; b = 0; cin = 1;
        #20;
        
        // Test case 6: a=1, b=0, cin=1
        a = 1; b = 0; cin = 1;
        #20;
        
        // Test case 7: a=0, b=1, cin=1
        a = 0; b = 1; cin = 1;
        #20;
        
        // Test case 8: a=1, b=1, cin=1
        a = 1; b = 1; cin = 1;
        #20;
        
        $finish; // Stop simulation
    end

endmodule
