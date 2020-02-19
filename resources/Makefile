CC	= gcc
CFLAGS	= -fPIC -I/usr/include/groonga
LIBS	= -lgroonga
PREFIX  = /usr/local
TARGET	= librakuroonga.so
SRCS	= raku-grn-context.c \
	  raku-grn-column.c \
	  raku-grn-database.c \
	  raku-grn-table.c \
          raku-groonga.c

all: $(TARGET)

$(TARGET):
	$(CC) $(CFLAGS) -shared -o $(TARGET) $(SRCS) $(LIBS)

install: $(TARGET)
	mkdir -p $(PREFIX)/lib/
	install -m644 $(TARGET) $(PREFIX)/lib/$(TARGET)

clean:
	-rm -f *.o *.so *.out *.a
