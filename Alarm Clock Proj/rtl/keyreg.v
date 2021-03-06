/********************************************************************************************

Copyright 2011-2012 - Maven Silicon Softech Pvt Ltd. All Rights Reserved.

This source code is an unpublished work belongs to Maven Silicon Softech Pvt Ltd.
It is considered a trade secret and is not to be divulged or used by parties who 
have not received written authorization from Maven Silicon Softech Pvt Ltd.

Maven Silicon Softech Pvt Ltd
Bangalore - 560076

Webpage: www.maven-silicon.com

Filename:	keyreg.v   

Description:	This is a functional description of Alarm clock
                Key register unit .It is a shift register which stores the key time .

Date:		23/02/2012

Author:		Maven Silicon

Email:		online@maven-silicon.com

Version:	1.0

*********************************************************************************************/

module keyreg(reset,
              clock,
              shift,
              key,
              key_buffer_ls_min,
              key_buffer_ms_min,
              key_buffer_ls_hr,
              key_buffer_ms_hr);
// Define input and output port direction

input reset,clock,shift;
input [3:0]key;

output [3:0]  key_buffer_ls_min,
              key_buffer_ms_min,
              key_buffer_ls_hr,
              key_buffer_ms_hr;


reg [3:0]     key_buffer_ls_min_reg,
              key_buffer_ms_min_reg,
              key_buffer_ls_hr_reg,
              key_buffer_ms_hr_reg; 



///////////////////////////////////////////////////////////////////
// This procedure stores the last 4 keys pressed. The FSM block
// detects the new key value and triggers the shift pulse to shift
// in the new key value.
///////////////////////////////////////////////////////////////////
always @(posedge clock or posedge reset)
begin
  // For asynchronous reset, reset the key_buffer output register to 1'b0
	if(reset==1)
	begin
	      key_buffer_ls_min_reg<=0;
              key_buffer_ms_min_reg<=0;
              key_buffer_ls_hr_reg<=0;
              key_buffer_ms_hr_reg<=0;
	end
	
	else if(shift==1 && key!=10)
	begin
	      key_buffer_ls_min_reg<=key;
              key_buffer_ms_min_reg<=key_buffer_ls_min_reg;
              key_buffer_ls_hr_reg<=key_buffer_ms_min_reg;
              key_buffer_ms_hr_reg<=key_buffer_ls_hr_reg;
	end
	

  // Else if there is a shift, perform left shift from LS_MIN to MS_HR
 
end


assign key_buffer_ls_min=key_buffer_ls_min_reg;
assign key_buffer_ms_min=key_buffer_ms_min_reg;
assign key_buffer_ls_hr=key_buffer_ls_hr_reg;
assign key_buffer_ms_hr=key_buffer_ms_hr_reg;

endmodule
