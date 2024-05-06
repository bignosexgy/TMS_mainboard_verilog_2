
module adc_filter(
    input sys_clk,
    input sys_rst_n,
    input [13:0] adc_data,	
    output reg [13:0] filtered_data	
);
 
parameter N = 14; // 数据位宽
parameter K = 5; // 滤波器阶数
 

reg  [13:0] adc_max;
reg  [13:0] adc_min;
reg  [31:0] sum;
reg  [31:0] sum_temp;
reg  [31:0] sum_temp1;

reg [6:0]   cnt;
integer i;

always @(posedge sys_clk or negedge sys_rst_n) begin	
    if(!sys_rst_n) begin   
        filtered_data <= 13'd0;   
    end 
	else begin 	
        sum_temp1 <= sum_temp;
		if(sum_temp1 != sum_temp)
		    filtered_data <= sum_temp[13:0];    
    end       
end                                                                                                                                                                                                                                                                                
always @(posedge sys_clk or negedge sys_rst_n) begin	if(!sys_rst_n) begin
       
        sum <= 1'b0;       
		adc_min <= 14'd16383;
		adc_max <= 14'd0;
    end 
	else begin 			
							
		if(cnt < K) begin
		    sum <= sum + adc_data;
		    cnt <= cnt + 1'b1;
		    if(adc_data >= adc_max )
		        adc_max <= adc_data;		    
		    if(adc_data <= adc_min )
		        adc_min <= adc_data;								
		end
		else begin
		    cnt <= 1'b0;		        
		    sum_temp <= (sum - adc_max - adc_min) / (K-2);
            sum <= 1'b0;	
		   	adc_min <= 14'd16383;
		    adc_max <= 14'd0;
		end		
    end
end 
endmodule