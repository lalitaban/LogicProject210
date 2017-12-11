module logicproject(sevensegment);
  output [6:0]sevensegment;
  reg [3:0]num;
  always @ ( 1 ) begin
    num=4;
  end
  sevenseg s1(sevensegment,num);

endmodule

module sevenseg(out,in); //show question
  input [3:0]in;
  output [6:0]out;

  reg [6:0]out;

  always @ (1) begin
    case (in)
      0:out=7'b0111111;
      1:out=7'b0000110;
      2:out=7'b0011011;
      3:out=7'b1001111;
      4:out=7'b1100110;
      5:out=7'b1101101;
      6:out=7'b1111101;
      7:out=7'b0000111;
      8:out=7'b1111111;
      9:out=7'b1101111;

      default:out=7'b1111001;
    endcase

  end


endmodule

module score_counter(score_out,trigger);//นับคะแนน
  input trigger;
  output [4:0]score_out;
  reg [4:0]score_out;
endmodule

module state_counter(state, trigger); //นับstate
  output [3:0]state;
  input trigger;
  reg [3:0]state;
  always @ (posedge trigger) begin
    case(state)
      0: state = 1;
      1: state = 2;
      2: state = 3;
      3: state = 4;
      4: state = 5;
      5: state = 6;
      6: state = 7;
      7: state = 8;
      8: state = 9;
      9: state = 0;
      default: state = 0;
    endcase
  end
endmodule


module question_show(num_left,num_right,operater,switch,state);
  input [3:0]state;
  input switch;
  output [3:0]num_left;
  output [3:0]num_right;
  output [3:0]operater;

  reg [3:0]num_left;
  reg [3:0]num_right;
  reg [3:0]operater;

  always @ (state) begin
  if (switch == 0) begin //q1
    if (state == 0) begin
      num_left = 8;
      num_right = 2;
      operater = 4'b1000;
    end
    else if (state == 1) begin
      num_left = 2;
      num_right = 3;
      operater = 4'b0100;
    end
    else if (state == 2) begin
      num_left = 9;
      num_right = 2;
      operater = 4'b0010;
    end
    else if (state == 3) begin
      num_left = 5;
      num_right = 3;
      operater = 4'b0001;
    end
    else if (state == 4) begin
      num_left = 4;
      num_right = 5;
      operater = 4'b0001;
    end
    else if (state == 5) begin
      num_left = 9;
      num_right = 3;
      operater = 4'b1000;
    end
    else if (state == 6) begin
      num_left = 6;
      num_right = 3;
      operater = 4'b0001;
    end
    else if (state == 7) begin
      num_left = 1;
      num_right = 1;
      operater = 4'b1000;
    end
    else if (state == 8) begin
      num_left = 6;
      num_right = 4;
      operater = 4'b0010;
    end
  end
  else if (switch == 1) begin //q2
    if (state == 0) begin
      num_left = 8;
      num_right = 2;
      operater = 4'b1000;
    end
    else if (state == 1) begin
      num_left = 2;
      num_right = 3;
      operater = 4'b0100;
    end
    else if (state == 2) begin
      num_left = 9;
      num_right = 2;
      operater = 4'b0010;
    end
    else if (state == 3) begin
      num_left = 5;
      num_right = 3;
      operater = 4'b0001;
    end
    else if (state == 4) begin
      num_left = 4;
      num_right = 5;
      operater = 4'b0001;
    end
    else if (state == 5) begin
      num_left = 9;
      num_right = 3;
      operater = 4'b1000;
    end
    else if (state == 6) begin
      num_left = 6;
      num_right = 3;
      operater = 4'b0001;
    end
    else if (state == 7) begin
      num_left = 1;
      num_right = 1;
      operater = 4'b1000;
    end
    else if (state == 8) begin
      num_left = 6;
      num_right = 4;
      operater = 4'b0010;
    end
  end
end
endmodule

module score(score_left,score_right,selector,trigger,joy_left,joy_right,state,selector);
  input [3:0]state;
  input selector;
  input [8:0]joy_left;
  input [8:0]joy_right;

  output trigger,score_left,score_right;
  reg trigger,score_left,score_right;

  wire joy_left_status,joy_right_status;

  or orjoy_left(joy_left_status,joy_left[0],joy_left[1],joy_left[2],joy_left[3],joy_left[4],joy_left[5],joy_left[6],joy_left[7],joy_left[8]);
  or orjoy_right(joy_right_status,joy_right[0],joy_right[1],joy_right[2],joy_right[3],joy_right[4],joy_right[5],joy_right[6],joy_right[7],joy_right[8]);

endmodule
