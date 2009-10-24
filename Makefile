MXMLC = mxmlc

MFLAGS = -compiler.source-path=src \
         -debug \
         -warnings


TARGET  = PseudoSiege.swf
 
all: $(TARGET)
 
clean:
	$(RM) $(TARGET)
 
.SUFFIXES: .as .swf
%.swf: src/%.as
	$(MXMLC) $(MFLAGS) -output $@ $<
