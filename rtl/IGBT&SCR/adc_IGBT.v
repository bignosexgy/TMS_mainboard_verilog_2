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
	input               adc_clk,                   //adc时钟

    //input         signed  [13:0]  adc_data_cap_1,          //谐振电容1电压ADC值 
    //input         signed  [13:0]  adc_data_cap_2,          //谐振电容2电压ADC值
	
	input                 [7:0]   Voltage_cap_set_1,       //脉冲功率，谐振电容1设置电压 
	input                 [7:0]   Voltage_cap_set_2,       //脉冲功率，谐振电容2设置电压 
	
	input                 [13:0]  filtered_data_out1,      //数字滤波器数据输入
	input                 [13:0]  filtered_data_out2,      //数字滤波器数据输入
		
	input                 [4:0]   IGBT_on_EN,             //5个IGBT开启使能
	
	input                 [1:0]   CAP_charge_flag,      
    input                 [1:0]   CAP_discharge_flag,   	
	
	output  reg   signed  [31:0]  adc_value_cap_1,	      //谐振电容1电压值mv   
	output  reg   signed  [31:0]  adc_value_cap_2,	      //谐振电容2电压值mv
	
	output  reg           [2:0]   Voltage_cap_flag,         //电容电压达到设定值标志位
	

	
	output  wire    signed        [31:0]  Voltage_cap_set_temp_1,   //谐振电容1充电电压设置
    output  wire    signed        [31:0]  Voltage_cap_set_temp_2,   //谐振电容2充电电压设置 
	
	output wire  signed  [31:0]     Voltage_cap_set_1_temp, 	      //支撑电容电压值mv
    output wire  signed  [31:0]     Voltage_cap_set_2_temp, 	      //支撑电容电压值mv	
	
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
//reg           [3:0]     adc_voltage_below_1_cnt;
//reg           [3:0]     adc_voltage_below_2_cnt;

         

reg  [13:0]  adc_value_cap_1_temp;
reg  [13:0]  adc_value_cap_2_temp;
//reg  [13:0]  adc_data_cap_1_temp;
//reg  [13:0]  adc_data_cap_2_temp;

reg  [13:0] a;
reg  signed [7:0] data1;
reg  signed [7:0] data2;

//reg         [1:0]   CAP_charge_flag; 
//reg         [1:0]   CAP_discharge_flag;




//wire  signed  [31:0]     Voltage_cap_set_temp_1;
//wire  signed  [31:0]     Voltage_cap_set_temp_2;
wire  signed  [31:0]     adc_value_cap_temp3; 	      //支撑电容电压值mv
wire  signed  [31:0]     adc_value_cap_temp4; 	      //支撑电容电压值mv	


wire  [3:0]  adc_voltage_over_1_cnt_temp;      //CAP1过压计数
wire  [3:0]  adc_voltage_over_2_cnt_temp;      //CAP2过压计数
wire  [3:0]  adc_voltage_below_1_cnt_temp;     //CAP1欠压计数
wire  [3:0]  adc_voltage_below_2_cnt_temp;     //CAP2欠压计数


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



assign  Voltage_cap_set_temp_1  = Voltage_cap_set_1_temp * VOLTAGE_MAX_CAP_1 *10 ;  //CAP1充电
assign  Voltage_cap_set_temp_2  = Voltage_cap_set_2_temp * VOLTAGE_MAX_CAP_2 *10 ;  //CAP2充电


assign  adc_voltage_over_1_cnt_temp = adc_voltage_over_1_cnt;
assign  adc_voltage_over_2_cnt_temp = adc_voltage_over_2_cnt;


