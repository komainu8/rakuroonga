use v6.c;
use NativeCall;

constant librakuroonga = "./resources/rakuroonga";

class Database is Groonga {
  class grn_obj is repr('CPointer') { * };
  sub raku_grn_db_create(Groonga::grn_ctx, Str) is native(librakuroonga) { * };

  has $!database;

  method create_database(grn_ctx $context, Str $path) {
    $!database = raku_grn_db_create($context, $path);
  }
}