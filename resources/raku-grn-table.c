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

static grn_obj_flags convert_flag(const char *flag) {
  if(strncmp("Hash", flag, strlen("Hash"))) {
    return GRN_OBJ_TABLE_HASH_KEY;
  } else if(strncmp("Pat", flag, strlen("Pat"))) {
    return GRN_OBJ_TABLE_PAT_KEY;
  } else {
    return GRN_OBJ_TABLE_NO_KEY;
  }
}

static grn_obj *convert_key_type(grn_ctx *ctx, const char *key_type) {
  return grn_ctx_get(ctx, key_type, strlen(key_type));
}

grn_obj *raku_grn_table_create(grn_ctx *ctx,
                               const char *name,
			       const char *flag,
			       const char *key_type,
			       const char *default_tokenizer,
			       const char *normalizer,
			       const char *token_filter) {
  unsigned int name_size = strlen(name);
  grn_obj_flags flags = GRN_OBJ_PERSISTENT;
  flags |= convert_flag(flag);
  grn_obj key_type = convert_key_type(key_type);

  return grn_table_create(name, name_size, NULL, flags, key_type, GRN_ENC_DEFAULT);
}

grn_id raku_grn_table_add(grn_ctx *ctx,
                          grn_obj *table,
                          const void *key, unsigned int key_size,
                          int *added) {
  return grn_table_add(ctx, table, key, key_size, added);
}
