
// module I2C_Slave #( parameter address = 3'b0 ) 
// (
//     input wire clk, input wire rst, 
//     input wire in_sda, input wire in_scl, 
//     output reg out_sda, 
//     output reg[4:0] received_data
// );

//     reg isListening = 0;
//     reg sendingACKbit = 0;
//     reg[3:0] data_mode = 0;
//     reg[2:0] received_slave_addr = 0;
//     reg[4:0] read_data;
//     reg[2:0] receiver_addr;

//     reg sampled_scl = 1;
//     reg sampled_sda = 1;

//     always @ (posedge clk) begin
        
//         sampled_sda <= in_sda;
//         sampled_scl <= in_scl;

//         if(rst) begin
//             sampled_scl <= 1;
//             sampled_sda <= 1;
//             isListening <= 0;
//             received_slave_addr <= 0;
//             data_mode <= 0;
//             out_sda <= 0;
//             sendingACKbit <= 0;
//             read_data <= 0;
//             received_data <= 0;
//             receiver_addr <= 0;
//         end
//         // if SDA changes while SCL is high
//         // toggle isListening(start/stop sequence for data transfer) 
//         else if((in_sda != sampled_sda) && in_scl) begin
//             isListening <= ~isListening;
//             received_slave_addr <= 0;
//             data_mode <= 0;
//             sendingACKbit <= 0;
//             read_data <= 0;
//             if(isListening && (receiver_addr == address)) received_data <= read_data;
//         end
//         // send Address ACK bit, if this the slave device
//         else if(data_mode == 4'd3 && !in_scl) begin
//             if(received_slave_addr == address) begin
//                 out_sda <= 1;
//                 sendingACKbit <= 1;
//             end
//             receiver_addr <= received_slave_addr;
//         end
//         else if(data_mode == 4'd4 && !in_scl) begin
//             out_sda <= 0;
//             sendingACKbit <= 0;
//             data_mode <= data_mode + 1;
//         end
//         // send Data ACK bit, if this the slave device
//         else if(data_mode == 4'd10 && !in_scl && (receiver_addr == address)) begin
//             out_sda <= 1;
//             sendingACKbit <= 1;
//         end
//         else if(data_mode == 4'd11 && !in_scl) begin
//             out_sda <= 0;
//             sendingACKbit <= 0;
//         end
//     end

//     always @ (posedge in_scl) begin
//         // if data is being transmitted on the line
//         // then read the data and store every clock edge
//         if(isListening) begin
//             if(data_mode < 4'd4) begin
//                 received_slave_addr <= {received_slave_addr[1:0], in_sda};
//             end
//             if(data_mode > 4'd4 && data_mode < 4'd10) begin
//                 read_data <= {read_data[3:0], in_sda};
//             end
//             data_mode <= data_mode + 1;
//         end
//     end

// endmodule


