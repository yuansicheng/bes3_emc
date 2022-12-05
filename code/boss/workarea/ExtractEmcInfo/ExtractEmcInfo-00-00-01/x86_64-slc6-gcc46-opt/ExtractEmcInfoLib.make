#-- start of make_header -----------------

#====================================
#  Library ExtractEmcInfoLib
#
#   Generated Thu Dec  1 15:28:47 2022  by yuansc
#
#====================================

include ${CMTROOT}/src/Makefile.core

ifdef tag
CMTEXTRATAGS = $(tag)
else
tag       = $(CMTCONFIG)
endif

cmt_ExtractEmcInfoLib_has_no_target_tag = 1

#--------------------------------------------------------

ifdef cmt_ExtractEmcInfoLib_has_target_tag

tags      = $(tag),$(CMTEXTRATAGS),target_ExtractEmcInfoLib

ExtractEmcInfo_tag = $(tag)

#cmt_local_tagfile_ExtractEmcInfoLib = $(ExtractEmcInfo_tag)_ExtractEmcInfoLib.make
cmt_local_tagfile_ExtractEmcInfoLib = $(bin)$(ExtractEmcInfo_tag)_ExtractEmcInfoLib.make

else

tags      = $(tag),$(CMTEXTRATAGS)

ExtractEmcInfo_tag = $(tag)

#cmt_local_tagfile_ExtractEmcInfoLib = $(ExtractEmcInfo_tag).make
cmt_local_tagfile_ExtractEmcInfoLib = $(bin)$(ExtractEmcInfo_tag).make

endif

include $(cmt_local_tagfile_ExtractEmcInfoLib)
#-include $(cmt_local_tagfile_ExtractEmcInfoLib)

ifdef cmt_ExtractEmcInfoLib_has_target_tag

cmt_final_setup_ExtractEmcInfoLib = $(bin)setup_ExtractEmcInfoLib.make
cmt_dependencies_in_ExtractEmcInfoLib = $(bin)dependencies_ExtractEmcInfoLib.in
#cmt_final_setup_ExtractEmcInfoLib = $(bin)ExtractEmcInfo_ExtractEmcInfoLibsetup.make
cmt_local_ExtractEmcInfoLib_makefile = $(bin)ExtractEmcInfoLib.make

else

cmt_final_setup_ExtractEmcInfoLib = $(bin)setup.make
cmt_dependencies_in_ExtractEmcInfoLib = $(bin)dependencies.in
#cmt_final_setup_ExtractEmcInfoLib = $(bin)ExtractEmcInfosetup.make
cmt_local_ExtractEmcInfoLib_makefile = $(bin)ExtractEmcInfoLib.make

endif

#cmt_final_setup = $(bin)setup.make
#cmt_final_setup = $(bin)ExtractEmcInfosetup.make

#ExtractEmcInfoLib :: ;

dirs ::
	@if test ! -r requirements ; then echo "No requirements file" ; fi; \
	  if test ! -d $(bin) ; then $(mkdir) -p $(bin) ; fi

javadirs ::
	@if test ! -d $(javabin) ; then $(mkdir) -p $(javabin) ; fi

srcdirs ::
	@if test ! -d $(src) ; then $(mkdir) -p $(src) ; fi

help ::
	$(echo) 'ExtractEmcInfoLib'

binobj = 
ifdef STRUCTURED_OUTPUT
binobj = ExtractEmcInfoLib/
#ExtractEmcInfoLib::
#	@if test ! -d $(bin)$(binobj) ; then $(mkdir) -p $(bin)$(binobj) ; fi
#	$(echo) "STRUCTURED_OUTPUT="$(bin)$(binobj)
endif

${CMTROOT}/src/Makefile.core : ;
ifdef use_requirements
$(use_requirements) : ;
endif

#-- end of make_header ------------------
#-- start of libary_header ---------------

ExtractEmcInfoLiblibname   = $(bin)$(library_prefix)ExtractEmcInfoLib$(library_suffix)
ExtractEmcInfoLiblib       = $(ExtractEmcInfoLiblibname).a
ExtractEmcInfoLibstamp     = $(bin)ExtractEmcInfoLib.stamp
ExtractEmcInfoLibshstamp   = $(bin)ExtractEmcInfoLib.shstamp

