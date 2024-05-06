//****************************************Copyright (c)***********************************//
//----------------------------------------------------------------------------------------
// File name:           Vadc_cap
// Last modified Date:  2024/4/10 
// Last Version:        V1.0
// Descriptions:        电容电压采样
//----------------------------------------------------------------------------------------
// Created by:          xgy
// Created date:        2024/4/10 
// Version:             V1.0
// Descriptions:        The original version
//
//----------------------------------------------------------------------------------------
//****************************************************************************************//

module adc_IGBT(
    input	            sys_clk,                   //系统时钟
    input               sys_rst_n,                 //系统复位，低电平有效

    input         signed  [13:0]  adc_data_cap_1,          //谐振电容1电压ADC值 
    input         signed  [13:0]  adc_data_cap_2,          //谐振电容2电压ADC值
	input         signed  [13:0]  adc_data_cap_3,          //支撑电容电压ADC值
	input                 [7:0]   Voltage_cap_set_1,       //脉冲功率，谐振电容1设置电压 
	input                 [7:0]   Voltage_cap_set_2,       //脉冲功率，谐振电容2设置电压 
	input                 [7:0]   Voltage_cap_set_3,       //脉冲功率，支撑电容电容设置电压 				          
	input         [13:0]  filtered_data_out1,      //数字滤波器数据输入
	input         [13:0]  filtered_data_out2,      //数字滤波器数据输入
	output  reg   signed  [31:0]  adc_value_cap_1,	      //谐振电容1电压值mv   
	output  reg   signed  [31:0]  adc_value_cap_2,	      //谐振电容2电压值mv
	output  reg           [31:0]  adc_value_cap_3,	      //支撑电容电压值mv
	output  reg           [2:0]   Voltage_cap_flag,         //电容电压达到设定值标志位
	output  wire  signed  [31:0]  Voltage_cap_set_1_temp,	      //支撑电容电压值mv
    output  wire  signed  [31:0]  Voltage_cap_set_2_temp,	      //支撑电容电压值mv	
	output  wire  signed  [31:0]  Voltage_cap_set_temp_1,
	output  wire  signed  [31:0]  Voltage_cap_set_temp_2,
	output  reg   [13:0]  filter_data_in1,             //传给数字滤波器数据  
	output  reg   [13:0]  filter_data_in2,            //传给数字滤波器数据
	//output  reg           [3:0]     adc_voltage_over_1_cnt,
	//output  reg           [3:0]     adc_voltage_over_2_cnt,
	//output  wire  [3:0]  adc_voltage_over_1_cnt_temp,
	//output  wire  [3:0]  adc_voltage_over_2_cnt_temp,
	output  reg                   test2, 
	output  reg                   test3,
	output  reg                   test4,
	output  reg                   test5,
    output  reg                   test1
	
);

reg           [15:0]    adc_updata_cnt;
reg                     adc_uart_send_flag;
reg           [3:0]     adc_voltage_over_1_cnt;
reg           [3:0]     adc_voltage_over_2_cnt;
         

reg  [13:0]  adc_value_cap_1_temp;
reg  [13:0]  adc_value_cap_2_temp;
reg  [13:0]  adc_data_cap_1_temp;
reg  [13:0]  adc_data_cap_2_temp;

reg  [13:0] a;
reg  signed [7:0] data1;
reg  signed [7:0] data2;


//wire  [31:0]     adc_value_cap_temp5; 	      //支撑电容电压值mv
//wire  [31:0]     adc_value_cap_temp6; 	      //支撑电容电压值mv
wire  signed   [31:0]    adc_value_cap_temp3; 	      //支撑电容电压值mv
wire  signed   [31:0]    adc_value_cap_temp4; 	      //支撑电容电压值mv
wire  signed   [31:0]    adc_value_cap_temp5; 	      //支撑电容电压值mv
wire  signed   [31:0]    adc_value_cap_temp6; 	      //支撑电容电压值mv
//wire  signed  [31:0]     Voltage_cap_set_1_temp;
//wire  signed  [31:0]     Voltage_cap_set_2_temp;

