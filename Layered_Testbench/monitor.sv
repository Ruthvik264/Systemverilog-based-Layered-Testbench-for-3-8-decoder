class monitor;
  virtual decoder_if vif;
  mailbox mon2scb;

  function new(virtual decoder_if vif, mailbox mon2scb);
    this.vif = vif;
    this.mon2scb = mon2scb;
  endfunction

  task main;
    transaction trans;
    repeat(100)
      begin
        #3;
        trans = new();

        trans.a = vif.a;
        trans.y = vif.y;

        mon2scb.put(trans);
        trans.display("Monitor");

        #2;
      end
  endtask
endclass