## -*- Makefile -*-
##
## User: janbar
## Time: 4 nov. 2013 22:25:36
##


#### Compiler and tool definitions shared by all build targets #####
CCC = g++
CXX = g++
BASICOPTS = -g
CCFLAGS = $(BASICOPTS)
CXXFLAGS = $(BASICOPTS)
CCADMIN = 


# Define the target directories.
TARGETDIR_test_demux=build


all: $(TARGETDIR_test_demux)/test_demux

## Target: test_demux
OBJS_test_demux =  \
	$(TARGETDIR_test_demux)/bitstream.o \
	$(TARGETDIR_test_demux)/ES_MPEGAudio.o \
	$(TARGETDIR_test_demux)/tsDemuxer.o \
	$(TARGETDIR_test_demux)/elementaryStream.o \
	$(TARGETDIR_test_demux)/ES_Subtitle.o \
	$(TARGETDIR_test_demux)/debug.o \
	$(TARGETDIR_test_demux)/test_demux.o \
	$(TARGETDIR_test_demux)/ES_AAC.o \
	$(TARGETDIR_test_demux)/ES_h264.o \
	$(TARGETDIR_test_demux)/ES_Teletext.o \
	$(TARGETDIR_test_demux)/ES_AC3.o \
	$(TARGETDIR_test_demux)/ES_MPEGVideo.o
SYSLIBS_test_demux = -lpthread 
USERLIBS_test_demux = $(SYSLIBS_test_demux) 
DEPLIBS_test_demux =  
LDLIBS_test_demux = $(USERLIBS_test_demux)


# Link or archive
$(TARGETDIR_test_demux)/test_demux: $(TARGETDIR_test_demux) $(OBJS_test_demux) $(DEPLIBS_test_demux)
	$(LINK.cc) $(CCFLAGS_test_demux) $(CPPFLAGS_test_demux) -o $@ $(OBJS_test_demux) $(LDLIBS_test_demux)


# Compile source files into .o files
$(TARGETDIR_test_demux)/bitstream.o: $(TARGETDIR_test_demux) bitstream.cpp
	$(COMPILE.cc) $(CCFLAGS_test_demux) $(CPPFLAGS_test_demux) -o $@ bitstream.cpp

$(TARGETDIR_test_demux)/ES_MPEGAudio.o: $(TARGETDIR_test_demux) ES_MPEGAudio.cpp
	$(COMPILE.cc) $(CCFLAGS_test_demux) $(CPPFLAGS_test_demux) -o $@ ES_MPEGAudio.cpp

$(TARGETDIR_test_demux)/tsDemuxer.o: $(TARGETDIR_test_demux) tsDemuxer.cpp
	$(COMPILE.cc) $(CCFLAGS_test_demux) $(CPPFLAGS_test_demux) -o $@ tsDemuxer.cpp

$(TARGETDIR_test_demux)/elementaryStream.o: $(TARGETDIR_test_demux) elementaryStream.cpp
	$(COMPILE.cc) $(CCFLAGS_test_demux) $(CPPFLAGS_test_demux) -o $@ elementaryStream.cpp

$(TARGETDIR_test_demux)/ES_Subtitle.o: $(TARGETDIR_test_demux) ES_Subtitle.cpp
	$(COMPILE.cc) $(CCFLAGS_test_demux) $(CPPFLAGS_test_demux) -o $@ ES_Subtitle.cpp

$(TARGETDIR_test_demux)/debug.o: $(TARGETDIR_test_demux) debug.cpp
	$(COMPILE.cc) $(CCFLAGS_test_demux) $(CPPFLAGS_test_demux) -o $@ debug.cpp

$(TARGETDIR_test_demux)/test_demux.o: $(TARGETDIR_test_demux) test_demux.cpp
	$(COMPILE.cc) $(CCFLAGS_test_demux) $(CPPFLAGS_test_demux) -o $@ test_demux.cpp

$(TARGETDIR_test_demux)/ES_AAC.o: $(TARGETDIR_test_demux) ES_AAC.cpp
	$(COMPILE.cc) $(CCFLAGS_test_demux) $(CPPFLAGS_test_demux) -o $@ ES_AAC.cpp

$(TARGETDIR_test_demux)/ES_h264.o: $(TARGETDIR_test_demux) ES_h264.cpp
	$(COMPILE.cc) $(CCFLAGS_test_demux) $(CPPFLAGS_test_demux) -o $@ ES_h264.cpp

$(TARGETDIR_test_demux)/ES_Teletext.o: $(TARGETDIR_test_demux) ES_Teletext.cpp
	$(COMPILE.cc) $(CCFLAGS_test_demux) $(CPPFLAGS_test_demux) -o $@ ES_Teletext.cpp

$(TARGETDIR_test_demux)/ES_AC3.o: $(TARGETDIR_test_demux) ES_AC3.cpp
	$(COMPILE.cc) $(CCFLAGS_test_demux) $(CPPFLAGS_test_demux) -o $@ ES_AC3.cpp

$(TARGETDIR_test_demux)/ES_MPEGVideo.o: $(TARGETDIR_test_demux) ES_MPEGVideo.cpp
	$(COMPILE.cc) $(CCFLAGS_test_demux) $(CPPFLAGS_test_demux) -o $@ ES_MPEGVideo.cpp



#### Clean target deletes all generated files ####
clean:
	rm -f \
		$(TARGETDIR_test_demux)/test_demux \
		$(TARGETDIR_test_demux)/bitstream.o \
		$(TARGETDIR_test_demux)/ES_MPEGAudio.o \
		$(TARGETDIR_test_demux)/tsDemuxer.o \
		$(TARGETDIR_test_demux)/elementaryStream.o \
		$(TARGETDIR_test_demux)/ES_Subtitle.o \
		$(TARGETDIR_test_demux)/debug.o \
		$(TARGETDIR_test_demux)/test_demux.o \
		$(TARGETDIR_test_demux)/ES_AAC.o \
		$(TARGETDIR_test_demux)/ES_h264.o \
		$(TARGETDIR_test_demux)/ES_Teletext.o \
		$(TARGETDIR_test_demux)/ES_AC3.o \
		$(TARGETDIR_test_demux)/ES_MPEGVideo.o
	$(CCADMIN)
	rm -f -r $(TARGETDIR_test_demux)


# Create the target directory (if needed)
$(TARGETDIR_test_demux):
	mkdir -p $(TARGETDIR_test_demux)


# Enable dependency checking
.KEEP_STATE:
.KEEP_STATE_FILE:.make.state.GNU-amd64-Linux

