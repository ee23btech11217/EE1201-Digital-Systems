module TBbooth;
    
    reg signed [7:0] a;
    reg signed [7:0] b;
    reg clk = 0;
    reg rst = 1;

    always #1 clk = !clk;

    wire signed [15:0] out;

    booth DUT (
        .clk(clk),
        .rst(rst),
        .x(a),
        .y(b),
        .s(out)
    );

    initial begin
        $dumpfile("booth.vcd");
        $dumpvars;

        #2;
        rst = 0;

        // Test for corner cases
        a =  3; b = -8; #20;
        $display("a = %d, b = %d, a*b = %d", a, b, out);

        a = 10; b = -8; #20;
        $display("a = %d, b = %d, a*b = %d", a, b, out);

        a = -1; b = -1; #20;
        $display("a = %d, b = %d, a*b = %d", a, b, out);

        a = 127; b = 127; #20;
        $display("a = %d, b = %d, a*b = %d", a, b, out);

        a = 127; b = -128; #100;
        $display("a = %d, b = %d, a*b = %d", a, b, out);

        $finish;
    end

endmodule // TBbooth
