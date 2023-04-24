module S2(clk,
	  rst,
	  S2_done,
	  RB2_RW,
	  RB2_A,
	  RB2_D,
	  RB2_Q,
	  sen,
	  sd);

input clk,
      rst;

output reg S2_done,
       RB2_RW;

output reg [2:0] RB2_A;

output reg [17:0] RB2_D;

input [17:0] RB2_Q;

input sen,
      sd;

reg first, done;
reg[4:0] cnt;
//reg[1:0] acnt;
//reg[2:0] addreg;
//reg state; 

//parameter addr = 2'd0;
parameter data = 1'd0;
parameter write = 1'd1;

always @(posedge clk or posedge rst)
begin
	if(rst)
	begin
		RB2_RW <= 1;
		RB2_A <= 0;
		RB2_D <= 0;
		S2_done <= 0; 
                first <= 1;
		cnt <= 5'd20;
		//acnt <= 2'd2;
		//addreg <= 3'd0;
                //state <= data;
	end
	else if(sen)
        begin
            RB2_RW <= 1;
	    RB2_D <= 0;
	    RB2_A <= 0;
	    S2_done <= 0;
		cnt <= 5'd20;
		//acnt <= 2'd2;
		//addreg <= 3'd0;
                //state <= data;
        end
	else begin
		//case(state)
		///addr:
		//begin
			//if(acnt > 2'd0)acnt <= acnt - 1;
			//else 
			//begin
				//state <= data;
				//cnt <= 5'd18;
			//end
			//addreg[acnt] <= sd;
		//end
		//data:
		//begin
			if(cnt == 5'd20) 
                        begin
		             if(RB2_A == 7)done <= 1;
                             RB2_A[2] <= sd;
                             RB2_RW <= 1;
                        end
                        else if(cnt == 5'd19)
                        begin
			     if(done)S2_done <= 1;
                             RB2_A[1] <= sd;
                        end
                        else if(cnt == 5'd18)
                        begin
                             
                             RB2_A[0] <= sd;
                        end
			else if(cnt <= 5'd17)
			begin
				//addreg <= 3'd0;
				//acnt <= 2'd2;
	                        if(cnt == 5'd0)RB2_RW <= 0;
                                RB2_D[cnt] <= sd;
				//state <= write;
			end

			if(cnt == 0) cnt <= 5'd20;
                        else cnt <= cnt - 5'd1;	
                        //RB2_D <= (RB2_D << 1) + sd;
		//end
		//write:
		//begin
			//if(RB2_A < 3'd7) RB2_A <= RB2_A+1;
			//else 
			//begin
		//		S2_done <= 1;
		//	end
		//	RB2_RW <= 1;
               //         RB2_D <= 0;
		//	state <= addr;
		//end
	//endcase
	end
end
endmodule
