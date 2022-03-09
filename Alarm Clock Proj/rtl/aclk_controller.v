module aclk_controller(input clk,reset,one_second,alarm_button,time_button,
		       input [3:0]key,
		       output load_new_c,show_new_time,show_a,load_new_a,shift,reset_count);

	parameter SHOW_TIME=3'd0,
		  KEY_STORED=3'd1,	
		  KEY_WAITED=3'd2,	
		  KEY_ENTRY=3'd3,	
		  SET_ALARM_TIME=3'd4,		
		  SET_CURRENT_TIME=3'd5,	
		  SHOW_ALARM=3'd6;

reg [2:0]pstate,next_state;

reg [3:0]count1,count2;

reg timeout;

//reg load_new_c_reg,show_new_time_reg,show_a_reg,load_new_a_reg,shift_reg;



assign load_new_c = (pstate==SET_CURRENT_TIME)?1:0;
assign load_new_a = (pstate== SET_ALARM_TIME)?1:0;

assign show_new_time= (pstate==KEY_STORED || pstate==KEY_WAITED || pstate==KEY_ENTRY || pstate==SET_ALARM_TIME || pstate==SET_CURRENT_TIME )?1:0;
assign show_a=(pstate==SHOW_ALARM)?1:0;
assign reset_count=0;
assign shift= (pstate==KEY_STORED)?1:0;



//SEQUENTIAL
always @(posedge clk or posedge reset)
	begin

	if(reset==1)
		{pstate,next_state}=0;
	

	else
		pstate<=next_state;
		
	end

//10 Second TIMER


always @(posedge one_second or posedge reset)
	begin
		if(reset==1)
			count1=0;

		else if(pstate!=KEY_WAITED)	
			count1=0;

		else if(count1==9)
			count1=0;
		else
			count1=count1+1;
	end


always @(posedge one_second or posedge reset)
	begin
		if(reset==1)
			count2=0;

		else if(pstate!=KEY_ENTRY)	
			count2=0;

		else if(count2==9)
			count2=0;
		else
			count2=count2+1;
	end



always @(*)
	timeout = (count1==9 || count2==9)?0:1;

//NEXT_STATE LOGIC
always @(pstate,one_second,alarm_button,time_button,key,timeout)
	begin
	
	case (pstate)

	SHOW_TIME:
		if(key!=10)
			next_state=KEY_STORED;

		else if(alarm_button==1)
			next_state=SHOW_ALARM;
		else
			next_state=SHOW_TIME;
	


	KEY_STORED:		
		if(key!=10)
			next_state=KEY_WAITED;
			
		else
			next_state=SHOW_TIME;

	KEY_WAITED:
		if(key==10)
			next_state=KEY_ENTRY;
		else if(timeout==0)
			next_state=SHOW_TIME;
		else
			next_state=KEY_WAITED;

	KEY_ENTRY:
		if(key!=10)
			next_state=KEY_STORED;

		else if(alarm_button==1)
			next_state=SET_ALARM_TIME;

		else if(time_button==1)
			next_state=SET_CURRENT_TIME;

		else if(timeout==0)
			next_state=SHOW_TIME;

		else
			next_state=KEY_ENTRY;
	SET_ALARM_TIME:
		next_state=SHOW_TIME;

	SET_CURRENT_TIME:
		next_state=SHOW_TIME;
	
	
	SHOW_ALARM:
		if(alarm_button==1)
			next_state=SHOW_ALARM;
		else
			next_state=SHOW_TIME;
	endcase

	
	end










endmodule	
	
	
