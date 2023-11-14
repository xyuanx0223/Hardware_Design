// Create a random stimulus for the 4-bit 4:1 Mux. 
// Generate 15 unique random stimuli for all the inputs.

class random_gen;
  randc bit [2: 0] a, b, c, d;  
  randc bit [1: 0] sel;   
endclass:random_gen

module tb();
  random_gen t1;
  initial begin
    t1 = new();
	integer i;
    for (i = 0, i< 10; i++) begin
      t1.randomize();
      #10;
      $display("Value of Index: %d A: %b B: %b C: %b D:%b  sel::%b",i, t1.a, t1.b, t1.c, t1.d, t1.sel );
    end
  end
endmodule
