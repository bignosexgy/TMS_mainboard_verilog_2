//****************************************Copyright (c)***********************************//
//----------------------------------------------------------------------------------------
// File name:           Pulse_logic_gen
// Last modified Date:  2024/3/6 
// Last Version:        V1.0
// Descriptions:        由刺激模式生成IGBT和晶闸管驱动信号的逻辑控制
//----------------------------------------------------------------------------------------
// Created by:          xgy
// Created date:        2024/3/6 
// Version:             V1.0
// Descriptions:        The original version
//
//----------------------------------------------------------------------------------------
//****************************************************************************************//

module Pulse_logic_gen(
    input                  sys_clk  ,        //系统时钟
    input                  sys_rst_n,        //系统复位，低电平有效
 

    input       [7:0]    receive_data,     //串口接受到的数据
    //input   reg  [11:0]     Burst_Frequency,    //簇的频率
    //input   reg  [11:0]     Pulses_Frequency,   //脉冲的频率
    //input       [4:0]        IGBT_status,      //5个IGBT状态标志
    //input  reg  [1:0]       SCR_status ,        //2个SCR状态标志
    //output  reg  [4:0]     IGBT,               //5个IGBT驱动端口
    //output  reg  [1:0]      CR,                //2个SCR驱动端口

    //output   reg  [4:0]      IGBT_on_EN,         //5个IGBT开启使能
    //output   reg  [1:0]     SCR_on_EN,          //2个SCR开启使能
    //output   reg  [23:0]    IGBT_on_time[4:0]  //5个IGBT开通时常
    //output     reg  [23:0]     IGBT_on_time             //5个IGBT开通时常
    //output   reg  [23:0]  SCR_on_time[1:0]    //2个SCR开通时常
    
    //output  reg  [1:0]        SCR_status ,                    //2个SCR状态标志
    output  reg  [4:0]        IGBT                            //5个IGBT驱动端口

    );

//reg define
reg [23:0] counter;
//reg [23:0]  IGBT_counter [4:0];    //IGBT驱动时长
reg [23:0]  IGBT_counter_1;    //IGBT驱动时长
reg [23:0]  IGBT_counter_2;    //IGBT驱动时长
//reg [1:0]  SCR_counter;     //晶闸管驱动时长
reg  [11:0]   Burst_Frequency;  //簇的频率        
reg  [11:0]   Pulses_Frequency;  //脉冲的频率   max=100Hz
reg  [3:0]    stimulate_mod;
reg  [4:0]        IGBT_status;            //5个IGBT状态标志
reg  [4:0]      IGBT_on_EN;                //5个IGBT开启使能
reg  [23:0]     IGBT_on_time_1;               //5个IGBT开通时常
reg  [23:0]     IGBT_on_time_2;               //5个IGBT开通时常
reg  [23:0]    IGBT_Frequency_counter_1;
reg  [23:0]    IGBT_Frequency_counter_2;
//parameter define
 


initial  begin
   IGBT_on_EN <= 5'b0;          //串口通信完成后去掉这一条
   IGBT_counter_1 <= 24'b0;
   IGBT_counter_2 <= 24'b0;
end
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


