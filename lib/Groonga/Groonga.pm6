use v6.c;
use NativeCall;

use Groonga::Database;

class Groonga {
  class grn_ctx is repr('CPointer') { * };
  sub raku_grn_init(--> Bool) is native(librakuroonga) { * };
  sub raku_grn_fin() is native(librakuroonga) { * };

  sub raku_grn_ctx_open(int32 --> grn_ctx) is native(librakuroonga) { * };
  sub raku_grn_ctx_close(grn_ctx) is native(librakuroonga) { * };

  has $!context;
  has $!database;

  submethod BUILD {
    unless raku_grn_init() {
      return Nil;
    }
    $!context = raku_grn_ctx_open(0);
  }

  method create_database(Str $path) {
    $!database = Database.new();
    $!database.create($!context, $path);
  }

  method fin {
    raku_grn_ctx_close($!context);
    raku_grn_fin();
  }
}


