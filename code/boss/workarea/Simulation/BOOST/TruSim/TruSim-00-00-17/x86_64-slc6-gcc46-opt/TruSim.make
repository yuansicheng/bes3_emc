#-- start of make_header -----------------

#====================================
#  Library TruSim
#
#   Generated Thu Dec  1 15:20:02 2022  by yuansc
#
#====================================

include ${CMTROOT}/src/Makefile.core

ifdef tag
CMTEXTRATAGS = $(tag)
else
tag       = $(CMTCONFIG)
endif

cmt_TruSim_has_no_target_tag = 1

#--------------------------------------------------------

ifdef cmt_TruSim_has_target_tag

tags      = $(tag),$(CMTEXTRATAGS),target_TruSim

TruSim_tag = $(tag)

#cmt_local_tagfile_TruSim = $(TruSim_tag)_TruSim.make
cmt_local_tagfile_TruSim = $(bin)$(TruSim_tag)_TruSim.make

else

tags      = $(tag),$(CMTEXTRATAGS)

TruSim_tag = $(tag)

#cmt_local_tagfile_TruSim = $(TruSim_tag).make
cmt_local_tagfile_TruSim = $(bin)$(TruSim_tag).make

endif

include $(cmt_local_tagfile_TruSim)
#-include $(cmt_local_tagfile_TruSim)

ifdef cmt_TruSim_has_target_tag

cmt_final_setup_TruSim = $(bin)setup_TruSim.make
cmt_dependencies_in_TruSim = $(bin)dependencies_TruSim.in
#cmt_final_setup_TruSim = $(bin)TruSim_TruSimsetup.make
cmt_local_TruSim_makefile = $(bin)TruSim.make

else

cmt_final_setup_TruSim = $(bin)setup.make
cmt_dependencies_in_TruSim = $(bin)dependencies.in
#cmt_final_setup_TruSim = $(bin)TruSimsetup.make
cmt_local_TruSim_makefile = $(bin)TruSim.make

endif

#cmt_final_setup = $(bin)setup.make
#cmt_final_setup = $(bin)TruSimsetup.make

#TruSim :: ;

dirs ::
	@if test ! -r requirements ; then echo "No requirements file" ; fi; \
	  if test ! -d $(bin) ; then $(mkdir) -p $(bin) ; fi

javadirs ::
	@if test ! -d $(javabin) ; then $(mkdir) -p $(javabin) ; fi

srcdirs ::
	@if test ! -d $(src) ; then $(mkdir) -p $(src) ; fi

help ::
	$(echo) 'TruSim'

binobj = 
ifdef STRUCTURED_OUTPUT
binobj = TruSim/
#TruSim::
#	@if test ! -d $(bin)$(binobj) ; then $(mkdir) -p $(bin)$(binobj) ; fi
#	$(echo) "STRUCTURED_OUTPUT="$(bin)$(binobj)
endif

${CMTROOT}/src/Makefile.core : ;
ifdef use_requirements
$(use_requirements) : ;
endif

#-- end of make_header ------------------
#-- start of libary_header ---------------

TruSimlibname   = $(bin)$(library_prefix)TruSim$(library_suffix)
TruSimlib       = $(TruSimlibname).a
TruSimstamp     = $(bin)TruSim.stamp
TruSimshstamp   = $(bin)TruSim.shstamp

TruSim :: dirs  TruSimLIB
	$(echo) "TruSim ok"

#-- end of libary_header ----------------

TruSimLIB :: $(TruSimlib) $(TruSimshstamp)
	@/bin/echo "------> TruSim : library ok"

$(TruSimlib) :: $(bin)BesTruthEvent.o $(bin)BesTruthVertex.o $(bin)BesTruthTrack.o $(bin)BesSensitiveManager.o $(bin)BesSensitiveDetector.o
	$(lib_echo) library
	$(lib_silent) cd $(bin); \
	  $(ar) $(TruSimlib) $?
	$(lib_silent) $(ranlib) $(TruSimlib)
	$(lib_silent) cat /dev/null >$(TruSimstamp)

