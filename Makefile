MXMLC = /opt/flex/bin/mxmlc

MFLAGS = -compiler.source-path=src \
         -debug \
         -warnings \
         -use-network=false


TARGET  = PseudoSiege.swf
 
all: $(TARGET)
 
clean:
	$(RM) $(TARGET)
 
.SUFFIXES: .as .swf
%.swf: src/%.as
	$(MXMLC) $(MFLAGS) -output $@ $<
