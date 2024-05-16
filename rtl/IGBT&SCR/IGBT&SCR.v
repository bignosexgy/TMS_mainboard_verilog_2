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
    input                  sys_clk  ,         //系统时钟
    input                  sys_rst_n,         //系统复位，低电平有效
	
    input        [4:0]     IGBT_on_EN,        //5个IGBT开通使能控制位			
    output  reg  [4:0]     IGBT,              //5个IGBT驱动端口
	output  reg  [4:0]     IGBT_status,       //5个IGBT状态位
	
	input        [1:0]     SCR_on_EN,         //2个SCR开通使能控制位
	output  reg  [1:0]     SCR,                //2个SCR驱动端口
	output  reg  [1:0]     SCR_status        //2个SCR状态位
    );

//reg define
reg [23:0]  counter;
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

//控制IGBT1的开通或断开
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

//控制IGBT2的开通或断开
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

//控制IGBT3的开通或断开
always @(posedge sys_clk or negedge sys_rst_n) begin
    if (!sys_rst_n)
        IGBT[2] <= 1'b0;
    else if(IGBT_on_EN[2]) begin                      //IGBT开通使能        
        IGBT_status[2] <= 1'b1;                       //复位IGBT开通状态标志
        IGBT[2] <= 1'b1;                              //关断IGBT
    end  
    else begin	
        IGBT[2] <= 1'b0;                              //开通IGBT
        IGBT_status[2] <= 1'b0;                       //置位IGBT开通状态标志            
    end               
end



//控制IGBT4的开通或断开
always @(posedge sys_clk or negedge sys_rst_n) begin
    if (!sys_rst_n)
        IGBT[3] <= 1'b0;
    else if(IGBT_on_EN[3]) begin                      //IGBT开通使能        
        IGBT_status[3] <= 1'b1;                       //复位IGBT开通状态标志
        IGBT[3] <= 1'b1;                              //关断IGBT
    end  
    else begin	
        IGBT[3] <= 1'b0;                              //开通IGBT
        IGBT_status[3] <= 1'b0;                       //置位IGBT开通状态标志            
    end               
end


//控制IGBT5的开通或断开
always @(posedge sys_clk or negedge sys_rst_n) begin
    if (!sys_rst_n)
        IGBT[4] <= 1'b0;
    else if(IGBT_on_EN[4]) begin                      //IGBT开通使能        
        IGBT_status[4] <= 1'b1;                       //复位IGBT开通状态标志
        IGBT[4] <= 1'b1;                              //关断IGBT
    end  
    else begin	
        IGBT[4] <= 1'b0;                              //开通IGBT
        IGBT_status[4] <= 1'b0;                       //置位IGBT开通状态标志            
    end               
end


//控制SCR1的开通或断开
always @(posedge sys_clk or negedge sys_rst_n) begin
    if (!sys_rst_n)
        SCR[0] <= 1'b0;
    else if(SCR_on_EN[0]) begin                      //IGBT开通使能        
        SCR_status[0] <= 1'b1;                       //复位IGBT开通状态标志
        SCR[0] <= 1'b1;                              //关断IGBT
    end  
    else begin	
        SCR[0] <= 1'b0;                              //开通IGBT
        SCR_status[0] <= 1'b0;                       //置位IGBT开通状态标志            
    end               
end

//控制SCR2的开通或断开
always @(posedge sys_clk or negedge sys_rst_n) begin
    if (!sys_rst_n)
        SCR[1] <= 1'b0;
    else if(SCR_on_EN[1]) begin                      //IGBT开通使能        
        SCR_status[1] <= 1'b1;                       //复位IGBT开通状态标志
        SCR[1] <= 1'b1;                              //关断IGBT
    end  
    else begin	
        SCR[1] <= 1'b0;                              //开通IGBT
        SCR_status[1] <= 1'b0;                       //置位IGBT开通状态标志            
    end               
end

endmodule 