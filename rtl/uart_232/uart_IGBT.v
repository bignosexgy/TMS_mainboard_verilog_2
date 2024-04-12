//****************************************Copyright (c)***********************************//
//原子哥在线教学平台：www.yuanzige.com
//技术支持：www.openedv.com
//淘宝店铺：http://openedv.taobao.com 
//关注微信公众平台微信号："正点原子"，免费获取ZYNQ & FPGA & STM32 & LINUX资料。
//版权所有，盗版必究。
//Copyright(C) 正点原子 2018-2028
//All rights reserved	                               
//----------------------------------------------------------------------------------------
// File name:           uart_loop
// Last modified Date:  2019/10/8 17:25:36
// Last Version:        V1.1
// Descriptions:        串口数据环回模块
//----------------------------------------------------------------------------------------
// Created by:          正点原子
// Created date:        2019/10/8 17:25:36
// Version:             V1.0
// Descriptions:        The original version
//
//----------------------------------------------------------------------------------------
//****************************************************************************************//

module uart_IGBT(
    input	            sys_clk,                   //系统时钟
    input               sys_rst_n,                 //系统复位，低电平有效
					    
    input               recv_done,                 //接收一帧数据完成标志
    input        [7:0]  recv_data,                 //接收的数据					    
	input               tx_busy,                   //发送忙状态标志      
    output reg          send_en,                   //发送使能信号
    output reg   [7:0]  send_data,                 //待发送数据			     
	output reg   [7:0]  Num_rx_data,               //接收到的有效数据长度
	output reg   [7:0]  rxdata_buff_0,             //frame header 1
    output reg   [7:0]  rxdata_buff_1,             //frame header 2
    output reg   [7:0]  rxdata_buff_2,             //num_rx_data
    output reg   [7:0]  rxdata_buff_3,             //work
    output reg   [7:0]  rxdata_buff_4,             //charge time h
    output reg   [7:0]  rxdata_buff_5,             //charge time m
    output reg   [7:0]  rxdata_buff_6,             //charge time l
    output reg   [7:0]  rxdata_buff_7,             //discharge time h
    output reg   [7:0]  rxdata_buff_8,             //discharge time m
    output reg   [7:0]  rxdata_buff_9,             //discharge time l
    output reg   [7:0]  rxdata_buff_10,            //check code h
    output reg   [7:0]  rxdata_buff_11,            //check code l   
	output reg   [7:0]  rxdata_buff_12,            //discharge time h
    output reg   [7:0]  rxdata_buff_13,            //discharge time m
    output reg   [7:0]  rxdata_buff_14,            //discharge time l
    output reg   [7:0]  rxdata_buff_15,            //check code h
    output reg   [7:0]  rxdata_buff_16,            //check code l  
	output reg   [7:0]  rxdata_buff_17,            //check code l  	
	output reg   [7:0]  Voltage_cap_set_1,         //脉冲功率，谐振电容1设置电压 
	output reg   [7:0]  Voltage_cap_set_2,         //脉冲功率，谐振电容2设置电压 
	output reg   [7:0]  Voltage_cap_set_3          //脉冲功率，支撑电容电容设置电压 
    );

//reg define
reg   recv_done_d0;
reg   recv_done_d1;
reg   tx_ready;
reg   Send_One_flag;
reg   rx_buff_flag;              //帧头第一个数据
//reg [1:0]  rx_buff_0_flag;            //帧头第二个数据
reg   rx_buff_1_flag;            //帧头第二个数据
reg   Sen_Group_en;
reg   [7:0]  wait_tx_busy_cnt;        //等待发送就绪延时        


reg   [7:0]  rx_data_cnt;              //接收数据计数 
reg   [7:0]  tx_data_cnt;             //发送数据计数
reg   [7:0]  txdata_buff_0;            //frame header 1
reg   [7:0]  txdata_buff_1;            //frame header 2
reg   [7:0]  txdata_buff_2;            //num_rx_data
reg   [7:0]  txdata_buff_3;            //work
reg   [7:0]  txdata_buff_4;            //charge time h
reg   [7:0]  txdata_buff_5;            //charge time m
reg   [7:0]  txdata_buff_6;            //charge time l
reg   [7:0]  txdata_buff_7;            //discharge time h
reg   [7:0]  txdata_buff_8;            //discharge time m
reg   [7:0]  txdata_buff_9;            //discharge time l
reg   [7:0]  txdata_buff_10;           //check code h
reg   [7:0]  txdata_buff_11;           //check code l
reg   [7:0]  txdata_buff_12;            //charge time m
reg   [7:0]  txdata_buff_13;            //charge time l
reg   [7:0]  txdata_buff_14;            //discharge time h
reg   [7:0]  txdata_buff_15;            //discharge time m
reg   [7:0]  txdata_buff_16;            //discharge time l
reg   [7:0]  txdata_buff_17;           //check code h
reg          recv_full_data_flag;      //接收完整的数据帧标志



