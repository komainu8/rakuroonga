/*
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
*/

#include "raku-grn.h"

grn_obj *raku_grn_db_create(grn_ctx *ctx,
                            conts char *path,
                            grn_db_create_optarg *optarg) {
  return grn_db_create(ctx, path, optarg);
}

grn_obj *raku_grn_db_open(grn_ctx *ctx, const char *path) {
  return gnr_db_open(path);
}