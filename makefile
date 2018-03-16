# Makefile that will build the Vectrex ROM

# Assembler and Linker
AS 		= lwasm
ASFLAGS	= --obj
LD		= lwlink
LDFLAGS	= -r

# Directories
SRCDIR	 = src
OBJDIR	 = obj
BUILDDIR = build

# Make does not offer a recursive wildcard function, so here's one:
rwildcard=$(wildcard $1$2) $(foreach d,$(wildcard $1*),$(call rwildcard,$d/,$2))

# Sources
SOURCES	:= $(call rwildcard,$(SRCDIR)/,*.asm)		# list all source files
SSRC	:= $(notdir $(SOURCES))						# remove file paths
SOBJ	:= $(patsubst %.asm, $(OBJDIR)/%.o, $(SSRC)) # create object list

# Recipes
EXECUTABLE = $(BUILDDIR)/HelloWorld.vec

all: dir $(EXECUTABLE)

$(EXECUTABLE): $(SOBJ)
	$(LD) $(LDFLAGS) -o $@ $^

$(OBJDIR)/%.o: $(SRCDIR)/%.asm
	$(AS) --obj -o $@ -l$@.txt $<

.PHONY: clean
clean:
	@rm -f $(OBJDIR)/*.o
	@rm -f $(EXECUTABLE)

dir:
	@mkdir -p $(OBJDIR)
	@mkdir -p $(BUILDDIR)