//wire define
wire   recv_done_flag;





//*****************************************************
//**                    main code
//*****************************************************

//捕获recv_done上升沿，得到一个时钟周期的脉冲信号
assign recv_done_flag = (~recv_done_d1) & recv_done_d0;
                                                 
//对发送使能信号recv_done延迟两个时钟周期
always @(posedge sys_clk or negedge sys_rst_n) begin         
    if (!sys_rst_n) begin
        recv_done_d0 <= 1'b0;                                  
        recv_done_d1 <= 1'b0;
    end                                                      
    else begin                                               
        recv_done_d0 <= recv_done;                               
        recv_done_d1 <= recv_done_d0;                            
    end
end


always @ (rxdata_buff_5) begin
    case (rxdata_buff_5)
	    8'd1: begin
	         Voltage_cap_set_1 <= rxdata_buff_5;   
	    end
	    8'd2: begin
	         Voltage_cap_set_2 <= rxdata_buff_5;   
	    end
		8'd3: begin
	         Voltage_cap_set_3 <= rxdata_buff_5;   
	    end
        default
	        ;
	endcase	   
end



//判断接收完成信号，并在串口发送模块空闲时给出发送使能信号
always @(posedge sys_clk or negedge sys_rst_n) begin         
    if (!sys_rst_n) begin	
        rx_buff_1_flag      <= 1'b0;
		rx_buff_flag        <= 1'b0;
		rx_data_cnt         <= 8'd0;	
		recv_full_data_flag <= 1'b0;
		Num_rx_data         <= 8'd0;
    end                                                      
    else begin 
	    if(recv_done_flag) begin                 //检测串口接收到数据       
			//if (rx_buff_flag == 1'b0 ) begin	
			if (rx_buff_flag) begin			   
			    case(rx_data_cnt)
				    8'd2 :begin
				        rx_data_cnt     <= rx_data_cnt + 1'b1;   
					    rxdata_buff_2   <= recv_data;
					    Num_rx_data     <=  recv_data;	
                        txdata_buff_2   <= recv_data;						
				    end
				    8'd3 :begin
					    rxdata_buff_3   <= recv_data;	
                        txdata_buff_3   <= recv_data;
					    if((rx_data_cnt - 8'd2) == Num_rx_data) begin
						    recv_full_data_flag <= 1'b1;
							rx_data_cnt    <= 8'd0;
						    rx_buff_flag   <= 1'b0;
							rx_buff_1_flag <= 1'b0;
						end
				        else begin
						    rx_data_cnt    <= rx_data_cnt + 1'b1;					        
                        end							
				    end    
			        8'd4 :begin
				        rxdata_buff_4   <= recv_data;	
                        txdata_buff_4   <= recv_data;
					    if((rx_data_cnt - 8'd2) == Num_rx_data) begin
						    recv_full_data_flag <= 1'b1;
							rx_data_cnt    <= 8'd0;
						    rx_buff_flag   <= 1'b0;
							rx_buff_1_flag <= 1'b0;
						end
				        else begin
						    rx_data_cnt    <= rx_data_cnt + 1'b1;					        
                        end						
				    end
			        8'd5 :begin
				        rxdata_buff_5   <= recv_data;	
                        txdata_buff_5   <= recv_data;
					    if((rx_data_cnt - 8'd2) == Num_rx_data) begin
						    recv_full_data_flag <= 1'b1;
							rx_data_cnt    <= 8'd0;
						    rx_buff_flag   <= 1'b0;
							rx_buff_1_flag <= 1'b0;
						end
				        else begin
						    rx_data_cnt    <= rx_data_cnt + 1'b1;					        
                        end							
				    end
			        8'd6 :begin
				        rxdata_buff_6   <= recv_data;
                        txdata_buff_6  <= recv_data;						
						 if((rx_data_cnt - 8'd2) == Num_rx_data) begin
						    recv_full_data_flag <= 1'b1;
							rx_data_cnt    <= 8'd0;
						    rx_buff_flag   <= 1'b0;
							rx_buff_1_flag <= 1'b0;
						end
				        else begin
						    rx_data_cnt    <= rx_data_cnt + 1'b1;					        
                        end	
				    end
			        8'd7 :begin				        
					    rxdata_buff_7   <= recv_data; 
						txdata_buff_7  <= recv_data;
						 if((rx_data_cnt - 8'd2) == Num_rx_data) begin
						    recv_full_data_flag <= 1'b1;
							rx_data_cnt    <= 8'd0;
						    rx_buff_flag   <= 1'b0;
							rx_buff_1_flag <= 1'b0;
						end
				        else begin
						    rx_data_cnt    <= rx_data_cnt + 1'b1;					        
                        end	
				    end
			        8'd8 :begin				        
					    rxdata_buff_8   <= recv_data;	
                        txdata_buff_8  <= recv_data;  						
						 if((rx_data_cnt - 8'd2) == Num_rx_data) begin
						    recv_full_data_flag <= 1'b1;
							rx_data_cnt    <= 8'd0;
						    rx_buff_flag   <= 1'b0;
							rx_buff_1_flag <= 1'b0;
						end
				        else begin
						    rx_data_cnt    <= rx_data_cnt + 1'b1;					        
                        end	
				    end
			        8'd9 :begin				        
					    rxdata_buff_9   <= recv_data;	
                        txdata_buff_9  <= recv_data;						
						 if((rx_data_cnt - 8'd2) == Num_rx_data) begin
						    recv_full_data_flag <= 1'b1;
							rx_data_cnt    <= 8'd0;
						    rx_buff_flag   <= 1'b0;
							rx_buff_1_flag <= 1'b0;
						end
				        else begin
						    rx_data_cnt    <= rx_data_cnt + 1'b1;					        
                        end	
				    end
			        8'd10 :begin				        
					    rxdata_buff_10  <= recv_data;
                        txdata_buff_10  <= recv_data;						
						 if((rx_data_cnt - 8'd2) == Num_rx_data) begin
						    recv_full_data_flag <= 1'b1;
							rx_data_cnt    <= 8'd0;
						    rx_buff_flag   <= 1'b0;
							rx_buff_1_flag <= 1'b0;
						end
				        else begin
						    rx_data_cnt    <= rx_data_cnt + 1'b1;					        
                        end	
				    end
				    8'd11 :begin						        
					    rxdata_buff_11  <= recv_data;
                        txdata_buff_11  <= recv_data;						
						 if((rx_data_cnt - 8'd2) == Num_rx_data) begin
						    recv_full_data_flag <= 1'b1;
							rx_data_cnt    <= 8'd0;
						    rx_buff_flag   <= 1'b0;
							rx_buff_1_flag <= 1'b0;
						end
				        else begin
						    rx_data_cnt    <= rx_data_cnt + 1'b1;					        
                        end	
				    end
				    8'd12 :begin									        
					    rxdata_buff_12   <= recv_data;
                        txdata_buff_12  <= recv_data;
                        if((rx_data_cnt - 8'd2) == Num_rx_data) begin
						    recv_full_data_flag <= 1'b1;
							rx_data_cnt    <= 8'd0;
						    rx_buff_flag   <= 1'b0;
							rx_buff_1_flag <= 1'b0;
						end
				        else begin
						    rx_data_cnt    <= rx_data_cnt + 1'b1;					        
                        end							
				    end
			        8'd13 :begin				        
					    rxdata_buff_13   <= recv_data;	
                        txdata_buff_13  <= recv_data;						
						if((rx_data_cnt - 8'd2) == Num_rx_data) begin
						    recv_full_data_flag <= 1'b1;
							rx_data_cnt    <= 8'd0;
						    rx_buff_flag   <= 1'b0;
							rx_buff_1_flag <= 1'b0;
						end
				        else begin
						    rx_data_cnt    <= rx_data_cnt + 1'b1;					        
                        end		
				    end
			        8'd14 :begin				        
					    rxdata_buff_14   <= recv_data;
                        txdata_buff_14  <= recv_data;						
						if((rx_data_cnt - 8'd2) == Num_rx_data) begin
						    recv_full_data_flag <= 1'b1;
							rx_data_cnt    <= 8'd0;
						    rx_buff_flag   <= 1'b0;
							rx_buff_1_flag <= 1'b0;
						end
				        else begin
						    rx_data_cnt    <= rx_data_cnt + 1'b1;					        
                        end		
				    end
			        8'd15 :begin				        
					    rxdata_buff_15  <= recv_data;
                        txdata_buff_15  <= recv_data;						
						if((rx_data_cnt - 8'd2) == Num_rx_data) begin
						    recv_full_data_flag <= 1'b1;
							rx_data_cnt    <= 8'd0;
						    rx_buff_flag   <= 1'b0;
							rx_buff_1_flag <= 1'b0;
						end
				        else begin
						    rx_data_cnt    <= rx_data_cnt + 1'b1;					        
                        end		
				    end
				    8'd16 :begin				        
					    rxdata_buff_16  <= recv_data;
                        txdata_buff_16  <= recv_data;						
						if((rx_data_cnt - 8'd2) == Num_rx_data) begin
						    recv_full_data_flag <= 1'b1;
							rx_data_cnt    <= 8'd0;
						    rx_buff_flag   <= 1'b0;
							rx_buff_1_flag <= 1'b0;
						end
				        else begin
						    rx_data_cnt    <= rx_data_cnt + 1'b1;					        
                        end		
				    end
				    8'd17 :begin				        
					    rxdata_buff_17  <= recv_data;	
                        txdata_buff_17  <= recv_data;	                        					
						if((rx_data_cnt - 8'd2) == Num_rx_data) begin
						    recv_full_data_flag <= 1'b1;
							rx_data_cnt    <= 8'd0;
						    rx_buff_flag   <= 1'b0;
							rx_buff_1_flag <= 1'b0;
						end
				        else begin
						    rx_data_cnt    <= rx_data_cnt + 1'b1;					        
                        end		
				    end
				    default:begin
				        rx_data_cnt    <= 8'd0;
						rx_buff_flag   <= 1'b0;
				    end	
                endcase				   
			end				
			else if (rx_buff_1_flag == 1'b1 ) begin			
                if(recv_data == 16'hFA) begin
				    rx_buff_1_flag <= 1'b0;
                    rx_buff_flag   <= 1'b1;
					rx_data_cnt    <= rx_data_cnt + 1'b1;
		            rxdata_buff_1  <= recv_data;	
					txdata_buff_1  <= recv_data;
					recv_full_data_flag <= 1'b0;
				end
                else begin
                    rx_buff_1_flag <= 1'b0;
		            rx_buff_flag <= 1'b0;
		            rx_data_cnt   <= 8'd0;					 				
				end				  
			end		
		
			else if(recv_data == 16'hAF)begin
			        rx_buff_1_flag <= 1'b1;  
                    rx_data_cnt    <= 8'd1; 					
				    rxdata_buff_0  <= recv_data;
					txdata_buff_0  <= recv_data;					
			end			
			else begin
			        rx_buff_1_flag <= 1'b0;
				    rx_buff_flag   <= 1'b0;
				    rx_data_cnt    <= 8'd0;	                   				  
			end	
			
        end	
        else if(recv_full_data_flag == 1'b1)	begin
            rx_buff_flag   <= 1'b0;
			rx_data_cnt <= 8'd0;
			recv_full_data_flag <= 1'b0;
		end	
        else ;    		
    end		
    //else; 		
end

//给发送缓冲数据赋值，在串口发送模块空闲时给出发送使能信号
always @(posedge sys_clk or negedge sys_rst_n) begin         
    if (!sys_rst_n) begin
        tx_ready  <= 1'b0; 
        send_en   <= 1'b0;
        send_data <= 8'd0;
		tx_data_cnt <= 8'd0;
    end                                                      
    else begin                                               
        //if(rx_data_cnt == 8'd18)begin                 //检测串口接收到数据
		if(recv_full_data_flag == 1'b1)begin                 //检测串口接收到数据
            Send_One_flag <= 1;
			Sen_Group_en <= 1;			
        end
		else if (Sen_Group_en) begin
		    if(tx_data_cnt <= Num_rx_data + 8'd2)begin          //测试
		    case(tx_data_cnt)
                8'd0 :begin
			        if(Send_One_flag && (~tx_busy)) begin
			            tx_ready <= 1'b1;                   //准备过程结束
                        send_en  <= 1'b0; 
                        send_data <= txdata_buff_0;							
                        Send_One_flag <= 1'b0;	
                        wait_tx_busy_cnt <= 8'd0;						
			 	    end
			 	    else if(tx_ready && (~tx_busy)) begin   //检测串口发送模块空闲
			 	        send_en  <= 1'b1; 
						wait_tx_busy_cnt <= wait_tx_busy_cnt + 1'b1;
						if(wait_tx_busy_cnt >= 8'd2) begin
						    tx_ready <= 1'b0;                   //准备过程结束						    
						    Send_One_flag <= 1'b1;	
                            tx_data_cnt <= tx_data_cnt+1'b1;
						    wait_tx_busy_cnt <= 8'd0;
						end						
			 	    end
			 	    else begin
			            tx_data_cnt <= tx_data_cnt;												
					end	
			    end	
			    8'd1 :begin
			        if(Send_One_flag && (~tx_busy)) begin
			            tx_ready <= 1'b1;                   //准备过程结束
                        send_en  <= 1'b0; 
                        send_data <= txdata_buff_1;						
                        Send_One_flag <= 1'b0;		
                        wait_tx_busy_cnt <= 8'd0;  						
			 	    end  
					else if(tx_ready && (~tx_busy)) begin   //检测串口发送模块空闲
			 	        send_en  <= 1'b1; 
						wait_tx_busy_cnt <= wait_tx_busy_cnt + 1'b1;
						if(wait_tx_busy_cnt >= 8'd2) begin
						    tx_ready <= 1'b0;                   //准备过程结束						    
						    Send_One_flag <= 1'b1;	
                            tx_data_cnt <= tx_data_cnt+1'b1;
						    wait_tx_busy_cnt <= 1'b0;
						end						
			 	    end					
					else begin
			            tx_data_cnt <= tx_data_cnt;                        					
                    end						
			    end  
	
			    8'd2 :begin
			        if(Send_One_flag && (~tx_busy)) begin
			            tx_ready <= 1'b1;                   //准备过程结束
                        send_en  <= 1'b0; 
                        send_data <= txdata_buff_2;							
                        Send_One_flag <= 1'b0;	
                        wait_tx_busy_cnt <= 8'd0;						
			 	    end
			 	    else if(tx_ready && (~tx_busy)) begin   //检测串口发送模块空闲
			 	        send_en  <= 1'b1; 
						wait_tx_busy_cnt <= wait_tx_busy_cnt + 1'b1;
						if(wait_tx_busy_cnt >= 8'd2) begin
						    tx_ready <= 1'b0;                   //准备过程结束						    
						    Send_One_flag <= 1'b1;	
                            tx_data_cnt <= tx_data_cnt+1'b1;
						    wait_tx_busy_cnt <= 1'b0;
						end						
			 	    end					
					else begin
			            tx_data_cnt <= tx_data_cnt;                        					
                    end		
			    end
				
			    8'd3 :begin
			        if(Send_One_flag && (~tx_busy)) begin
			            tx_ready <= 1'b1;                   //准备过程结束
                        send_en  <= 1'b0; 
                        send_data <= txdata_buff_3;							
                        Send_One_flag <= 1'b0;	
                        wait_tx_busy_cnt <= 8'd0;						
			 	    end
			 	    else if(tx_ready && (~tx_busy)) begin   //检测串口发送模块空闲
			 	        send_en  <= 1'b1; 
						wait_tx_busy_cnt <= wait_tx_busy_cnt + 1'b1;
						if(wait_tx_busy_cnt >= 8'd2) begin
						    tx_ready <= 1'b0;                   //准备过程结束						    
						    Send_One_flag <= 1'b1;	
                            tx_data_cnt <= tx_data_cnt+1'b1;
						    wait_tx_busy_cnt <= 1'b0;
						end						
			 	    end					
					else begin
			            tx_data_cnt <= tx_data_cnt;                        					
                    end				   
			    end
				
			    8'd4 :begin
			        if(Send_One_flag && (~tx_busy)) begin
			            tx_ready <= 1'b1;                   //准备过程结束
                        send_en  <= 1'b0; 
                        send_data <= txdata_buff_4;							
                        Send_One_flag <= 1'b0;	
                        wait_tx_busy_cnt <= 8'd0;						
			 	    end
			 	    else if(tx_ready && (~tx_busy)) begin   //检测串口发送模块空闲
			 	        send_en  <= 1'b1; 
						wait_tx_busy_cnt <= wait_tx_busy_cnt + 1'b1;
						if(wait_tx_busy_cnt >= 8'd2) begin
						    tx_ready <= 1'b0;                   //准备过程结束						    
						    Send_One_flag <= 1'b1;	
                            tx_data_cnt <= tx_data_cnt+1'b1;
						    wait_tx_busy_cnt <= 1'b0;
						end						
			 	    end					
					else begin
			            tx_data_cnt <= tx_data_cnt;                        					
                    end			   
			    end
			    8'd5 :begin
			       if(Send_One_flag && (~tx_busy)) begin
			            tx_ready <= 1'b1;                   //准备过程结束
                        send_en  <= 1'b0; 
                        send_data <= txdata_buff_5;							
                        Send_One_flag <= 1'b0;
                        wait_tx_busy_cnt <= 8'd0;						
			 	  end
			 	  else if(tx_ready && (~tx_busy)) begin   //检测串口发送模块空闲
			 	        send_en  <= 1'b1; 
						wait_tx_busy_cnt <= wait_tx_busy_cnt + 1'b1;
						if(wait_tx_busy_cnt >= 8'd2) begin
						    tx_ready <= 1'b0;                   //准备过程结束						    
						    Send_One_flag <= 1'b1;	
                            tx_data_cnt <= tx_data_cnt+1'b1;
						    wait_tx_busy_cnt <= 1'b0;
						end						
			 	    end					
					else begin
			            tx_data_cnt <= tx_data_cnt;                        					
                    end		
			    end
					
			    8'd6 :begin
			       if(Send_One_flag && (~tx_busy)) begin
			            tx_ready <= 1'b1;                   //准备过程结束
                        send_en  <= 1'b0; 
                        send_data <= txdata_buff_6;							
                        Send_One_flag <= 1'b0;	
                        wait_tx_busy_cnt <= 8'd0; 						
			 	  end
			 	  else if(tx_ready && (~tx_busy)) begin   //检测串口发送模块空闲
			 	        send_en  <= 1'b1; 
						wait_tx_busy_cnt <= wait_tx_busy_cnt + 1'b1;
						if(wait_tx_busy_cnt >= 8'd2) begin
						    tx_ready <= 1'b0;                   //准备过程结束						    
						    Send_One_flag <= 1'b1;	
                            tx_data_cnt <= tx_data_cnt+1'b1;
						    wait_tx_busy_cnt <= 1'b0;
						end						
			 	    end					
					else begin
			            tx_data_cnt <= tx_data_cnt;                        					
                    end				   
			    end
			    8'd7 :begin
			       if(Send_One_flag && (~tx_busy)) begin
			            tx_ready <= 1'b1;                   //准备过程结束
                        send_en  <= 1'b0; 
                        send_data <= txdata_buff_7;							
                        Send_One_flag <= 1'b0;	
                        wait_tx_busy_cnt <= 8'd0;						
			 	  end
			 	  else if(tx_ready && (~tx_busy)) begin   //检测串口发送模块空闲
			 	        send_en  <= 1'b1; 
						wait_tx_busy_cnt <= wait_tx_busy_cnt + 1'b1;
						if(wait_tx_busy_cnt >= 8'd2) begin
						    tx_ready <= 1'b0;                   //准备过程结束						    
						    Send_One_flag <= 1'b1;	
                            tx_data_cnt <= tx_data_cnt+1'b1;
						    wait_tx_busy_cnt <= 1'b0;
						end						
			 	    end					
					else begin
			            tx_data_cnt <= tx_data_cnt;                        					
                    end		   
			    end
				
			    8'd8 :begin
			       if(Send_One_flag && (~tx_busy)) begin
			            tx_ready <= 1'b1;                   //准备过程结束
                        send_en  <= 1'b0; 
                        send_data <= txdata_buff_8;	                        
                        Send_One_flag <= 1'b0;	
                        wait_tx_busy_cnt <= 8'd0;						
			 	  end
			 	  else if(tx_ready && (~tx_busy)) begin   //检测串口发送模块空闲
			 	        send_en  <= 1'b1; 
						wait_tx_busy_cnt <= wait_tx_busy_cnt + 1'b1;
						if(wait_tx_busy_cnt >= 8'd2) begin
						    tx_ready <= 1'b0;                   //准备过程结束						    
						    Send_One_flag <= 1'b1;	
                            tx_data_cnt <= tx_data_cnt+1'b1;
						    wait_tx_busy_cnt <= 1'b0;
						end						
			 	    end					
					else begin
			            tx_data_cnt <= tx_data_cnt;                        					
                    end			   
			    end
			    8'd9 :begin
			       if(Send_One_flag && (~tx_busy)) begin
			            tx_ready      <= 1'b1;                   //准备过程结束
                        send_en       <= 1'b0; 
                        send_data     <= txdata_buff_9;							
                        Send_One_flag <= 1'b0;	
                        wait_tx_busy_cnt <= 8'd0;						
			 	  end
			 	  else if(tx_ready && (~tx_busy)) begin   //检测串口发送模块空闲
			 	        send_en  <= 1'b1; 
						wait_tx_busy_cnt <= wait_tx_busy_cnt + 1'b1;
						if(wait_tx_busy_cnt >= 8'd2) begin
						    tx_ready <= 1'b0;                   //准备过程结束						    
						    Send_One_flag <= 1'b1;	
                            tx_data_cnt <= tx_data_cnt+1'b1;
						    wait_tx_busy_cnt <= 1'b0;
						end						
			 	    end					
					else begin
			            tx_data_cnt <= tx_data_cnt;                        					
                    end			   
			    end                 			  			
                8'd10 :begin
			       if(Send_One_flag && (~tx_busy)) begin
			            tx_ready      <= 1'b1;                   //准备过程结束
                        send_en       <= 1'b0; 
                        send_data     <= txdata_buff_10;						
                        Send_One_flag <= 1'b0;	
                        wait_tx_busy_cnt <= 8'd0;						
			 	  end
			 	  else if(tx_ready && (~tx_busy)) begin   //检测串口发送模块空闲
			 	        send_en  <= 1'b1; 
						wait_tx_busy_cnt <= wait_tx_busy_cnt + 1'b1;
						if(wait_tx_busy_cnt >= 8'd2) begin
						    tx_ready <= 1'b0;                   //准备过程结束						    
						    Send_One_flag <= 1'b1;	
                            tx_data_cnt <= tx_data_cnt+1'b1;
						    wait_tx_busy_cnt <= 1'b0;
						end						
			 	    end					
					else begin
			            tx_data_cnt <= tx_data_cnt;                        					
                    end			   
			    end
					
			    8'd11 :begin
			       if(Send_One_flag && (~tx_busy)) begin
			            tx_ready      <= 1'b1;                   //准备过程结束
                        send_en       <= 1'b0; 
                        send_data     <= txdata_buff_11;						
                        Send_One_flag <= 1'b0;	
                        wait_tx_busy_cnt <= 8'd0;						
			 	  end
			 	  else if(tx_ready && (~tx_busy)) begin   //检测串口发送模块空闲
			 	        send_en  <= 1'b1; 
						wait_tx_busy_cnt <= wait_tx_busy_cnt + 1'b1;
						if(wait_tx_busy_cnt >= 8'd2) begin
						    tx_ready <= 1'b0;                   //准备过程结束						    
						    Send_One_flag <= 1'b1;	
                            tx_data_cnt <= tx_data_cnt+1'b1;
						    wait_tx_busy_cnt <= 1'b0;
						end						
			 	    end					
					else begin
			            tx_data_cnt <= tx_data_cnt;                        					
                    end		   
			    end
			    8'd12 :begin
			       if(Send_One_flag && (~tx_busy)) begin
			            tx_ready      <= 1'b1;                   //准备过程结束
                        send_en       <= 1'b0; 
                        send_data     <= txdata_buff_12;						
                        Send_One_flag <= 1'b0;	
                        wait_tx_busy_cnt <= 8'd0; 						
			 	  end
			 	  else if(tx_ready && (~tx_busy)) begin   //检测串口发送模块空闲
			 	        send_en  <= 1'b1; 
						wait_tx_busy_cnt <= wait_tx_busy_cnt + 1'b1;
						if(wait_tx_busy_cnt >= 8'd2) begin
						    tx_ready <= 1'b0;                   //准备过程结束						    
						    Send_One_flag <= 1'b1;	
                            tx_data_cnt <= tx_data_cnt+1'b1;
						    wait_tx_busy_cnt <= 1'b0;
						end						
			 	    end					
					else begin
			            tx_data_cnt <= tx_data_cnt;                        					
                    end		  
			    end
			    8'd13 :begin
			       if(Send_One_flag && (~tx_busy)) begin
			            tx_ready      <= 1'b1;                   //准备过程结束
                        send_en       <= 1'b0; 
                        send_data     <= txdata_buff_13;						
                        Send_One_flag <= 1'b0;	
                        wait_tx_busy_cnt <= 8'd0; 						
			 	  end
			 	  else if(tx_ready && (~tx_busy)) begin   //检测串口发送模块空闲
			 	        send_en  <= 1'b1; 
						wait_tx_busy_cnt <= wait_tx_busy_cnt + 1'b1;
						if(wait_tx_busy_cnt >= 8'd2) begin
						    tx_ready <= 1'b0;                   //准备过程结束						    
						    Send_One_flag <= 1'b1;	
                            tx_data_cnt <= tx_data_cnt+1'b1;
						    wait_tx_busy_cnt <= 1'b0;
						end						
			 	    end					
					else begin
			            tx_data_cnt <= tx_data_cnt;                        					
                    end			   
			    end
			    8'd14 :begin
			       if(Send_One_flag && (~tx_busy)) begin
			            tx_ready      <= 1'b1;                   //准备过程结束
                        send_en       <= 1'b0; 
                        send_data     <= txdata_buff_14;						
                        Send_One_flag <= 1'b0;	
                        wait_tx_busy_cnt <= 8'd0;						
			 	  end
			 	  else if(tx_ready && (~tx_busy)) begin   //检测串口发送模块空闲
			 	        send_en  <= 1'b1; 
						wait_tx_busy_cnt <= wait_tx_busy_cnt + 1'b1;
						if(wait_tx_busy_cnt >= 8'd2) begin
						    tx_ready <= 1'b0;                   //准备过程结束						    
						    Send_One_flag <= 1'b1;	
                            tx_data_cnt <= tx_data_cnt+1'b1;
						    wait_tx_busy_cnt <= 1'b0;
						end						
			 	    end					
					else begin
			            tx_data_cnt <= tx_data_cnt;                        					
                    end		   
			    end
			    8'd15 :begin
			       if(Send_One_flag && (~tx_busy)) begin
			            tx_ready      <= 1'b1;                   //准备过程结束
                        send_en       <= 1'b0; 
                        send_data     <= txdata_buff_15;						
                        Send_One_flag <= 1'b0;	
                        wait_tx_busy_cnt <= 8'd0; 						
			 	  end
			 	  else if(tx_ready && (~tx_busy)) begin   //检测串口发送模块空闲
			 	        send_en  <= 1'b1; 
						wait_tx_busy_cnt <= wait_tx_busy_cnt + 1'b1;
						if(wait_tx_busy_cnt >= 8'd2) begin
						    tx_ready <= 1'b0;                   //准备过程结束						    
						    Send_One_flag <= 1'b1;	
                            tx_data_cnt <= tx_data_cnt+1'b1;
						    wait_tx_busy_cnt <= 1'b0;
						end						
			 	    end					
					else begin
			            tx_data_cnt <= tx_data_cnt;                        					
                    end			   
			    end
			    8'd16 :begin
			       if(Send_One_flag && (~tx_busy)) begin
			            tx_ready      <= 1'b1;                   //准备过程结束
                        send_en       <= 1'b0; 
                        send_data     <= txdata_buff_16;							
                        Send_One_flag <= 1'b0;	
                        wait_tx_busy_cnt <= 8'd0;						
			 	  end
			 	  else if(tx_ready && (~tx_busy)) begin   //检测串口发送模块空闲
			 	        send_en  <= 1'b1; 
						wait_tx_busy_cnt <= wait_tx_busy_cnt + 1'b1;
						if(wait_tx_busy_cnt >= 8'd2) begin
						    tx_ready <= 1'b0;                   //准备过程结束						    
						    Send_One_flag <= 1'b1;	
                            tx_data_cnt <= tx_data_cnt+1'b1;
						    wait_tx_busy_cnt <= 1'b0;
						end						
			 	    end					
					else begin
			            tx_data_cnt <= tx_data_cnt;                        					
                    end		   
			    end
			    8'd17 :begin
			       if(Send_One_flag && (~tx_busy)) begin
			            tx_ready      <= 1'b1;                   //准备过程结束
                        send_en       <= 1'b0; 
                        send_data     <= txdata_buff_17;						
                        Send_One_flag <= 1'b0;	
                        wait_tx_busy_cnt <= 8'd0;						
			 	  end
			 	  else if(tx_ready && (~tx_busy)) begin   //检测串口发送模块空闲
			 	        send_en  <= 1'b1; 
						wait_tx_busy_cnt <= wait_tx_busy_cnt + 1'b1;
						if(wait_tx_busy_cnt >= 8'd2) begin
						    tx_ready <= 1'b0;                   //准备过程结束						    
						    Send_One_flag <= 1'b1;	
                            tx_data_cnt <= tx_data_cnt+1'b1;
						    wait_tx_busy_cnt <= 1'b0;
						end						
			 	    end					
					else begin
			            tx_data_cnt <= tx_data_cnt;                        					
                    end			   
			    end	
				
			    default:begin
			        tx_data_cnt      <= 8'd0;
			 	    Sen_Group_en     <= 1'b0;
			    end		
            endcase 
			end
            else  begin
                tx_data_cnt      <= 8'd0;
			 	Sen_Group_en     <= 1'b0;
			end			
		end		
		else 
		    tx_data_cnt <= 8'd0;
	
	end
	
end


endmodule 