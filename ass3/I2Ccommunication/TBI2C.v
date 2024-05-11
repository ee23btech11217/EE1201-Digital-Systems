
// module i2c_test;
    
//     reg signed [8-1:0] a;
//     reg signed [8-1:0] b;
//     reg clk = 0;
//     reg slave_scl = 0;
//     reg slave_sda = 0;
//     reg rst = 1;
//     wire master_bus_ctrl;

//     reg[2:0] slave_addr = 3'b101;
//     reg[4:0] slave_data = 5'd2;

//     wire m_sda;
//     wire m_scl;
//     wire[4:0] received_data[8];

//     always #1 clk = !clk;
//     always #2 slave_scl = !slave_scl;

//     wire signed [2*8-1:0] out;

//     wire slave_sda_out[8];
//     wire sda_line = slave_sda
//                 | slave_sda_out[0] | slave_sda_out[1] | slave_sda_out[2]
//                 | slave_sda_out[3] | slave_sda_out[4] | slave_sda_out[5] 
//                 | slave_sda_out[6] | slave_sda_out[7];

//     I2C_IO i2c_interface(.clk(clk), .rst(rst), .in_sda(sda_line), .in_scl(slave_scl), .slave_addr(slave_addr), .slave_data(slave_data), .out_sda(m_sda), .out_scl(m_scl));
//     I2C_Slave #(0) i2c_slave0(.clk(clk), .rst(rst), .in_sda(m_sda), .in_scl(m_scl), .received_data(received_data[0]), .out_sda(slave_sda_out[0]) ); 
//     I2C_Slave #(1) i2c_slave1(.clk(clk), .rst(rst), .in_sda(m_sda), .in_scl(m_scl), .received_data(received_data[1]), .out_sda(slave_sda_out[1]) ); 
//     I2C_Slave #(2) i2c_slave2(.clk(clk), .rst(rst), .in_sda(m_sda), .in_scl(m_scl), .received_data(received_data[2]), .out_sda(slave_sda_out[2]) ); 
//     I2C_Slave #(3) i2c_slave3(.clk(clk), .rst(rst), .in_sda(m_sda), .in_scl(m_scl), .received_data(received_data[3]), .out_sda(slave_sda_out[3]) ); 
//     I2C_Slave #(4) i2c_slave4(.clk(clk), .rst(rst), .in_sda(m_sda), .in_scl(m_scl), .received_data(received_data[4]), .out_sda(slave_sda_out[4]) ); 
//     I2C_Slave #(5) i2c_slave5(.clk(clk), .rst(rst), .in_sda(m_sda), .in_scl(m_scl), .received_data(received_data[5]), .out_sda(slave_sda_out[5]) ); 
//     I2C_Slave #(6) i2c_slave6(.clk(clk), .rst(rst), .in_sda(m_sda), .in_scl(m_scl), .received_data(received_data[6]), .out_sda(slave_sda_out[6]) ); 
//     I2C_Slave #(7) i2c_slave7(.clk(clk), .rst(rst), .in_sda(m_sda), .in_scl(m_scl), .received_data(received_data[7]), .out_sda(slave_sda_out[7]) ); 

//     integer seed;
//     initial begin
//         $dumpfile("i2c.vcd");
//         $dumpvars;

//         $monitor("\treceived data slave[0] = %d\n\treceived data slave[1] = %d\n\treceived data slave[2] = %d\n\treceived data slave[3] = %d\n\treceived data slave[4] = %d\n\treceived data slave[5] = %d\n\treceived data slave[6] = %d\n\treceived data slave[7] = %d\n", 
//         received_data[0], received_data[1], received_data[2], received_data[3], received_data[4], received_data[5], received_data[6], received_data[7]);

//         $display("Resetting all devices");
//         #2;
//         rst = 0;

//         $display("Dividing SCL clock Frequency");
//         $display("Sending %d to slave[%d]", slave_data, slave_addr);
//         // send the sequence 001[1(110]1)[1110] 
//         // (the sequence inside the parenthesis is start sequence
//         // and the one inside square brackets is the frequency divide sequence
//         #2; // slave_scl = high, read sda = 0
//         #1;
//         slave_sda = 0;
//         #1;
//         #2; // slave_scl = high, read sda = 0
//         #1;
//         slave_sda = 1;
//         #1;
//         #2; // slave_scl = high, read sda = 1
//         #1;
//         slave_sda = 1;
//         #1;
//         #2; // slave_scl = high, read sda = 1
//         #1;
//         slave_sda = 1;
//         #1;
//         #2; // slave_scl = high, read sda = 1
//         #1;
//         slave_sda = 1;
//         #1;
//         #2; // slave_scl = high, read sda = 1
//         #1;
//         slave_sda = 0;
//         #1;
//         #2; // slave_scl = high, read sda = 0
//         #1;
//         slave_sda = 1;
//         #1;
//         #2; // slave_scl = high, read sda = 1
//         #1;
//         slave_sda = 1;
//         #1;
//         #2; // slave_scl = high, read sda = 1
//         #1;
//         slave_sda = 1;
//         #1;
//         #2; // slave_scl = high, read sda = 1
//         #1;
//         slave_sda = 1;
//         #1;
//         #2; // slave_scl = high, read sda = 1
//         #1;
//         slave_sda = 0;
//         #1;
//         #2; // slave_scl = high, read sda = 0
//         #1;

