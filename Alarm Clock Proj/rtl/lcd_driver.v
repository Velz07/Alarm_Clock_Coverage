/********************************************************************************************

Copyright 2018-2019 - Maven Silicon Softech Pvt Ltd. All Rights Reserved.

This source code is an unpublished work belongs to Maven Silicon Softech Pvt Ltd.
It is considered a trade secret and is not to be divulged or used by parties who 
have not received written authorization from Maven Silicon Softech Pvt Ltd.

Maven Silicon Softech Pvt Ltd
Bangalore - 560076

Webpage: www.maven-silicon.com

Filename:	lcd_driver.v   

Description:	This module is the functional description of
                display unit.It generates alarm sound signal and 
	        displays values in LCD display format.

Date:		01/05/2018

Author:		Maven Silicon

Email:		online@maven-silicon.com

Version:	1.0

*********************************************************************************************/
module lcd_driver (alarm_time,
                   current_time,
                   show_alarm,
                   show_new_time,
                   key,display_time,
                   sound_alarm);
//Define input and output ports direction
input [3:0] key;
input [3:0]alarm_time;
input [3:0]current_time;
input show_alarm;
input show_new_time;


output reg [7:0]display_time;
output reg sound_alarm;

//Define the internal signals  
reg [3:0]display_value ;

//Define the Parameter constants to represent LCD numbers
parameter ZERO   = 8'h30;
parameter ONE    = 8'h31;
parameter TWO    = 8'h32;
parameter THREE  = 8'h33;
parameter FOUR   = 8'h34;
parameter FIVE   = 8'h35;
parameter SIX    = 8'h36;
parameter SEVEN  = 8'h37;
parameter EIGHT  = 8'h38;
parameter NINE   = 8'h39;
parameter ERROR  = 8'h3A;


 assign sound_alarm=(alarm_time==current_time)?1:0;

always @ (alarm_time or current_time or show_alarm or show_new_time or key)
  begin
    //Displays the key_time,alarm_time or current_time as per the control signals

	if(show_alarm==1 && show_new_time==0)
		display_value=alarm_time;

	else if(show_alarm==0 && show_new_time==1)
		display_value=key;

	else if(show_alarm==0 && show_new_time==0)
		display_value=current_time;
	else
		display_value=current_time;


		

  end

//Decoder logic 
always @ (display_value)
  begin
    // For number stored in display_value register, load display_time register with LCD equivalent
    case (display_value)
	0: display_time=ZERO;
	1: display_time=ONE;
	2: display_time=TWO;
	3: display_time=THREE;
	4: display_time=FOUR;
	5: display_time=FIVE;
	6: display_time=SIX;
	7: display_time=SEVEN;
	8: display_time=EIGHT;
	9: display_time=NINE;
    
       default : display_time = ERROR;
    endcase
   end 


endmodule	    
  
	
