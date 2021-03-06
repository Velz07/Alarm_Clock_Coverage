/********************************************************************************************

Copyright 2018-2019 - Maven Silicon Softech Pvt Ltd. All Rights Reserved.

This source code is an unpublished work belongs to Maven Silicon Softech Pvt Ltd.
It is considered a trade secret and is not to be divulged or used by parties who 
have not received written authorization from Maven Silicon Softech Pvt Ltd.

Maven Silicon Softech Pvt Ltd
Bangalore - 560076

Webpage: www.maven-silicon.com

Filename:	counter.v   

Description:	This is a functional description of Alarm clock
                counter unit .It generates the counting sequence for current time.

Date:		01/05/2018

Author:		Maven Silicon

Email:		online@maven-silicon.com

Version:	1.0

*********************************************************************************************/

module counter (clk,
	        reset,
		one_minute,
		load_new_c,
		new_current_time_ms_hr,
		new_current_time_ms_min,
		new_current_time_ls_hr,
		new_current_time_ls_min,
		current_time_ms_hr,
		current_time_ms_min,
		current_time_ls_hr,
		current_time_ls_min);
// Define input and output port directions
input clk,reset,one_minute,load_new_c;

input  [3:0] new_current_time_ms_hr,
	     new_current_time_ms_min,
	     new_current_time_ls_hr,
	     new_current_time_ls_min;

output [3:0] 	current_time_ms_hr,
		current_time_ms_min,
		current_time_ls_hr,
		current_time_ls_min;
// Define register to store current time

reg [3:0] 	current_time_ms_hr_reg,
		current_time_ms_min_reg,
		current_time_ls_hr_reg,
		current_time_ls_min_reg;



// Lodable Binary up synchronous Counter logic                                 /******************************

// Write an always block with asynchronous reset 
always@( posedge clk or posedge reset)                                         
 begin              
    // Check for reset signal and upon reset load the current_time register with default value (1'b0)                                                                                                       
    if(reset==1)
	{current_time_ms_hr_reg,
		current_time_ms_min_reg,
		current_time_ls_hr_reg,
		current_time_ls_min_reg}=0;
	
    // Else if there is no reset, then check for load_new_c signal and load new_current_time to current_time register
      else if(load_new_c==1) 
	begin
		current_time_ms_hr_reg<=new_current_time_ms_hr;
		current_time_ms_min_reg<=new_current_time_ms_min;
		current_time_ls_hr_reg<=new_current_time_ls_hr;
		current_time_ls_min_reg<=new_current_time_ls_min; 
	end     //              0       0       0       9  -> 00:10
    // Else if there is no load_new_c signal, then check for one_minute signal and implement the counting algorithm
	else if(one_minute==1)
	begin
		
		if(current_time_ms_hr_reg==2 && current_time_ls_hr_reg==3 &&
		   current_time_ms_min_reg==5 && current_time_ls_min_reg==9)
			
			begin

			current_time_ms_hr_reg<=0;
			current_time_ls_hr_reg<=0;
			current_time_ms_min_reg<=0;
			current_time_ls_min_reg<=0;
			
			end

		else if(current_time_ms_min_reg==5 && current_time_ls_min_reg==9)
			begin
			
			if(current_time_ls_hr_reg==9)
				begin

				current_time_ms_hr_reg<=current_time_ms_hr_reg+1;
				current_time_ls_hr_reg<=0;
				current_time_ms_min_reg<=0;
				current_time_ls_min_reg<=0;
				
				end
			else
				begin
				current_time_ls_hr_reg<=current_time_ls_hr_reg+1;
				current_time_ms_min_reg<=0;
				current_time_ls_min_reg<=0;
				end
			
			end
		
		else if(current_time_ls_min_reg==9)
			begin

				current_time_ms_min_reg<=current_time_ms_min_reg+1;
				current_time_ls_min_reg<=0;
			end

		else 
			current_time_ls_min_reg<=current_time_ls_min_reg+1;

	end
    // Check for the corner case
    // If the current_time is 23:59, then the next current_time will be 00:00
        
    // Else check if the current_time is 09:59, then the next current_time will be 10:00
     
    // Else check if the time represented by minutes is 59, Increment the LS_HR by 1 and set MS_MIN and LS_MIN to 1'b0
 
    // Else check if the LS_MIN is equal to 9, Increment the MS_MIN by 1 and set MS_MIN to 1'b0
	
    // Else just increment the LS_MIN by 1
     
    end

assign	 current_time_ms_hr=current_time_ms_hr_reg;
assign	 current_time_ms_min=current_time_ms_min_reg;
assign	 current_time_ls_hr=current_time_ls_hr_reg;
assign	 current_time_ls_min=current_time_ls_min_reg;

endmodule

