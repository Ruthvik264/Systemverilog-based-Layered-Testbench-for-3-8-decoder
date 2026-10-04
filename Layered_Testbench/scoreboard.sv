class scoreboard;
  mailbox mon2scb;
  coverage cov;
  int pass_cnt;
  int fail_cnt;

  function new(mailbox mon2scb);
    this.mon2scb = mon2scb;
    cov = new();
    pass_cnt = 0;
    fail_cnt = 0;
  endfunction

  task main;
    transaction trans;
    bit [7:0] expected;

    repeat(100)
      begin
        mon2scb.get(trans);
        cov.sample(trans);

        expected = 8'b00000001 << trans.a;

        if (trans.y === expected)
          begin
            pass_cnt++;
            $display("[SCO][PASS] a=%b output correct: %b", trans.a, trans.y);
          end
        else
          begin
            fail_cnt++;
            $display("[SCO][FAIL] a=%b expected=%b got=%b", trans.a, expected, trans.y);
          end
      end
  endtask

  function void report();
    $display("--------------------------------------");
    $display("Total=%0d  PASS=%0d  FAIL=%0d", pass_cnt + fail_cnt, pass_cnt, fail_cnt);
    $display("Functional coverage = %0.2f%%", cov.cg.get_coverage());
    $display("--------------------------------------");
  endfunction
endclass