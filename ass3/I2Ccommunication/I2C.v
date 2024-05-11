
// module scl_clk(input wire clk, input wire rst, input wire[3:0] fdiv, input wire enable, output wire scl_clk, output wire scl_double);

//     reg[15:0] fdiv_clk = 0;
//     reg sampled_enable = 0;
//     wire[16:0] clks = { fdiv_clk[15:0], clk ^ sampled_enable };

//     always @ (posedge clk) begin : SCL_CLK
//         if (rst) begin
//             fdiv_clk <= 0;  
//             sampled_enable <= 0;
//         end
//         else if (enable && !sampled_enable) begin
//             fdiv_clk <= 0;
//             sampled_enable <= enable;
//         end
//         else begin
//             fdiv_clk <= fdiv_clk + 1; 
//             sampled_enable <= enable; 
//         end
//     end

//     assign scl_double = clks[fdiv];
//     assign scl_clk = (fdiv_clk[fdiv]) | !sampled_enable;

// endmodule

// module I2C_stseq_detect(input wire clk, input wire rst, input wire in_sda, input wire in_scl, output reg isBeginSequence);

//     reg[2:0] state = 0;

//     always @ (posedge clk) begin : START_SEQ_DET
//         if (rst) begin
//             state <= 0;
//             //isBeginSequence <= 1'b0;
//         end
//         else if(in_scl) begin
//             case(state)
//                 0: begin
//                     isBeginSequence <= 1'b0;
//                     if(in_sda == 1'b1) state <= 1;
//                 end
//                 1: begin
//                     if(in_sda == 1'b1) state <= 2;
//                     else state <= 0;
//                 end
//                 2: begin
//                     if(in_sda == 1'b0) state <= 3;
//                     else state <= 2;
//                 end
//                 3: begin
//                     if(in_sda == 1'b1) begin
//                         state <= 0;
//                         isBeginSequence <= 1'b1;
//                     end
//                     else state <= 0;
//                 end
//             endcase
//         end
//     end

// endmodule

// module I2C_clkseq_detect(input wire clk, input wire rst, input wire in_sda, input wire in_scl, output reg isEndSequence);

//     reg[2:0] state = 0;

//     always @ (posedge clk) begin : END_SEQ_DET
//         if (rst) begin
//             state <= 0;
//             //isEndSequence <= 1'b0;
//         end
//         else if(in_scl) begin
//             case(state)
//                 0: begin
//                     isEndSequence <= 1'b0;
//                     if(in_sda == 1'b1) state <= 1;
//                 end
//                 1: begin
//                     if(in_sda == 1'b1) state <= 2;
//                     else state <= 0;
//                 end
//                 2: begin
//                     if(in_sda == 1'b1) state <= 3;
//                     else state <= 0;
//                 end
//                 3: begin
//                     if(in_sda == 1'b0) begin
//                         state <= 0;
//                         isEndSequence <= 1'b1;
//                     end
//                 end
//             endcase
//         end
//     end

// endmodule

// // in_sda, in_scl, value read on the SDA line and SCL line
// // out_sda, out_scl, value to send on SDA and SCL lines
// // slave_addr: address of slave
// // slave_data: data to send slave at address slave_addr
// // sda_ctrl: enable writing to SDA line
// // scl_ctrl: enable writing to SCL line

