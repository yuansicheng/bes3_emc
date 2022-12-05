#-- start of make_header -----------------

#====================================
#  Library NNGeneratorSvc
#
#   Generated Thu Dec  1 13:57:35 2022  by yuansc
#
#====================================

include ${CMTROOT}/src/Makefile.core

ifdef tag
CMTEXTRATAGS = $(tag)
else
tag       = $(CMTCONFIG)
endif

cmt_NNGeneratorSvc_has_no_target_tag = 1

#--------------------------------------------------------

ifdef cmt_NNGeneratorSvc_has_target_tag

tags      = $(tag),$(CMTEXTRATAGS),target_NNGeneratorSvc

NNGeneratorSvc_tag = $(tag)

#cmt_local_tagfile_NNGeneratorSvc = $(NNGeneratorSvc_tag)_NNGeneratorSvc.make
cmt_local_tagfile_NNGeneratorSvc = $(bin)$(NNGeneratorSvc_tag)_NNGeneratorSvc.make

else

tags      = $(tag),$(CMTEXTRATAGS)

NNGeneratorSvc_tag = $(tag)

#cmt_local_tagfile_NNGeneratorSvc = $(NNGeneratorSvc_tag).make
cmt_local_tagfile_NNGeneratorSvc = $(bin)$(NNGeneratorSvc_tag).make

endif

include $(cmt_local_tagfile_NNGeneratorSvc)
#-include $(cmt_local_tagfile_NNGeneratorSvc)

ifdef cmt_NNGeneratorSvc_has_target_tag

cmt_final_setup_NNGeneratorSvc = $(bin)setup_NNGeneratorSvc.make
cmt_dependencies_in_NNGeneratorSvc = $(bin)dependencies_NNGeneratorSvc.in
#cmt_final_setup_NNGeneratorSvc = $(bin)NNGeneratorSvc_NNGeneratorSvcsetup.make
cmt_local_NNGeneratorSvc_makefile = $(bin)NNGeneratorSvc.make

else

cmt_final_setup_NNGeneratorSvc = $(bin)setup.make
cmt_dependencies_in_NNGeneratorSvc = $(bin)dependencies.in
#cmt_final_setup_NNGeneratorSvc = $(bin)NNGeneratorSvcsetup.make
cmt_local_NNGeneratorSvc_makefile = $(bin)NNGeneratorSvc.make

endif

#cmt_final_setup = $(bin)setup.make
#cmt_final_setup = $(bin)NNGeneratorSvcsetup.make

#NNGeneratorSvc :: ;

dirs ::
	@if test ! -r requirements ; then echo "No requirements file" ; fi; \
	  if test ! -d $(bin) ; then $(mkdir) -p $(bin) ; fi

javadirs ::
	@if test ! -d $(javabin) ; then $(mkdir) -p $(javabin) ; fi

srcdirs ::
	@if test ! -d $(src) ; then $(mkdir) -p $(src) ; fi

help ::
	$(echo) 'NNGeneratorSvc'

binobj = 
ifdef STRUCTURED_OUTPUT
binobj = NNGeneratorSvc/
#NNGeneratorSvc::
#	@if test ! -d $(bin)$(binobj) ; then $(mkdir) -p $(bin)$(binobj) ; fi
#	$(echo) "STRUCTURED_OUTPUT="$(bin)$(binobj)
endif

${CMTROOT}/src/Makefile.core : ;
ifdef use_requirements
$(use_requirements) : ;
endif

#-- end of make_header ------------------
#-- start of libary_header ---------------

NNGeneratorSvclibname   = $(bin)$(library_prefix)NNGeneratorSvc$(library_suffix)
NNGeneratorSvclib       = $(NNGeneratorSvclibname).a
NNGeneratorSvcstamp     = $(bin)NNGeneratorSvc.stamp
NNGeneratorSvcshstamp   = $(bin)NNGeneratorSvc.shstamp

NNGeneratorSvc :: dirs  NNGeneratorSvcLIB
	$(echo) "NNGeneratorSvc ok"

#-- end of libary_header ----------------

NNGeneratorSvcLIB :: $(NNGeneratorSvclib) $(NNGeneratorSvcshstamp)
	@/bin/echo "------> NNGeneratorSvc : library ok"

$(NNGeneratorSvclib) :: $(bin)NNGeneratorSvc.o $(bin)NNGeneratorSvc_dll.o $(bin)NNGeneratorSvc_load.o
	$(lib_echo) library
	$(lib_silent) cd $(bin); \
	  $(ar) $(NNGeneratorSvclib) $?
	$(lib_silent) $(ranlib) $(NNGeneratorSvclib)
	$(lib_silent) cat /dev/null >$(NNGeneratorSvcstamp)

#------------------------------------------------------------------
#  Future improvement? to empty the object files after
#  storing in the library
#
##	  for f in $?; do \
##	    rm $${f}; touch $${f}; \
##	  done
#------------------------------------------------------------------

