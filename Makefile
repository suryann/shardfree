# Super-basic Makefile. To be made more awesome once I have stuff up and running
# and it matters.

CXXFILES:=$(shell find . -type f -name '*.cc' -print)
OUTPUTS = build/sf-server

SERVER_OBJECTS = sf-server.o sf-worker.o sf-simulator.o sf-global.o sf-logger.o
OBJECTS = $(SERVER_OBJECTS)
BUILD_DIR = build

WARNINGS = -Wall
LFLAGS = -lzmq
CPPFLAGS = $(WARNINGS) -g

all: $(BUILD_DIR) $(OUTPUTS)

$(BUILD_DIR):
	mkdir -p $@	

clean:
	rm -rf $(BUILD_DIR)
	rm -rf $(OBJECTS)

build/sf-server: $(SERVER_OBJECTS)
	g++ $(CPPFLAGS) $(LFLAGS) $^ -o $@

depend:
	cp /dev/null dependencies.mk
	for F in $(CFILES); do \
		D=`dirname $$F`; \
		B=`basename -s .c $$F`; \
		$(CC) $(CPPFLAGS) -MM -MT $$D/$$B.o -MG $$F \
		 >> dependencies.mk; \
	done
	for F in $(CXXFILES); do \
		D=`dirname $$F`; \
		B=`basename -s .cpp $$F`; \
		$(CXX) $(CPPFLAGS) -MM -MT $$D/$$B.o -MG $$F \
		 >> dependencies.mk; \
	done