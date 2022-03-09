/********************************************************************************************

Copyright 2018-2019 - Maven Silicon Softech Pvt Ltd. All Rights Reserved.

This source code is an unpublished work belongs to Maven Silicon Softech Pvt Ltd.
It is considered a trade secret and is not to be divulged or used by parties who 
have not received written authorization from Maven Silicon Softech Pvt Ltd.

Maven Silicon Softech Pvt Ltd
Bangalore - 560076

Webpage: www.maven-silicon.com

Filename:	alarm_clock_top.v   

Description:	This is the top module of Alarm clock.
                It has instantiated all the sub-modules 
		which are connected via internal wires .

Date:		01/05/2018

Author:		Maven Silicon

Email:	        online@maven-silicon.com	

Version:	1.0

*********************************************************************************************/
module alarm_clock_top(clock,
	               key,
		       reset,
		       time_button,
		       alarm_button,
		       fast_watch,
		       ms_hour,
		       ls_hour,
		       ms_minute,
		       ls_minute,
		       alarm_sound);
// Define port directions for the signals
input clock,reset,time_button,alarm_button,fast_watch;
input [3:0]key;

output alarm_sound;

output [7:0] ms_hour,
	     ls_hour,
	     ms_minute,
   	     ls_minute;

//Define the Interconnecting internal wires
	//TIMING GENERTOR
wire one_minute,one_second,reset_count;
	//ALARM CONTROLLER
wire load_new_c,show_new_time,show_a,load_new_a,shift;

	//KEY REG
wire [3:0]    key_buffer_ls_min,
              key_buffer_ms_min,
              key_buffer_ls_hr,
              key_buffer_ms_hr;

	//ALARM,CURRENT TIME REGS
wire [3:0] alarm_time_ms_hr,
            alarm_time_ls_hr,
            alarm_time_ms_min,
            alarm_time_ls_min,
            current_time_ms_hr,
            current_time_ls_hr,
            current_time_ms_min,
            current_time_ls_min;
	




//Instantiate lower sub-modules. Use interconnect(Internal) signals for connecting the sub modules
// Instantiate the timing generator module

aclk_timegen TG(.clk(clock),.reset(reset),.reset_count(reset_count),.fast_watch(fast_watch),.one_minute(one_minute),.one_second(one_second));





//FSM

aclk_controller CTRL(.clk(clock),.reset(reset),.one_second(one_second),.alarm_button(alarm_button),.time_button(time_button),
		       .key(key),.load_new_c(load_new_c),.show_new_time(show_new_time),.show_a(show_a),.load_new_a(load_new_a),
			.shift(shift),.reset_count(reset_count) );

// Instantiate the counter module
counter CNT(    .clk(clock),
	        .reset(reset),
		.one_minute(one_minute),
		.load_new_c(load_new_c),
		.new_current_time_ms_hr(key_buffer_ms_hr),
		.new_current_time_ms_min(key_buffer_ms_min),
		.new_current_time_ls_hr(key_buffer_ls_hr),
		.new_current_time_ls_min(key_buffer_ls_min),
		.current_time_ms_hr(current_time_ms_hr),
		.current_time_ms_min(current_time_ms_min),
		.current_time_ls_hr(current_time_ls_hr),
		.current_time_ls_min(current_time_ls_min) );

// Instantiate the key register module

keyreg KEYREG(.reset(reset),
              .clock(clock),
              .shift(shift),
              .key(key),
              .key_buffer_ls_min(key_buffer_ls_min),
              .key_buffer_ms_min(key_buffer_ms_min),
              .key_buffer_ls_hr(key_buffer_ls_hr),
              .key_buffer_ms_hr(key_buffer_ms_hr) );


// Instantiate the alarm register module
alarm_reg A_REG(.new_alarm_ms_hr(key_buffer_ms_hr),
              .new_alarm_ls_hr(key_buffer_ls_hr),
              .new_alarm_ms_min(key_buffer_ms_min),
              .new_alarm_ls_min(key_buffer_ls_min),
              .load_new_alarm(load_new_a),
              .clock(clock),
              .reset(reset),
              .alarm_time_ms_hr(alarm_time_ms_hr),
              .alarm_time_ls_hr(alarm_time_ls_hr),
              .alarm_time_ms_min(alarm_time_ms_min),
              .alarm_time_ls_min(alarm_time_ls_min) );



// Instantiate the lcd_driver_4 module
lcd_driver_4 LCD(     .alarm_time_ms_hr(alarm_time_ms_hr),
                      .alarm_time_ls_hr(alarm_time_ls_hr),
                      .alarm_time_ms_min(alarm_time_ms_min),
                      .alarm_time_ls_min(alarm_time_ls_min),
                      .current_time_ms_hr(current_time_ms_hr),
                      .current_time_ls_hr(current_time_ls_hr),
                      .current_time_ms_min(current_time_ms_min),
                      .current_time_ls_min(current_time_ls_min),
                      .key_ms_hr(key_buffer_ms_hr),
                      .key_ls_hr(key_buffer_ls_hr),
                      .key_ms_min(key_buffer_ms_min),
                      .key_ls_min(key_buffer_ls_min),
                      .show_a(show_a),
                      .show_current_time(show_new_time),
                      .display_ms_hr(ms_hour),
                      .display_ls_hr(ls_hour),
                      .display_ms_min(ms_minute),
                      .display_ls_min(ls_minute),
                      .sound_a(alarm_sound) 
		);


endmodule


		   

