exe = ./bin/program.exe
objects = program.o \
			MainWindow.o
libs =
CompileOption = `pkg-config gtkmm-3.0 --cflags --libs` -mwindows -Wall -std=c++11 -s -O3
DirSrc = ./src
DirBin = ./bin
DirLib = ./lib
DirObj = ./obj
ifeq "$(strip $(DirSrc))" ""
	SRCDIR = .
endif
ifeq "$(strip $(DirBin))" ""
	SRCDIR = .
endif
ifeq "$(strip $(DirLib))" ""
	SRCDIR = .
endif
ifeq "$(strip $(DirObj))" ""
	SRCDIR = .
endif
include = -I./include

sources = $(wildcard $(DirSrc)/*.cc)
objects = $(addprefix $(DirObj)/, $(notdir $(sources:.cc=.o)))
depends = $(objects:.o=.d)

$(exe): $(objects) $(libs)
	-mkdir -p $(DirBin)
	g++ -o $(exe) $(objects) $(CompileOption)

$(DirObj)/%.o: $(DirSrc)/%.cc
	-mkdir -p $(DirObj)
	g++ -o $@ -c $< $(include) $(CompileOption) 

.PHONY : all
all:
	clean $(exe)

.PHONY : clean
clean :
	-rm $(exe) $(objects)

-include $(DEPENDS)
