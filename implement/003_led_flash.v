module led_flash (
  input Clk,
  input Reset_n,
  output Led
);
  reg [24: 0] counter;

  always @ (posedge Clk, negedge Reset_n) begin
    if (!Reset_n) counter <= 0;
    else if (counter == 25000000)
      counter <= 0;
    else
      counter <= counter + 1;
  end

  always @ (*) begin
    
  end

endmodule
