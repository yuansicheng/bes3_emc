#-- start of make_header -----------------

#====================================
#  Library NNGeneratorSvcLib
#
#   Generated Thu Dec  1 13:11:26 2022  by yuansc
#
#====================================

include ${CMTROOT}/src/Makefile.core

ifdef tag
CMTEXTRATAGS = $(tag)
else
tag       = $(CMTCONFIG)
endif

cmt_NNGeneratorSvcLib_has_no_target_tag = 1

#--------------------------------------------------------

ifdef cmt_NNGeneratorSvcLib_has_target_tag

tags      = $(tag),$(CMTEXTRATAGS),target_NNGeneratorSvcLib

NNGeneratorSvc_tag = $(tag)

#cmt_local_tagfile_NNGeneratorSvcLib = $(NNGeneratorSvc_tag)_NNGeneratorSvcLib.make
cmt_local_tagfile_NNGeneratorSvcLib = $(bin)$(NNGeneratorSvc_tag)_NNGeneratorSvcLib.make

else

tags      = $(tag),$(CMTEXTRATAGS)

NNGeneratorSvc_tag = $(tag)

#cmt_local_tagfile_NNGeneratorSvcLib = $(NNGeneratorSvc_tag).make
cmt_local_tagfile_NNGeneratorSvcLib = $(bin)$(NNGeneratorSvc_tag).make

endif

include $(cmt_local_tagfile_NNGeneratorSvcLib)
#-include $(cmt_local_tagfile_NNGeneratorSvcLib)

ifdef cmt_NNGeneratorSvcLib_has_target_tag

cmt_final_setup_NNGeneratorSvcLib = $(bin)setup_NNGeneratorSvcLib.make
cmt_dependencies_in_NNGeneratorSvcLib = $(bin)dependencies_NNGeneratorSvcLib.in
#cmt_final_setup_NNGeneratorSvcLib = $(bin)NNGeneratorSvc_NNGeneratorSvcLibsetup.make
cmt_local_NNGeneratorSvcLib_makefile = $(bin)NNGeneratorSvcLib.make

else

cmt_final_setup_NNGeneratorSvcLib = $(bin)setup.make
cmt_dependencies_in_NNGeneratorSvcLib = $(bin)dependencies.in
#cmt_final_setup_NNGeneratorSvcLib = $(bin)NNGeneratorSvcsetup.make
cmt_local_NNGeneratorSvcLib_makefile = $(bin)NNGeneratorSvcLib.make

endif

#cmt_final_setup = $(bin)setup.make
#cmt_final_setup = $(bin)NNGeneratorSvcsetup.make

#NNGeneratorSvcLib :: ;

dirs ::
	@if test ! -r requirements ; then echo "No requirements file" ; fi; \
	  if test ! -d $(bin) ; then $(mkdir) -p $(bin) ; fi

javadirs ::
	@if test ! -d $(javabin) ; then $(mkdir) -p $(javabin) ; fi

srcdirs ::
	@if test ! -d $(src) ; then $(mkdir) -p $(src) ; fi

help ::
	$(echo) 'NNGeneratorSvcLib'

binobj = 
ifdef STRUCTURED_OUTPUT
binobj = NNGeneratorSvcLib/
#NNGeneratorSvcLib::
#	@if test ! -d $(bin)$(binobj) ; then $(mkdir) -p $(bin)$(binobj) ; fi
#	$(echo) "STRUCTURED_OUTPUT="$(bin)$(binobj)
endif

${CMTROOT}/src/Makefile.core : ;
ifdef use_requirements
$(use_requirements) : ;
endif

#-- end of make_header ------------------
#-- start of libary_header ---------------

NNGeneratorSvcLiblibname   = $(bin)$(library_prefix)NNGeneratorSvcLib$(library_suffix)
NNGeneratorSvcLiblib       = $(NNGeneratorSvcLiblibname).a
NNGeneratorSvcLibstamp     = $(bin)NNGeneratorSvcLib.stamp
NNGeneratorSvcLibshstamp   = $(bin)NNGeneratorSvcLib.shstamp