ExtractEmcInfoLib :: dirs  ExtractEmcInfoLibLIB
	$(echo) "ExtractEmcInfoLib ok"

#-- end of libary_header ----------------

ExtractEmcInfoLibLIB :: $(ExtractEmcInfoLiblib) $(ExtractEmcInfoLibshstamp)
	@/bin/echo "------> ExtractEmcInfoLib : library ok"

$(ExtractEmcInfoLiblib) :: $(bin)ExtractEmcInfo.o $(bin)ExtractEmcInfo_load.o $(bin)ExtractEmcInfo_entries.o
	$(lib_echo) library
	$(lib_silent) cd $(bin); \
	  $(ar) $(ExtractEmcInfoLiblib) $?
	$(lib_silent) $(ranlib) $(ExtractEmcInfoLiblib)
	$(lib_silent) cat /dev/null >$(ExtractEmcInfoLibstamp)

#------------------------------------------------------------------
#  Future improvement? to empty the object files after
#  storing in the library
#
##	  for f in $?; do \
##	    rm $${f}; touch $${f}; \
##	  done
#------------------------------------------------------------------

$(ExtractEmcInfoLiblibname).$(shlibsuffix) :: $(ExtractEmcInfoLiblib) $(ExtractEmcInfoLibstamps)
	$(lib_silent) cd $(bin); QUIET=$(QUIET); $(make_shlib) "$(tags)" ExtractEmcInfoLib $(ExtractEmcInfoLib_shlibflags)

$(ExtractEmcInfoLibshstamp) :: $(ExtractEmcInfoLiblibname).$(shlibsuffix)
	@if test -f $(ExtractEmcInfoLiblibname).$(shlibsuffix) ; then cat /dev/null >$(ExtractEmcInfoLibshstamp) ; fi

ExtractEmcInfoLibclean ::
	$(cleanup_echo) objects
	$(cleanup_silent) cd $(bin); /bin/rm -f $(bin)ExtractEmcInfo.o $(bin)ExtractEmcInfo_load.o $(bin)ExtractEmcInfo_entries.o

#-----------------------------------------------------------------
#
#  New section for automatic installation
#
#-----------------------------------------------------------------

