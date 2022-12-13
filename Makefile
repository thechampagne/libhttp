BUILD := build
DD := dmd
STATIC := -lib
SHARED := -shared -defaultlib=libphobos2.so
LIBS := $(BUILD)/main.o $(BUILD)/http.o


.PHONY: all

all: $(LIBS)
	$(DD) $(SHARED) $(LIBS) -oflib/libhttp.so
	$(DD) $(STATIC) $(LIBS) -oflib/libhttp.a

$(BUILD)/main.o: main.d
	$(DD) -c -od$(BUILD) $< http.d

$(BUILD)/http.o: http.d
	$(DD) -c -od$(BUILD) $<

clean:
	find $(BUILD) -type f -name '*.o' -delete
	find lib -type f \( -name '*.so' -o -name '*.a' \) -delete
