//interface example
//using mux as design.
//inputs 2 bit, sel 2 bit, output 2 bit
interface mux_inf();
  logic [1:0]a;
  logic [1:0]b;
  logic [1:0]c;
  logic [1:0]d;
  logic [1:0]sel;
  logic [1:0]out;
endinterface:mux_inf

//testing with tb

module interface_ex_tb();
//creating an instance of the interface
  mux_inf vif();
  initial begin
    for (int i=0; i < 20; i++) begin
      vif.a = $random();
      vif.b = $random();
      vif.c = $random();
      vif.d = $random();
      vif.sel = $random();
      $display("--------------------------------------");
      $display("The generated values for the interface are a:%0d b:%0d c:%0d d:%0d sel:%0b:"
               ,vif.a, vif.b, vif.c, vif.d,vif.sel);
      $display("--------------------------------------");
    end
  end
endmodule:interface_ex_tb
