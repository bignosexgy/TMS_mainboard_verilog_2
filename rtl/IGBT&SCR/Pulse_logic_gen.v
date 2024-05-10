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
    input                  sys_clk  ,              //系统时钟
    input                  sys_rst_n,              //系统复位，低电平有效
											      
	input         [3:0]    key_push,               //按键
	input         [2:0]    Voltage_cap_flag,       //充放电电压达到预设值标志 
	input         [4:0]    IGBT_status,            //5个IGBT状态位
    input                  fault_IGBT_driver1,     //IGBT驱动板1故障信号	
	input                  fault_IGBT_driver2,     //IGBT驱动板2故障信号	
	input                  fault_IGBT_driver3,     //IGBT驱动板3故障信号
	input                  error_IGBT_driver1,     //IGBT驱动板1两路同时输入高报警
	input                  error_IGBT_driver2,     //IGBT驱动板2两路同时输入高报警
	input                  error_IGBT_driver3,     //IGBT驱动板3两路同时输入高报警
    output  reg            reset_IGBT_driver1,     //IGBT驱动板1复位 	
	output  reg            reset_IGBT_driver2,     //IGBT驱动板2复位
	output  reg            reset_IGBT_driver3,     //IGBT驱动板3复位           
	output  reg   [4:0]    IGBT_on_EN,             //5个IGBT开启使能
	
	output  reg   [1:0]    SCR_on_EN_d0,                  //SCR_on_EN状态0
	output  reg   [1:0]    SCR_on_EN_d1,                  //SCR_on_EN状态1
				 
	output  wire  [1:0]    SCR_conter_reset_flag,         //SCR计数器复位标志 
    output  reg   [1:0]    SCR_conter_Start_flag,	
	
	input         [1:0]    SCR_status,             //2个SCR状态位
	output  reg   [1:0]    SCR_on_EN               //2个SCR开启使能		

);

//reg define
reg   [23:0]    counter;                       //系统时钟计数器 
reg   [23:0]    SCR_counter_1;                 //SCR1计数器
reg   [23:0]    SCR_counter_2;                 //SCR2计数器
reg   [11:0]    Burst_Frequency;               //簇的频率        
reg   [11:0]    Pulses_Frequency;              //脉冲的频率   max=100Hz
reg   [3:0]     stimulate_mod;                 
reg   [4:0]     IGBT_on_Flag;
reg   [23:0]    IGBT_on_time_1;                //通道1IGBT开通时间
reg   [23:0]    IGBT_on_time_2;                //通道2IGBT开通时间
reg   [23:0]    Pulses_cycle_counter_1;        //通道1脉冲时钟计数
reg   [23:0]    Pulses_cycle_counter_2;        //通道2脉冲时钟计数
//reg   [1:0]     SCR_on_EN_d0;                  //SCR_on_EN状态0
//reg   [1:0]     SCR_on_EN_d1;                  //SCR_on_EN状态1
reg   [1:0]     SCR_on_Flag;

//wire  [1:0]     SCR_conter_reset_flag;         //SCR计数器复位标志             
											   
//parameter define                             
parameter SCR_timer_1  = 200;                  //SCR1定时器 200us
parameter SCR_timer_2  = 200;                  //SCR2定时器 200us
											   
											   
initial  begin                                 
   IGBT_on_EN     <= 5'b0;                     //初始时，禁止IGBT启动   
   SCR_on_EN      <= 2'b0;                     //初始时，禁止SCR启动
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


//判断SCR_on_EN的下降沿，用于计数器清零
assign SCR_conter_reset_flag[0] = (~SCR_on_EN_d1[0]) & SCR_on_EN_d0[0];
assign SCR_conter_reset_flag[1] = (~SCR_on_EN_d1[1]) & SCR_on_EN_d0[1];
always @(posedge sys_clk or negedge sys_rst_n) begin
    if (!sys_rst_n)  begin
	    SCR_on_EN_d0 <= 2'b00;
        SCR_on_EN_d1 <= 2'b00;		
	end	
    else  begin 
	    SCR_on_EN_d0[0] <= SCR_on_EN[0]; 
	    SCR_on_EN_d1[0] <= SCR_on_EN_d0[0];	    
		SCR_on_EN_d0[1] <= SCR_on_EN[1]; 
	    SCR_on_EN_d1[1] <= SCR_on_EN_d0[1];	    
    end
end


