//****************************************Copyright (c)***********************************//
//技术支持：www.openedv.com
//淘宝店铺：http://openedv.taobao.com 
//关注微信公众平台微信号："正点原子"，免费获取FPGA & STM32资料。
//版权所有，盗版必究。
//Copyright(C) 正点原子 2018-2028
//All rights reserved                                  
//----------------------------------------------------------------------------------------
// File name:           key_led
// Last modified Date:  2018年5月11日14:46:18
// Last Version:        V1.1
// Descriptions:        按键控制LED
//----------------------------------------------------------------------------------------
// Created by:          正点原子
// Created date:        
// Version:             V1.0
// Descriptions:        The original version
//
//----------------------------------------------------------------------------------------
// Modified by:         正点原子
// Modified date:       2018/4/24 9:56:36
// Version:             V1.1
// Descriptions:        
//
//----------------------------------------------------------------------------------------
//****************************************************************************************//

module led_key(
    input               sys_clk  ,    //50Mhz系统时钟
    input               sys_rst_n,    //系统复位，低有效
  
    output  reg  [3:0]  led,           //LED输出信号
	input        [3:0]  led_state
    );



//识别按键，切换显示模式
always @(posedge sys_clk or negedge sys_rst_n) begin
    if(!sys_rst_n) begin
          led<=4'b 0000;
    end
	else
		led<=led_state;	
end

endmodule 