use v6.c;
use NativeCall;

constant librakuroonga = "./resources/rakuroonga";

class Table {
  class grn_ctx is repr('CPointer') { * };
  class grn_obj is repr('CPointer') { * };
  sub raku_grn_table_create(grn_ctx, Str, Str, Str, Str, Str --> grn_obj) { * };

  has $!table;

  method create($context, $table_name, %options) {
    $!table = raku_grn_table_create($context,
                                    $table_name,
				    %options<key_type>,
				    %options<value_type>,
				    Nil, Nil, Nil);
  }
}
