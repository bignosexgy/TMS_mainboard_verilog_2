
module adc_filter(
    input clk,
    input sys_rst_n,
    input [13:0] adc_data,	
    output reg [13:0] filtered_data	
);
 
parameter N = 14; // 数据位宽
parameter K = 20; // 滤波器阶数
 

reg  [13:0]  adc_max;
reg  [13:0]  adc_min;
reg  [31:0]  sum;			 
reg  [31:0]  sum_temp;
reg  [31:0]  sum_temp1;
reg  [31:0]  adc_data_temp [20];

reg [6:0]   cnt;
integer i;
integer j;

always @(posedge clk or negedge sys_rst_n) begin	
    if(!sys_rst_n) begin   
        filtered_data <= 13'd0;   
    end 
	else begin 	
        sum_temp1 <= sum_temp;
		if(sum_temp1 != sum_temp)
		    filtered_data <= sum_temp[13:0];    
    end       
end                                                                                                                                                                                                                                                                                
always @(posedge clk or negedge sys_rst_n) begin	
    if(!sys_rst_n) begin       
        sum <= 1'b0;       
		adc_min <= 14'd16383;
		adc_max <= 14'd0;
    end 
	else begin 	
        adc_data_temp[0] <= adc_data;   	
		for (i = 0;i < K-1;i=i+1) begin
            adc_data_temp[i+1] <= adc_data_temp[i];    
		end			
		sum <= adc_data_temp[0]+adc_data_temp[1]+adc_data_temp[2]+adc_data_temp[3]+adc_data_temp[4]+adc_data_temp[5]   
		      +adc_data_temp[6]+adc_data_temp[7]+adc_data_temp[8]+adc_data_temp[9]+adc_data_temp[10]+adc_data_temp[11]  
			  +adc_data_temp[12]+adc_data_temp[13]+adc_data_temp[14]+adc_data_temp[15]+adc_data_temp[16]+adc_data_temp[17]  
			  +adc_data_temp[18]+adc_data_temp[19];
		sum_temp <= sum/K;	   
/*	    
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
*/		
    end
end 
endmodule