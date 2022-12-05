#-- start of make_header -----------------

#====================================
#  Library EmcRec
#
#   Generated Thu Dec  1 10:53:55 2022  by yuansc
#
#====================================

include ${CMTROOT}/src/Makefile.core

ifdef tag
CMTEXTRATAGS = $(tag)
else
tag       = $(CMTCONFIG)
endif

cmt_EmcRec_has_no_target_tag = 1

#--------------------------------------------------------

ifdef cmt_EmcRec_has_target_tag

tags      = $(tag),$(CMTEXTRATAGS),target_EmcRec

EmcRec_tag = $(tag)

#cmt_local_tagfile_EmcRec = $(EmcRec_tag)_EmcRec.make
cmt_local_tagfile_EmcRec = $(bin)$(EmcRec_tag)_EmcRec.make

else

tags      = $(tag),$(CMTEXTRATAGS)

EmcRec_tag = $(tag)

#cmt_local_tagfile_EmcRec = $(EmcRec_tag).make
cmt_local_tagfile_EmcRec = $(bin)$(EmcRec_tag).make

endif

include $(cmt_local_tagfile_EmcRec)
#-include $(cmt_local_tagfile_EmcRec)

ifdef cmt_EmcRec_has_target_tag

cmt_final_setup_EmcRec = $(bin)setup_EmcRec.make
cmt_dependencies_in_EmcRec = $(bin)dependencies_EmcRec.in
#cmt_final_setup_EmcRec = $(bin)EmcRec_EmcRecsetup.make
cmt_local_EmcRec_makefile = $(bin)EmcRec.make

else

cmt_final_setup_EmcRec = $(bin)setup.make
cmt_dependencies_in_EmcRec = $(bin)dependencies.in
#cmt_final_setup_EmcRec = $(bin)EmcRecsetup.make
cmt_local_EmcRec_makefile = $(bin)EmcRec.make

endif

#cmt_final_setup = $(bin)setup.make
#cmt_final_setup = $(bin)EmcRecsetup.make

#EmcRec :: ;

dirs ::
	@if test ! -r requirements ; then echo "No requirements file" ; fi; \
	  if test ! -d $(bin) ; then $(mkdir) -p $(bin) ; fi

javadirs ::
	@if test ! -d $(javabin) ; then $(mkdir) -p $(javabin) ; fi

srcdirs ::
	@if test ! -d $(src) ; then $(mkdir) -p $(src) ; fi

help ::
	$(echo) 'EmcRec'

binobj = 
ifdef STRUCTURED_OUTPUT
binobj = EmcRec/
#EmcRec::
#	@if test ! -d $(bin)$(binobj) ; then $(mkdir) -p $(bin)$(binobj) ; fi
#	$(echo) "STRUCTURED_OUTPUT="$(bin)$(binobj)
endif

${CMTROOT}/src/Makefile.core : ;
ifdef use_requirements
$(use_requirements) : ;
endif

#-- end of make_header ------------------
#-- start of libary_header ---------------

EmcReclibname   = $(bin)$(library_prefix)EmcRec$(library_suffix)
EmcReclib       = $(EmcReclibname).a
EmcRecstamp     = $(bin)EmcRec.stamp
EmcRecshstamp   = $(bin)EmcRec.shstamp

EmcRec :: dirs  EmcRecLIB
	$(echo) "EmcRec ok"

#-- end of libary_header ----------------

EmcRecLIB :: $(EmcReclib) $(EmcRecshstamp)
	@/bin/echo "------> EmcRec : library ok"

$(EmcReclib) :: $(bin)EmcRec_load.o $(bin)EmcRec_entries.o
	$(lib_echo) library
	$(lib_silent) cd $(bin); \
	  $(ar) $(EmcReclib) $?
	$(lib_silent) $(ranlib) $(EmcReclib)
	$(lib_silent) cat /dev/null >$(EmcRecstamp)

#------------------------------------------------------------------
#  Future improvement? to empty the object files after
#  storing in the library
#
##	  for f in $?; do \
##	    rm $${f}; touch $${f}; \
##	  done
#------------------------------------------------------------------

$(EmcReclibname).$(shlibsuffix) :: $(EmcReclib) $(EmcRecstamps)
	$(lib_silent) cd $(bin); QUIET=$(QUIET); $(make_shlib) "$(tags)" EmcRec $(EmcRec_shlibflags)

$(EmcRecshstamp) :: $(EmcReclibname).$(shlibsuffix)
	@if test -f $(EmcReclibname).$(shlibsuffix) ; then cat /dev/null >$(EmcRecshstamp) ; fi

EmcRecclean ::
	$(cleanup_echo) objects
	$(cleanup_silent) cd $(bin); /bin/rm -f $(bin)EmcRec_load.o $(bin)EmcRec_entries.o

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
EmcRecinstallname = $(library_prefix)EmcRec$(library_suffix).$(shlibsuffix)

EmcRec :: EmcRecinstall

install :: EmcRecinstall

EmcRecinstall :: $(install_dir)/$(EmcRecinstallname)
	@if test ! "${installarea}" = ""; then\
	  echo "installation done"; \
	fi

