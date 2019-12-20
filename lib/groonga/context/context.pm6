use v6.c;

use NativeCall;
constant LIB_PATH="ext/groonga/grn";

class Context is repr('CPointer') {
  sub grn_ctx_open() return Context is native(LIB_PATH) { * }
  sub grn_ctx_close(Context) return int8 is native(LIB_PATH) { * }

  method new {
    grn_ctx_open();
  }

  method close {
    grn_ctx_close(self);
  }

  submethod DESTROY {
    grn_ctx_close(self);
  }
}

groonga = Groonga.new()
groonga.database.create("aaa/aa.db");
table = groonga.schema.create_table("a", "Hash");
table.add_column("aaaa", "Text");
table.insert
table.create_index("column")
table.select

table.update
table.delete
table.truncate

