module logicproject(seg_left,seg_right,score_left,score_right,operator,joy_left,joy_right,selector);
 input selector;
 input [8:0]joy_left;
 input [8:0]joy_right;
 output [4:0]score_right;
 output [4:0]score_left;
 output [6:0]seg_right;
 output [6:0]seg_left;
 output [3:0]operator;
wire trigger;
 wire [3:0]state;
 state_counter state_c(state,trigger);
 wire [3:0]num_left;
 wire [3:0]num_right;
 question_show qs(num_left,num_right,operator,selector,state);
 sevenseg segL(seg_left,num_left);
 sevenseg segR(seg_right,num_right);

 wire scoreL_trig,scoreR_trig;
 score check1(scoreL_trig,scoreR_trig,trigger,joy_left,joy_right,state,selector);

 score_counter scL(score_left,scoreL_trig);
 score_counter scR(score_right,scoreR_trig);




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
  always @ (posedge trigger) begin
    case(score_out)
      0'b00000: score_out = 0'b00001;
      0'b00001: score_out = 0'b00011;
      0'b00011: score_out = 0'b00111;
      0'b00111: score_out = 0'b01111;
      0'b01111: score_out = 0'b11111;
      default: score_out = 0'b00000;
    endcase
    end
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

module score(score_left,score_right,trigger,joy_left,joy_right,state,selector);
  input [3:0]state;
  input selector;
  input [8:0]joy_left;
  input [8:0]joy_right;

  output trigger,score_left,score_right;
  reg trigger,score_left,score_right;

  wire joy_left_status,joy_right_status;

  or orjoy_left(joy_left_status,joy_left[0],joy_left[1],joy_left[2],joy_left[3],joy_left[4],joy_left[5],joy_left[6],joy_left[7],joy_left[8]);
  or orjoy_right(joy_right_status,joy_right[0],joy_right[1],joy_right[2],joy_right[3],joy_right[4],joy_right[5],joy_right[6],joy_right[7],joy_right[8]);
  always @ ( 1 ) begin
    if (joy_left_status == 1) begin
      if(selector == 0) begin //ans 1 left
        if (joy_left == 9'b000001000 && state == 0) begin
          trigger = 1;
          score_left = 1;
          score_right = 0;
        end
        else begin
        if (joy_left == 9'b000100000 && state == 1) begin
          trigger = 1;
          score_left = 1;
          score_right = 0;
        end
        else begin
        if (joy_left == 9'b001000000 && state == 2) begin
          trigger = 1;
          score_left = 1;
          score_right = 0;
        end
        else begin
        if (joy_left == 9'b010000000 && state == 3) begin
          trigger = 1;
          score_left = 1;
          score_right = 0;
        end
        else begin
        if (joy_left == 9'b100000000 && state == 4) begin
          trigger = 1;
          score_left = 1;
          score_right = 0;
        end
        else begin
        if (joy_left == 9'b000000100 && state == 5) begin
          trigger = 1;
          score_left = 1;
          score_right = 0;
        end
        else begin
        if (joy_left == 9'b100000000 && state == 6) begin
          trigger = 1;
          score_left = 1;
          score_right = 0;
        end
        else begin
        if (joy_left == 9'b000000001 && state == 7) begin
          trigger = 1;
          score_left = 1;
          score_right = 0;
        end
        else begin
        if (joy_left == 9'b000000010 && state == 8) begin
          trigger = 1;
          score_left = 1;
          score_right = 0;
        end
        else begin
          trigger = 0;
          score_left = 0;
          score_right = 0;
        end
        end
        end
        end
        end
        end
        end
        end
        end



      end
      else begin

      if(selector == 1) begin //ans 2 left
        if (joy_left == 9'b000001000 && state == 0) begin
          trigger = 1;
          score_left = 1;
          score_right = 0;
        end
        else begin
        if (joy_left == 9'b000100000 && state == 1) begin
          trigger = 1;
          score_left = 1;
          score_right = 0;
        end
        else begin
        if (joy_left == 9'b001000000 && state == 2) begin
          trigger = 1;
          score_left = 1;
          score_right = 0;
        end
        else begin
        if (joy_left == 9'b010000000 && state == 3) begin
          trigger = 1;
          score_left = 1;
          score_right = 0;
        end
        else begin
        if (joy_left == 9'b100000000 && state == 4) begin
          trigger = 1;
          score_left = 1;
          score_right = 0;
        end
        else begin
        if (joy_left == 9'b000000100 && state == 5) begin
          trigger = 1;
          score_left = 1;
          score_right = 0;
        end
        else begin
        if (joy_left == 9'b100000000 && state == 6) begin
          trigger = 1;
          score_left = 1;
          score_right = 0;
        end
        else begin
        if (joy_left == 9'b000000001 && state == 7) begin
          trigger = 1;
          score_left = 1;
          score_right = 0;
        end
        else begin
        if (joy_left == 9'b000000010 && state == 8) begin
          trigger = 1;
          score_left = 1;
          score_right = 0;
        end
        else begin
          trigger = 0;
          score_left = 0;
          score_right = 0;
        end
        end
        end
        end
        end
        end
        end
        end
        end

      end
    end

    if (joy_right_status == 1) begin
      if(selector == 0) begin //ans 1 right
      if (joy_right == 9'b000001000 && state == 0) begin
        trigger = 1;
        score_left = 0;
        score_right = 1;
      end
        else begin
        if (joy_right == 9'b000100000 && state == 1) begin
          trigger = 1;
          score_left = 0;
          score_right = 1;
        end
        else begin
        if (joy_right == 9'b001000000 && state == 2) begin
          trigger = 1;
          score_left = 0;
          score_right = 1;
        end
        else begin
        if (joy_right == 9'b010000000 && state == 3) begin
          trigger = 1;
          score_left = 0;
          score_right = 1;
        end
        else begin
        if (joy_right == 9'b100000000 && state == 4) begin
          trigger = 1;
          score_left = 0;
          score_right = 1;
        end
        else begin
        if (joy_right == 9'b000000100 && state == 5) begin
          trigger = 1;
          score_left = 0;
          score_right = 1;
        end
        else begin
        if (joy_right == 9'b100000000 && state == 6) begin
          trigger = 1;
          score_left = 0;
          score_right = 1;
        end
        else begin
        if (joy_right == 9'b000000001 && state == 7) begin
          trigger = 1;
          score_left = 0;
          score_right = 1;
        end
        else begin
        if (joy_right == 9'b000000010 && state == 8) begin
          trigger = 1;
          score_left = 0;
          score_right = 1;
        end
        else begin
          trigger = 0;
          score_left = 0;
          score_right = 0;
        end
        end
        end
        end
        end
        end
        end
        end
        end


      end
      else begin

      if(selector == 1) begin //ans 2 right
      if (joy_right == 9'b000001000 && state == 0) begin
        trigger = 1;
        score_left = 0;
        score_right = 1;
      end
        else begin
        if (joy_right == 9'b000100000 && state == 1) begin
          trigger = 1;
          score_left = 0;
          score_right = 1;
        end
        else begin
        if (joy_right == 9'b001000000 && state == 2) begin
          trigger = 1;
          score_left = 0;
          score_right = 1;
        end
        else begin
        if (joy_right == 9'b010000000 && state == 3) begin
          trigger = 1;
          score_left = 0;
          score_right = 1;
        end
        else begin
        if (joy_right == 9'b100000000 && state == 4) begin
          trigger = 1;
          score_left = 0;
          score_right = 1;
        end
        else begin
        if (joy_right == 9'b000000100 && state == 5) begin
          trigger = 1;
          score_left = 0;
          score_right = 1;
        end
        else begin
        if (joy_right == 9'b100000000 && state == 6) begin
          trigger = 1;
          score_left = 0;
          score_right = 1;
        end
        else begin
        if (joy_right == 9'b000000001 && state == 7) begin
          trigger = 1;
          score_left = 0;
          score_right = 1;
        end
        else begin
        if (joy_right == 9'b000000010 && state == 8) begin
          trigger = 1;
          score_left = 0;
          score_right = 1;
        end
        else begin
          trigger = 0;
          score_left = 0;
          score_right = 0;
        end
        end
        end
        end
        end
        end
        end
        end
        end


      end

      end
    end
  end
  end

endmodule
