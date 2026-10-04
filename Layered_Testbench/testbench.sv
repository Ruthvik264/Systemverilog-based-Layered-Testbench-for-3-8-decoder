`include "interface.sv"
`include "test.sv"

module top;
  decoder_if i_intf();

  test t1(i_intf);

  decoder d1(
    .a(i_intf.a),
    .y(i_intf.y)
  );

  initial begin
    $dumpfile("dump.vcd");
    $dumpvars;
  end
endmodule