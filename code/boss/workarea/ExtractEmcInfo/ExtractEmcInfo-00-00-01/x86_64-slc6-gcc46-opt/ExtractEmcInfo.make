#-- start of make_header -----------------

#====================================
#  Library ExtractEmcInfo
#
#   Generated Thu Dec  1 15:28:53 2022  by yuansc
#
#====================================

include ${CMTROOT}/src/Makefile.core

ifdef tag
CMTEXTRATAGS = $(tag)
else
tag       = $(CMTCONFIG)
endif

cmt_ExtractEmcInfo_has_no_target_tag = 1

#--------------------------------------------------------

ifdef cmt_ExtractEmcInfo_has_target_tag

tags      = $(tag),$(CMTEXTRATAGS),target_ExtractEmcInfo

ExtractEmcInfo_tag = $(tag)

#cmt_local_tagfile_ExtractEmcInfo = $(ExtractEmcInfo_tag)_ExtractEmcInfo.make
cmt_local_tagfile_ExtractEmcInfo = $(bin)$(ExtractEmcInfo_tag)_ExtractEmcInfo.make

else

tags      = $(tag),$(CMTEXTRATAGS)

ExtractEmcInfo_tag = $(tag)

#cmt_local_tagfile_ExtractEmcInfo = $(ExtractEmcInfo_tag).make
cmt_local_tagfile_ExtractEmcInfo = $(bin)$(ExtractEmcInfo_tag).make

endif

include $(cmt_local_tagfile_ExtractEmcInfo)
#-include $(cmt_local_tagfile_ExtractEmcInfo)

ifdef cmt_ExtractEmcInfo_has_target_tag

cmt_final_setup_ExtractEmcInfo = $(bin)setup_ExtractEmcInfo.make
cmt_dependencies_in_ExtractEmcInfo = $(bin)dependencies_ExtractEmcInfo.in
#cmt_final_setup_ExtractEmcInfo = $(bin)ExtractEmcInfo_ExtractEmcInfosetup.make
cmt_local_ExtractEmcInfo_makefile = $(bin)ExtractEmcInfo.make

else

cmt_final_setup_ExtractEmcInfo = $(bin)setup.make
cmt_dependencies_in_ExtractEmcInfo = $(bin)dependencies.in
#cmt_final_setup_ExtractEmcInfo = $(bin)ExtractEmcInfosetup.make
cmt_local_ExtractEmcInfo_makefile = $(bin)ExtractEmcInfo.make

endif

#cmt_final_setup = $(bin)setup.make
#cmt_final_setup = $(bin)ExtractEmcInfosetup.make

#ExtractEmcInfo :: ;

dirs ::
	@if test ! -r requirements ; then echo "No requirements file" ; fi; \
	  if test ! -d $(bin) ; then $(mkdir) -p $(bin) ; fi

javadirs ::
	@if test ! -d $(javabin) ; then $(mkdir) -p $(javabin) ; fi

srcdirs ::
	@if test ! -d $(src) ; then $(mkdir) -p $(src) ; fi

help ::
	$(echo) 'ExtractEmcInfo'

binobj = 
ifdef STRUCTURED_OUTPUT
binobj = ExtractEmcInfo/
#ExtractEmcInfo::
#	@if test ! -d $(bin)$(binobj) ; then $(mkdir) -p $(bin)$(binobj) ; fi
#	$(echo) "STRUCTURED_OUTPUT="$(bin)$(binobj)
endif

${CMTROOT}/src/Makefile.core : ;
ifdef use_requirements
$(use_requirements) : ;
endif

#-- end of make_header ------------------
#-- start of libary_header ---------------

ExtractEmcInfolibname   = $(bin)$(library_prefix)ExtractEmcInfo$(library_suffix)
ExtractEmcInfolib       = $(ExtractEmcInfolibname).a
ExtractEmcInfostamp     = $(bin)ExtractEmcInfo.stamp
ExtractEmcInfoshstamp   = $(bin)ExtractEmcInfo.shstamp

