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
    input          [13:0]     adc_data_cap_1,          //谐振电容1电压ADC值 
    input          [13:0]     adc_data_cap_2,          //谐振电容2电压ADC值
	input          [13:0]     adc_data_cap_3,          //支撑电容电压ADC值
	input          [7:0]      Voltage_cap_set_1,       //脉冲功率，谐振电容1设置电压 
	input          [7:0]      Voltage_cap_set_2,       //脉冲功率，谐振电容2设置电压 
	input          [7:0]      Voltage_cap_set_3,       //脉冲功率，支撑电容电容设置电压 
	output   reg   [31:0]     adc_valuecap_1,	      //谐振电容1电压值mv   
	output   reg   [31:0]     adc_valuecap_2,	      //谐振电容2电压值mv
	output   reg   [31:0]     adc_valuecap_3,	      //支撑电容电压值mv
	output   reg   [2:0]      Voltage_cap_flag         //电容电压达到设定值标志位
);
 
// 分辨率是16384，所以每个ADC值对应于10V/16384 = 0.0006V
parameter REF_VOLTAGE = 10000;        // 10V转换为整数
parameter RESOLUTION  = 16383;        // 14bitADC
parameter SCALE_VOLTAGE = 1;          //输入功率百分比和电容充电电压的比率  输入0-10V

//电容1的电压设定 
always @ (adc_data_cap_1) begin
    // 计算整数部分
    adc_valuecap_1 = adc_data_cap_1 * (REF_VOLTAGE / RESOLUTION)-5000;
    // 如果需要小数部分，可以通过模运算获取剩余电压，并乘以1000进行缩放
    // decimal_value_frac = (adc_value % (RESOLUTION / 1000)) * (REF_VOLTAGE / RESOLUTION / 1000);
	if(adc_valuecap_1 >= (Voltage_cap_set_1 * SCALE_VOLTAGE * REF_VOLTAGE / 100))
	    Voltage_cap_flag[0] <= 1'b1;
	else
	    Voltage_cap_flag[0] <= 1                          'b0;
end

//电容2的电压设定 
always @ (adc_data_cap_2) begin
    // 计算整数部分
    adc_valuecap_2 = adc_data_cap_2 * (REF_VOLTAGE / RESOLUTION)-5000;
    // 如果需要小数部分，可以通过模运算获取剩余电压，并乘以1000进行缩放
    // decimal_value_frac = (adc_value % (RESOLUTION / 1000)) * (REF_VOLTAGE / RESOLUTION / 1000);
	if(adc_valuecap_2 >= (Voltage_cap_set_2 * SCALE_VOLTAGE * REF_VOLTAGE / 100))
	    Voltage_cap_flag[1] <= 1'b1;
	else
	    Voltage_cap_flag[1] <= 1'b0;
end 
endmodule