$(NNGeneratorSvclibname).$(shlibsuffix) :: $(NNGeneratorSvclib) $(NNGeneratorSvcstamps)
	$(lib_silent) cd $(bin); QUIET=$(QUIET); $(make_shlib) "$(tags)" NNGeneratorSvc $(NNGeneratorSvc_shlibflags)

$(NNGeneratorSvcshstamp) :: $(NNGeneratorSvclibname).$(shlibsuffix)
	@if test -f $(NNGeneratorSvclibname).$(shlibsuffix) ; then cat /dev/null >$(NNGeneratorSvcshstamp) ; fi

NNGeneratorSvcclean ::
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
NNGeneratorSvcinstallname = $(library_prefix)NNGeneratorSvc$(library_suffix).$(shlibsuffix)

NNGeneratorSvc :: NNGeneratorSvcinstall

install :: NNGeneratorSvcinstall

NNGeneratorSvcinstall :: $(install_dir)/$(NNGeneratorSvcinstallname)
	@if test ! "${installarea}" = ""; then\
	  echo "installation done"; \
	fi

$(install_dir)/$(NNGeneratorSvcinstallname) :: $(bin)$(NNGeneratorSvcinstallname)
	@if test ! "${installarea}" = ""; then \
	  cd $(bin); \
	  if test ! "$(install_dir)" = ""; then \
	    if test ! -d "$(install_dir)"; then \
	      mkdir -p $(install_dir); \
	    fi ; \
	    if test -d "$(install_dir)"; then \
	      echo "Installing library $(NNGeneratorSvcinstallname) into $(install_dir)"; \
	      if test -e $(install_dir)/$(NNGeneratorSvcinstallname); then \
	        $(cmt_uninstall_area_command) $(install_dir)/$(NNGeneratorSvcinstallname); \
	        $(cmt_uninstall_area_command) $(install_dir)/$(NNGeneratorSvcinstallname).cmtref; \
	      fi; \
	      $(cmt_install_area_command) `pwd`/$(NNGeneratorSvcinstallname) $(install_dir)/$(NNGeneratorSvcinstallname); \
	      echo `pwd`/$(NNGeneratorSvcinstallname) >$(install_dir)/$(NNGeneratorSvcinstallname).cmtref; \
	    fi \
          else \
	    echo "Cannot install library $(NNGeneratorSvcinstallname), no installation directory specified"; \
	  fi; \
	fi

NNGeneratorSvcclean :: NNGeneratorSvcuninstall

uninstall :: NNGeneratorSvcuninstall

NNGeneratorSvcuninstall ::
	@if test ! "${installarea}" = ""; then \
	  cd $(bin); \
	  if test ! "$(install_dir)" = ""; then \
	    if test -d "$(install_dir)"; then \
	      echo "Removing installed library $(NNGeneratorSvcinstallname) from $(install_dir)"; \
	      $(cmt_uninstall_area_command) $(install_dir)/$(NNGeneratorSvcinstallname); \
	      $(cmt_uninstall_area_command) $(install_dir)/$(NNGeneratorSvcinstallname).cmtref; \
	    fi \
          else \
	    echo "Cannot uninstall library $(NNGeneratorSvcinstallname), no installation directory specified"; \
	  fi; \
	fi




#-- start of cpp_library -----------------

ifneq (-MMD -MP -MF $*.d -MQ $@,)

ifneq ($(MAKECMDGOALS),NNGeneratorSvcclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)NNGeneratorSvc.d

$(bin)$(binobj)NNGeneratorSvc.d :

$(bin)$(binobj)NNGeneratorSvc.o : $(cmt_final_setup_NNGeneratorSvc)

$(bin)$(binobj)NNGeneratorSvc.o : $(src)NNGeneratorSvc.cc
	$(cpp_echo) $(src)NNGeneratorSvc.cc
	$(cpp_silent) $(cppcomp) -MMD -MP -MF $*.d -MQ $@ -o $@ $(use_pp_cppflags) $(NNGeneratorSvc_pp_cppflags) $(lib_NNGeneratorSvc_pp_cppflags) $(NNGeneratorSvc_pp_cppflags) $(use_cppflags) $(NNGeneratorSvc_cppflags) $(lib_NNGeneratorSvc_cppflags) $(NNGeneratorSvc_cppflags) $(NNGeneratorSvc_cc_cppflags)  $(src)NNGeneratorSvc.cc
endif
endif

else
$(bin)NNGeneratorSvc_dependencies.make : $(NNGeneratorSvc_cc_dependencies)

$(bin)NNGeneratorSvc_dependencies.make : $(src)NNGeneratorSvc.cc

$(bin)$(binobj)NNGeneratorSvc.o : $(NNGeneratorSvc_cc_dependencies)
	$(cpp_echo) $(src)NNGeneratorSvc.cc
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(NNGeneratorSvc_pp_cppflags) $(lib_NNGeneratorSvc_pp_cppflags) $(NNGeneratorSvc_pp_cppflags) $(use_cppflags) $(NNGeneratorSvc_cppflags) $(lib_NNGeneratorSvc_cppflags) $(NNGeneratorSvc_cppflags) $(NNGeneratorSvc_cc_cppflags)  $(src)NNGeneratorSvc.cc

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (-MMD -MP -MF $*.d -MQ $@,)