//计数器对SCR1开通时间计数，计数单位1u秒
always @(posedge sys_clk or negedge sys_rst_n) begin
    if (!sys_rst_n)  begin
	    SCR_counter_1 <= 24'b0;   
        SCR_conter_Start_flag[0] <= 1'b0;		
	end	
    else begin 
	    if(SCR_conter_reset_flag[0]) begin
		    SCR_conter_Start_flag[0] <= 1'b1;
			SCR_counter_1 <= 24'b0; 
		end	
		else if(counter >= 24'd50) begin
    		if(SCR_conter_Start_flag[0]) begin
			    if (SCR_counter_1 < SCR_timer_1) begin
                   SCR_counter_1 <= SCR_counter_1+1'b1;
                end				
			    else begin
			        SCR_conter_Start_flag[0] <= 1'b0;
                    SCR_counter_1 <= 24'b0;					
                end			
            end	
            else begin
			    SCR_counter_1 <= 24'b0;				
            end			
        end
        else begin
            SCR_counter_1 <= SCR_counter_1;   
            SCR_conter_Start_flag[0] <= SCR_conter_Start_flag[0];	
	    end	
    end		
end

//计数器对SCR2开通时间计数，计数单位1u秒
always @(posedge sys_clk or negedge sys_rst_n) begin
    if (!sys_rst_n)  begin	    
        SCR_counter_2 <= 24'b0; 
        SCR_conter_Start_flag[1] <= 1'b0;		
	end	
    else begin 
	    if(SCR_conter_reset_flag[1]) begin
		    SCR_conter_Start_flag[1] <= 1'b1;
			SCR_counter_2 <= 24'b0; 
		end	
		else if(counter >= 24'd50) begin
    		if(SCR_conter_Start_flag[1]) begin
			    if (SCR_counter_2 < SCR_timer_2) begin
                   SCR_counter_2 <= SCR_counter_2+1'b1;
                end				
			    else begin
			        SCR_conter_Start_flag[1] <= 1'b0;
                    SCR_counter_2 <= 24'b0;					
                end			
            end	
            else begin
			    SCR_counter_2 <= 24'b0;				
            end			
        end	
        else begin
	        SCR_counter_2 <= SCR_counter_2;   
            SCR_conter_Start_flag[1] <= SCR_conter_Start_flag[1];	
	    end	        
    end	
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
                if(Voltage_cap_flag[0] == 1'b1) begin      //
                    IGBT_on_Flag[0]    <= 1'b0;
                    IGBT_on_EN[0]      <= 1'b0;				
	    		end	                   
                else if(~IGBT_on_EN[1])  begin                   
                    IGBT_on_EN[0]      <= 1'b1;					
					//IGBT_on_EN[1]      <= 1'b0;					
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
	    if (key_push[1]) begin           //按下按键2
	        IGBT_on_Flag[1]    <= 1'b1;    
	    end
	    else begin           //未按按键1
            if(IGBT_on_Flag[1] == 1'b1) begin
                if(Voltage_cap_flag[1] == 1'b1) begin      //
                    IGBT_on_Flag[1]    <= 1'b0;
                    IGBT_on_EN[1]      <= 1'b0;				
	    		end	                   
                else if(~IGBT_on_EN[0])begin 
				    //IGBT_on_EN[0]      <= 1'b0;					
                    IGBT_on_EN[1]      <= 1'b1;
				end	
            end		
	    	else
	    	    IGBT_on_EN[1]      <= 1'b0;    
        end    
	end
end

//按键3开启SCR1
always @(posedge sys_clk or negedge sys_rst_n) begin
    if (!sys_rst_n) begin
        SCR_on_Flag[0]    <= 1'b0;
        SCR_on_EN[0]      <= 1'b0;	
	end        
    else begin
	    if (key_push[2]) begin           //按下按键3
	        SCR_on_Flag[0]    <= 1'b1;    
	    end
	    else begin           //未按按键1
            if(SCR_on_Flag[0] == 1'b1) begin
                if(SCR_counter_1 >= SCR_timer_1 - 1'b1) begin      //电容电压达到设定的值
                    SCR_on_Flag[0]    <= 1'b0;
                    SCR_on_EN[0]      <= 1'b0;				
	    		end	                   
                else if(~SCR_on_EN[0])begin 
                    SCR_on_EN[0]      <= 1'b1;
				end	
            end		
	    	else
	    	    SCR_on_EN[0]      <= 1'b0;    
        end    
	end
end

//按键4开启SCR2
always @(posedge sys_clk or negedge sys_rst_n) begin
    if (!sys_rst_n) begin
        SCR_on_Flag[1]    <= 1'b0;
        SCR_on_EN[1]      <= 1'b0;	
	end        
    else begin
	    if (key_push[3]) begin           //按下按键3
	        SCR_on_Flag[1]    <= 1'b1;    
	    end
	    else begin           //未按按键1
            if(SCR_on_Flag[1] == 1'b1) begin
                if(SCR_counter_2 >= SCR_timer_2 - 1'b1) begin      //电容电压达到设定的值
                    SCR_on_Flag[1]    <= 1'b0;
                    SCR_on_EN[1]      <= 1'b0;				
	    		end	                   
                else if(~SCR_on_EN[1])begin 
                    SCR_on_EN[1]      <= 1'b1;
				end	
            end		
	    	else
	    	    SCR_on_EN[1]      <= 1'b0;    
        end    
	end
end


//p mode


//r mode



//TBS mode


//single Pulse mode



endmodule 