ifeq ($(INSTALLAREA),)
installarea = $(CMTINSTALLAREA)
else
ifeq ($(findstring `,$(INSTALLAREA)),`)
installarea = $(shell $(subst `,, $(INSTALLAREA)))
else
installarea = $(INSTALLAREA)
endif
endif

install_dir = ${installarea}/${CMTCONFIG}/lib
ExtractEmcInfoLibinstallname = $(library_prefix)ExtractEmcInfoLib$(library_suffix).$(shlibsuffix)

ExtractEmcInfoLib :: ExtractEmcInfoLibinstall

install :: ExtractEmcInfoLibinstall

ExtractEmcInfoLibinstall :: $(install_dir)/$(ExtractEmcInfoLibinstallname)
	@if test ! "${installarea}" = ""; then\
	  echo "installation done"; \
	fi

$(install_dir)/$(ExtractEmcInfoLibinstallname) :: $(bin)$(ExtractEmcInfoLibinstallname)
	@if test ! "${installarea}" = ""; then \
	  cd $(bin); \
	  if test ! "$(install_dir)" = ""; then \
	    if test ! -d "$(install_dir)"; then \
	      mkdir -p $(install_dir); \
	    fi ; \
	    if test -d "$(install_dir)"; then \
	      echo "Installing library $(ExtractEmcInfoLibinstallname) into $(install_dir)"; \
	      if test -e $(install_dir)/$(ExtractEmcInfoLibinstallname); then \
	        $(cmt_uninstall_area_command) $(install_dir)/$(ExtractEmcInfoLibinstallname); \
	        $(cmt_uninstall_area_command) $(install_dir)/$(ExtractEmcInfoLibinstallname).cmtref; \
	      fi; \
	      $(cmt_install_area_command) `pwd`/$(ExtractEmcInfoLibinstallname) $(install_dir)/$(ExtractEmcInfoLibinstallname); \
	      echo `pwd`/$(ExtractEmcInfoLibinstallname) >$(install_dir)/$(ExtractEmcInfoLibinstallname).cmtref; \
	    fi \
          else \
	    echo "Cannot install library $(ExtractEmcInfoLibinstallname), no installation directory specified"; \
	  fi; \
	fi

ExtractEmcInfoLibclean :: ExtractEmcInfoLibuninstall

uninstall :: ExtractEmcInfoLibuninstall

ExtractEmcInfoLibuninstall ::
	@if test ! "${installarea}" = ""; then \
	  cd $(bin); \
	  if test ! "$(install_dir)" = ""; then \
	    if test -d "$(install_dir)"; then \
	      echo "Removing installed library $(ExtractEmcInfoLibinstallname) from $(install_dir)"; \
	      $(cmt_uninstall_area_command) $(install_dir)/$(ExtractEmcInfoLibinstallname); \
	      $(cmt_uninstall_area_command) $(install_dir)/$(ExtractEmcInfoLibinstallname).cmtref; \
	    fi \
          else \
	    echo "Cannot uninstall library $(ExtractEmcInfoLibinstallname), no installation directory specified"; \
	  fi; \
	fi




#-- start of cpp_library -----------------

ifneq (-MMD -MP -MF $*.d -MQ $@,)

ifneq ($(MAKECMDGOALS),ExtractEmcInfoLibclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)ExtractEmcInfo.d

$(bin)$(binobj)ExtractEmcInfo.d :

$(bin)$(binobj)ExtractEmcInfo.o : $(cmt_final_setup_ExtractEmcInfoLib)

$(bin)$(binobj)ExtractEmcInfo.o : $(src)ExtractEmcInfo.cxx
	$(cpp_echo) $(src)ExtractEmcInfo.cxx
	$(cpp_silent) $(cppcomp) -MMD -MP -MF $*.d -MQ $@ -o $@ $(use_pp_cppflags) $(ExtractEmcInfoLib_pp_cppflags) $(lib_ExtractEmcInfoLib_pp_cppflags) $(ExtractEmcInfo_pp_cppflags) $(use_cppflags) $(ExtractEmcInfoLib_cppflags) $(lib_ExtractEmcInfoLib_cppflags) $(ExtractEmcInfo_cppflags) $(ExtractEmcInfo_cxx_cppflags)  $(src)ExtractEmcInfo.cxx
endif
endif

else
$(bin)ExtractEmcInfoLib_dependencies.make : $(ExtractEmcInfo_cxx_dependencies)

$(bin)ExtractEmcInfoLib_dependencies.make : $(src)ExtractEmcInfo.cxx

$(bin)$(binobj)ExtractEmcInfo.o : $(ExtractEmcInfo_cxx_dependencies)
	$(cpp_echo) $(src)ExtractEmcInfo.cxx
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(ExtractEmcInfoLib_pp_cppflags) $(lib_ExtractEmcInfoLib_pp_cppflags) $(ExtractEmcInfo_pp_cppflags) $(use_cppflags) $(ExtractEmcInfoLib_cppflags) $(lib_ExtractEmcInfoLib_cppflags) $(ExtractEmcInfo_cppflags) $(ExtractEmcInfo_cxx_cppflags)  $(src)ExtractEmcInfo.cxx

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (-MMD -MP -MF $*.d -MQ $@,)

ifneq ($(MAKECMDGOALS),ExtractEmcInfoLibclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)ExtractEmcInfo_load.d

$(bin)$(binobj)ExtractEmcInfo_load.d :

$(bin)$(binobj)ExtractEmcInfo_load.o : $(cmt_final_setup_ExtractEmcInfoLib)

$(bin)$(binobj)ExtractEmcInfo_load.o : $(src)components/ExtractEmcInfo_load.cxx
	$(cpp_echo) $(src)components/ExtractEmcInfo_load.cxx
	$(cpp_silent) $(cppcomp) -MMD -MP -MF $*.d -MQ $@ -o $@ $(use_pp_cppflags) $(ExtractEmcInfoLib_pp_cppflags) $(lib_ExtractEmcInfoLib_pp_cppflags) $(ExtractEmcInfo_load_pp_cppflags) $(use_cppflags) $(ExtractEmcInfoLib_cppflags) $(lib_ExtractEmcInfoLib_cppflags) $(ExtractEmcInfo_load_cppflags) $(ExtractEmcInfo_load_cxx_cppflags) -I../src/components $(src)components/ExtractEmcInfo_load.cxx
endif
endif

else
$(bin)ExtractEmcInfoLib_dependencies.make : $(ExtractEmcInfo_load_cxx_dependencies)

$(bin)ExtractEmcInfoLib_dependencies.make : $(src)components/ExtractEmcInfo_load.cxx

$(bin)$(binobj)ExtractEmcInfo_load.o : $(ExtractEmcInfo_load_cxx_dependencies)
	$(cpp_echo) $(src)components/ExtractEmcInfo_load.cxx
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(ExtractEmcInfoLib_pp_cppflags) $(lib_ExtractEmcInfoLib_pp_cppflags) $(ExtractEmcInfo_load_pp_cppflags) $(use_cppflags) $(ExtractEmcInfoLib_cppflags) $(lib_ExtractEmcInfoLib_cppflags) $(ExtractEmcInfo_load_cppflags) $(ExtractEmcInfo_load_cxx_cppflags) -I../src/components $(src)components/ExtractEmcInfo_load.cxx

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (-MMD -MP -MF $*.d -MQ $@,)

ifneq ($(MAKECMDGOALS),ExtractEmcInfoLibclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)ExtractEmcInfo_entries.d

$(bin)$(binobj)ExtractEmcInfo_entries.d :

$(bin)$(binobj)ExtractEmcInfo_entries.o : $(cmt_final_setup_ExtractEmcInfoLib)

$(bin)$(binobj)ExtractEmcInfo_entries.o : $(src)components/ExtractEmcInfo_entries.cxx
	$(cpp_echo) $(src)components/ExtractEmcInfo_entries.cxx
	$(cpp_silent) $(cppcomp) -MMD -MP -MF $*.d -MQ $@ -o $@ $(use_pp_cppflags) $(ExtractEmcInfoLib_pp_cppflags) $(lib_ExtractEmcInfoLib_pp_cppflags) $(ExtractEmcInfo_entries_pp_cppflags) $(use_cppflags) $(ExtractEmcInfoLib_cppflags) $(lib_ExtractEmcInfoLib_cppflags) $(ExtractEmcInfo_entries_cppflags) $(ExtractEmcInfo_entries_cxx_cppflags) -I../src/components $(src)components/ExtractEmcInfo_entries.cxx
endif
endif

else
$(bin)ExtractEmcInfoLib_dependencies.make : $(ExtractEmcInfo_entries_cxx_dependencies)

$(bin)ExtractEmcInfoLib_dependencies.make : $(src)components/ExtractEmcInfo_entries.cxx

$(bin)$(binobj)ExtractEmcInfo_entries.o : $(ExtractEmcInfo_entries_cxx_dependencies)
	$(cpp_echo) $(src)components/ExtractEmcInfo_entries.cxx
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(ExtractEmcInfoLib_pp_cppflags) $(lib_ExtractEmcInfoLib_pp_cppflags) $(ExtractEmcInfo_entries_pp_cppflags) $(use_cppflags) $(ExtractEmcInfoLib_cppflags) $(lib_ExtractEmcInfoLib_cppflags) $(ExtractEmcInfo_entries_cppflags) $(ExtractEmcInfo_entries_cxx_cppflags) -I../src/components $(src)components/ExtractEmcInfo_entries.cxx

endif

#-- end of cpp_library ------------------
#-- start of cleanup_header --------------

clean :: ExtractEmcInfoLibclean ;
#	@cd .

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(ExtractEmcInfoLib.make) $@: No rule for such target" >&2
else
.DEFAULT::
	$(error PEDANTIC: $@: No rule for such target)
endif

ExtractEmcInfoLibclean ::
#-- end of cleanup_header ---------------
#-- start of cleanup_library -------------
	$(cleanup_echo) library ExtractEmcInfoLib
	-$(cleanup_silent) cd $(bin); /bin/rm -f $(library_prefix)ExtractEmcInfoLib$(library_suffix).a $(library_prefix)ExtractEmcInfoLib$(library_suffix).s? ExtractEmcInfoLib.stamp ExtractEmcInfoLib.shstamp
#-- end of cleanup_library ---------------
