//****************************************Copyright (c)***********************************//
//原子哥在线教学平台：www.yuanzige.com
//技术支持：www.openedv.com
//淘宝店铺：http://openedv.taobao.com
//关注微信公众平台微信号："正点原子"，免费获取ZYNQ & FPGA & STM32 & LINUX资料。
//版权所有，盗版必究。
//Copyright(C) 正点原子 2018-2028
//All rights reserved
//----------------------------------------------------------------------------------------
// File name:           key_sw_disp
// Last modified Date:  2021/04/12 20:28:08
// Last Version:        V1.0
// Descriptions:        按键切换数码管显示
//                      
//----------------------------------------------------------------------------------------
// Created by:          正点原子
// Created date:        2021/04/12 20:28:08
// Version:             V1.0
// Descriptions:        The original version
//
//----------------------------------------------------------------------------------------
//****************************************************************************************//

module key_sw_disp(                                                            
    input                clk       , //时钟   
    input                rst_n     , //复位  
                                                           
    input                key_value , //按键
    input       [7:0]    sec       , //秒
    input       [7:0]    min       , //分钟
    input       [7:0]    hour      , //小时
    input       [7:0]    day       , //日
    input       [7:0]    mon       , //月
    input       [7:0]    year      , //年
    
    output      [5:0]    point     , //数码管小数点控制
    output      [23:0]   disp_data   //数码管显示的数值控制
     );

//reg define
reg    sw_flag     ;
reg    key_value_d0;
reg    key_value_d1;

//wire define
wire   neg_key_value;
     
//*****************************************************
//**                    main code
//*****************************************************     

//采集输入信号的下降沿
assign neg_key_value = key_value_d1 & (~key_value_d0);
//切换输出数码管要显示的数据
assign disp_data = (sw_flag == 1'b0) ? {hour,min,sec} : {year,mon,day};
//数码管小数点显示位置
assign point = 6'b010100;

//对输入的按键信号打两拍
always @(posedge clk or negedge rst_n) begin
    if(!rst_n) begin
        key_value_d0 <= 1'b0;
        key_value_d1 <= 1'b0;
    end
    else begin
        key_value_d0 <= key_value;
        key_value_d1 <= key_value_d0;
    end
end

//控制sw_flag信号翻转
always @(posedge clk or negedge rst_n) begin
    if(!rst_n)
        sw_flag <= 1'b0;
    else if(neg_key_value)
        sw_flag <= ~sw_flag;
end        

endmodule
