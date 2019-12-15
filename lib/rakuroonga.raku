=begin comment
    Copyright (C) 2019 Horimoto Yasuhiro <iddqsar888plekww@gmail.com>

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
=end comment

use NativeCall;

constant LIB_PATH="ext/groonga/grn";
sub init_rakuroonga() is native(LIB_PATH) is symbol('init_groonga') { * }
sub fin_rakuroonga() is native(LIB_PATH) is symbol('fin_groonga') { * }

say init_rakuroonga();
fin_rakuroonga();


