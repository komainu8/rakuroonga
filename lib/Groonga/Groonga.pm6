use v6.c;
use NativeCall;

use Groonga::Database;
use Groonga::Table;

class Groonga {
  constant LIB_RAKUROONGA = "$*CWD/resources/rakuroonga";

  class grn_ctx is repr('CPointer') { * };
  sub raku_grn_init(--> Bool) is native(LIB_RAKUROONGA) { * };
  sub raku_grn_fin() is native(LIB_RAKUROONGA) { * };

  sub raku_grn_ctx_open(int32 --> grn_ctx) is native(LIB_RAKUROONGA) { * };
  sub raku_grn_ctx_close(grn_ctx) is native(LIB_RAKUROONGA) { * };

  has $!context;
  has $!database;

  submethod BUILD {
    unless raku_grn_init() {
      return Nil;
    }
    $!context = raku_grn_ctx_open(0);
  }

  multi method create_database(Str $path) {
    $!database = Database.new();
    $!database.create($!context, $path);
  }

  multi method create_database {
    $!database = Database.new();
    $!database.create($!context);
  }

  method open_database(Str $path) {
    $!database = Database.new();
    $!database.open($!context, $path);
  }

  method table_create(Str $table_name, Hash %options) {
    $!table = Table.new();
    $!table.create($table_name,
                   $key_type,
		   $value_type,
		   $default_tokenizer,
		   $normalizer,
		   $token_filter);
  }

  method fin {
    raku_grn_ctx_close($!context);
    raku_grn_fin();
  }
}
