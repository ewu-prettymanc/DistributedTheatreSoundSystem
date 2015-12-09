

# Warning: This is an automatically generated file, do not edit!

srcdir=.
top_srcdir=.

include $(top_srcdir)/config.make

ifeq ($(CONFIG),DEBUG_X86)
ASSEMBLY_COMPILER_COMMAND = dmcs
ASSEMBLY_COMPILER_FLAGS =  -noconfig -codepage:utf8 -warn:4 -optimize- -debug "-define:DEBUG;" "-main:Audio.AudioCommandListener"
ASSEMBLY = bin/Debug/AudioCommandListener.exe
ASSEMBLY_MDB = $(ASSEMBLY).mdb
COMPILE_TARGET = exe
PROJECT_REFERENCES = 
BUILD_DIR = bin/Debug

AUDIOCOMMANDLISTENER_EXE_MDB_SOURCE=bin/Debug/AudioCommandListener.exe.mdb
AUDIOCOMMANDLISTENER_EXE_MDB=$(BUILD_DIR)/AudioCommandListener.exe.mdb

endif

ifeq ($(CONFIG),RELEASE_X86)
ASSEMBLY_COMPILER_COMMAND = dmcs
ASSEMBLY_COMPILER_FLAGS =  -noconfig -codepage:utf8 -warn:4 -optimize+ "-main:Audio.AudioCommandListener"
ASSEMBLY = bin/Release/AudioCommandListener.exe
ASSEMBLY_MDB = 
COMPILE_TARGET = exe
PROJECT_REFERENCES = 
BUILD_DIR = bin/Release

AUDIOCOMMANDLISTENER_EXE_MDB=

endif

AL=al
SATELLITE_ASSEMBLY_NAME=$(notdir $(basename $(ASSEMBLY))).resources.dll

PROGRAMFILES = \
	$(AUDIOCOMMANDLISTENER_EXE_MDB)  

BINARIES = \
	$(AUDIOCOMMANDLISTENER)  


RESGEN=resgen2

AUDIOCOMMANDLISTENER = $(BUILD_DIR)/audiocommandlistener

FILES = \
	src/Audio.cs \
	src/AudioBin.cs \
	src/AudioCommandListener.cs \
	src/CommandListener.cs \
	src/DurationResponder.cs \
	src/Logging.cs 

DATA_FILES = 

RESOURCES = 

EXTRAS = \
	audiocommandlistener.in 

REFERENCES =  \
	System \
	-pkg:glib-sharp-2.0 \
	-pkg:gstreamer-sharp-0.10

DLL_REFERENCES = 

CLEANFILES = $(PROGRAMFILES) $(BINARIES) 

#Targets
all-local: $(ASSEMBLY) $(PROGRAMFILES) $(BINARIES)  $(top_srcdir)/config.make



$(eval $(call emit-deploy-wrapper,AUDIOCOMMANDLISTENER,audiocommandlistener,x))


$(eval $(call emit_resgen_targets))
$(build_xamlg_list): %.xaml.g.cs: %.xaml
	xamlg '$<'


$(ASSEMBLY_MDB): $(ASSEMBLY)
$(ASSEMBLY): $(build_sources) $(build_resources) $(build_datafiles) $(DLL_REFERENCES) $(PROJECT_REFERENCES) $(build_xamlg_list) $(build_satellite_assembly_list)
	make pre-all-local-hook prefix=$(prefix)
	mkdir -p $(shell dirname $(ASSEMBLY))
	make $(CONFIG)_BeforeBuild
	$(ASSEMBLY_COMPILER_COMMAND) $(ASSEMBLY_COMPILER_FLAGS) -out:$(ASSEMBLY) -target:$(COMPILE_TARGET) $(build_sources_embed) $(build_resources_embed) $(build_references_ref)
	make $(CONFIG)_AfterBuild
	make post-all-local-hook prefix=$(prefix)

install-local: $(ASSEMBLY) $(ASSEMBLY_MDB)
	make pre-install-local-hook prefix=$(prefix)
	make install-satellite-assemblies prefix=$(prefix)
	mkdir -p '$(DESTDIR)$(libdir)/$(PACKAGE)'
	$(call cp,$(ASSEMBLY),$(DESTDIR)$(libdir)/$(PACKAGE))
	$(call cp,$(ASSEMBLY_MDB),$(DESTDIR)$(libdir)/$(PACKAGE))
	$(call cp,$(AUDIOCOMMANDLISTENER_EXE_MDB),$(DESTDIR)$(libdir)/$(PACKAGE))
	mkdir -p '$(DESTDIR)$(bindir)'
	$(call cp,$(AUDIOCOMMANDLISTENER),$(DESTDIR)$(bindir))
	make post-install-local-hook prefix=$(prefix)

uninstall-local: $(ASSEMBLY) $(ASSEMBLY_MDB)
	make pre-uninstall-local-hook prefix=$(prefix)
	make uninstall-satellite-assemblies prefix=$(prefix)
	$(call rm,$(ASSEMBLY),$(DESTDIR)$(libdir)/$(PACKAGE))
	$(call rm,$(ASSEMBLY_MDB),$(DESTDIR)$(libdir)/$(PACKAGE))
	$(call rm,$(AUDIOCOMMANDLISTENER_EXE_MDB),$(DESTDIR)$(libdir)/$(PACKAGE))
	$(call rm,$(AUDIOCOMMANDLISTENER),$(DESTDIR)$(bindir))
	make post-uninstall-local-hook prefix=$(prefix)
