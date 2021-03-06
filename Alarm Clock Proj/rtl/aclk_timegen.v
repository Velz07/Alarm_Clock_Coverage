module aclk_timegen(clk,reset,reset_count,fast_watch,one_minute,one_second);
		
	input clk,reset,fast_watch,reset_count;
	output one_minute,one_second;

	reg [15:0]count_reg;

	reg one_minute_reg,one_second_reg;


	
	//one second
	always @(posedge clk or posedge reset)
	begin
		if(reset==1)
			begin
			count_reg<=0;
			one_second_reg<=0;
			end
		else if(reset_count==1)
			begin
			count_reg<=0;
			one_second_reg<=0;
			end
			
			
		else if(count_reg%256==0 && count_reg!=0)
			begin
			one_second_reg<=1;

			if(count_reg!=15360)
				count_reg<=count_reg+1;

			end
		else
			begin
			count_reg<=count_reg+1;
			one_second_reg<=0;
			end

	end

	//one minute
	always @(posedge clk or posedge reset)
	begin
		if(reset==1 || reset_count==1)
			begin
			count_reg<=0;
			one_minute_reg<=0;
			end

		else if(reset_count==1)
			begin
			count_reg<=0;
			one_minute_reg<=0;
			end
			
		else if(count_reg==15360)
			begin
			one_minute_reg<=1;
			count_reg<=0;
			end
		else
			one_minute_reg<=0;

	end

	
	assign one_second=one_second_reg;
	assign one_minute=(fast_watch==1)?one_second_reg:one_minute_reg;
	
	
endmodule	

	