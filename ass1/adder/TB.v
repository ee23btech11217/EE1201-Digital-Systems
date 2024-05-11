module full_adder_8bit_tb;

  reg [7:0] x, h;
  wire [7:0] sum;
  wire cout;

  full_adder_8bit dut (x, h, sum, cout);

  // Define dumpfile
  initial begin
    $dumpfile("waveform.vcd");
    $dumpvars(0, full_adder_8bit_tb);
  end

  // Test case 1
  initial begin
    $display("Test Case 1:");
    x = 8'b01010101;
    h = 8'b10101010;
    #10; // Wait for 10 time units
    $display("x = %b, h = %b, sum = %b, cout = %b", x, h, sum, cout);
    // Expected output: sum = 11111111, cout = 1
    if (sum !== 8'b11111111 || cout !== 0) $error("Test Case 1 failed!");
  end

  // Test case 2
  initial begin
    #20; // Wait for 20 time units before starting the next test case
    $display("Test Case 2:");
    x = 8'b11111111;
    h = 8'b00000001;
    #10; // Wait for 10 time units
    $display("x = %b, h = %b, sum = %b, cout = %b", x, h, sum, cout);
    // Expected output: sum = 00000000, cout = 1
    if (sum !== 8'b00000000 || cout !== 1) $error("Test Case 2 failed!");
  end

  // Stop simulation
  initial begin
    #50; // Wait for 100 time units before finishing simulation
    $finish;
  end

endmodule