NNGeneratorSvcLib :: dirs  NNGeneratorSvcLibLIB
	$(echo) "NNGeneratorSvcLib ok"

#-- end of libary_header ----------------

NNGeneratorSvcLibLIB :: $(NNGeneratorSvcLiblib) $(NNGeneratorSvcLibshstamp)
	@/bin/echo "------> NNGeneratorSvcLib : library ok"

$(NNGeneratorSvcLiblib) :: $(bin)NNGeneratorSvc.o $(bin)NNGeneratorSvc_dll.o $(bin)NNGeneratorSvc_load.o
	$(lib_echo) library
	$(lib_silent) cd $(bin); \
	  $(ar) $(NNGeneratorSvcLiblib) $?
	$(lib_silent) $(ranlib) $(NNGeneratorSvcLiblib)
	$(lib_silent) cat /dev/null >$(NNGeneratorSvcLibstamp)

#------------------------------------------------------------------
#  Future improvement? to empty the object files after
#  storing in the library
#
##	  for f in $?; do \
##	    rm $${f}; touch $${f}; \
##	  done
#------------------------------------------------------------------

$(NNGeneratorSvcLiblibname).$(shlibsuffix) :: $(NNGeneratorSvcLiblib) $(NNGeneratorSvcLibstamps)
	$(lib_silent) cd $(bin); QUIET=$(QUIET); $(make_shlib) "$(tags)" NNGeneratorSvcLib $(NNGeneratorSvcLib_shlibflags)

$(NNGeneratorSvcLibshstamp) :: $(NNGeneratorSvcLiblibname).$(shlibsuffix)
	@if test -f $(NNGeneratorSvcLiblibname).$(shlibsuffix) ; then cat /dev/null >$(NNGeneratorSvcLibshstamp) ; fi

NNGeneratorSvcLibclean ::
	$(cleanup_echo) objects
	$(cleanup_silent) cd $(bin); /bin/rm -f $(bin)NNGeneratorSvc.o $(bin)NNGeneratorSvc_dll.o $(bin)NNGeneratorSvc_load.o

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
NNGeneratorSvcLibinstallname = $(library_prefix)NNGeneratorSvcLib$(library_suffix).$(shlibsuffix)

NNGeneratorSvcLib :: NNGeneratorSvcLibinstall

install :: NNGeneratorSvcLibinstall

NNGeneratorSvcLibinstall :: $(install_dir)/$(NNGeneratorSvcLibinstallname)
	@if test ! "${installarea}" = ""; then\
	  echo "installation done"; \
	fi

$(install_dir)/$(NNGeneratorSvcLibinstallname) :: $(bin)$(NNGeneratorSvcLibinstallname)
	@if test ! "${installarea}" = ""; then \
	  cd $(bin); \
	  if test ! "$(install_dir)" = ""; then \
	    if test ! -d "$(install_dir)"; then \
	      mkdir -p $(install_dir); \
	    fi ; \
	    if test -d "$(install_dir)"; then \
	      echo "Installing library $(NNGeneratorSvcLibinstallname) into $(install_dir)"; \
	      if test -e $(install_dir)/$(NNGeneratorSvcLibinstallname); then \
	        $(cmt_uninstall_area_command) $(install_dir)/$(NNGeneratorSvcLibinstallname); \
	        $(cmt_uninstall_area_command) $(install_dir)/$(NNGeneratorSvcLibinstallname).cmtref; \
	      fi; \
	      $(cmt_install_area_command) `pwd`/$(NNGeneratorSvcLibinstallname) $(install_dir)/$(NNGeneratorSvcLibinstallname); \
	      echo `pwd`/$(NNGeneratorSvcLibinstallname) >$(install_dir)/$(NNGeneratorSvcLibinstallname).cmtref; \
	    fi \
          else \
	    echo "Cannot install library $(NNGeneratorSvcLibinstallname), no installation directory specified"; \
	  fi; \
	fi

NNGeneratorSvcLibclean :: NNGeneratorSvcLibuninstall

