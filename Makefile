CC=gcc
CFLAGS=-I.
DEPS = 
OBJ = src/main.o src/parseConf.o 

%.o: %.c $(DEPS)
	$(CC) -c -o $@ $< $(CFLAGS)

parseConf: $(OBJ)
	gcc -o $@ $^ $(CFLAGS)