#------------------------------------------------------------------
#  Future improvement? to empty the object files after
#  storing in the library
#
##	  for f in $?; do \
##	    rm $${f}; touch $${f}; \
##	  done
#------------------------------------------------------------------

$(TruSimlibname).$(shlibsuffix) :: $(TruSimlib) $(TruSimstamps)
	$(lib_silent) cd $(bin); QUIET=$(QUIET); $(make_shlib) "$(tags)" TruSim $(TruSim_shlibflags)

$(TruSimshstamp) :: $(TruSimlibname).$(shlibsuffix)
	@if test -f $(TruSimlibname).$(shlibsuffix) ; then cat /dev/null >$(TruSimshstamp) ; fi

TruSimclean ::
	$(cleanup_echo) objects
	$(cleanup_silent) cd $(bin); /bin/rm -f $(bin)BesTruthEvent.o $(bin)BesTruthVertex.o $(bin)BesTruthTrack.o $(bin)BesSensitiveManager.o $(bin)BesSensitiveDetector.o

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
TruSiminstallname = $(library_prefix)TruSim$(library_suffix).$(shlibsuffix)

TruSim :: TruSiminstall

install :: TruSiminstall

TruSiminstall :: $(install_dir)/$(TruSiminstallname)
	@if test ! "${installarea}" = ""; then\
	  echo "installation done"; \
	fi

$(install_dir)/$(TruSiminstallname) :: $(bin)$(TruSiminstallname)
	@if test ! "${installarea}" = ""; then \
	  cd $(bin); \
	  if test ! "$(install_dir)" = ""; then \
	    if test ! -d "$(install_dir)"; then \
	      mkdir -p $(install_dir); \
	    fi ; \
	    if test -d "$(install_dir)"; then \
	      echo "Installing library $(TruSiminstallname) into $(install_dir)"; \
	      if test -e $(install_dir)/$(TruSiminstallname); then \
	        $(cmt_uninstall_area_command) $(install_dir)/$(TruSiminstallname); \
	        $(cmt_uninstall_area_command) $(install_dir)/$(TruSiminstallname).cmtref; \
	      fi; \
	      $(cmt_install_area_command) `pwd`/$(TruSiminstallname) $(install_dir)/$(TruSiminstallname); \
	      echo `pwd`/$(TruSiminstallname) >$(install_dir)/$(TruSiminstallname).cmtref; \
	    fi \
          else \
	    echo "Cannot install library $(TruSiminstallname), no installation directory specified"; \
	  fi; \
	fi

TruSimclean :: TruSimuninstall

uninstall :: TruSimuninstall

TruSimuninstall ::
	@if test ! "${installarea}" = ""; then \
	  cd $(bin); \
	  if test ! "$(install_dir)" = ""; then \
	    if test -d "$(install_dir)"; then \
	      echo "Removing installed library $(TruSiminstallname) from $(install_dir)"; \
	      $(cmt_uninstall_area_command) $(install_dir)/$(TruSiminstallname); \
	      $(cmt_uninstall_area_command) $(install_dir)/$(TruSiminstallname).cmtref; \
	    fi \
          else \
	    echo "Cannot uninstall library $(TruSiminstallname), no installation directory specified"; \
	  fi; \
	fi




#-- start of cpp_library -----------------

ifneq (-MMD -MP -MF $*.d -MQ $@,)

ifneq ($(MAKECMDGOALS),TruSimclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)BesTruthEvent.d

$(bin)$(binobj)BesTruthEvent.d :

$(bin)$(binobj)BesTruthEvent.o : $(cmt_final_setup_TruSim)

$(bin)$(binobj)BesTruthEvent.o : $(src)BesTruthEvent.cc
	$(cpp_echo) $(src)BesTruthEvent.cc
	$(cpp_silent) $(cppcomp) -MMD -MP -MF $*.d -MQ $@ -o $@ $(use_pp_cppflags) $(TruSim_pp_cppflags) $(lib_TruSim_pp_cppflags) $(BesTruthEvent_pp_cppflags) $(use_cppflags) $(TruSim_cppflags) $(lib_TruSim_cppflags) $(BesTruthEvent_cppflags) $(BesTruthEvent_cc_cppflags)  $(src)BesTruthEvent.cc
