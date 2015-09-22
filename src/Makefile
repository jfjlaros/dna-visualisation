CC = gcc
CFLAGS = -O3
LFLAGS =

EXEC = dnavis
MAIN = dnavis.c
OBJS = 

all: $(EXEC)

.cc.o:
	$(CC) $(CFLAGS) -c $<
	
$(EXEC): $(MAIN) $(OBJS)
	$(CC) $(CFLAGS) -o $@ $^ $(LFLAGS)

release: $(EXEC) clean
	strip $(EXEC)

clean:
	rm -f $(OBJS) core

distclean: clean
	rm -f $(EXEC)
