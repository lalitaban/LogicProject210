module logicproject(sevensegment);
  output [6:0]sevensegment;
  reg [3:0]num;
  always @ ( 1 ) begin
    num=4;
  end
  sevenseg s1(sevensegment,num);

endmodule

module sevenseg(out,in);
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




module state_counter(state, trigger);
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