//         #80;
//         slave_addr = 3'b000;
//         slave_data = 5'd3;
//         $display("Dividing SCL clock Frequency");
//         $display("Sending %d to slave[%d]", slave_data, slave_addr);
//         slave_sda = 1;
//         #1;
//         #2; // slave_scl = high, read sda = 1
//         #1;
//         slave_sda = 1;
//         #1;
//         #2; // slave_scl = high, read sda = 1
//         #1;
//         slave_sda = 1;
//         #1;
//         #2; // slave_scl = high, read sda = 1
//         #1;
//         slave_sda = 0;
//         #1;
//         #2; // slave_scl = high, read sda = 0
//         #1;
//         slave_sda = 1;
//         #1;
//         #2; // slave_scl = high, read sda = 1
//         #1;
//         slave_sda = 1;
//         #1;
//         #2; // slave_scl = high, read sda = 1
//         #1;
//         slave_sda = 0;
//         #1;
//         #2; // slave_scl = high, read sda = 0
//         #1;
//         slave_sda = 1;
//         #1;
//         #2; // slave_scl = high, read sda = 1
//         #1;
//         slave_sda = 0;

//         #200;
//         slave_addr = 3'b010;
//         slave_data = 5'd5;
//         $display("Sending %d to slave[%d]", slave_data, slave_addr);
//         slave_sda = 1;
//         #1;
//         #2; // slave_scl = high, read sda = 1
//         #1;
//         slave_sda = 1;
//         #1;
//         #2; // slave_scl = high, read sda = 1
//         #1;
//         slave_sda = 0;
//         #1;
//         #2; // slave_scl = high, read sda = 0
//         #1;
//         slave_sda = 1;
//         #1;
//         #2; // slave_scl = high, read sda = 1
//         #1;
//         slave_sda = 0;

//         #300;
//         slave_addr = 3'b001;
//         slave_data = 5'd7;
//         $display("Sending %d to slave[%d]", slave_data, slave_addr);
//         slave_sda = 1;
//         #1;
//         #2; // slave_scl = high, read sda = 1
//         #1;
//         slave_sda = 1;
//         #1;
//         #2; // slave_scl = high, read sda = 1
//         #1;
//         slave_sda = 0;
//         #1;
//         #2; // slave_scl = high, read sda = 0
//         #1;
//         slave_sda = 1;
//         #1;
//         #2; // slave_scl = high, read sda = 1
//         #1;
//         slave_sda = 0;

//         #300;
//         slave_addr = 3'b110;
//         slave_data = 5'd11;
//         $display("Sending %d to slave[%d]", slave_data, slave_addr);
//         slave_sda = 1;
//         #1;
//         #2; // slave_scl = high, read sda = 1
//         #1;
//         slave_sda = 1;
//         #1;
//         #2; // slave_scl = high, read sda = 1
//         #1;
//         slave_sda = 0;
//         #1;
//         #2; // slave_scl = high, read sda = 0
//         #1;
//         slave_sda = 1;
//         #1;
//         #2; // slave_scl = high, read sda = 1
//         #1;
//         slave_sda = 0;

//         #300;
//         slave_addr = 3'b111;
//         slave_data = 5'd13;
//         $display("Sending %d to slave[%d]", slave_data, slave_addr);
//         slave_sda = 1;
//         #1;
//         #2; // slave_scl = high, read sda = 1
//         #1;
//         slave_sda = 1;
//         #1;
//         #2; // slave_scl = high, read sda = 1
//         #1;
//         slave_sda = 0;
//         #1;
//         #2; // slave_scl = high, read sda = 0
//         #1;
//         slave_sda = 1;
//         #1;
//         #2; // slave_scl = high, read sda = 1
//         #1;
//         slave_sda = 0;

//         #300;
//         slave_addr = 3'b100;
//         slave_data = 5'd17;
//         $display("Sending %d to slave[%d]", slave_data, slave_addr);
//         slave_sda = 1;
//         #1;
//         #2; // slave_scl = high, read sda = 1
//         #1;
//         slave_sda = 1;
//         #1;
//         #2; // slave_scl = high, read sda = 1
//         #1;
//         slave_sda = 0;
//         #1;
//         #2; // slave_scl = high, read sda = 0
//         #1;
//         slave_sda = 1;
//         #1;
//         #2; // slave_scl = high, read sda = 1
//         #1;
//         slave_sda = 0;

//         #300;
//         slave_addr = 3'b011;
//         slave_data = 5'd31;
//         $display("Sending %d to slave[%d]", slave_data, slave_addr);
//         slave_sda = 1;
//         #1;
//         #2; // slave_scl = high, read sda = 1
//         #1;
//         slave_sda = 1;
//         #1;
//         #2; // slave_scl = high, read sda = 1
//         #1;
//         slave_sda = 0;
//         #1;
//         #2; // slave_scl = high, read sda = 0
//         #1;
//         slave_sda = 1;
//         #1;
//         #2; // slave_scl = high, read sda = 1
//         #1;
//         slave_sda = 0;

//         #25600;

//         $finish;
//     end

// endmodule // booth_test
