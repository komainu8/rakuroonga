/*
    Copyright (C) 2019-2020 Horimoto Yasuhiro

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

  return grn_table_create(ctx,
			  name, name_size,
			  NULL,
			  flags,
			  convert_key_type(ctx, key_type),
			  GRN_ENC_DEFAULT);
}

bool raku_grn_table_insert(grn_ctx *ctx,
                           grn_obj *table, char *key,
                           const char *insert_column,
                           const char *insert_value) {
  grn_obj value;
  int added;

  grn_id id = grn_table_add(ctx, table, key, strlen(key), &added);
  /* TODO: Error handling using added */

  GRN_OBJ_INIT(&value, GRN_BULK, GRN_OBJ_DO_SHALLOW_COPY, GRN_ID_NIL);
  GRN_TEXT_SET(ctx, &value, insert_value, strlen(insert_value));

  grn_obj *column = grn_obj_column(ctx, table, insert_column, strlen(insert_column));
  /* TODO: Error handling
    if (!column) {
      char table_name[GRN_TABLE_MAX_KEY_SIZE];
      int table_name_size;
      table_name_size = grn_obj_name(ctx,
                                     loader->table,
                                     table_name,
                                     GRN_TABLE_MAX_KEY_SIZE);
      GRN_LOG(ctx, GRN_LOG_ERROR, "[load] nonexistent column: <%.*s.%.*s>",
              table_name_size,
              table_name,
              (int)name_size,
              name);
  */
  grn_rc inserted = grn_obj_set_value(ctx, column, id, &value, GRN_OBJ_SET);

  if (inserted == GRN_INVALID_ARGUMENT) {
    return false;
  }
  return true;
}

void raku_grn_table_select(grn_ctx *ctx,
                           grn_obj *table, const char *filter) {
  grn_obj *value, *condition;
  grn_obj *match_records = NULL;
  grn_obj *table_created = NULL;
  
  GRN_EXPR_CREATE_FOR_QUERY(ctx, table, condition, value);
  grn_expr_parse(ctx, condition,
		 filter, strlen(filter),
		 NULL,
		 GRN_OP_MATCH, GRN_OP_AND, GRN_EXPR_SYNTAX_SCRIPT);

  table_created = grn_table_create(ctx, NULL, 0, NULL,
				   GRN_TABLE_HASH_KEY|GRN_OBJ_WITH_SUBREC,
				   table, NULL);
  if (table_created) {
    grn_table_select(ctx, table, condition, match_records, GRN_OP_OR);
  }
}
