//****************************************Copyright (c)***********************************//
//原子哥在线教学平台：www.yuanzige.com
//技术支持：www.openedv.com
//淘宝店铺：http://openedv.taobao.com 
//关注微信公众平台微信号："正点原子"，免费获取ZYNQ & FPGA & STM32 & LINUX资料。
//版权所有，盗版必究。
//Copyright(C) 正点原子 2018-2028
//All rights reserved	                               
//----------------------------------------------------------------------------------------
// File name:           uart_message_upload
// Last modified Date:  2019/10/8 17:25:36
// Last Version:        V1.1
// Descriptions:        主机状态上传
//----------------------------------------------------------------------------------------
// Created by:          xgy
// Created date:        2019/10/8 17:25:36
// Version:             V1.0
// Descriptions:        The original version
//
//----------------------------------------------------------------------------------------
//****************************************************************************************//

module uart_message_upload(
    input	            sys_clk,                   //系统时钟
    input               sys_rst_n,                 //系统复位，低电平有效					    


    inout               uart_send_busy_flag,       //串口竞争
 	    
	input               tx_busy,                   //发送忙状态标志      
    output reg          send_en,                   //发送使能信号
    output reg   [7:0]  send_data_gg                  //待发送数据	
	

    );

//reg define

reg   tx_ready;
reg   Send_One_flag;
reg   Sen_Group_en;
reg   [7:0]  wait_tx_busy_cnt;        //等待发送就绪延时   
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


reg   [31:0] tx_message_cnt;

//wire define
wire   recv_done_flag;





//*****************************************************
//**                    main code
//*****************************************************

//捕获recv_done上升沿，得到一个时钟周期的脉冲信号
//assign recv_done_flag = (~recv_done_d1) & recv_done_d0;
                                                 
//间隔1S上传一次信息
always @(posedge sys_clk or negedge sys_rst_n) begin         
    if (!sys_rst_n) begin
        tx_message_cnt <= 32'd0;                                  
    end                                                      
    else if (tx_message_cnt < 32'd5000_0000)        //1s
        tx_message_cnt <= tx_message_cnt + 1'b1;
    else
        tx_message_cnt <= 32'd0;
end




//判断接收完成一帧信号，并在串口发送模块空闲时给出发送使能信号
always @(posedge sys_clk or negedge sys_rst_n) begin         
    if (!sys_rst_n) begin
        tx_ready  <= 1'b0; 
        send_en   <= 1'b0;
        send_data_gg <= 8'd0;
		tx_data_cnt <= 8'd0;
    end                                                      
    else begin                                               
        if(tx_message_cnt == 32'd5000_0000)begin                 //检测串口接收到数据
            Send_One_flag <= 1;
			Sen_Group_en <= 1;            			
        end
		else if (Sen_Group_en) begin
		    case(tx_data_cnt)
                8'd0 :begin
			        if(Send_One_flag && (~tx_busy)) begin
			            tx_ready <= 1'b1;                   //准备过程结束
                        send_en  <= 1'b0; 
                        send_data_gg <= 8'hAF;							
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
                        send_data_gg <= 8'hFA;						
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
                        send_data_gg <= 8'h55;							
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
		else 
		    tx_data_cnt <= 8'd0;
	
	end
	
end


endmodule 