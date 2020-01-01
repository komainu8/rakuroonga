use v6.c;
use groonga::groonga;


unit class rakuroonga:ver<0.0.1>;

method init {
  my $rc = grn_init();
  if $rc != GRN_SUCCESS.value {
    say "Initialize of Groonga failed!: $rc";
  }
  return $rc;
}

method fin {
  my $rc = grn_fin();
  if $rc != GRN_SUCCESS.value {
    say "Finish of Groonga failed!: $rc";
  }
  return $rc;
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
