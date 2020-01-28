use v6.c;
use Groonga::Groonga;

class Rakuroonga {

  has $!groonga;

  submethod BUILD {
    $!groonga = Groonga.new();
  }

  method create_database(Str $path="") {
    $!groonga.create_database($path);
  }

  method open_database(Str $path="") {
    $!groonga.open_database($path);
  }

  submethod DESTROY {
    $!groonga.fin();
  }
}

=begin pod

=head1 NAME

Rakuroonga

=head1 SYNOPSIS

=begin code :lang<perl6>

use Rakuroonga;

=end code

=head1 DESCRIPTION

TODO.

=head1 AUTHOR

Horimoto Yasuhiro <horimoto@clear-code.com>

=head1 COPYRIGHT AND LICENSE

    Copyright (C) 2020 Horimoto Yasuhiro

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