wire  [3:0]  adc_voltage_over_1_cnt_temp;
wire  [3:0]  adc_voltage_over_2_cnt_temp;

//wire  integer       adc_value_cap_temp3; 	      //支撑电容电压值mv
//wire  integer       adc_value_cap_temp4; 	      //支撑电容电压值mv
//wire  integer       adc_value_cap_temp5; 	      //支撑电容电压值mv
//wire  integer       adc_value_cap_temp6; 	      //支撑电容电压值mv

//wire  integer   Voltage_cap_set_temp_1;
//wire  integer   Voltage_cap_set_temp_2;
//wire  [31:0] Voltage_cap_set_temp_1;
//wire  [31:0] Voltage_cap_set_temp_2;
//assign adc_value_cap_temp1 = adc_data_cap_1;
//assign adc_value_cap_temp2 = adc_data_cap_2;
//assign test = test1 & test2; 
//reg adc_data_convert_cnt 
// 分辨率是16384，所以每个ADC值对应于10V/16384 = 0.0006V
//parameter  REF_VOLTAGE         = 10000;        // 10V转换为整数
parameter  REF_VOLTAGE_1          = 24000;        // 测量量程，转换为mv
parameter  REF_VOLTAGE_2          = 10000;        // 测量量程，转换为mv
parameter  RESOLUTION           = 16383;        // 14bitADC
parameter  SCALE_VOLTAGE        = 1;            //输入功率百分比和电容充电电压的比率  输入0-10V
parameter  VOLTAGE_MAX_CAP_1    = 24;           //v,谐振电容1的最大电压
parameter  VOLTAGE_MAX_CAP_2    = 10;           //v,谐振电容2的最大电压
parameter  VOLTAGE_MAX_CAP_3    = 2400;         //支撑电容的最大电压
							    
