//****************************************Copyright (c)***********************************//
//原子哥在线教学平台：www.yuanzige.com
//技术支持：www.openedv.com
//淘宝店铺：http://openedv.taobao.com 
//关注微信公众平台微信号："正点原子"，免费获取ZYNQ & FPGA & STM32 & LINUX资料。
//版权所有，盗版必究。
//Copyright(C) 正点原子 2018-2028
//All rights reserved	                               
//----------------------------------------------------------------------------------------
// File name:           uart_loopback_top
// Last modified Date:  2019/10/9 9:56:36
// Last Version:        V1.0
// Descriptions:        开发板通过串口接收PC发送的字符，然后将收到的字符发送给PC
//----------------------------------------------------------------------------------------
// Created by:          正点原子
// Created date:        2019/10/9 9:56:36
// Version:             V1.0
// Descriptions:        The original version
//
//----------------------------------------------------------------------------------------
//****************************************************************************************//

module dev_board_top(
    input           sys_clk,            //外部50M时钟
    input           sys_rst_n,          //外部复位信号，低有效

    input           uart_rxd,           //UART接收端口
    output          uart_txd,            //UART发送端口
	 
	 output    [3:0]  led,         //4个LED灯
	 input     [3:0]  key,          //4个按键
	 
	//////////////////////////rtc_seg_led begin
    //按键
    //input                key,         //输入按键KEY0
    
    //数码管
    output        [5:0]  seg_sel,     //数码管位选信号
    output        [7:0]  seg_led,     //数码管段选信号
    
    //RTC实时时钟
    output               iic_scl,     //RTC的时钟线scl
    inout                iic_sda      //RTC的数据线sda   
   //output
   //output  reg  [5:0]     seg_sel,        // 数码管位选
  // output  reg  [7:0]     seg_led         // 数码管段选
    );
	
	//////////////////////////rtc_seg_led end

//parameter define
parameter  CLK_FREQ = 50000000;         //定义系统时钟频率
parameter  UART_BPS = 9600;           //定义串口波特率

//////////////////////////rtc_seg_led 
parameter    SLAVE_ADDR = 7'b101_0001   ; //器件地址(SLAVE_ADDR)
parameter    BIT_CTRL   = 1'b0          ; //字地址位控制参数(16b/8b)
//parameter    CLK_FREQ   = 26'd50_000_000; //i2c_dri模块的驱动时钟频率(CLK_FREQ)
parameter    I2C_FREQ   = 18'd250_000   ; //I2C的SCL时钟频率
parameter    TIME_INIT  = 48'h20_04_01_09_30_00;//初始时间

    
//wire define   
wire       uart_recv_done;              //UART接收完成
wire [7:0] uart_recv_data;              //UART接收数据
wire       uart_send_en;                //UART发送使能
wire [7:0] uart_send_data;              //UART发送数据
wire       uart_tx_busy;                //UART发送忙状态标志
wire [3:0] led_state;                   //led将要改变的状态
wire [3:0] key_push;  					//按键当前状态


//////////////////////////rtc_seg_led begin
wire          dri_clk   ;   //I2C操作时钟
wire          i2c_exec  ;   //I2C触发控制
wire  [15:0]  i2c_addr  ;   //I2C操作地址
wire  [ 7:0]  i2c_data_w;   //I2C写入的数据
wire          i2c_done  ;   //I2C操作结束标志
wire          i2c_ack   ;   //I2C应答标志 0:应答 1:未应答
wire          i2c_rh_wl ;   //I2C读写控制
wire  [ 7:0]  i2c_data_r;   //I2C读出的数据

wire    [7:0]  sec      ;   //秒
wire    [7:0]  min      ;   //分
wire    [7:0]  hour     ;   //时
wire    [7:0]  day      ;   //日
wire    [7:0]  mon      ;   //月
wire    [7:0]  year     ;   //年

wire           key_value;   //消抖后的按键值
wire    [5:0]  point    ;   //数码管小数点控制
wire    [23:0] disp_data;   //数码管显示的数值控制

//////////////////////////rtc_seg_led end




//*****************************************************
//**                    main code
//*****************************************************

//串口接收模块     
uart_recv #(                          
    .CLK_FREQ       (CLK_FREQ),         //设置系统时钟频率
    .UART_BPS       (UART_BPS))         //设置串口接收波特率
u_uart_recv(                 
    .sys_clk        (sys_clk), 
    .sys_rst_n      (sys_rst_n),
    
    .uart_rxd       (uart_rxd),
    .uart_done      (uart_recv_done),
    .uart_data      (uart_recv_data)
    );

