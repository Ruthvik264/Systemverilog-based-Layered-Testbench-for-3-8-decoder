class transaction;
  rand bit [2:0] a;
  bit [7:0] y;

  function void display(string name);
    $display("%s",name);
    $display("a=%0d, y=%b", a, y);
  endfunction
endclass