assign  adc_value_cap_temp3     = {18'b0,filtered_data_out1};
assign  adc_value_cap_temp4     = {18'b0,filtered_data_out2};
assign  Voltage_cap_set_1_temp  = {18'b0,Voltage_cap_set_1};
assign  Voltage_cap_set_2_temp  = {18'b0,Voltage_cap_set_2};

assign  adc_value_cap_temp5     = adc_value_cap_temp3 * REF_VOLTAGE_1 / RESOLUTION - REF_VOLTAGE_1/2;    //mv,加偏执电压
assign  adc_value_cap_temp6     = adc_value_cap_temp4 * REF_VOLTAGE_2 / RESOLUTION - REF_VOLTAGE_2/2;    //mv,加偏执电压
assign  Voltage_cap_set_temp_1  = Voltage_cap_set_1_temp * VOLTAGE_MAX_CAP_1 *10 ;  //mv
assign  Voltage_cap_set_temp_2  = Voltage_cap_set_2_temp * VOLTAGE_MAX_CAP_2 *10 ;  //mv
assign  adc_voltage_over_1_cnt_temp = adc_voltage_over_1_cnt;
assign  adc_voltage_over_2_cnt_temp = adc_voltage_over_2_cnt;


always @(posedge sys_clk or negedge sys_rst_n) begin
    if (!sys_rst_n) begin
	    data1 <= 8'b0000_0001;
		data2 <= 8'b1111_1110;
        test5 <= 1'b1;
	end	
    else begin
        if(data1 < data2)
		    test5 <= ~test5;  
        else 
    	    test4 <= ~test4;  
	end	
end

always @(posedge sys_clk or negedge sys_rst_n) begin
    if (!sys_rst_n)
        adc_updata_cnt <= 16'd0;
    else if (adc_updata_cnt < 16'd5) begin           //20ns*5=100nS
        adc_updata_cnt <= adc_updata_cnt + 1'b1;            
    end      
    else
        adc_updata_cnt <= 16'd0;
end

always @(posedge sys_clk or negedge sys_rst_n) begin
    if (!sys_rst_n) 	begin        
		adc_data_cap_1_temp <=  14'd0;
		adc_data_cap_2_temp <=  14'd0;		
	end	 
	else begin
        adc_data_cap_1_temp <= adc_data_cap_1;
	    adc_data_cap_2_temp <= adc_data_cap_2;
		if (adc_data_cap_1_temp != adc_data_cap_1)
		    filter_data_in1 <= adc_data_cap_1;
		if (adc_data_cap_2_temp != adc_data_cap_2)
		    filter_data_in2 <= adc_data_cap_2;		
	end	
end

always @(posedge sys_clk or negedge sys_rst_n) begin
    if (!sys_rst_n) 	begin        
		adc_value_cap_1 <=  14'd0;
		adc_value_cap_2 <=  14'd0;		
	end	
    else if (adc_updata_cnt >= 16'd5) begin           //20ns*5=100nS
	    //test1 <= ~test1;
        //adc_value_cap_1 <=  adc_value_cap_temp5 - 12000 ;
		//adc_value_cap_2 <=  adc_value_cap_temp6 - 12000 ;
		adc_value_cap_1 <=  adc_value_cap_temp5  ;
		adc_value_cap_2 <=  adc_value_cap_temp6  ;
	end      
    else begin
	    adc_value_cap_1 <=  adc_value_cap_1;
		adc_value_cap_2 <=  adc_value_cap_2;	
	end        
end

always @(posedge sys_clk or negedge sys_rst_n) begin
     if (!sys_rst_n) 	begin        
		adc_value_cap_1_temp <=  14'd0;			
	end	 
    else  begin
	    adc_value_cap_1_temp <= adc_value_cap_1;	 
	    if(adc_value_cap_1_temp != adc_value_cap_1) begin	    
            if (adc_value_cap_1 >= Voltage_cap_set_temp_1) begin           //20ns*5=100nS	    
	         	adc_voltage_over_1_cnt <= adc_voltage_over_1_cnt + 1'b1; 
                test1 <= ~test1;		
                if(adc_voltage_over_1_cnt >= 4'd10)	
	         	    adc_voltage_over_1_cnt <= 4'd10;
	         end  
            else begin
                adc_voltage_over_1_cnt <= 4'd0;
	         	test2 <= ~test2;
            end	
	    end	    	
	end	
end

always @(posedge sys_clk or negedge sys_rst_n) begin
     if (!sys_rst_n) 	begin       		
		adc_value_cap_2_temp <=  14'd0;		
	end	 
    else  begin	    
	    adc_value_cap_2_temp <= adc_value_cap_2;	   
	    if(adc_value_cap_2_temp != adc_value_cap_2) begin
            if (adc_value_cap_2 >= Voltage_cap_set_temp_2) begin           //20ns*5=100nS	    
	        	adc_voltage_over_2_cnt <= adc_voltage_over_2_cnt + 1'b1;   
                if(adc_voltage_over_2_cnt >= 4'd10)	
	        	    adc_voltage_over_2_cnt <= 4'd10;
	        end  
            else begin
                adc_voltage_over_2_cnt <= 4'd0;
            end	
	    end	
	end	
end

always @(posedge sys_clk or negedge sys_rst_n) begin
    if (!sys_rst_n) begin
	    Voltage_cap_flag <=  3'b0;       
	end	
    else  begin 
	   // a <=  adc_voltage_over_1_cnt;
	    if (adc_voltage_over_1_cnt_temp >= 4'd3)            //20ns*5=100nS
		    begin
                //Voltage_cap_flag <= Voltage_cap_flag | 3'b001 ;            
				Voltage_cap_flag = Voltage_cap_flag | 3'b001 ;            
			    test3 <= ~test3; 	
            end      
        else  
		    begin
                //Voltage_cap_flag <= Voltage_cap_flag & 3'b110 ;
				Voltage_cap_flag = Voltage_cap_flag & 3'b110 ;
           	    //test4 <= ~test4;	
	        end 
			
		 if (adc_voltage_over_2_cnt_temp >= 4'd3)            //20ns*5=100nS
		    begin
                Voltage_cap_flag <= Voltage_cap_flag | 3'b010 ;            
            end      
        else  
		    begin
                Voltage_cap_flag <= Voltage_cap_flag & 3'b101 ;            	
	        end 	
	end
end

endmodule