ExtractEmcInfo :: dirs  ExtractEmcInfoLIB
	$(echo) "ExtractEmcInfo ok"

#-- end of libary_header ----------------

ExtractEmcInfoLIB :: $(ExtractEmcInfolib) $(ExtractEmcInfoshstamp)
	@/bin/echo "------> ExtractEmcInfo : library ok"

$(ExtractEmcInfolib) :: $(bin)ExtractEmcInfo_load.o $(bin)ExtractEmcInfo_entries.o $(bin)ExtractEmcInfo.o $(bin)ExtractEmcInfo_load.o $(bin)ExtractEmcInfo_entries.o
	$(lib_echo) library
	$(lib_silent) cd $(bin); \
	  $(ar) $(ExtractEmcInfolib) $?
	$(lib_silent) $(ranlib) $(ExtractEmcInfolib)
	$(lib_silent) cat /dev/null >$(ExtractEmcInfostamp)

#------------------------------------------------------------------
#  Future improvement? to empty the object files after
#  storing in the library
#
##	  for f in $?; do \
##	    rm $${f}; touch $${f}; \
##	  done
#------------------------------------------------------------------

$(ExtractEmcInfolibname).$(shlibsuffix) :: $(ExtractEmcInfolib) $(ExtractEmcInfostamps)
	$(lib_silent) cd $(bin); QUIET=$(QUIET); $(make_shlib) "$(tags)" ExtractEmcInfo $(ExtractEmcInfo_shlibflags)

$(ExtractEmcInfoshstamp) :: $(ExtractEmcInfolibname).$(shlibsuffix)
	@if test -f $(ExtractEmcInfolibname).$(shlibsuffix) ; then cat /dev/null >$(ExtractEmcInfoshstamp) ; fi

ExtractEmcInfoclean ::
	$(cleanup_echo) objects
	$(cleanup_silent) cd $(bin); /bin/rm -f $(bin)ExtractEmcInfo_load.o $(bin)ExtractEmcInfo_entries.o $(bin)ExtractEmcInfo.o $(bin)ExtractEmcInfo_load.o $(bin)ExtractEmcInfo_entries.o

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
ExtractEmcInfoinstallname = $(library_prefix)ExtractEmcInfo$(library_suffix).$(shlibsuffix)

ExtractEmcInfo :: ExtractEmcInfoinstall

install :: ExtractEmcInfoinstall

ExtractEmcInfoinstall :: $(install_dir)/$(ExtractEmcInfoinstallname)
	@if test ! "${installarea}" = ""; then\
	  echo "installation done"; \
	fi

$(install_dir)/$(ExtractEmcInfoinstallname) :: $(bin)$(ExtractEmcInfoinstallname)
	@if test ! "${installarea}" = ""; then \
	  cd $(bin); \
	  if test ! "$(install_dir)" = ""; then \
	    if test ! -d "$(install_dir)"; then \
	      mkdir -p $(install_dir); \
	    fi ; \
	    if test -d "$(install_dir)"; then \
	      echo "Installing library $(ExtractEmcInfoinstallname) into $(install_dir)"; \
	      if test -e $(install_dir)/$(ExtractEmcInfoinstallname); then \
	        $(cmt_uninstall_area_command) $(install_dir)/$(ExtractEmcInfoinstallname); \
	        $(cmt_uninstall_area_command) $(install_dir)/$(ExtractEmcInfoinstallname).cmtref; \
	      fi; \
	      $(cmt_install_area_command) `pwd`/$(ExtractEmcInfoinstallname) $(install_dir)/$(ExtractEmcInfoinstallname); \
	      echo `pwd`/$(ExtractEmcInfoinstallname) >$(install_dir)/$(ExtractEmcInfoinstallname).cmtref; \
	    fi \
          else \
	    echo "Cannot install library $(ExtractEmcInfoinstallname), no installation directory specified"; \
	  fi; \
	fi

ExtractEmcInfoclean :: ExtractEmcInfouninstall

uninstall :: ExtractEmcInfouninstall

