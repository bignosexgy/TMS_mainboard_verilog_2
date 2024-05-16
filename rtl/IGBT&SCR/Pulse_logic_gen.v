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
											      
	
	input  signed  [31:0]   adc_value_cap_1,
	input  signed  [31:0]   adc_value_cap_2,
	input  signed  [31:0]   Voltage_cap_set_temp_1,
	input  signed  [31:0]   Voltage_cap_set_temp_2,		
	input          [3:0]    key_push,               //按键
	input          [1:0]    Voltage_cap_flag,       //充放电电压达到预设值标志 
	input          [4:0]    IGBT_status,            //5个IGBT状态位
    input                   fault_IGBT_driver1,     //IGBT驱动板1故障信号	
	input                   fault_IGBT_driver2,     //IGBT驱动板2故障信号	
	input                   fault_IGBT_driver3,     //IGBT驱动板3故障信号
	input                   error_IGBT_driver1,     //IGBT驱动板1两路同时输入高报警
	input                   error_IGBT_driver2,     //IGBT驱动板2两路同时输入高报警
	input                   error_IGBT_driver3,     //IGBT驱动板3两路同时输入高报警
    output  reg             reset_IGBT_driver1,     //IGBT驱动板1复位 	
	output  reg             reset_IGBT_driver2,     //IGBT驱动板2复位
	output  reg             reset_IGBT_driver3,     //IGBT驱动板3复位  
    output  reg   [1:0]     CAP_charge_flag,      
    output  reg   [1:0]     CAP_discharge_flag,   		
	output  reg   [4:0]     IGBT_on_EN,             //5个IGBT开启使能					 			
	input         [1:0]     SCR_status,             //2个SCR状态位
	output  reg                test1,
	output  reg                test2,
	output  reg                test3,
	output  reg   [1:0]     SCR_on_EN               //2个SCR开启使能		
	
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
reg   [1:0]     SCR_on_EN_d0;                  //SCR_on_EN状态0
reg   [1:0]     SCR_on_EN_d1;                  //SCR_on_EN状态1
reg   [1:0]     SCR_on_Flag;
reg   [1:0]     SCR_conter_Start_flag;

//reg   [1:0]     CAP_charge_flag; 
//reg   [1:0]     CAP_discharge_flag;

reg             key0_done_0;
reg             key0_done_1;
reg             key1_done_0;
reg             key1_done_1;	            
reg             key0_done;
reg             key1_done;
reg             key0_done_flag;
reg             key1_done_flag;
reg             voltage1_measure_comp;
reg             voltage2_measure_comp;
reg   [3:0]     voltage_over_1_cnt;
reg   [3:0]     voltage_over_2_cnt;
reg   [3:0]     voltage_below_1_cnt;
reg   [3:0]     voltage_below_2_cnt;
//reg   [7:0]     key0_done_cnt;
//reg   [7:0]     key1_done_cnt;
 
wire  [1:0]     SCR_conter_reset_flag;         //SCR计数器复位标志             
											   
//parameter define                             


parameter SCR_timer_1  = 50;                  //SCR1定时器 200us
parameter SCR_timer_2  = 50;                  //SCR2定时器 200us											   											   

//*****************************************************
//**                    main code
//***************************************************** 

//判断按键下降沿,输出持续一定时间的信号		
always @(posedge sys_clk or negedge sys_rst_n) begin
    if (!sys_rst_n) begin
	    key0_done_0 <= 1'b0;
		key0_done_1 <= 1'b0;
		key1_done_0 <= 1'b0;
		key1_done_1 <= 1'b0;        
	end	
    else begin          
        key0_done_0 <= key_push[0];
		key0_done_1 <= key0_done_0;
		key1_done_0 <= key_push[1];
		key1_done_1 <= key1_done_0;
		key0_done   <= (~key0_done_0) & key0_done_1;
		key1_done   <= (~key1_done_0) & key1_done_1;
		if (key0_done) 	
		    key0_done_flag <= 1'b1;
		else if (key0_done_flag && voltage1_measure_comp) 
		    key0_done_flag <= 1'b0;	 					
        else 	   
			key0_done_flag <= key0_done_flag;
		
		
   	    if (key1_done)  
		    key1_done_flag <= 1'b1;
		else if (key1_done_flag && voltage2_measure_comp) 
		    key1_done_flag <= 1'b0;	
		else 		   
			key1_done_flag <= key1_done_flag;		
    end   
