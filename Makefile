#
# Взято отсюда: http://habrahabr.ru/blogs/development/111691/
#

root_source_dir  := src
source_subdirs   := . stuff terp
compile_flags    := -Wall
link_flags       :=
libraries        :=

gc               := g++

relative_include_dirs := $(addprefix ../../, $(root_include_dir))
relative_source_dirs  := $(addprefix ../../$(root_source_dir)/, $(source_subdirs))
objects_dirs          := $(addprefix $(root_source_dir)/, $(source_subdirs))
objects               := $(patsubst ../../%, %, $(wildcard $(addsuffix /*.c*, $(relative_source_dirs))))
objects               := $(objects:.cpp=.o)
objects               := $(objects:.c=.o)

all : $(program_name)

$(program_name) : obj_dirs $(objects)
	$(gc) -o $@ $(objects) $(link_flags) $(libraries) $(build_flags)

obj_dirs :
	mkdir -p $(objects_dirs)

VPATH := ../../

%.o : %.cpp
	$(gc) -o $@ -c $< $(compile_flags) $(build_flags)

%.o : %.c
	$(gc) -o $@ -c $< $(compile_flags) $(build_flags)

.PHONY : clean

clean :
	rm -rf bin obj

include $(wildcard $(addsuffix /*.d, $(objects_dirs)))
