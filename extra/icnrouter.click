in :: ICNInputMux();  out :: ICNOutputDemux()
cs :: ICNContentStore()
pit :: ICNPendingInterestTable()
fib :: ICNForwardingInformationBase()

iface0in -> [0] in; iface1in -> [1] in;  // ...

//          D,I-miss   I-miss  I-hit
in -> cs [0] -> pit [0] -> fib -> out;
//          I-hit
      cs [1] -> out;
//                     D-hit
                pit [1] -> out;

out [0] -> iface0out; out [1] -> iface1out;  // ...

