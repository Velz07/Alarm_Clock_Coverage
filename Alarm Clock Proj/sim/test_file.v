module test();
	
	reg [3:0]a,b,c;

	wire w1;

	integer i;
	
	real r1;
	
	time t1;

	realtime rt;

	
	

initial
	begin
/*
	$display("def values regs a=%b  wires w1=%b  integers i=%b  real=%b , time=%b , realtime=%b",a,w1,i,r1,t1,rt);	
	a=4'b0xx1;
	b=4'b1010;
	c=a+b;	
	$display("test a+b a=%b,b=%b,c=%b",a,b,c);

	c=a|b;	
	$display("test a|b a=%b,b=%b,c=%b",a,b,c);

	c=a||b;	
	$display("test a||b a=%b,b=%b,c=%b",a,b,c);

	c=a&b;	
	$display("test a&b a=%b,b=%b,c=%b",a,b,c);

	c=a&&b;	
	$display("test a&&b a=%b,b=%b,c=%b",a,b,c);

	c=~a;	
	$display("test ~a a=%b,b=%b,c=%b",a,b,c);

	c= b>=a;
	$display("test b>=a a=%b,b=%b,c=%b",a,b,c);

	
	c=(b>=a)?4'b1010:4'b1001 ;
	$display("test b>=a a=%b,b=%b,c=%b",a,b,c);
	
	if(a>b)
	$display(" if a>b ");
	else
	$display("elseif a>b ");*/

	repeat(5)
	begin 
		a=$random;
		$display("TEST1 rand1",a);
	end


	repeat(5)
	begin 
		a={$random};
		$display("TEST2 rand1",a);
	end


	repeat(5)
	begin 
		a={$random}%7;
		$display("TEST3 rand1",a);
	end



	repeat(5)
	begin 
		a=8+{$random}%(15-8);
		$display("TEST4 rand1",a);
	end
	






	end

endmodule