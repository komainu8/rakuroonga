use v6.c;
use NativeCall;

constant librakuroonga = "./resources/rakuroonga";

class Database {
  class grn_ctx is repr('CPointer') { * };
  class grn_obj is repr('CPointer') { * };
  sub raku_grn_db_create(grn_ctx, Str) is native(librakuroonga) { * };

  has $!database;
  has $!path;

  method create($context, $path) {
    say $context;
    $!path = $path;
    $!database = raku_grn_db_create($context, $!path);

    if $!database {
      return True;
    } else {
      return False;
    }
  }
}