//确定将要进行的工作模式，确定IGBT1工作参数、开启或关断IGBT
always @(posedge sys_clk or negedge sys_rst_n) begin 
   if(!sys_rst_n) 
      IGBT_Frequency_counter_1 <= 24'd0; 
   else if(counter == 24'd50) begin      
     IGBT_Frequency_counter_1 <= IGBT_Frequency_counter_1 + 1;  
    
     if(IGBT_Frequency_counter_1 == 24'd1000) begin          //设定IGBT开通时间间隔1mS
         stimulate_mod <= 4'd4;
         IGBT_on_time_1 <= 24'd100;
         IGBT_Frequency_counter_1 <= 24'd0;  
         IGBT_on_EN[0] <= 1'b1;       
      end
    
     else begin 
       if(IGBT_on_EN[0] == 1'b1) begin                        //IGBT开通使能
           IGBT_counter_1 <=  IGBT_counter_1 + 1;      
      
           if(IGBT_counter_1 == IGBT_on_time_1) begin     //开通时间计时技术
              //IGBT_counter[0] <=  24'd1000_0000;
              IGBT_status[0] <= 1'b0;                      //复位IGBT开通状态标志
           
              IGBT[0] <= 1'b0;                                           //关断IGBT
              IGBT_on_EN[0] <= 1'b0;
              IGBT_counter_1 <=  24'b0; 
           end 
       
           else begin                                       //IGBT开通计时未结束
              IGBT[0] <= 1'b1;                                  //开通IGBT
              IGBT_status[0] <= 1'b1;                      //置位IGBT开通状态标志
           end
       
        end   
       
        else begin                                                       //IGBT关断
           IGBT_status[0] <= 1'b0;
           IGBT[0] <= 1'b0;
           IGBT_counter_1 <=  24'b0; 
        end
        
     end   
   end
   else
      stimulate_mod <= stimulate_mod;
end

//确定将要进行的工作模式，确定IGBT2工作参数、开启或关断IGBT工作参数、开启或关断IGBT
always @(posedge sys_clk or negedge sys_rst_n) begin 
   if(!sys_rst_n) 
      IGBT_Frequency_counter_2 <= 24'd0; 
   else if(counter == 24'd50) begin      
     IGBT_Frequency_counter_2 <= IGBT_Frequency_counter_2 + 1;  
    
     if(IGBT_Frequency_counter_2 == 24'd1000) begin          //设定IGBT开通时间间隔1mS
         stimulate_mod <= 4'd4;
         IGBT_on_time_2 <= 24'd100;
         IGBT_Frequency_counter_2 <= 24'd0;  
         IGBT_on_EN[1] <= 1'b1;       
      end
    
     else begin 
       if(IGBT_on_EN[1] == 1'b1) begin                        //IGBT开通使能
           IGBT_counter_2 <=  IGBT_counter_2 + 1;      
      
           if(IGBT_counter_2 == IGBT_on_time_2) begin     //开通时间计时技术
              //IGBT_counter[0] <=  24'd1000_0000;
              IGBT_status[1] <= 1'b0;                      //复位IGBT开通状态标志
           
              IGBT[1] <= 1'b0;                                           //关断IGBT
              IGBT_on_EN[1] <= 1'b0;
              IGBT_counter_2 <=  24'b0; 
           end 
       
           else begin                                       //IGBT开通计时未结束
              IGBT[1] <= 1'b1;                                  //开通IGBT
              IGBT_status[1] <= 1'b1;                      //置位IGBT开通状态标志
           end
       
        end   
       
        else begin                                                       //IGBT关断
           IGBT_status[1] <= 1'b0;
           IGBT[1] <= 1'b0;
           IGBT_counter_2 <=  24'b0; 
        end
        
     end   
   end
   else
      stimulate_mod <= stimulate_mod;
end



//p mode


//r mode



//TBS mode


//single Pulse mode

//控制IGBT[0]的开通或断开
/*
always @(posedge sys_clk or negedge sys_rst_n) begin
    if (!sys_rst_n)
        IGBT[0] <= 1'b0;
      else if(IGBT_on_EN[0]) begin                        //IGBT开通使能
        IGBT_counter_1 <=  IGBT_counter_1 + 1'b1;      
         if(IGBT_counter_1 == IGBT_on_time) begin     //开通时间计时技术
            //IGBT_counter[0] <=  24'd1000_0000;
            IGBT_status[0] <= 1'b0;                      //复位IGBT开通状态标志
            IGBT[0] <= 1'b0;                                           //关断IGBT
         IGBT_on_EN[0] <= 1'b0;
         IGBT_counter_1 <=  24'b0; 
         end      
         else begin                                       //IGBT开通计时未结束
            IGBT[0] <= 1'b1;                                  //开通IGBT
            IGBT_status[0] <= 1'b1;                      //置位IGBT开通状态标志
         end      
      end                  
      else begin                                                       //IGBT关断
         IGBT_status[0] <= 1'b0;
         IGBT[0] <= 1'b0;
        IGBT_counter_1 <=  24'b0; 
      end
end
*/

endmodule 