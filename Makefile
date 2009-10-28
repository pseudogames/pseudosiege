MXMLC = mxmlc
FDB = fdb

TARGET = PseudoSiege.swf

MFLAGS = -compiler.source-path=src \
         -warnings \
         -debug \
         -use-network=false

all: $(TARGET)
	$(FDB) $<

$(TARGET): src/*.as

.SUFFIXES: .as .swf 
%.swf: src/%.as
	$(MXMLC) $(MFLAGS) -output $@ $<

clean:
	$(RM) $(TARGET)
 
