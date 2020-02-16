use v6.c;
use NativeCall;

use Groonga::Context;
use Groonga::Database;

class Groonga {
  constant LIB_RAKUROONGA = "$*CWD/resources/rakuroonga";

  sub raku_grn_init(--> Bool) is native(LIB_RAKUROONGA) { * };
  sub raku_grn_fin() is native(LIB_RAKUROONGA) { * };

  sub raku_grn_ctx_open(int32 --> grn_ctx) is native(LIB_RAKUROONGA) { * };
  sub raku_grn_ctx_close(grn_ctx) is native(LIB_RAKUROONGA) { * };

  has $!context;
  has $!database; #TODO: Use Hash. Because we need have multiple databases.
  has $!table;

  submethod BUILD {
    unless raku_grn_init() {
      return Nil;
    }
    $!context = raku_grn_ctx_open(0);
  }

  multi method create_database(Str $path) {
    $!database = Database.new(context => $!context);
    $!database.create($path);
  }

  multi method create_database {
    $!database = Database.new(context => $!context);
    $!database.create();
  }

  method open_database(Str $path) {
    $!database = Database.new(context => $!context);
    $!database.open($path);
  }

  method create_table(Str $table_name, %options) {
    $!database.create_table($table_name, %options);
  }

  method fin {
    raku_grn_ctx_close($!context);
    raku_grn_fin();
  }
}