$(install_dir)/$(EmcRecinstallname) :: $(bin)$(EmcRecinstallname)
	@if test ! "${installarea}" = ""; then \
	  cd $(bin); \
	  if test ! "$(install_dir)" = ""; then \
	    if test ! -d "$(install_dir)"; then \
	      mkdir -p $(install_dir); \
	    fi ; \
	    if test -d "$(install_dir)"; then \
	      echo "Installing library $(EmcRecinstallname) into $(install_dir)"; \
	      if test -e $(install_dir)/$(EmcRecinstallname); then \
	        $(cmt_uninstall_area_command) $(install_dir)/$(EmcRecinstallname); \
	        $(cmt_uninstall_area_command) $(install_dir)/$(EmcRecinstallname).cmtref; \
	      fi; \
	      $(cmt_install_area_command) `pwd`/$(EmcRecinstallname) $(install_dir)/$(EmcRecinstallname); \
	      echo `pwd`/$(EmcRecinstallname) >$(install_dir)/$(EmcRecinstallname).cmtref; \
	    fi \
          else \
	    echo "Cannot install library $(EmcRecinstallname), no installation directory specified"; \
	  fi; \
	fi

EmcRecclean :: EmcRecuninstall

uninstall :: EmcRecuninstall

EmcRecuninstall ::
	@if test ! "${installarea}" = ""; then \
	  cd $(bin); \
	  if test ! "$(install_dir)" = ""; then \
	    if test -d "$(install_dir)"; then \
	      echo "Removing installed library $(EmcRecinstallname) from $(install_dir)"; \
	      $(cmt_uninstall_area_command) $(install_dir)/$(EmcRecinstallname); \
	      $(cmt_uninstall_area_command) $(install_dir)/$(EmcRecinstallname).cmtref; \
	    fi \
          else \
	    echo "Cannot uninstall library $(EmcRecinstallname), no installation directory specified"; \
	  fi; \
	fi




#-- start of cpp_library -----------------

ifneq (-MMD -MP -MF $*.d -MQ $@,)

ifneq ($(MAKECMDGOALS),EmcRecclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)EmcRec_load.d

$(bin)$(binobj)EmcRec_load.d :

$(bin)$(binobj)EmcRec_load.o : $(cmt_final_setup_EmcRec)

$(bin)$(binobj)EmcRec_load.o : $(src)components/EmcRec_load.cxx
	$(cpp_echo) $(src)components/EmcRec_load.cxx
	$(cpp_silent) $(cppcomp) -MMD -MP -MF $*.d -MQ $@ -o $@ $(use_pp_cppflags) $(EmcRec_pp_cppflags) $(lib_EmcRec_pp_cppflags) $(EmcRec_load_pp_cppflags) $(use_cppflags) $(EmcRec_cppflags) $(lib_EmcRec_cppflags) $(EmcRec_load_cppflags) $(EmcRec_load_cxx_cppflags) -I../src/components $(src)components/EmcRec_load.cxx
endif
endif

else
$(bin)EmcRec_dependencies.make : $(EmcRec_load_cxx_dependencies)

$(bin)EmcRec_dependencies.make : $(src)components/EmcRec_load.cxx

$(bin)$(binobj)EmcRec_load.o : $(EmcRec_load_cxx_dependencies)
	$(cpp_echo) $(src)components/EmcRec_load.cxx
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(EmcRec_pp_cppflags) $(lib_EmcRec_pp_cppflags) $(EmcRec_load_pp_cppflags) $(use_cppflags) $(EmcRec_cppflags) $(lib_EmcRec_cppflags) $(EmcRec_load_cppflags) $(EmcRec_load_cxx_cppflags) -I../src/components $(src)components/EmcRec_load.cxx

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (-MMD -MP -MF $*.d -MQ $@,)

ifneq ($(MAKECMDGOALS),EmcRecclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)EmcRec_entries.d

$(bin)$(binobj)EmcRec_entries.d :

$(bin)$(binobj)EmcRec_entries.o : $(cmt_final_setup_EmcRec)

$(bin)$(binobj)EmcRec_entries.o : $(src)components/EmcRec_entries.cxx
	$(cpp_echo) $(src)components/EmcRec_entries.cxx
	$(cpp_silent) $(cppcomp) -MMD -MP -MF $*.d -MQ $@ -o $@ $(use_pp_cppflags) $(EmcRec_pp_cppflags) $(lib_EmcRec_pp_cppflags) $(EmcRec_entries_pp_cppflags) $(use_cppflags) $(EmcRec_cppflags) $(lib_EmcRec_cppflags) $(EmcRec_entries_cppflags) $(EmcRec_entries_cxx_cppflags) -I../src/components $(src)components/EmcRec_entries.cxx
endif
endif

else
$(bin)EmcRec_dependencies.make : $(EmcRec_entries_cxx_dependencies)

$(bin)EmcRec_dependencies.make : $(src)components/EmcRec_entries.cxx

$(bin)$(binobj)EmcRec_entries.o : $(EmcRec_entries_cxx_dependencies)
	$(cpp_echo) $(src)components/EmcRec_entries.cxx
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(EmcRec_pp_cppflags) $(lib_EmcRec_pp_cppflags) $(EmcRec_entries_pp_cppflags) $(use_cppflags) $(EmcRec_cppflags) $(lib_EmcRec_cppflags) $(EmcRec_entries_cppflags) $(EmcRec_entries_cxx_cppflags) -I../src/components $(src)components/EmcRec_entries.cxx

endif

#-- end of cpp_library ------------------
#-- start of cleanup_header --------------

clean :: EmcRecclean ;
#	@cd .

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(EmcRec.make) $@: No rule for such target" >&2
else
.DEFAULT::
	$(error PEDANTIC: $@: No rule for such target)
endif

EmcRecclean ::
#-- end of cleanup_header ---------------
#-- start of cleanup_library -------------
	$(cleanup_echo) library EmcRec
	-$(cleanup_silent) cd $(bin); /bin/rm -f $(library_prefix)EmcRec$(library_suffix).a $(library_prefix)EmcRec$(library_suffix).s? EmcRec.stamp EmcRec.shstamp
#-- end of cleanup_library ---------------
