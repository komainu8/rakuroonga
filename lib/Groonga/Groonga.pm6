use v6.c;
use NativeCall;

constant librakuroonga = "resources/rakuroonga";

class Groonga {
  class grn_ctx is repr('CPointer') { * };
  sub raku_grn_init(--> Bool) is native(librakuroonga) { * };
  sub raku_grn_fin() is native(librakuroonga) { * };

  sub raku_grn_ctx_open(int32 --> grn_ctx) is native(librakuroonga) { * };
  sub raku_grn_ctx_close(grn_ctx) is native(librakuroonga) { * };

  has $!context;

  submethod BUILD {
    unless raku_grn_init() {
      return Nil;
    }
    $!context = raku_grn_ctx_open(0);
  }

  method fin {
    raku_grn_ctx_close(self.context);
    raku_grn_fin();
  }
}


