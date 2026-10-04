class driver;
  virtual decoder_if vif;
  mailbox gen2driv;

  function new(virtual decoder_if vif, mailbox gen2driv);
    this.vif = vif;
    this.gen2driv = gen2driv;
  endfunction

  task main();
    transaction trans;
    repeat(100)
      begin
        gen2driv.get(trans);
        vif.a <= trans.a;

        #3;
        trans.y = vif.y;
        trans.display("Driver");

        #2;
      end
  endtask
endclass