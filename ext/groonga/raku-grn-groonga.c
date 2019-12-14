/*
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
*/

#include "raku-grn.h"

bool init_groonga(void) {
  grn_rc rc;

  rc = grn_init();
  if (rc != GRN_SUCCESS) {
    /* TODO: Convert grn_rc to int*/
    return false;
  }
  return true;
}

void fin_groonga(void) {
  grn_fin();
}