uninstall :: NNGeneratorSvcLibuninstall

NNGeneratorSvcLibuninstall ::
	@if test ! "${installarea}" = ""; then \
	  cd $(bin); \
	  if test ! "$(install_dir)" = ""; then \
	    if test -d "$(install_dir)"; then \
	      echo "Removing installed library $(NNGeneratorSvcLibinstallname) from $(install_dir)"; \
	      $(cmt_uninstall_area_command) $(install_dir)/$(NNGeneratorSvcLibinstallname); \
	      $(cmt_uninstall_area_command) $(install_dir)/$(NNGeneratorSvcLibinstallname).cmtref; \
	    fi \
          else \
	    echo "Cannot uninstall library $(NNGeneratorSvcLibinstallname), no installation directory specified"; \
	  fi; \
	fi




#-- start of cpp_library -----------------

ifneq (-MMD -MP -MF $*.d -MQ $@,)

ifneq ($(MAKECMDGOALS),NNGeneratorSvcLibclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)NNGeneratorSvc.d

$(bin)$(binobj)NNGeneratorSvc.d :

$(bin)$(binobj)NNGeneratorSvc.o : $(cmt_final_setup_NNGeneratorSvcLib)

$(bin)$(binobj)NNGeneratorSvc.o : $(src)NNGeneratorSvc.cc
	$(cpp_echo) $(src)NNGeneratorSvc.cc
	$(cpp_silent) $(cppcomp) -MMD -MP -MF $*.d -MQ $@ -o $@ $(use_pp_cppflags) $(NNGeneratorSvcLib_pp_cppflags) $(lib_NNGeneratorSvcLib_pp_cppflags) $(NNGeneratorSvc_pp_cppflags) $(use_cppflags) $(NNGeneratorSvcLib_cppflags) $(lib_NNGeneratorSvcLib_cppflags) $(NNGeneratorSvc_cppflags) $(NNGeneratorSvc_cc_cppflags)  $(src)NNGeneratorSvc.cc
endif
endif

else
$(bin)NNGeneratorSvcLib_dependencies.make : $(NNGeneratorSvc_cc_dependencies)

$(bin)NNGeneratorSvcLib_dependencies.make : $(src)NNGeneratorSvc.cc

$(bin)$(binobj)NNGeneratorSvc.o : $(NNGeneratorSvc_cc_dependencies)
	$(cpp_echo) $(src)NNGeneratorSvc.cc
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(NNGeneratorSvcLib_pp_cppflags) $(lib_NNGeneratorSvcLib_pp_cppflags) $(NNGeneratorSvc_pp_cppflags) $(use_cppflags) $(NNGeneratorSvcLib_cppflags) $(lib_NNGeneratorSvcLib_cppflags) $(NNGeneratorSvc_cppflags) $(NNGeneratorSvc_cc_cppflags)  $(src)NNGeneratorSvc.cc

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (-MMD -MP -MF $*.d -MQ $@,)

ifneq ($(MAKECMDGOALS),NNGeneratorSvcLibclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)NNGeneratorSvc_dll.d

$(bin)$(binobj)NNGeneratorSvc_dll.d :

$(bin)$(binobj)NNGeneratorSvc_dll.o : $(cmt_final_setup_NNGeneratorSvcLib)

$(bin)$(binobj)NNGeneratorSvc_dll.o : $(src)components/NNGeneratorSvc_dll.cc
	$(cpp_echo) $(src)components/NNGeneratorSvc_dll.cc
	$(cpp_silent) $(cppcomp) -MMD -MP -MF $*.d -MQ $@ -o $@ $(use_pp_cppflags) $(NNGeneratorSvcLib_pp_cppflags) $(lib_NNGeneratorSvcLib_pp_cppflags) $(NNGeneratorSvc_dll_pp_cppflags) $(use_cppflags) $(NNGeneratorSvcLib_cppflags) $(lib_NNGeneratorSvcLib_cppflags) $(NNGeneratorSvc_dll_cppflags) $(NNGeneratorSvc_dll_cc_cppflags) -I../src/components $(src)components/NNGeneratorSvc_dll.cc
