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

static grn_obj *convert_value_type(grn_ctx *ctx, const char *value_type) {
  return grn_ctx_get(ctx, value_type, strlen(value_type));
}

grn_obj *raku_grn_column_create(grn_ctx *ctx,
                                grn_obj *table,
			        const char *name,
			        const char *value_type) {
  unsigned int name_size = strlen(name);
  grn_obj_flags flags = GRN_OBJ_PERSISTENT | GRN_OBJ_COLUMN_SCALAR;

  return grn_column_create(ctx,
			   table,
			   name, name_size,
			   NULL,
			   flags,
			   convert_value_type(ctx, value_type));
}