ExtractEmcInfouninstall ::
	@if test ! "${installarea}" = ""; then \
	  cd $(bin); \
	  if test ! "$(install_dir)" = ""; then \
	    if test -d "$(install_dir)"; then \
	      echo "Removing installed library $(ExtractEmcInfoinstallname) from $(install_dir)"; \
	      $(cmt_uninstall_area_command) $(install_dir)/$(ExtractEmcInfoinstallname); \
	      $(cmt_uninstall_area_command) $(install_dir)/$(ExtractEmcInfoinstallname).cmtref; \
	    fi \
          else \
	    echo "Cannot uninstall library $(ExtractEmcInfoinstallname), no installation directory specified"; \
	  fi; \
	fi




#-- start of cpp_library -----------------

ifneq (-MMD -MP -MF $*.d -MQ $@,)

ifneq ($(MAKECMDGOALS),ExtractEmcInfoclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)ExtractEmcInfo_load.d

$(bin)$(binobj)ExtractEmcInfo_load.d :

$(bin)$(binobj)ExtractEmcInfo_load.o : $(cmt_final_setup_ExtractEmcInfo)

$(bin)$(binobj)ExtractEmcInfo_load.o : $(src)components/ExtractEmcInfo_load.cxx
	$(cpp_echo) $(src)components/ExtractEmcInfo_load.cxx
	$(cpp_silent) $(cppcomp) -MMD -MP -MF $*.d -MQ $@ -o $@ $(use_pp_cppflags) $(ExtractEmcInfo_pp_cppflags) $(lib_ExtractEmcInfo_pp_cppflags) $(ExtractEmcInfo_load_pp_cppflags) $(use_cppflags) $(ExtractEmcInfo_cppflags) $(lib_ExtractEmcInfo_cppflags) $(ExtractEmcInfo_load_cppflags) $(ExtractEmcInfo_load_cxx_cppflags) -I../src/components $(src)components/ExtractEmcInfo_load.cxx
endif
endif

else
$(bin)ExtractEmcInfo_dependencies.make : $(ExtractEmcInfo_load_cxx_dependencies)

$(bin)ExtractEmcInfo_dependencies.make : $(src)components/ExtractEmcInfo_load.cxx

$(bin)$(binobj)ExtractEmcInfo_load.o : $(ExtractEmcInfo_load_cxx_dependencies)
	$(cpp_echo) $(src)components/ExtractEmcInfo_load.cxx
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(ExtractEmcInfo_pp_cppflags) $(lib_ExtractEmcInfo_pp_cppflags) $(ExtractEmcInfo_load_pp_cppflags) $(use_cppflags) $(ExtractEmcInfo_cppflags) $(lib_ExtractEmcInfo_cppflags) $(ExtractEmcInfo_load_cppflags) $(ExtractEmcInfo_load_cxx_cppflags) -I../src/components $(src)components/ExtractEmcInfo_load.cxx

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (-MMD -MP -MF $*.d -MQ $@,)

ifneq ($(MAKECMDGOALS),ExtractEmcInfoclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)ExtractEmcInfo_entries.d

$(bin)$(binobj)ExtractEmcInfo_entries.d :

$(bin)$(binobj)ExtractEmcInfo_entries.o : $(cmt_final_setup_ExtractEmcInfo)

$(bin)$(binobj)ExtractEmcInfo_entries.o : $(src)components/ExtractEmcInfo_entries.cxx
	$(cpp_echo) $(src)components/ExtractEmcInfo_entries.cxx
	$(cpp_silent) $(cppcomp) -MMD -MP -MF $*.d -MQ $@ -o $@ $(use_pp_cppflags) $(ExtractEmcInfo_pp_cppflags) $(lib_ExtractEmcInfo_pp_cppflags) $(ExtractEmcInfo_entries_pp_cppflags) $(use_cppflags) $(ExtractEmcInfo_cppflags) $(lib_ExtractEmcInfo_cppflags) $(ExtractEmcInfo_entries_cppflags) $(ExtractEmcInfo_entries_cxx_cppflags) -I../src/components $(src)components/ExtractEmcInfo_entries.cxx