endif
endif

else
$(bin)NNGeneratorSvcLib_dependencies.make : $(NNGeneratorSvc_dll_cc_dependencies)

$(bin)NNGeneratorSvcLib_dependencies.make : $(src)components/NNGeneratorSvc_dll.cc

$(bin)$(binobj)NNGeneratorSvc_dll.o : $(NNGeneratorSvc_dll_cc_dependencies)
	$(cpp_echo) $(src)components/NNGeneratorSvc_dll.cc
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(NNGeneratorSvcLib_pp_cppflags) $(lib_NNGeneratorSvcLib_pp_cppflags) $(NNGeneratorSvc_dll_pp_cppflags) $(use_cppflags) $(NNGeneratorSvcLib_cppflags) $(lib_NNGeneratorSvcLib_cppflags) $(NNGeneratorSvc_dll_cppflags) $(NNGeneratorSvc_dll_cc_cppflags) -I../src/components $(src)components/NNGeneratorSvc_dll.cc

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (-MMD -MP -MF $*.d -MQ $@,)

ifneq ($(MAKECMDGOALS),NNGeneratorSvcLibclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)NNGeneratorSvc_load.d

$(bin)$(binobj)NNGeneratorSvc_load.d :

$(bin)$(binobj)NNGeneratorSvc_load.o : $(cmt_final_setup_NNGeneratorSvcLib)

$(bin)$(binobj)NNGeneratorSvc_load.o : $(src)components/NNGeneratorSvc_load.cc
	$(cpp_echo) $(src)components/NNGeneratorSvc_load.cc
	$(cpp_silent) $(cppcomp) -MMD -MP -MF $*.d -MQ $@ -o $@ $(use_pp_cppflags) $(NNGeneratorSvcLib_pp_cppflags) $(lib_NNGeneratorSvcLib_pp_cppflags) $(NNGeneratorSvc_load_pp_cppflags) $(use_cppflags) $(NNGeneratorSvcLib_cppflags) $(lib_NNGeneratorSvcLib_cppflags) $(NNGeneratorSvc_load_cppflags) $(NNGeneratorSvc_load_cc_cppflags) -I../src/components $(src)components/NNGeneratorSvc_load.cc
endif
endif

else
$(bin)NNGeneratorSvcLib_dependencies.make : $(NNGeneratorSvc_load_cc_dependencies)

$(bin)NNGeneratorSvcLib_dependencies.make : $(src)components/NNGeneratorSvc_load.cc

$(bin)$(binobj)NNGeneratorSvc_load.o : $(NNGeneratorSvc_load_cc_dependencies)
	$(cpp_echo) $(src)components/NNGeneratorSvc_load.cc
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(NNGeneratorSvcLib_pp_cppflags) $(lib_NNGeneratorSvcLib_pp_cppflags) $(NNGeneratorSvc_load_pp_cppflags) $(use_cppflags) $(NNGeneratorSvcLib_cppflags) $(lib_NNGeneratorSvcLib_cppflags) $(NNGeneratorSvc_load_cppflags) $(NNGeneratorSvc_load_cc_cppflags) -I../src/components $(src)components/NNGeneratorSvc_load.cc

endif

#-- end of cpp_library ------------------
#-- start of cleanup_header --------------

clean :: NNGeneratorSvcLibclean ;
#	@cd .

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(NNGeneratorSvcLib.make) $@: No rule for such target" >&2
else
.DEFAULT::
	$(error PEDANTIC: $@: No rule for such target)
endif

NNGeneratorSvcLibclean ::
#-- end of cleanup_header ---------------
#-- start of cleanup_library -------------
	$(cleanup_echo) library NNGeneratorSvcLib
	-$(cleanup_silent) cd $(bin); /bin/rm -f $(library_prefix)NNGeneratorSvcLib$(library_suffix).a $(library_prefix)NNGeneratorSvcLib$(library_suffix).s? NNGeneratorSvcLib.stamp NNGeneratorSvcLib.shstamp
#-- end of cleanup_library ---------------