always @(posedge sys_clk or negedge sys_rst_n) begin
    if (!sys_rst_n)
        adc_updata_cnt <= 16'd0;
    else if (adc_updata_cnt < 16'd5) begin           //20ns*5=100nS
        adc_updata_cnt <= adc_updata_cnt + 1'b1;            
    end      
    else
        adc_updata_cnt <= 16'd0;
end

always @(posedge adc_clk or negedge sys_rst_n) begin
    if (!sys_rst_n) 	begin        
		adc_value_cap_1 <=  14'd0;
		adc_value_cap_2 <=  14'd0;		
	end	
    else   begin       	         		
		adc_value_cap_1 <=  2*adc_value_cap_temp3 * REF_VOLTAGE_1 / RESOLUTION - REF_VOLTAGE_1;
		//adc_value_cap_2 <=  2*adc_value_cap_temp4 * REF_VOLTAGE_2 / RESOLUTION - REF_VOLTAGE_2;
		adc_value_cap_2 <=  adc_value_cap_temp4 * REF_VOLTAGE_2 / RESOLUTION - REF_VOLTAGE_2/2;
	end                 
end

//谐振电容1过压检测
always @(posedge adc_clk or negedge sys_rst_n) begin
    if (!sys_rst_n) 	begin        
		adc_voltage_over_1_cnt <=  4'd0;			
	end	 
    else  begin	    
        if(CAP_charge_flag[0]) begin	  
            if (adc_value_cap_1 >= Voltage_cap_set_temp_1) begin       
                if(adc_voltage_over_1_cnt < 4'd5) begin    	    
	         	    adc_voltage_over_1_cnt <= adc_voltage_over_1_cnt + 1'b1; 
                    test1 <= ~test1;		
				end
                else	
	         	    adc_voltage_over_1_cnt <= 4'd5;
	        end   
            else
                adc_voltage_over_1_cnt <= 4'd0;			
		end
	    else if (CAP_discharge_flag[0]) begin 	
		    if (adc_value_cap_1 <= Voltage_cap_set_temp_1) begin  
                if(adc_voltage_over_1_cnt < 4'd5)	begin
	         	    adc_voltage_over_1_cnt <= adc_voltage_over_1_cnt + 1'b1; 
                    //test1 <= ~test1;		
				end	
                else
	         	    adc_voltage_over_1_cnt <= 4'd5;	    	  
	         end  
            else begin
                adc_voltage_over_1_cnt <= 4'd0;
	         	 //test2 <= ~test2;
            end	
		end
		else
		    adc_voltage_over_1_cnt <= 4'd0;			
	end	
end

//谐振电容2过压检测
always @(posedge adc_clk or negedge sys_rst_n) begin
     if (!sys_rst_n) 	begin       		
		adc_voltage_over_2_cnt <=  4'd0;		
	end	 
    else  begin	  
        if(CAP_charge_flag[1]) begin		
            if (adc_value_cap_2 >= Voltage_cap_set_temp_2) begin           //20ns*5=100nS	    
			    if(adc_voltage_over_2_cnt <= 4'd5)	
	        	    adc_voltage_over_2_cnt <= adc_voltage_over_2_cnt + 1'b1;   
                else	
	        	    adc_voltage_over_2_cnt <= 4'd5;
	        end  
            else begin
                adc_voltage_over_2_cnt <= 4'd0;
            end		
        end	
        else if(CAP_discharge_flag[1]) begin		
            if (adc_value_cap_2 <= Voltage_cap_set_temp_2) begin           //20ns*5=100nS	    
	        	if(adc_voltage_over_2_cnt < 4'd5)	
				    adc_voltage_over_2_cnt <= adc_voltage_over_2_cnt + 1'b1;   
                else
	        	    adc_voltage_over_2_cnt <= 4'd5;	
	        end  
            else begin
                adc_voltage_over_2_cnt <= 4'd0;
            end		
        end	
      	else
		    adc_voltage_over_2_cnt <= 4'd0;			
	end	
end

//谐振电容过压标志设置
always @(posedge adc_clk or negedge sys_rst_n) begin
    if (!sys_rst_n) begin
	    Voltage_cap_flag <=  3'b0;       
	end	
    else  begin 	  
	    if (adc_voltage_over_1_cnt >= 4'd5)            //20ns*5=100nS
		    begin                         
				Voltage_cap_flag = Voltage_cap_flag | 3'b001 ;            
			    test3 <= ~test3; 	
            end      
        else  
		    begin                
				Voltage_cap_flag = Voltage_cap_flag & 3'b110 ;
           	    //test4 <= ~test4;	
	        end 
			
		 if (adc_voltage_over_2_cnt >= 4'd5)            //20ns*5=100nS
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