endif
endif

else
$(bin)ExtractEmcInfo_dependencies.make : $(ExtractEmcInfo_entries_cxx_dependencies)

$(bin)ExtractEmcInfo_dependencies.make : $(src)components/ExtractEmcInfo_entries.cxx

$(bin)$(binobj)ExtractEmcInfo_entries.o : $(ExtractEmcInfo_entries_cxx_dependencies)
	$(cpp_echo) $(src)components/ExtractEmcInfo_entries.cxx
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(ExtractEmcInfo_pp_cppflags) $(lib_ExtractEmcInfo_pp_cppflags) $(ExtractEmcInfo_entries_pp_cppflags) $(use_cppflags) $(ExtractEmcInfo_cppflags) $(lib_ExtractEmcInfo_cppflags) $(ExtractEmcInfo_entries_cppflags) $(ExtractEmcInfo_entries_cxx_cppflags) -I../src/components $(src)components/ExtractEmcInfo_entries.cxx

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (-MMD -MP -MF $*.d -MQ $@,)

ifneq ($(MAKECMDGOALS),ExtractEmcInfoclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)ExtractEmcInfo.d

$(bin)$(binobj)ExtractEmcInfo.d :

$(bin)$(binobj)ExtractEmcInfo.o : $(cmt_final_setup_ExtractEmcInfo)

$(bin)$(binobj)ExtractEmcInfo.o : $(src)ExtractEmcInfo.cxx
	$(cpp_echo) $(src)ExtractEmcInfo.cxx
	$(cpp_silent) $(cppcomp) -MMD -MP -MF $*.d -MQ $@ -o $@ $(use_pp_cppflags) $(ExtractEmcInfo_pp_cppflags) $(lib_ExtractEmcInfo_pp_cppflags) $(ExtractEmcInfo_pp_cppflags) $(use_cppflags) $(ExtractEmcInfo_cppflags) $(lib_ExtractEmcInfo_cppflags) $(ExtractEmcInfo_cppflags) $(ExtractEmcInfo_cxx_cppflags)  $(src)ExtractEmcInfo.cxx
endif
endif

else
$(bin)ExtractEmcInfo_dependencies.make : $(ExtractEmcInfo_cxx_dependencies)

$(bin)ExtractEmcInfo_dependencies.make : $(src)ExtractEmcInfo.cxx

$(bin)$(binobj)ExtractEmcInfo.o : $(ExtractEmcInfo_cxx_dependencies)
	$(cpp_echo) $(src)ExtractEmcInfo.cxx
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(ExtractEmcInfo_pp_cppflags) $(lib_ExtractEmcInfo_pp_cppflags) $(ExtractEmcInfo_pp_cppflags) $(use_cppflags) $(ExtractEmcInfo_cppflags) $(lib_ExtractEmcInfo_cppflags) $(ExtractEmcInfo_cppflags) $(ExtractEmcInfo_cxx_cppflags)  $(src)ExtractEmcInfo.cxx

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (-MMD -MP -MF $*.d -MQ $@,)

ifneq ($(MAKECMDGOALS),ExtractEmcInfoclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)ExtractEmcInfo_load.d

$(bin)$(binobj)ExtractEmcInfo_load.d :

$(bin)$(binobj)ExtractEmcInfo_load.o : $(cmt_final_setup_ExtractEmcInfo)

$(bin)$(binobj)ExtractEmcInfo_load.o : $(src)components/ExtractEmcInfo_load.cxx
	$(cpp_echo) $(src)components/ExtractEmcInfo_load.cxx
	$(cpp_silent) $(cppcomp) -MMD -MP -MF $*.d -MQ $@ -o $@ $(use_pp_cppflags) $(ExtractEmcInfo_pp_cppflags) $(lib_ExtractEmcInfo_pp_cppflags) $(ExtractEmcInfo_load_pp_cppflags) $(use_cppflags) $(ExtractEmcInfo_cppflags) $(lib_ExtractEmcInfo_cppflags) $(ExtractEmcInfo_load_cppflags) $(ExtractEmcInfo_load_cxx_cppflags) -I../src/components $(src)components/ExtractEmcInfo_load.cxx
