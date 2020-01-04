use v6.c;
use groonga::groonga;


unit class rakuroonga:ver<0.0.1>;

has $.context;
has $.database;

method new {
  rakuroonga_init();
  $!context = grn_ctx_open(0);

  return self.bless();
}


submethod DESTROY {
  grn_ctx_close($!context);
  grn_fin();
}

method init {
  my $rc = grn_init();
  if $rc != GRN_SUCCESS.value {
    say "Initialize of Groonga failed!: $rc";
  }
  $!context = grn_ctx_open(0);
  return $rc;
}

method fin {
  my $rc = grn_ctx_close($!context);
  if $rc != GRN_SUCCESS.value {
    say "Colse context failed!: $rc";
  }

  $rc = grn_fin();
  if $rc != GRN_SUCCESS.value {
    say "Finish of Groonga failed!: $rc";
  }

  return $rc;
}

multi method create_database {
  my $old_database = grn_ctx_db($!context);
  if $old_database.Bool {
    grn_obj_unlink($!context, $old_database);
  }
  $!database = grn_db_create($!context, Nil, Nil);
}

multi method create_database($path) {
  my $old_database = grn_ctx_db($!context);
  if $old_database.Bool {
    grn_obj_unlink($!context, $old_database);
  }
  $!database = grn_db_create($!context, $path, Nil);
}

method open_database($path) {
  $!database = grn_db_open($!context, $path);
}

method create_table($table_name, $path, $flags, $key_type, $value_type) {
  my key_type = grn_ctx_at($!context, GRN_DB_SHORT_TEXT.value);
  my value_type = grn_ctx_at($!context, GRN_DB_SHORT_TEXT.value);
  $!table =
    grn_table_create($!context, $table_name, $table_name.encode.byte, Nil, GRN_OBJ_TABLE_HASH_KEY, key_type, value_type);
}

=begin pod

=head1 NAME

rakuroonga

=head1 SYNOPSIS

=begin code :lang<perl6>

use rakuroonga;

=end code

=head1 DESCRIPTION

TODO.

=head1 AUTHOR

Yasuhiro Horimoto <horimoto@clear-code.com>

=head1 COPYRIGHT AND LICENSE

    Copyright (C) 2019 Horimoto Yasuhiro

    This file is part of Rakuroonga.

    Rakuroonga is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    Rakuroong is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with Rakuroonga.  If not, see <http://www.gnu.org/licenses/>.

=end pod
