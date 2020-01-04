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

grn_ctx *raku_grn_ctx_open(int flags) {
  return grn_ctx_open(flags);
}

grn_obj *raku_grn_ctx_db(grn_ctx *ctx) {
  return grn_ctx_db(ctx);
}

grn_obj *raku_grn_ctx_at(grn_ctx *ctx, grn_id id) {
  return grn_ctx_at(ctx, id);
}

grn_rc raku_grn_ctx_close(grn_ctx *ctx) {
  grn_rc rc;

  rc = grn_ctx_close(ctx);
  if (rc != GRN_SUCCESS) {
    /* Output to log file */
    printf("Failed to close context!: %d", rc);
  }

  return rc;
}
