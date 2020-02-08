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
  has $!context;
  has $!table_name;
  has %!options;

  method !parse_options(%options) {
    unless %options<flag>:exists {
      %options.push: (flag => '');
    }
    unless %options<key_type>:exists {
      %options.push: (key_type => '');
    }
    unless %options<default_tokenizer>:exists {
      %options.push: (default_tokenizer => '');
    }
    unless %options<normalizer>:exists {
      %options.push: (normalizer => '');
    }
    unless %options<token_filter>:exists {
      %options.push: (token_filter => '');
    }
  }

  submethod BUILD {
    self!parse_options(%!options);
    raku_grn_table_create($!context,
                          $!table_name,
		          %!options<flag>,
		          %!options<key_type>,
		          %!options<default_tokenizer>,
		          %!options<normalizer>,
		          %!options<token_filter>);
  }
}
