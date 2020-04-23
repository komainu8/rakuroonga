use v6.c;
use NativeCall;

use Groonga::Context;

class Table {
  constant LIB_RAKUROONGA = "$*CWD/resources/rakuroonga";

  class grn_obj is repr('CPointer') { * };
  sub raku_grn_table_create(grn_ctx $context,
                            Str $table_name,
                            Str $flag,
                            Str $key_type,
                            Str $default_tokenizer,
                            Str $normalizer,
                            Str $token_filter --> grn_obj)
  is native(LIB_RAKUROONGA) { * };

  sub raku_grn_column_create(grn_ctx $context,
                             grn_obj $table,
                             Str $column_name,
                             Str $value_type) is native(LIB_RAKUROONGA) { * };

  sub raku_grn_table_insert(grn_ctx $context,
                            grn_obj $table,
                            Str $key, Str $column, Str $value)
  is native(LIB_RAKUROONGA) { * };


  sub raku_grn_table_select(grn_ctx $context,
                            grn_obj $table,
                            Str $filter --> grn_obj) is native(LIB_RAKUROONGA) { * };

  sub raku_grn_get_n_columns(grn_ctx $context,
                             grn_obj $result_table --> size_t)
  is native(LIB_RAKUROONGA) { * };

  has $.context;
  has $.table;
  has $.table_name;
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
    %options
  }

  submethod BUILD(:$!context, :$!table_name, :%!options) {
      my %parsed_options = self!parse_options(%!options);
      $!table = raku_grn_table_create($!context,
                                      $!table_name,
                                      %parsed_options<flag>,
                                      %parsed_options<key_type>,
                                      %parsed_options<default_tokenizer>,
                                      %parsed_options<normalizer>,
                                      %parsed_options<token_filter>);
  }

  method name {
    $!table_name;
  }

  method add_column($column_name, $value_type) {
    raku_grn_column_create($!context,
                           $!table,
                           $column_name,
                           $value_type);
  }

  method insert(%records) {
    my $key = '';
    my $column = '';
    my $value = '';

    for %records -> %record {
      if %record<_key>:exists {
        $key = %record<_key>;
      } else {
        $column = %record<>:k.Str;
        $value = %record<>:v.Str;
      }
      raku_grn_table_insert($!context,
                            $!table,
                            $key, $column, $value);
    }
  }

  method select($table_name, $filter) {
    my $match_records = raku_grn_table_select($!context, $!table, $filter);
    say $match_records;
      my $n_columns = raku_grn_get_n_columns($!context, $result_table);
  }
}
