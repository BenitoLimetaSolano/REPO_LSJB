#--start--
NAME = tetris
ENTRY = _tetris

SYMS =  -defsym instructionsX=12
SYMS += -defsym instructionsY=19
SYMS += -defsym width=10
SYMS += -defsym xoffset=100
SYMS += -defsym height=116
SYMS += -defsym height=214
SYMS += -defsym yoffset=100
SYMS += -defsym wait=255
SYMS += -defsym scoredrop=2
SYMS += -defsym scorelockin=3
SYMS += -defsym scoreline=100
SYMS += -defsym scoretetris=1000
SYMS += -defsym speedup=10

$(NAME): $(NAME).o
	ld -s -o $@ -m elf_i386 $^ -e $(ENTRY)

$(NAME).o: $(NAME).s
	as --32 -o $@ $^ $(SYMS)

clean:
	rm -f $(NAME).o $(NAME)
#--end--