endif
endif

else
$(bin)TruSim_dependencies.make : $(BesTruthEvent_cc_dependencies)

$(bin)TruSim_dependencies.make : $(src)BesTruthEvent.cc

$(bin)$(binobj)BesTruthEvent.o : $(BesTruthEvent_cc_dependencies)
	$(cpp_echo) $(src)BesTruthEvent.cc
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(TruSim_pp_cppflags) $(lib_TruSim_pp_cppflags) $(BesTruthEvent_pp_cppflags) $(use_cppflags) $(TruSim_cppflags) $(lib_TruSim_cppflags) $(BesTruthEvent_cppflags) $(BesTruthEvent_cc_cppflags)  $(src)BesTruthEvent.cc

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (-MMD -MP -MF $*.d -MQ $@,)

ifneq ($(MAKECMDGOALS),TruSimclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)BesTruthVertex.d

$(bin)$(binobj)BesTruthVertex.d :

$(bin)$(binobj)BesTruthVertex.o : $(cmt_final_setup_TruSim)

$(bin)$(binobj)BesTruthVertex.o : $(src)BesTruthVertex.cc
	$(cpp_echo) $(src)BesTruthVertex.cc
	$(cpp_silent) $(cppcomp) -MMD -MP -MF $*.d -MQ $@ -o $@ $(use_pp_cppflags) $(TruSim_pp_cppflags) $(lib_TruSim_pp_cppflags) $(BesTruthVertex_pp_cppflags) $(use_cppflags) $(TruSim_cppflags) $(lib_TruSim_cppflags) $(BesTruthVertex_cppflags) $(BesTruthVertex_cc_cppflags)  $(src)BesTruthVertex.cc
endif
endif

else
$(bin)TruSim_dependencies.make : $(BesTruthVertex_cc_dependencies)

$(bin)TruSim_dependencies.make : $(src)BesTruthVertex.cc

$(bin)$(binobj)BesTruthVertex.o : $(BesTruthVertex_cc_dependencies)
	$(cpp_echo) $(src)BesTruthVertex.cc
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(TruSim_pp_cppflags) $(lib_TruSim_pp_cppflags) $(BesTruthVertex_pp_cppflags) $(use_cppflags) $(TruSim_cppflags) $(lib_TruSim_cppflags) $(BesTruthVertex_cppflags) $(BesTruthVertex_cc_cppflags)  $(src)BesTruthVertex.cc

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (-MMD -MP -MF $*.d -MQ $@,)

ifneq ($(MAKECMDGOALS),TruSimclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)BesTruthTrack.d

$(bin)$(binobj)BesTruthTrack.d :

$(bin)$(binobj)BesTruthTrack.o : $(cmt_final_setup_TruSim)

$(bin)$(binobj)BesTruthTrack.o : $(src)BesTruthTrack.cc
	$(cpp_echo) $(src)BesTruthTrack.cc
	$(cpp_silent) $(cppcomp) -MMD -MP -MF $*.d -MQ $@ -o $@ $(use_pp_cppflags) $(TruSim_pp_cppflags) $(lib_TruSim_pp_cppflags) $(BesTruthTrack_pp_cppflags) $(use_cppflags) $(TruSim_cppflags) $(lib_TruSim_cppflags) $(BesTruthTrack_cppflags) $(BesTruthTrack_cc_cppflags)  $(src)BesTruthTrack.cc
endif
endif

else
$(bin)TruSim_dependencies.make : $(BesTruthTrack_cc_dependencies)

$(bin)TruSim_dependencies.make : $(src)BesTruthTrack.cc

$(bin)$(binobj)BesTruthTrack.o : $(BesTruthTrack_cc_dependencies)
	$(cpp_echo) $(src)BesTruthTrack.cc
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(TruSim_pp_cppflags) $(lib_TruSim_pp_cppflags) $(BesTruthTrack_pp_cppflags) $(use_cppflags) $(TruSim_cppflags) $(lib_TruSim_cppflags) $(BesTruthTrack_cppflags) $(BesTruthTrack_cc_cppflags)  $(src)BesTruthTrack.cc

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (-MMD -MP -MF $*.d -MQ $@,)

