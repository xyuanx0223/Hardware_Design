module tb();
  event a;
  initial begin
    fork
      // process 1      
      begin
        #10;
        ->a;
      end
      // process 2
      begin
        @(a.triggered);
        $display("Event triggered");
        // cannot utilize the $time here
      end
    join
    $display("All the process executed successfully at %0t", $time);
    // can utilize the $time here
  end
endmodule
