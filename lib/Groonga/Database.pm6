use v6.c;
use NativeCall;

use Groonga::Table;

class Database {
  constant LIB_RAKUROONGA = "$*CWD/resources/rakuroonga";

  class grn_ctx is repr('CPointer') { * };
  class grn_obj is repr('CPointer') { * };
  sub raku_grn_db_create(grn_ctx, Str --> grn_obj) is native(LIB_RAKUROONGA) { * };
  sub raku_grn_db_open(grn_ctx, Str, grn_obj --> Bool) is native(LIB_RAKUROONGA) { * };

  has $.context;
  has $!database;
  has $!path;
  has %!tables;

  method create($path=Nil --> Bool) {
    say $!context;
    $!path = $path;
    $!database = raku_grn_db_create($!context, $!path);

    if $!database {
      return True;
    } else {
      return False;
    }
  }

  method open($path=Nil --> Bool) {
    unless $path {
      return False;
    }

    if raku_grn_db_open($!context, $path, $!database) {
      return True;
    } else {
      return False;
    }
  }

  method create_table($table_name, %options) {
    %!tables = $table_name => Table.new($!context,
                                        $table_name,
                                        %options);
  }
}