ifneq ($(MAKECMDGOALS),TruSimclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)BesSensitiveManager.d

$(bin)$(binobj)BesSensitiveManager.d :

$(bin)$(binobj)BesSensitiveManager.o : $(cmt_final_setup_TruSim)

$(bin)$(binobj)BesSensitiveManager.o : $(src)BesSensitiveManager.cc
	$(cpp_echo) $(src)BesSensitiveManager.cc
	$(cpp_silent) $(cppcomp) -MMD -MP -MF $*.d -MQ $@ -o $@ $(use_pp_cppflags) $(TruSim_pp_cppflags) $(lib_TruSim_pp_cppflags) $(BesSensitiveManager_pp_cppflags) $(use_cppflags) $(TruSim_cppflags) $(lib_TruSim_cppflags) $(BesSensitiveManager_cppflags) $(BesSensitiveManager_cc_cppflags)  $(src)BesSensitiveManager.cc
endif
endif

else
$(bin)TruSim_dependencies.make : $(BesSensitiveManager_cc_dependencies)

$(bin)TruSim_dependencies.make : $(src)BesSensitiveManager.cc

$(bin)$(binobj)BesSensitiveManager.o : $(BesSensitiveManager_cc_dependencies)
	$(cpp_echo) $(src)BesSensitiveManager.cc
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(TruSim_pp_cppflags) $(lib_TruSim_pp_cppflags) $(BesSensitiveManager_pp_cppflags) $(use_cppflags) $(TruSim_cppflags) $(lib_TruSim_cppflags) $(BesSensitiveManager_cppflags) $(BesSensitiveManager_cc_cppflags)  $(src)BesSensitiveManager.cc

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (-MMD -MP -MF $*.d -MQ $@,)

ifneq ($(MAKECMDGOALS),TruSimclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)BesSensitiveDetector.d

$(bin)$(binobj)BesSensitiveDetector.d :

$(bin)$(binobj)BesSensitiveDetector.o : $(cmt_final_setup_TruSim)

$(bin)$(binobj)BesSensitiveDetector.o : $(src)BesSensitiveDetector.cc
	$(cpp_echo) $(src)BesSensitiveDetector.cc
	$(cpp_silent) $(cppcomp) -MMD -MP -MF $*.d -MQ $@ -o $@ $(use_pp_cppflags) $(TruSim_pp_cppflags) $(lib_TruSim_pp_cppflags) $(BesSensitiveDetector_pp_cppflags) $(use_cppflags) $(TruSim_cppflags) $(lib_TruSim_cppflags) $(BesSensitiveDetector_cppflags) $(BesSensitiveDetector_cc_cppflags)  $(src)BesSensitiveDetector.cc
endif
endif

else
$(bin)TruSim_dependencies.make : $(BesSensitiveDetector_cc_dependencies)

$(bin)TruSim_dependencies.make : $(src)BesSensitiveDetector.cc

$(bin)$(binobj)BesSensitiveDetector.o : $(BesSensitiveDetector_cc_dependencies)
	$(cpp_echo) $(src)BesSensitiveDetector.cc
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(TruSim_pp_cppflags) $(lib_TruSim_pp_cppflags) $(BesSensitiveDetector_pp_cppflags) $(use_cppflags) $(TruSim_cppflags) $(lib_TruSim_cppflags) $(BesSensitiveDetector_cppflags) $(BesSensitiveDetector_cc_cppflags)  $(src)BesSensitiveDetector.cc

endif

#-- end of cpp_library ------------------
#-- start of cleanup_header --------------

clean :: TruSimclean ;
#	@cd .

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(TruSim.make) $@: No rule for such target" >&2
else
.DEFAULT::
	$(error PEDANTIC: $@: No rule for such target)
endif

TruSimclean ::
#-- end of cleanup_header ---------------
#-- start of cleanup_library -------------
	$(cleanup_echo) library TruSim
	-$(cleanup_silent) cd $(bin); /bin/rm -f $(library_prefix)TruSim$(library_suffix).a $(library_prefix)TruSim$(library_suffix).s? TruSim.stamp TruSim.shstamp
#-- end of cleanup_library ---------------