ifneq ($(MAKECMDGOALS),NNGeneratorSvcclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)NNGeneratorSvc_dll.d

$(bin)$(binobj)NNGeneratorSvc_dll.d :

$(bin)$(binobj)NNGeneratorSvc_dll.o : $(cmt_final_setup_NNGeneratorSvc)

$(bin)$(binobj)NNGeneratorSvc_dll.o : $(src)components/NNGeneratorSvc_dll.cc
	$(cpp_echo) $(src)components/NNGeneratorSvc_dll.cc
	$(cpp_silent) $(cppcomp) -MMD -MP -MF $*.d -MQ $@ -o $@ $(use_pp_cppflags) $(NNGeneratorSvc_pp_cppflags) $(lib_NNGeneratorSvc_pp_cppflags) $(NNGeneratorSvc_dll_pp_cppflags) $(use_cppflags) $(NNGeneratorSvc_cppflags) $(lib_NNGeneratorSvc_cppflags) $(NNGeneratorSvc_dll_cppflags) $(NNGeneratorSvc_dll_cc_cppflags) -I../src/components $(src)components/NNGeneratorSvc_dll.cc
endif
endif

else
$(bin)NNGeneratorSvc_dependencies.make : $(NNGeneratorSvc_dll_cc_dependencies)

$(bin)NNGeneratorSvc_dependencies.make : $(src)components/NNGeneratorSvc_dll.cc

$(bin)$(binobj)NNGeneratorSvc_dll.o : $(NNGeneratorSvc_dll_cc_dependencies)
	$(cpp_echo) $(src)components/NNGeneratorSvc_dll.cc
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(NNGeneratorSvc_pp_cppflags) $(lib_NNGeneratorSvc_pp_cppflags) $(NNGeneratorSvc_dll_pp_cppflags) $(use_cppflags) $(NNGeneratorSvc_cppflags) $(lib_NNGeneratorSvc_cppflags) $(NNGeneratorSvc_dll_cppflags) $(NNGeneratorSvc_dll_cc_cppflags) -I../src/components $(src)components/NNGeneratorSvc_dll.cc

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (-MMD -MP -MF $*.d -MQ $@,)

ifneq ($(MAKECMDGOALS),NNGeneratorSvcclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)NNGeneratorSvc_load.d

$(bin)$(binobj)NNGeneratorSvc_load.d :

$(bin)$(binobj)NNGeneratorSvc_load.o : $(cmt_final_setup_NNGeneratorSvc)

$(bin)$(binobj)NNGeneratorSvc_load.o : $(src)components/NNGeneratorSvc_load.cc
	$(cpp_echo) $(src)components/NNGeneratorSvc_load.cc
	$(cpp_silent) $(cppcomp) -MMD -MP -MF $*.d -MQ $@ -o $@ $(use_pp_cppflags) $(NNGeneratorSvc_pp_cppflags) $(lib_NNGeneratorSvc_pp_cppflags) $(NNGeneratorSvc_load_pp_cppflags) $(use_cppflags) $(NNGeneratorSvc_cppflags) $(lib_NNGeneratorSvc_cppflags) $(NNGeneratorSvc_load_cppflags) $(NNGeneratorSvc_load_cc_cppflags) -I../src/components $(src)components/NNGeneratorSvc_load.cc
endif
endif

else
$(bin)NNGeneratorSvc_dependencies.make : $(NNGeneratorSvc_load_cc_dependencies)

$(bin)NNGeneratorSvc_dependencies.make : $(src)components/NNGeneratorSvc_load.cc

$(bin)$(binobj)NNGeneratorSvc_load.o : $(NNGeneratorSvc_load_cc_dependencies)
	$(cpp_echo) $(src)components/NNGeneratorSvc_load.cc
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(NNGeneratorSvc_pp_cppflags) $(lib_NNGeneratorSvc_pp_cppflags) $(NNGeneratorSvc_load_pp_cppflags) $(use_cppflags) $(NNGeneratorSvc_cppflags) $(lib_NNGeneratorSvc_cppflags) $(NNGeneratorSvc_load_cppflags) $(NNGeneratorSvc_load_cc_cppflags) -I../src/components $(src)components/NNGeneratorSvc_load.cc

endif

#-- end of cpp_library ------------------
#-- start of cleanup_header --------------

clean :: NNGeneratorSvcclean ;
#	@cd .

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(NNGeneratorSvc.make) $@: No rule for such target" >&2
else
.DEFAULT::
	$(error PEDANTIC: $@: No rule for such target)
endif

NNGeneratorSvcclean ::
#-- end of cleanup_header ---------------
#-- start of cleanup_library -------------
	$(cleanup_echo) library NNGeneratorSvc
	-$(cleanup_silent) cd $(bin); /bin/rm -f $(library_prefix)NNGeneratorSvc$(library_suffix).a $(library_prefix)NNGeneratorSvc$(library_suffix).s? NNGeneratorSvc.stamp NNGeneratorSvc.shstamp
#-- end of cleanup_library ---------------