module I2C_IO(
    input wire clk, input wire rst,
    input wire in_sda, input wire in_scl, 
    input wire[2:0] slave_addr, input wire[4:0] slave_data, 
    output reg out_sda, output wire out_scl, 
    output wire sda_ctrl, output wire scl_ctrl
);

    wire io_clk;

    reg[3:0] scl_freq = 0;
    reg isBusClaimed = 0;
    reg pullClkLow = 0;
    wire isRequestingData;
    wire shouldDivideFrequency;

    reg[2:0] dataState = 0;
    reg addr_ack = 0;
    reg read_ack = 0;
    reg getACKbit = 0;
    reg isDataTranfered = 0;

    // packet to transfer
    // low 3 bits is the slave address
    // high 5 bits is the data 
    reg[7:0] i2c_packet = 0;

    // clock for sending data
    wire scl_clk;

    // this makes sure SCL is pulled low after
    // SDA is pulled low
    // for the transmission start
    assign out_scl = scl_clk | !pullClkLow;

    assign scl_ctrl = (pullClkLow | isBusClaimed);
    assign sda_ctrl = (pullClkLow | isBusClaimed) & !getACKbit;

    // the io_clk clock is twice the scl_clk(Master SCL) clock
    // scl_clk only if the bus is claimed
    scl_clk scl_clk0(.clk(clk), .rst(rst), .fdiv(scl_freq), .enable(isBusClaimed), .scl_clk(scl_clk), .scl_double(io_clk));

    // when state is default, wait till seeing the sequence 1101
    // then pull SDA low before pulling SCL low
    I2C_stseq_detect i2c_stseq(.clk(clk), .rst(rst), .in_sda(in_sda), .in_scl(in_scl), .isBeginSequence(isRequestingData));

    // when in default state, if sequence 1110 is detected,
    // then increase frequency
    I2C_clkseq_detect i2c_clkseq(.clk(clk), .rst(rst), .in_sda(in_sda), .in_scl(in_scl), .isEndSequence(shouldDivideFrequency));

    // Manages reset, frequency divide, bus claiming and releasing
    always @ (posedge clk) begin : I2C_BUS_IDLE
        if(rst) begin
            // reset all state variables
            scl_freq <= 0;
            isBusClaimed <= 0;
            out_sda <= 1;
            dataState <= 0;
            addr_ack <= 0;
            read_ack <= 1;
            isDataTranfered <= 0;
            i2c_packet <= 0;
        end
        else if(isRequestingData && !isBusClaimed) begin
            // if a slave is requesting data(done by sending 1101 on sda)
            // then claim the bus, pull SDA to low and reset data transfer states
            isBusClaimed <= 1;
            dataState <= 0;
            out_sda <= 0;
            addr_ack <= 0;
            read_ack <= 1;
            isDataTranfered <= 0;
            // load the i2c_packet to transfer
            i2c_packet <= {slave_data[0], slave_data[1], slave_data[2], slave_data[3], slave_data[4], slave_addr[0], slave_addr[1], slave_addr[2]};
        end
        else if(scl_clk && !isBusClaimed) begin
            out_sda <= 1;
            pullClkLow <= 0;
        end

        // if it is not in between any transaction
        // then divide frequency by 2.
        if(shouldDivideFrequency && in_scl && !scl_ctrl) begin
            scl_freq <= scl_freq + 1;
        end
    end

    // Manages packet transfer and ACK bits
    always @ (posedge io_clk) begin : I2C_MAIN_BLK
        if(isBusClaimed) begin
            // Send the data after bus has been claimed.
            // after sending the slave address
            // wait one out_scl(master SCL) cycle to check the ACK bit.
            // then continue sending data
            if(getACKbit && !read_ack) begin
                if(scl_clk) begin
                    addr_ack <= in_sda;
                    read_ack <= 1'b1;
                end
            end
            else begin
                // pull the out_scl clock low
                pullClkLow <= 1'b1;

                // update between consecutive scl_clk pulses
                // only if bus is claimed by master
                if(!(scl_clk | !isBusClaimed) && !isDataTranfered) begin
                    out_sda <= i2c_packet[dataState];

                    // Wait for ACK bit before sending data bits
                    if((dataState != 3'b011 && dataState != 3'b000) || read_ack) begin
                        dataState <= dataState + 1;
                        read_ack = 1'b0;
                        getACKbit = 1'b0;
                    end
                    else if(dataState == 3'b000) begin
                        // since read_ack is 1 by default(set after rst/1101 seq)
                        // this else if is only reached if dataState went from 0-7 and then back to 0
                        // thus the data was put on the line.
                        isDataTranfered <= 1;
                        getACKbit = 1'b1;
                    end
                    else getACKbit = 1'b1;
                end
                // if data was transfered and ack was read from sda
                // then give up control of bus and start the stop sequence
                else if(!(scl_clk | !isBusClaimed) && isDataTranfered && read_ack) begin
                    isBusClaimed <= 0;
                    out_sda <= 0;
                    read_ack = 1'b0;
                    getACKbit = 1'b0;
                end
            end
        end
    end

endmodule