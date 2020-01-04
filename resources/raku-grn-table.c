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

grn_obj *raku_grn_table_create(grn_ctx *ctx,
                               const char *name, unsigned int name_size,
                               const char *path,
                               grn_obj_flags flags,
                               grn_obj *key_type,
                               grn_obj *value_type) {
  return grn_table_create(name, name_size, path, flags, key_type, value_type);
}

grn_id raku_grn_table_add(grn_ctx *ctx,
                          grn_obj *table,
                          const void *key, unsigned int key_size,
                          int *added) {
  return grn_table_add(ctx, table, key, key_size, added);
}
