//****************************************Copyright (c)***********************************//
//----------------------------------------------------------------------------------------
// File name:           IGBT_SCR
// Last modified Date:  2024/3/5 
// Last Version:        V1.0
// Descriptions:        IGBT和晶闸管驱动信号
//----------------------------------------------------------------------------------------
// Created by:          xgy
// Created date:        2024/3/5 
// Version:             V1.0
// Descriptions:        The original version
//
//----------------------------------------------------------------------------------------
//****************************************************************************************//

module IGBT_SCR(
    input                  sys_clk  ,        //系统时钟
    input                  sys_rst_n,        //系统复位，低电平有效
	
    input        [4:0]     IGBT_on_EN,       //5个IGBT开通使能控制位	
    output  reg  [4:0]     IGBT,             //5个IGBT驱动端口
	output  reg  [4:0]     IGBT_status       //5个IGBT状态位
    );

//reg define
reg [23:0] counter;
reg [23:0]  IGBT_counter_1;    //IGBT驱动时长



//*****************************************************
//**                    main code
//***************************************************** 
                                                                                                                                                                                                                         
//计数器对系统时钟计数，计时1u秒
always @(posedge sys_clk or negedge sys_rst_n) begin
    if (!sys_rst_n)
        counter <= 24'd0;
    else if (counter < 24'd50) begin           //20ns*50=1uS
          counter <= counter + 1'b1;            
      end      
    else
        counter <= 24'd0;
end
/*
//用于IGBT[0]开通时间计时
always @(posedge sys_clk or negedge sys_rst_n) begin
    if (!sys_rst_n)
         IGBT_counter_1 <= 24'b0;
    else if(counter < IGBT_on_time)       //1us*IGBT_on_time
         IGBT_counter_1 <=  IGBT_counter_1 + 1'b1;
    else
         IGBT_counter_1 <=  24'b0;
end
*/

//控制IGBT[0]的开通或断开
always @(posedge sys_clk or negedge sys_rst_n) begin
    if (!sys_rst_n)
        IGBT[0] <= 1'b0;
    else if(IGBT_on_EN[0]) begin                       //IGBT开通使能        
        IGBT_status[0] <= 1'b1;                        //复位IGBT开通状态标志
        IGBT[0] <= 1'b1;                               //关断IGBT
    end  
    else begin	
        IGBT[0] <= 1'b0;                               //开通IGBT
        IGBT_status[0] <= 1'b0;                        //置位IGBT开通状态标志            
    end               
end

//控制IGBT[1]的开通或断开
always @(posedge sys_clk or negedge sys_rst_n) begin
    if (!sys_rst_n)
        IGBT[1] <= 1'b0;
    else if(IGBT_on_EN[1]) begin                      //IGBT开通使能        
        IGBT_status[1] <= 1'b1;                       //复位IGBT开通状态标志
        IGBT[1] <= 1'b1;                              //关断IGBT
    end  
    else begin	
        IGBT[1] <= 1'b0;                              //开通IGBT
        IGBT_status[1] <= 1'b0;                       //置位IGBT开通状态标志            
    end               
end

endmodule 