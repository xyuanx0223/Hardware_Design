module tb();
  reg [3:0] a = 4'h0;
  reg [3:0] b;
  initial begin
    a <= 4'b1001;
    $display("[DISPLAY] Value of a: %0b", a);
    //[DISPLAY] Value of a: 0
    #10;
    $display("[DISPLAY] #10 Value of a: %0b", a);
    //[DISPLAY] #10 Value of a: 1001
  end
  
  initial begin
    #30;
    b = 4'b1001;
    $display("[DISPLAY] Value of b: %0d @ %0t", b, $time);
    //[DISPLAY] Value of b: 9
    #10;
    b = 4'b0001;
    $display("[DISPLAY] #10 Value of b: %0d @ %0t", b, $time);
    //[DISPLAY] #10 Value of b: 1
    #10;
    b = 4'b0001;
    $display("[DISPLAY] #10 Value of b: %0d @ %0t", b, $time);
    //[DISPLAY] #10 Value of b: 1
  end
  
  initial begin
    $monitor("[MONITOR] Value of b: %0d @ %0t", b, $time);
    /*
    # KERNEL: [DISPLAY] Value of a: 0
    # KERNEL: [MONITOR] Value of b: x @ 0
    # KERNEL: [DISPLAY] #10 Value of a: 1001
    # KERNEL: [DISPLAY] Value of b: 9 @ 30
    # KERNEL: [MONITOR] Value of b: 9 @ 30
    # KERNEL: [DISPLAY] #10 Value of b: 1 @ 40
    # KERNEL: [MONITOR] Value of b: 1 @ 40
    # KERNEL: [DISPLAY] #10 Value of b: 1 @ 50
    monitor is updated only when the data is changed
    */
  end
endmodule