//串口发送模块    
uart_send #(                          
    .CLK_FREQ       (CLK_FREQ),         //设置系统时钟频率
    .UART_BPS       (UART_BPS))         //设置串口发送波特率
u_uart_send(                 
    .sys_clk        (sys_clk),
    .sys_rst_n      (sys_rst_n),
     
    .uart_en        (uart_send_en),
    .uart_din       (uart_send_data),
    .uart_tx_busy   (uart_tx_busy),
    .uart_txd       (uart_txd)
    );
    
//串口环回模块    
uart_loop u_uart_loop(
    .sys_clk        (sys_clk),             
    .sys_rst_n      (sys_rst_n),           
   
    .recv_done      (uart_recv_done),   //接收一帧数据完成标志信号
    .recv_data      (uart_recv_data),   //接收的数据
   
    .tx_busy        (uart_tx_busy),     //发送忙状态标志      
    .send_en        (uart_send_en),     //发送使能信号
    .send_data      (uart_send_data)    //待发送数据
    );
	 
//flow_led
/*
flow_led flow_led_u(
	.sys_clk        (sys_clk),
	.sys_rst_n      (sys_rst_n),
	
	.led            (led)
);
*/
key_scan key_scan_u(
.sys_clk  	(sys_clk), 
.sys_rst_n	(sys_rst_n), 

.key			(key),           
.key_push   (key_push)
);


led_key led_key_u(
.sys_clk  		(sys_clk), 
.sys_rst_n		(sys_rst_n),
      
.led          	(led),
.led_state		(led_state)
);

key_led_association key_led_association_u(
.sys_clk			(sys_clk),   
.sys_rst_n		(sys_rst_n), 

.key_push		(key_push),
.led_state 		(led_state)
);


//i2c驱动模块
i2c_dri #(
    .SLAVE_ADDR  (SLAVE_ADDR),  //从机地址
    .CLK_FREQ    (CLK_FREQ  ),  //模块输入的时钟频率
    .I2C_FREQ    (I2C_FREQ  )   //IIC_SCL的时钟频率
) u_i2c_dri(
    .clk         (sys_clk   ),  
    .rst_n       (sys_rst_n ),  
    //i2c interface
    .i2c_exec    (i2c_exec  ), 
    .bit_ctrl    (BIT_CTRL  ), 
    .i2c_rh_wl   (i2c_rh_wl ), 
    .i2c_addr    (i2c_addr  ), 
    .i2c_data_w  (i2c_data_w), 
    .i2c_data_r  (i2c_data_r), 
    .i2c_done    (i2c_done  ), 
    .i2c_ack     (i2c_ack   ), 
    .scl         (iic_scl   ), 
    .sda         (iic_sda   ), 
    //user interface
    .dri_clk     (dri_clk   )  
);

//PCF8563控制模块
pcf8563_ctrl #(
    .TIME_INIT (TIME_INIT)
   )u_pcf8563_ctrl(
    .clk         (dri_clk   ),
    .rst_n       (sys_rst_n ),
    //IIC
    .i2c_rh_wl   (i2c_rh_wl ),
    .i2c_exec    (i2c_exec  ),
    .i2c_addr    (i2c_addr  ),
    .i2c_data_w  (i2c_data_w),
    .i2c_data_r  (i2c_data_r),
    .i2c_done    (i2c_done  ),
    //时间和日期
    .sec         (sec       ),
    .min         (min       ),
    .hour        (hour      ),
    .day         (day       ),
    .mon         (mon       ),
    .year        (year      )
    );

//消抖模块
key_debounce u_key_debounce(
    .sys_clk     (sys_clk   ),    //外部50M时钟
    .sys_rst_n   (sys_rst_n ),    //外部复位信号，低有效
    .key         (key       ),    //外部按键输入
	.key_value   (key_value ),    //按键消抖后的数据
    .key_flag    ()               //按键数据有效信号
);

//显示值切换模块
key_sw_disp u_key_sw_disp(
    .clk          (sys_clk),
    .rst_n        (sys_rst_n),
             
    .key_value    (key_value),
    .sec          (sec ),
    .min          (min ),
    .hour         (hour),
    .day          (day ),
    .mon          (mon ),
    .year         (year),
               
    .point        (point),
    .disp_data    (disp_data)
    );

//数码管驱动模块
seg_bcd_dri u_seg_bcd_dri(
   //input
   .clk          (sys_clk   ),    //时钟信号
   .rst_n        (sys_rst_n ),    //复位信号
   .data         (disp_data ),    //6个数码管要显示的数值
   .point        (point     ),    //小数点具体显示的位置,从左往右,高有效
   //output
   .seg_sel      (seg_sel   ),    //数码管位选
   .seg_led      (seg_led   )     //数码管段选
);    
    

    
endmodule