end		
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


//按键1开启CAP1控制，根据CAP1电压开启IGBT1、IGBT3或关断IGBT1、IGBT3
always @(posedge sys_clk or negedge sys_rst_n) begin
    if (!sys_rst_n) begin
        CAP_charge_flag[0]    <= 1'b0; 
		CAP_discharge_flag[0] <= 1'b0; 
	end       
    else begin	    
	    if (key0_done_flag) begin           //按下按键1
	        if(adc_value_cap_1 > Voltage_cap_set_temp_1) begin
			    voltage_below_1_cnt <= 1'b0;
			    if(voltage_over_1_cnt < 4'd5) begin
			        voltage_over_1_cnt     <= voltage_over_1_cnt + 1'b1;  
					voltage1_measure_comp  <= 1'b0;					
				end	
				else begin	
	        	    voltage_over_1_cnt     <= 4'd0;	
                    CAP_charge_flag[0]     <= 1'b0; 
		            CAP_discharge_flag[0]  <= 1'b1;
                    voltage1_measure_comp  <= 1'b1;					
				end
			end	
            else if(adc_value_cap_1 <= Voltage_cap_set_temp_1) begin
			    voltage_over_1_cnt    <= 1'b0;
				if(voltage_below_1_cnt < 4'd5) begin
			        voltage_below_1_cnt    <= voltage_below_1_cnt + 1'b1;  
					voltage1_measure_comp  <= 1'b0;					
				end	
				else begin	
				    voltage_below_1_cnt    <= 1'b0;
                    CAP_charge_flag[0]     <= 1'b1; 
		            CAP_discharge_flag[0]  <= 1'b0; 
                    voltage1_measure_comp  <= 1'b1;	
				end	
			end												
	    end
	    else begin           //未按按键1
		    if(Voltage_cap_flag[0]) begin
                CAP_charge_flag[0]    <= 1'b0; 
		        CAP_discharge_flag[0] <= 1'b0; 	   
			end
        end    
	end
end

//按键2开启CAP2控制，根据CAP2电压开启IGBT2、IGBT4或关断IGBT1、IGBT3
always @(posedge sys_clk or negedge sys_rst_n) begin
    if (!sys_rst_n) begin
        CAP_charge_flag[1]    <= 1'b0; 
		CAP_discharge_flag[1] <= 1'b0; 
	end       
    else begin
	    if (key1_done_flag) begin           //按下按键1
	        if(adc_value_cap_2 > Voltage_cap_set_temp_2) begin
			    voltage_below_2_cnt <= 1'b0;
			    if(voltage_over_2_cnt < 4'd5) begin
			        voltage_over_2_cnt <= voltage_over_2_cnt + 1'b1;  
					voltage2_measure_comp  <= 1'b0;					
				end	
				else begin	
	        	    voltage_over_2_cnt     <= 4'd0;	
                    CAP_charge_flag[1]     <= 1'b0; 
		            CAP_discharge_flag[1]  <= 1'b1;
                    voltage2_measure_comp  <= 1'b1;					
				end
			end	
            else if(adc_value_cap_1 <= Voltage_cap_set_temp_1) begin
			    voltage_over_2_cnt    <= 1'b0;
				if(voltage_below_2_cnt < 4'd5) begin
			        voltage_below_2_cnt    <= voltage_below_2_cnt + 1'b1;  
					voltage2_measure_comp  <= 1'b0;					
				end	
				else begin	
				    voltage_below_2_cnt    <= 1'b0;
                    CAP_charge_flag[1]     <= 1'b1; 
		            CAP_discharge_flag[1]  <= 1'b0; 
                    voltage2_measure_comp  <= 1'b1;	
				end	
			end												
	    end
	    else begin           //未按按键1
		    if(Voltage_cap_flag[1]) begin
                CAP_charge_flag[1]    <= 1'b0; 
		        CAP_discharge_flag[1] <= 1'b0; 	   
			end
        end          	
	end
end


//按键1开启IGBT1，Vcap关断IGBT1,谐振电容1大电流充电控制
always @(posedge sys_clk or negedge sys_rst_n) begin
    if (!sys_rst_n) begin
        IGBT_on_Flag[0]    <= 1'b0;
        IGBT_on_EN[0]      <= 1'b0;	
	end        
    else begin	   
		if(!IGBT_on_Flag[0]) begin
            if(CAP_charge_flag[0])
                IGBT_on_Flag[0] <= 1'b1;
            else
                IGBT_on_Flag[0] <= 1'b0;			
	    end			
	    else begin           //未按按键1           
            if(Voltage_cap_flag[0] == 1'b1) begin      //
                IGBT_on_Flag[0]    <= 1'b0;
                IGBT_on_EN[0]      <= 1'b0;				
	        end	                   
            else if(!IGBT_on_EN[1])  begin                   
                IGBT_on_EN[0]      <= 1'b1;															
            end	                
        end    
	end
end

//按键2开启IGBT2，Vcap关断IGBT2，谐振电容1放电控制
always @(posedge sys_clk or negedge sys_rst_n) begin
    if (!sys_rst_n) begin
        IGBT_on_Flag[1]    <= 1'b0;
        IGBT_on_EN[1]      <= 1'b0;	
	end        
    else begin	    
		if(!IGBT_on_Flag[1]) begin
            if(CAP_discharge_flag[0])
                IGBT_on_Flag[1] <= 1'b1;
            else
                IGBT_on_Flag[1] <= 1'b0;			
	    end
	    else begin           //未按按键1           
            if(Voltage_cap_flag[0] == 1'b1) begin      //
                IGBT_on_Flag[1]    <= 1'b0;
                IGBT_on_EN[1]      <= 1'b0;				
	        end	                   
            else if(!IGBT_on_EN[0])begin 				  			
                IGBT_on_EN[1]      <= 1'b1;
            end	            
        end    
	end
end

//按键3开启IGBT3，Vcap关断IGBT3,谐振电容2小电流充电控制
always @(posedge sys_clk or negedge sys_rst_n) begin
    if (!sys_rst_n) begin
        IGBT_on_Flag[2]    <= 1'b0;
        IGBT_on_EN[2]      <= 1'b0;	
	end        
    else begin	      
		if(!IGBT_on_Flag[2]) begin
            if(CAP_charge_flag[1])
                IGBT_on_Flag[2] <= 1'b1;
            else
                IGBT_on_Flag[2] <= 1'b0;			
	    end
	    else begin           //未按按键1            
            if(Voltage_cap_flag[1] == 1'b1) begin      
                IGBT_on_Flag[2]    <= 1'b0;
                IGBT_on_EN[2]      <= 1'b0;	
                test1 <= ~test1;					
	        end	                   
            else if(!IGBT_on_EN[3]) begin 				 													 					
                IGBT_on_EN[2]      <= 1'b1;
	            test2 <= ~test2;
            end	           
        end    
	end
end

//按键2开启IGBT4，Vcap关断IGBT4,谐振电容2放电控制
always @(posedge sys_clk or negedge sys_rst_n) begin
    if (!sys_rst_n) begin
        IGBT_on_Flag[3]    <= 1'b0;
        IGBT_on_EN[3]      <= 1'b0;	
	end        
    else begin	   
		if(!IGBT_on_Flag[3]) begin
            if(CAP_discharge_flag[1])
                IGBT_on_Flag[3] <= 1'b1;
            else
                IGBT_on_Flag[3] <= 1'b0;			
	    end
	    else begin           //未按按键1           
            if(Voltage_cap_flag[1] == 1'b1) begin      //
                IGBT_on_Flag[3]    <= 1'b0;
                IGBT_on_EN[3]      <= 1'b0;				
	        end	                   
            else if(!IGBT_on_EN[2])begin 				  			
                IGBT_on_EN[3]      <= 1'b1;
            end	               
        end    
	end
end

//启IGBT5，Vcap关断IGBT5、谐振电容1小充电电控制
always @(posedge sys_clk or negedge sys_rst_n) begin
    if (!sys_rst_n) begin
        IGBT_on_Flag[4]    <= 1'b0;
        IGBT_on_EN[4]      <= 1'b0;	
	end        
    else begin	   
		if(!IGBT_on_Flag[4]) begin
            if(CAP_charge_flag[0])
                IGBT_on_Flag[4] <= 1'b1;
            else
                IGBT_on_Flag[4] <= 1'b0;			
	    end	
	    else begin           //未按按键1            
            if(Voltage_cap_flag[0] == 1'b1) begin      //
                IGBT_on_Flag[4]    <= 1'b0;
                IGBT_on_EN[4]      <= 1'b0;				
	        end	                   
            else 				  			
                IGBT_on_EN[4]      <= 1'b1;				  
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