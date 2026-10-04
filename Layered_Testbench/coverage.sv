class coverage;
  transaction trans;

  covergroup cg;
    option.per_instance = 1;

    cp_a: coverpoint trans.a {
      bins a_val[] = {[0:7]};
    }

    cp_y: coverpoint trans.y {
      bins one_hot[] = {8'h01, 8'h02, 8'h04, 8'h08,
                        8'h10, 8'h20, 8'h40, 8'h80};
    }
  endgroup

  function new();
    cg = new();
  endfunction

  function void sample(transaction t);
    trans = t;
    cg.sample();
  endfunction
endclass