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
constant LIB_PATH="../ext/groonga/libgrn";

my class grn_ctx is repr('CStruct') {
  has grn_rc $.rc;
  has int32 $.flags;
  has grn_encoding $.encoding;
  has uint8 $.ntrace;
  has uint8 $.errlvl;
  has uint8 $.stat;
  has uint32 $.seqno;
  has uint32 $.subno;
  has uint32 $.seqno2;
  has uint32 $.errline;
  has grn_user_data $.user_data;
  has Pointer[grn_ctx] $.prev;
  has Pointer[grn_ctx] $.next;
  has Str $.errfile;
  has Str $.errfunc;
  has Pointer[_grn_ctx_impl] $.impl;
  has void *trace[16];
  has Str $.errbuf[GRN_CTX_MSGSIZE];
}

struct _grn_ctx {
};
