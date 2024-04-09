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
    input	         sys_clk,                   //系统时钟
    input            sys_rst_n,                 //系统复位，低电平有效
     
    input            recv_done,                 //接收一帧数据完成标志
    input      [7:0] recv_data,                 //接收的数据
     
    input            tx_busy,                   //发送忙状态标志      
    output reg       send_en,                   //发送使能信号
    output reg [7:0] send_data,                  //待发送数据
	output reg [7:0]  Num_rx_data               //接收到的有效数据长度
    );

//reg define
reg recv_done_d0;
reg recv_done_d1;
reg tx_ready;

reg   [7:0]  rxdata_buff_0;            //frame header 1
reg   [7:0]  rxdata_buff_1;            //frame header 2
reg   [7:0]  rxdata_buff_2;//num_rx_data
reg   [7:0]  rxdata_buff_3;//work
reg   [7:0]  rxdata_buff_4;//charge time h
reg   [7:0]  rxdata_buff_5;//charge time m
reg   [7:0]  rxdata_buff_6;//charge time l
reg   [7:0]  rxdata_buff_7;//discharge time h
reg   [7:0]  rxdata_buff_8;//discharge time m
reg   [7:0]  rxdata_buff_9;//discharge time l
reg   [7:0]  rxdata_buff_10;//check code h
reg   [7:0]  rxdata_buff_11;//check code l
reg   [7:0]  rxdata_buff_12;

reg  [3:0]           Num_data_cnt;              //接收到的实际有效数据 

//wire define
wire   recv_done_flag;
wire   rx_buff_flag;              //帧头第一个数据
wire   rx_buff_1_flag;            //帧头第二个数据

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

//判断接收完成信号，并在串口发送模块空闲时给出发送使能信号
always @(posedge sys_clk or negedge sys_rst_n) begin         
    if (!sys_rst_n) begin
        tx_ready  <= 1'b0; 
        send_en   <= 1'b0;
        send_data <= 8'd0;
    end                                                      
    else begin                                               
        if(recv_done_flag)begin                 //检测串口接收到数据
            if (rx_buff_flag == 1 ) begin			   
			    case （Num_data_cnt）
				   4'd0 :begin
				      Num_data_cnt    <= Num_data_cnt + 1'b1;
					  rxdata_buff_2   <= recv_data;
					  Num_rx_data     <=  recv_data;				   
				   end
				   4'd1 :begin
				      Num_data_cnt    <= Num_data_cnt + 1'b1;
					  rxdata_buff_3   <= recv_data;			   
				   end    
			       4'd2 :begin
				      Num_data_cnt    <= Num_data_cnt + 1'b1;
					  rxdata_buff_4   <= recv_data;				   
				   end
			       4'd3 :begin
				      Num_data_cnt    <= Num_data_cnt + 1'b1;
					  rxdata_buff_5   <= recv_data;				   
				   end
			       4'd4 :begin
				      Num_data_cnt    <= Num_data_cnt + 1'b1;
					  rxdata_buff_6   <= recv_data;				   
				   end
			       4'd5 :begin
				      Num_data_cnt    <= Num_data_cnt + 1'b1;
					  rxdata_buff_7   <= recv_data; 
				   end
			       4'd6 :begin
				      Num_data_cnt    <= Num_data_cnt + 1'b1;
					  rxdata_buff_8   <= recv_data;			   
				   end
			       4'd7 :begin
				      Num_data_cnt    <= Num_data_cnt + 1'b1;
					  rxdata_buff_9   <= recv_data;			   
				   end
			       4'd8 :begin
				      Num_data_cnt    <= Num_data_cnt + 1'b1;
					  rxdata_buff_10  <= recv_data;			   
				   end
				   4'd9 :begin
				      Num_data_cnt    <= Num_data_cnt + 1'b1;
					  rxdata_buff_11  <= recv_data;			   
				   end
				   default:begin
				      Num_data_cnt    <= 1'b0;
				   end				
			end
			else begin
			   if (rx_buff_1_flag == 1'b1 ) begin
                  if(recv_data == 16'hFA) begin
                     rx_buff_flag   <= 1'b0;
					 rxdata_buff_1  <= recv_data;			   
				  end
                  else begin
                     rx_buff_1_flag <= 1'b0;
					 rx_buff_0_flag <= 1'b0;
					 Num_data_cnt   <= 1'b0;					 				
				  end				  
			   end			   
			   else if(recv_data == 16'hAF)begin
			      rx_buff_1_flag <= 1'b1;   
				  rxdata_buff_0  <= recv_data;			   
			   end
			   else begin
			      rx_buff_1_flag <= 1'b0;
				  rx_buff_0_flag <= 1'b0;
				  Num_data_cnt   <= 1'b0;	                   				  
			   end
			end					
        end		
        else ; 		
    end
end

endmodule 