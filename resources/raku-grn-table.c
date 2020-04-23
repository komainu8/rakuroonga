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
#include <stdio.h>

static grn_obj_flags convert_flag(const char *flag) {
  if(strncmp("Hash", flag, strlen("Hash")) == 0) {
    return GRN_OBJ_TABLE_HASH_KEY;
  } else if(strncmp("Pat", flag, strlen("Pat")) == 0) {
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
  grn_obj *table;

  flags |= convert_flag(flag);

  if (convert_flag(flag) == GRN_OBJ_TABLE_NO_KEY) {
    table = grn_table_create(ctx,
                             name, name_size,
                             NULL,
                             flags,
                             NULL, grn_ctx_at(ctx, GRN_DB_UINT32));
  } else {
    table = grn_table_create(ctx,
                             name, name_size,
                             NULL,
                             flags,
                             convert_key_type(ctx, key_type),
                             GRN_ENC_DEFAULT);
  }

  return table;
}

bool raku_grn_table_insert(grn_ctx *ctx,
                           grn_obj *table, char *key,
                           const char *insert_column,
                           const char *insert_value) {
  grn_obj value;
  int added;

  grn_id id = grn_table_add(ctx, table, NULL, 0, &added);
  if (id == GRN_ID_NIL) {
    return false;
  }

  GRN_TEXT_INIT(&value, 0);
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
    grn_obj_unlink(ctx, column);
    return false;
  }

  return true;
}
size_t raku_grn_get_n_columns(grn_ctx *ctx, grn_obj *result_table) {
  grn_obj columns;
  GRN_PTR_INIT(&columns, GRN_OBJ_VECTOR, GRN_ID_NIL);
  const char *column_names = "*";
  grn_obj_columns(ctx, result_table, column_names, strlen(column_names), &columns);
  size_t n_columns = GRN_PTR_VECTOR_SIZE(&columns);

  {
    size_t i;
    for (i = 0; i < n_columns; i++) {
      grn_obj *column = GRN_PTR_VALUE_AT(&columns, i);
      grn_obj_unlink(ctx, column);
    }
  }
  GRN_OBJ_FIN(ctx, &columns);

  return n_columns;
}

grn_obj *raku_grn_table_select(grn_ctx *ctx,
                               grn_obj *table, const char *filter) {
  grn_obj *value, *condition;
  grn_obj *result_table = NULL;

  GRN_EXPR_CREATE_FOR_QUERY(ctx, table, condition, value);
  grn_rc rc = grn_expr_parse(ctx, condition,
                             filter, strlen(filter),
                             NULL,
                             GRN_OP_MATCH, GRN_OP_AND, GRN_EXPR_SYNTAX_SCRIPT);

  result_table = grn_table_select(ctx, table, condition, NULL, GRN_OP_OR);
  return result_table;

  /*
  grn_obj columns;
  GRN_PTR_INIT(&columns, GRN_OBJ_VECTOR, GRN_ID_NIL);
  const char *column_names = "*";
  grn_obj_columns(ctx, result_table, column_names, strlen(column_names), &columns);
  const size_t n_columns = GRN_PTR_VECTOR_SIZE(&columns);

  grn_obj buffer;
  GRN_VOID_INIT(&buffer);

  GRN_TABLE_EACH_BEGIN(ctx, result_table, cursor, result_id) {
    size_t i;
    for (i = 0; i < n_columns; i++) {
      grn_obj *column = GRN_PTR_VALUE_AT(&columns, i);
      GRN_BULK_REWIND(&buffer);
      grn_obj_get_value(ctx, column, result_id, &buffer);
      printf("AAA=%d", buffer.header.domain);
      
        typedef enum {
          GRN_DB_VOID = 0,
          GRN_DB_DB,
          GRN_DB_OBJECT,
          GRN_DB_BOOL,
          GRN_DB_INT8,
          GRN_DB_UINT8,
          GRN_DB_INT16,
          GRN_DB_UINT16,
          GRN_DB_INT32,
          GRN_DB_UINT32,
          GRN_DB_INT64,
          GRN_DB_UINT64,
          GRN_DB_FLOAT,
          GRN_DB_TIME,
          GRN_DB_SHORT_TEXT,
          GRN_DB_TEXT,
          GRN_DB_LONG_TEXT,
          GRN_DB_TOKYO_GEO_POINT,
          GRN_DB_WGS84_GEO_POINT,
          GRN_DB_FLOAT32
        } grn_builtin_type;
      
      grn_p(ctx, &buffer);
      printf("AAA\n");
    }
  } GRN_TABLE_EACH_END(ctx, cursor);
  GRN_OBJ_FIN(ctx, &buffer);

  {
    size_t i;
    for (i = 0; i < n_columns; i++) {
      grn_obj *column = GRN_PTR_VALUE_AT(&columns, i);
      grn_obj_unlink(ctx, column);
    }
  }
  GRN_OBJ_FIN(ctx, &columns);
  */
}