endif
endif

else
$(bin)ExtractEmcInfo_dependencies.make : $(ExtractEmcInfo_load_cxx_dependencies)

$(bin)ExtractEmcInfo_dependencies.make : $(src)components/ExtractEmcInfo_load.cxx

$(bin)$(binobj)ExtractEmcInfo_load.o : $(ExtractEmcInfo_load_cxx_dependencies)
	$(cpp_echo) $(src)components/ExtractEmcInfo_load.cxx
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(ExtractEmcInfo_pp_cppflags) $(lib_ExtractEmcInfo_pp_cppflags) $(ExtractEmcInfo_load_pp_cppflags) $(use_cppflags) $(ExtractEmcInfo_cppflags) $(lib_ExtractEmcInfo_cppflags) $(ExtractEmcInfo_load_cppflags) $(ExtractEmcInfo_load_cxx_cppflags) -I../src/components $(src)components/ExtractEmcInfo_load.cxx

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (-MMD -MP -MF $*.d -MQ $@,)

ifneq ($(MAKECMDGOALS),ExtractEmcInfoclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)ExtractEmcInfo_entries.d

$(bin)$(binobj)ExtractEmcInfo_entries.d :

$(bin)$(binobj)ExtractEmcInfo_entries.o : $(cmt_final_setup_ExtractEmcInfo)

$(bin)$(binobj)ExtractEmcInfo_entries.o : $(src)components/ExtractEmcInfo_entries.cxx
	$(cpp_echo) $(src)components/ExtractEmcInfo_entries.cxx
	$(cpp_silent) $(cppcomp) -MMD -MP -MF $*.d -MQ $@ -o $@ $(use_pp_cppflags) $(ExtractEmcInfo_pp_cppflags) $(lib_ExtractEmcInfo_pp_cppflags) $(ExtractEmcInfo_entries_pp_cppflags) $(use_cppflags) $(ExtractEmcInfo_cppflags) $(lib_ExtractEmcInfo_cppflags) $(ExtractEmcInfo_entries_cppflags) $(ExtractEmcInfo_entries_cxx_cppflags) -I../src/components $(src)components/ExtractEmcInfo_entries.cxx
endif
endif

else
$(bin)ExtractEmcInfo_dependencies.make : $(ExtractEmcInfo_entries_cxx_dependencies)

$(bin)ExtractEmcInfo_dependencies.make : $(src)components/ExtractEmcInfo_entries.cxx

$(bin)$(binobj)ExtractEmcInfo_entries.o : $(ExtractEmcInfo_entries_cxx_dependencies)
	$(cpp_echo) $(src)components/ExtractEmcInfo_entries.cxx
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(ExtractEmcInfo_pp_cppflags) $(lib_ExtractEmcInfo_pp_cppflags) $(ExtractEmcInfo_entries_pp_cppflags) $(use_cppflags) $(ExtractEmcInfo_cppflags) $(lib_ExtractEmcInfo_cppflags) $(ExtractEmcInfo_entries_cppflags) $(ExtractEmcInfo_entries_cxx_cppflags) -I../src/components $(src)components/ExtractEmcInfo_entries.cxx

endif

#-- end of cpp_library ------------------
#-- start of cleanup_header --------------

clean :: ExtractEmcInfoclean ;
#	@cd .

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(ExtractEmcInfo.make) $@: No rule for such target" >&2
else
.DEFAULT::
	$(error PEDANTIC: $@: No rule for such target)
endif

ExtractEmcInfoclean ::
#-- end of cleanup_header ---------------
#-- start of cleanup_library -------------
	$(cleanup_echo) library ExtractEmcInfo
	-$(cleanup_silent) cd $(bin); /bin/rm -f $(library_prefix)ExtractEmcInfo$(library_suffix).a $(library_prefix)ExtractEmcInfo$(library_suffix).s? ExtractEmcInfo.stamp ExtractEmcInfo.shstamp
#-- end of cleanup_library ---------------
