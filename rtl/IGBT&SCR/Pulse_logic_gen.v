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
    input                  sys_clk  ,             //系统时钟
    input                  sys_rst_n,             //系统复位，低电平有效
											      
	input       [3:0]      key_push,              //按键
	input       [2:0]      Voltage_cap_flag,      //充放电电压达到预设值标志 
    input                  fault_IGBT_driver1,     //IGBT驱动板1故障信号	
	input                  fault_IGBT_driver2,     //IGBT驱动板2故障信号	
	input                  fault_IGBT_driver3,     //IGBT驱动板3故障信号
	input                  error_IGBT_driver1,     //IGBT驱动板1两路同时输入高报警
	input                  error_IGBT_driver2,     //IGBT驱动板2两路同时输入高报警
	input                  error_IGBT_driver3,     //IGBT驱动板3两路同时输入高报警
    output                 reset_IGBT_driver1,     //IGBT驱动板1复位 	
	output                 reset_IGBT_driver2,     //IGBT驱动板2复位
	output                 reset_IGBT_driver3,     //IGBT驱动板3复位
	
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
	output  reg   [4:0]     IGBT_on_EN                    //5个IGBT开启使能
   //output  reg   [4:0]     IGBT                            //5个IGBT驱动端口

    );

//reg define
reg   [23:0]    counter;                       //系统时钟计数器 
//reg [23:0]  IGBT_counter [4:0];              //IGBT驱动时长
reg   [23:0]    IGBT_counter_1;                //IGBT驱动时长
reg   [23:0]    IGBT_counter_2;                //IGBT驱动时长
//reg [1:0]  SCR_counter;                      //晶闸管驱动时长
reg   [11:0]    Burst_Frequency;               //簇的频率        
reg   [11:0]    Pulses_Frequency;              //脉冲的频率   max=100Hz
reg   [3:0]     stimulate_mod;                 
reg   [4:0]     IGBT_status;                   //5个IGBT状态标志

reg   [4:0]     IGBT_on_Flag;
reg   [23:0]    IGBT_on_time_1;                //通道1IGBT开通时间
reg   [23:0]    IGBT_on_time_2;                //通道2IGBT开通时间
reg   [23:0]    Pulses_cycle_counter_1;    //通道1脉冲时钟计数
reg   [23:0]    Pulses_cycle_counter_2;     //通道2脉冲时钟计数

//parameter define
 


initial  begin
   IGBT_on_EN     <= 5'b0;          //串口通信完成后去掉这一条
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


//按键1开启IGBT1，Vcap关断IGBT1
always @(posedge sys_clk or negedge sys_rst_n) begin
    if (!sys_rst_n) begin
        IGBT_on_Flag[0]    <= 1'b0;
        IGBT_on_EN[0]      <= 1'b0;	
	end        
    else begin
	    if (key_push[0]) begin           //按下按键1
	        IGBT_on_Flag[0]    <= 1'b1;    
	    end
	    else begin           //未按按键1
            if(IGBT_on_Flag[0] == 1'b1) begin
                if(Voltage_cap_flag[0] == 1'b1) begin      //电容电压达到设定的值
                    IGBT_on_Flag[0]    <= 1'b0;
                    IGBT_on_EN[0]      <= 1'b0;				
	    		end	                   
                else  begin                   
                    IGBT_on_EN[0]      <= 1'b1;					
				end	
            end		
	    	else
	    	    IGBT_on_EN[0]      <= 1'b0;    
        end    
	end
end

//按键2开启IGBT2，Vcap关断IGBT2
always @(posedge sys_clk or negedge sys_rst_n) begin
    if (!sys_rst_n) begin
        IGBT_on_Flag[1]    <= 1'b0;
        IGBT_on_EN[1]      <= 1'b0;	
	end        
    else begin
	    if (key_push[1]) begin           //按下按键1
	        IGBT_on_Flag[1]    <= 1'b1;    
	    end
	    else begin           //未按按键1
            if(IGBT_on_Flag[1] == 1'b1) begin
                if(Voltage_cap_flag[1] == 1'b1) begin      //电容电压达到设定的值
                    IGBT_on_Flag[1]    <= 1'b0;
                    IGBT_on_EN[1]      <= 1'b0;				
	    		end	                   
                else                   
                    IGBT_on_EN[1]      <= 1'b1;
            end		
	    	else
	    	    IGBT_on_EN[1]      <= 1'b0;    
        end    
	end
end



/*
//确定将要进行的工作模式，确定IGBT1工作参数、开启或关断IGBT
always @(posedge sys_clk or negedge sys_rst_n) begin 
    if(!sys_rst_n) 
        Pulses_cycle_counter_1 <= 24'd0; 
    else if(counter == 24'd50) begin      
        Pulses_cycle_counter_1 <= Pulses_cycle_counter_1 + 1;      
        if(Pulses_cycle_counter_1 == 24'd1000) begin          //设定IGBT开通时间间隔1mS
            stimulate_mod <= 4'd4;
            IGBT_on_time_1 <= 24'd100;
            Pulses_cycle_counter_1 <= 24'd0;  
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
    
// 确定将要进行的工作模式，确定IGBT2工作参数、开启或关断IGBT工作参数、开启或关断IGBT
alw ays @(posedge sys_clk or negedge sys_rst_n) begin 
    if(!sys_rst_n) 
       Pulses_cycle_counter_2 <= 24'd0; 
    else if(counter == 24'd50) begin      
      Pulses_cycle_counter_2 <= Pulses_cycle_counter_2 + 1;  
     
      if(Pulses_cycle_counter_2 == 24'd1000) begin          //设定IGBT开通时间间隔1mS
          stimulate_mod <= 4'd4;
          IGBT_on_time_2 <= 24'd100;
          Pulses_cycle_counter_2 <= 24'd0;  
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
*/


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