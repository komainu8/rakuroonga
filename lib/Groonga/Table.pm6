use v6.c;
use NativeCall;

class Table {
  constant LIB_RAKUROONGA = "$*CWD/resources/rakuroonga";

  class grn_ctx is repr('CPointer') { * };
  class grn_obj is repr('CPointer') { * };
  sub raku_grn_table_create(grn_ctx,
                            Str,
			    Str,
			    Str,
			    Str,
			    Str --> grn_obj) is native(LIB_RAKUROONGA) { * };

  has $!table;

  method create($context, $table_name, %options) {
    $!table = raku_grn_table_create($context,
                                    $table_name,
				    %options<key_type>,
				    %options<value_type>,
				    Nil, Nil, Nil);
  }
}
