module adc_filter(
    input clk,
    input reset,
    input [N-1:0] adc_data,
    output reg [N-1:0] filtered_data
);
 
parameter N = 8; // 数据位宽
parameter K = 3; // 滤波器阶数
 
reg [N-1:0] delay_reg [K-1:0];
reg [N-1:0] sum;
integer i;
 
// 有限状态机
reg state;
 
always @(posedge clk) begin
    if (reset) begin
        state <= 1'b0;
        for (i = 0; i < K; i = i + 1)
            delay_reg[i] <= '0;
        sum <= '0;
        filtered_data <= '0;
    end else begin
        case (state)
            1'b0: begin // 第一阶段
                delay_reg[0] <= adc_data;
                sum <= delay_reg[0];
                for (i = 1; i < K; i = i + 1) begin
                    sum <= sum + delay_reg[i];
                end
                state <= 1'b1;
            end
            1'b1: begin // 第二阶段
                sum <= sum - delay_reg[0] + adc_data;
                for (i = 0; i < K - 1; i = i + 1) begin
                    delay_reg[i] <= delay_reg[i + 1];
                end
                delay_reg[K - 1] <= adc_data;
                filtered_data <= sum >> (N - (K - 1)); // 输出平均后的数据
                state <= 1'b0;
            end
            default: state <= 1'b0;
        endcase
    end
end
 
endmodule