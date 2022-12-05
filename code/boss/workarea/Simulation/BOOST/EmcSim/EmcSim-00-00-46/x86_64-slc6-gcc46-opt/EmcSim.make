#-- start of make_header -----------------

#====================================
#  Library EmcSim
#
#   Generated Wed Nov 30 18:01:57 2022  by yuansc
#
#====================================

include ${CMTROOT}/src/Makefile.core

ifdef tag
CMTEXTRATAGS = $(tag)
else
tag       = $(CMTCONFIG)
endif

cmt_EmcSim_has_no_target_tag = 1

#--------------------------------------------------------

ifdef cmt_EmcSim_has_target_tag

tags      = $(tag),$(CMTEXTRATAGS),target_EmcSim

EmcSim_tag = $(tag)

#cmt_local_tagfile_EmcSim = $(EmcSim_tag)_EmcSim.make
cmt_local_tagfile_EmcSim = $(bin)$(EmcSim_tag)_EmcSim.make

else

tags      = $(tag),$(CMTEXTRATAGS)

EmcSim_tag = $(tag)

#cmt_local_tagfile_EmcSim = $(EmcSim_tag).make
cmt_local_tagfile_EmcSim = $(bin)$(EmcSim_tag).make

endif

include $(cmt_local_tagfile_EmcSim)
#-include $(cmt_local_tagfile_EmcSim)

ifdef cmt_EmcSim_has_target_tag

cmt_final_setup_EmcSim = $(bin)setup_EmcSim.make
cmt_dependencies_in_EmcSim = $(bin)dependencies_EmcSim.in
#cmt_final_setup_EmcSim = $(bin)EmcSim_EmcSimsetup.make
cmt_local_EmcSim_makefile = $(bin)EmcSim.make

else

cmt_final_setup_EmcSim = $(bin)setup.make
cmt_dependencies_in_EmcSim = $(bin)dependencies.in
#cmt_final_setup_EmcSim = $(bin)EmcSimsetup.make
cmt_local_EmcSim_makefile = $(bin)EmcSim.make

endif

#cmt_final_setup = $(bin)setup.make
#cmt_final_setup = $(bin)EmcSimsetup.make

#EmcSim :: ;

dirs ::
	@if test ! -r requirements ; then echo "No requirements file" ; fi; \
	  if test ! -d $(bin) ; then $(mkdir) -p $(bin) ; fi

javadirs ::
	@if test ! -d $(javabin) ; then $(mkdir) -p $(javabin) ; fi

srcdirs ::
	@if test ! -d $(src) ; then $(mkdir) -p $(src) ; fi

help ::
	$(echo) 'EmcSim'

binobj = 
ifdef STRUCTURED_OUTPUT
binobj = EmcSim/
#EmcSim::
#	@if test ! -d $(bin)$(binobj) ; then $(mkdir) -p $(bin)$(binobj) ; fi
#	$(echo) "STRUCTURED_OUTPUT="$(bin)$(binobj)
endif

${CMTROOT}/src/Makefile.core : ;
ifdef use_requirements
$(use_requirements) : ;
endif

#-- end of make_header ------------------
#-- start of libary_header ---------------

EmcSimlibname   = $(bin)$(library_prefix)EmcSim$(library_suffix)
EmcSimlib       = $(EmcSimlibname).a
EmcSimstamp     = $(bin)EmcSim.stamp
EmcSimshstamp   = $(bin)EmcSim.shstamp

EmcSim :: dirs  EmcSimLIB
	$(echo) "EmcSim ok"

#-- end of libary_header ----------------

EmcSimLIB :: $(EmcSimlib) $(EmcSimshstamp)
	@/bin/echo "------> EmcSim : library ok"

$(EmcSimlib) :: $(bin)BesEmcConstruction.o $(bin)BesEmcDigitizer.o $(bin)BesEmcDigi.o $(bin)BesEmcHit.o $(bin)BesEmcWaveform.o $(bin)BesEmcGeometry.o $(bin)BesEmcDigitization.o $(bin)BesEmcDetectorMessenger.o $(bin)BesCrystalParameterisation.o $(bin)BesEmcEndGeometry.o $(bin)BesEmcSD.o $(bin)BesEmcParameter.o
	$(lib_echo) library
	$(lib_silent) cd $(bin); \
	  $(ar) $(EmcSimlib) $?
	$(lib_silent) $(ranlib) $(EmcSimlib)
	$(lib_silent) cat /dev/null >$(EmcSimstamp)

#------------------------------------------------------------------
#  Future improvement? to empty the object files after
#  storing in the library
#
##	  for f in $?; do \
##	    rm $${f}; touch $${f}; \
##	  done
#------------------------------------------------------------------

$(EmcSimlibname).$(shlibsuffix) :: $(EmcSimlib) $(EmcSimstamps)
	$(lib_silent) cd $(bin); QUIET=$(QUIET); $(make_shlib) "$(tags)" EmcSim $(EmcSim_shlibflags)

$(EmcSimshstamp) :: $(EmcSimlibname).$(shlibsuffix)
	@if test -f $(EmcSimlibname).$(shlibsuffix) ; then cat /dev/null >$(EmcSimshstamp) ; fi

EmcSimclean ::
	$(cleanup_echo) objects
	$(cleanup_silent) cd $(bin); /bin/rm -f $(bin)BesEmcConstruction.o $(bin)BesEmcDigitizer.o $(bin)BesEmcDigi.o $(bin)BesEmcHit.o $(bin)BesEmcWaveform.o $(bin)BesEmcGeometry.o $(bin)BesEmcDigitization.o $(bin)BesEmcDetectorMessenger.o $(bin)BesCrystalParameterisation.o $(bin)BesEmcEndGeometry.o $(bin)BesEmcSD.o $(bin)BesEmcParameter.o

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
EmcSiminstallname = $(library_prefix)EmcSim$(library_suffix).$(shlibsuffix)

EmcSim :: EmcSiminstall

install :: EmcSiminstall

EmcSiminstall :: $(install_dir)/$(EmcSiminstallname)
	@if test ! "${installarea}" = ""; then\
	  echo "installation done"; \
	fi

$(install_dir)/$(EmcSiminstallname) :: $(bin)$(EmcSiminstallname)
	@if test ! "${installarea}" = ""; then \
	  cd $(bin); \
	  if test ! "$(install_dir)" = ""; then \
	    if test ! -d "$(install_dir)"; then \
	      mkdir -p $(install_dir); \
	    fi ; \
	    if test -d "$(install_dir)"; then \
	      echo "Installing library $(EmcSiminstallname) into $(install_dir)"; \
	      if test -e $(install_dir)/$(EmcSiminstallname); then \
	        $(cmt_uninstall_area_command) $(install_dir)/$(EmcSiminstallname); \
	        $(cmt_uninstall_area_command) $(install_dir)/$(EmcSiminstallname).cmtref; \
	      fi; \
	      $(cmt_install_area_command) `pwd`/$(EmcSiminstallname) $(install_dir)/$(EmcSiminstallname); \
	      echo `pwd`/$(EmcSiminstallname) >$(install_dir)/$(EmcSiminstallname).cmtref; \
	    fi \
          else \
	    echo "Cannot install library $(EmcSiminstallname), no installation directory specified"; \
	  fi; \
	fi

EmcSimclean :: EmcSimuninstall

uninstall :: EmcSimuninstall

EmcSimuninstall ::
	@if test ! "${installarea}" = ""; then \
	  cd $(bin); \
	  if test ! "$(install_dir)" = ""; then \
	    if test -d "$(install_dir)"; then \
	      echo "Removing installed library $(EmcSiminstallname) from $(install_dir)"; \
	      $(cmt_uninstall_area_command) $(install_dir)/$(EmcSiminstallname); \
	      $(cmt_uninstall_area_command) $(install_dir)/$(EmcSiminstallname).cmtref; \
	    fi \
          else \
	    echo "Cannot uninstall library $(EmcSiminstallname), no installation directory specified"; \
	  fi; \
	fi




#-- start of cpp_library -----------------

ifneq (-MMD -MP -MF $*.d -MQ $@,)

ifneq ($(MAKECMDGOALS),EmcSimclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)BesEmcConstruction.d

$(bin)$(binobj)BesEmcConstruction.d :

$(bin)$(binobj)BesEmcConstruction.o : $(cmt_final_setup_EmcSim)

$(bin)$(binobj)BesEmcConstruction.o : $(src)BesEmcConstruction.cc
	$(cpp_echo) $(src)BesEmcConstruction.cc
	$(cpp_silent) $(cppcomp) -MMD -MP -MF $*.d -MQ $@ -o $@ $(use_pp_cppflags) $(EmcSim_pp_cppflags) $(lib_EmcSim_pp_cppflags) $(BesEmcConstruction_pp_cppflags) $(use_cppflags) $(EmcSim_cppflags) $(lib_EmcSim_cppflags) $(BesEmcConstruction_cppflags) $(BesEmcConstruction_cc_cppflags)  $(src)BesEmcConstruction.cc
endif
endif

else
$(bin)EmcSim_dependencies.make : $(BesEmcConstruction_cc_dependencies)

$(bin)EmcSim_dependencies.make : $(src)BesEmcConstruction.cc

$(bin)$(binobj)BesEmcConstruction.o : $(BesEmcConstruction_cc_dependencies)
	$(cpp_echo) $(src)BesEmcConstruction.cc
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(EmcSim_pp_cppflags) $(lib_EmcSim_pp_cppflags) $(BesEmcConstruction_pp_cppflags) $(use_cppflags) $(EmcSim_cppflags) $(lib_EmcSim_cppflags) $(BesEmcConstruction_cppflags) $(BesEmcConstruction_cc_cppflags)  $(src)BesEmcConstruction.cc

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (-MMD -MP -MF $*.d -MQ $@,)

ifneq ($(MAKECMDGOALS),EmcSimclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)BesEmcDigitizer.d

$(bin)$(binobj)BesEmcDigitizer.d :

$(bin)$(binobj)BesEmcDigitizer.o : $(cmt_final_setup_EmcSim)

$(bin)$(binobj)BesEmcDigitizer.o : $(src)BesEmcDigitizer.cc
	$(cpp_echo) $(src)BesEmcDigitizer.cc
	$(cpp_silent) $(cppcomp) -MMD -MP -MF $*.d -MQ $@ -o $@ $(use_pp_cppflags) $(EmcSim_pp_cppflags) $(lib_EmcSim_pp_cppflags) $(BesEmcDigitizer_pp_cppflags) $(use_cppflags) $(EmcSim_cppflags) $(lib_EmcSim_cppflags) $(BesEmcDigitizer_cppflags) $(BesEmcDigitizer_cc_cppflags)  $(src)BesEmcDigitizer.cc
endif
endif

else
$(bin)EmcSim_dependencies.make : $(BesEmcDigitizer_cc_dependencies)

$(bin)EmcSim_dependencies.make : $(src)BesEmcDigitizer.cc

$(bin)$(binobj)BesEmcDigitizer.o : $(BesEmcDigitizer_cc_dependencies)
	$(cpp_echo) $(src)BesEmcDigitizer.cc
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(EmcSim_pp_cppflags) $(lib_EmcSim_pp_cppflags) $(BesEmcDigitizer_pp_cppflags) $(use_cppflags) $(EmcSim_cppflags) $(lib_EmcSim_cppflags) $(BesEmcDigitizer_cppflags) $(BesEmcDigitizer_cc_cppflags)  $(src)BesEmcDigitizer.cc

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (-MMD -MP -MF $*.d -MQ $@,)

ifneq ($(MAKECMDGOALS),EmcSimclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)BesEmcDigi.d

$(bin)$(binobj)BesEmcDigi.d :

$(bin)$(binobj)BesEmcDigi.o : $(cmt_final_setup_EmcSim)

$(bin)$(binobj)BesEmcDigi.o : $(src)BesEmcDigi.cc
	$(cpp_echo) $(src)BesEmcDigi.cc
	$(cpp_silent) $(cppcomp) -MMD -MP -MF $*.d -MQ $@ -o $@ $(use_pp_cppflags) $(EmcSim_pp_cppflags) $(lib_EmcSim_pp_cppflags) $(BesEmcDigi_pp_cppflags) $(use_cppflags) $(EmcSim_cppflags) $(lib_EmcSim_cppflags) $(BesEmcDigi_cppflags) $(BesEmcDigi_cc_cppflags)  $(src)BesEmcDigi.cc
endif
endif

else
$(bin)EmcSim_dependencies.make : $(BesEmcDigi_cc_dependencies)

$(bin)EmcSim_dependencies.make : $(src)BesEmcDigi.cc

$(bin)$(binobj)BesEmcDigi.o : $(BesEmcDigi_cc_dependencies)
	$(cpp_echo) $(src)BesEmcDigi.cc
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(EmcSim_pp_cppflags) $(lib_EmcSim_pp_cppflags) $(BesEmcDigi_pp_cppflags) $(use_cppflags) $(EmcSim_cppflags) $(lib_EmcSim_cppflags) $(BesEmcDigi_cppflags) $(BesEmcDigi_cc_cppflags)  $(src)BesEmcDigi.cc

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (-MMD -MP -MF $*.d -MQ $@,)

ifneq ($(MAKECMDGOALS),EmcSimclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)BesEmcHit.d

$(bin)$(binobj)BesEmcHit.d :

$(bin)$(binobj)BesEmcHit.o : $(cmt_final_setup_EmcSim)

$(bin)$(binobj)BesEmcHit.o : $(src)BesEmcHit.cc
	$(cpp_echo) $(src)BesEmcHit.cc
	$(cpp_silent) $(cppcomp) -MMD -MP -MF $*.d -MQ $@ -o $@ $(use_pp_cppflags) $(EmcSim_pp_cppflags) $(lib_EmcSim_pp_cppflags) $(BesEmcHit_pp_cppflags) $(use_cppflags) $(EmcSim_cppflags) $(lib_EmcSim_cppflags) $(BesEmcHit_cppflags) $(BesEmcHit_cc_cppflags)  $(src)BesEmcHit.cc
endif
endif

else
$(bin)EmcSim_dependencies.make : $(BesEmcHit_cc_dependencies)

$(bin)EmcSim_dependencies.make : $(src)BesEmcHit.cc

$(bin)$(binobj)BesEmcHit.o : $(BesEmcHit_cc_dependencies)
	$(cpp_echo) $(src)BesEmcHit.cc
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(EmcSim_pp_cppflags) $(lib_EmcSim_pp_cppflags) $(BesEmcHit_pp_cppflags) $(use_cppflags) $(EmcSim_cppflags) $(lib_EmcSim_cppflags) $(BesEmcHit_cppflags) $(BesEmcHit_cc_cppflags)  $(src)BesEmcHit.cc

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (-MMD -MP -MF $*.d -MQ $@,)

ifneq ($(MAKECMDGOALS),EmcSimclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)BesEmcWaveform.d

$(bin)$(binobj)BesEmcWaveform.d :

$(bin)$(binobj)BesEmcWaveform.o : $(cmt_final_setup_EmcSim)

$(bin)$(binobj)BesEmcWaveform.o : $(src)BesEmcWaveform.cc
	$(cpp_echo) $(src)BesEmcWaveform.cc
	$(cpp_silent) $(cppcomp) -MMD -MP -MF $*.d -MQ $@ -o $@ $(use_pp_cppflags) $(EmcSim_pp_cppflags) $(lib_EmcSim_pp_cppflags) $(BesEmcWaveform_pp_cppflags) $(use_cppflags) $(EmcSim_cppflags) $(lib_EmcSim_cppflags) $(BesEmcWaveform_cppflags) $(BesEmcWaveform_cc_cppflags)  $(src)BesEmcWaveform.cc
endif
endif

else
$(bin)EmcSim_dependencies.make : $(BesEmcWaveform_cc_dependencies)

$(bin)EmcSim_dependencies.make : $(src)BesEmcWaveform.cc

$(bin)$(binobj)BesEmcWaveform.o : $(BesEmcWaveform_cc_dependencies)
	$(cpp_echo) $(src)BesEmcWaveform.cc
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(EmcSim_pp_cppflags) $(lib_EmcSim_pp_cppflags) $(BesEmcWaveform_pp_cppflags) $(use_cppflags) $(EmcSim_cppflags) $(lib_EmcSim_cppflags) $(BesEmcWaveform_cppflags) $(BesEmcWaveform_cc_cppflags)  $(src)BesEmcWaveform.cc

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (-MMD -MP -MF $*.d -MQ $@,)

ifneq ($(MAKECMDGOALS),EmcSimclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)BesEmcGeometry.d

$(bin)$(binobj)BesEmcGeometry.d :

$(bin)$(binobj)BesEmcGeometry.o : $(cmt_final_setup_EmcSim)

$(bin)$(binobj)BesEmcGeometry.o : $(src)BesEmcGeometry.cc
	$(cpp_echo) $(src)BesEmcGeometry.cc
	$(cpp_silent) $(cppcomp) -MMD -MP -MF $*.d -MQ $@ -o $@ $(use_pp_cppflags) $(EmcSim_pp_cppflags) $(lib_EmcSim_pp_cppflags) $(BesEmcGeometry_pp_cppflags) $(use_cppflags) $(EmcSim_cppflags) $(lib_EmcSim_cppflags) $(BesEmcGeometry_cppflags) $(BesEmcGeometry_cc_cppflags)  $(src)BesEmcGeometry.cc
endif
endif

else
$(bin)EmcSim_dependencies.make : $(BesEmcGeometry_cc_dependencies)

$(bin)EmcSim_dependencies.make : $(src)BesEmcGeometry.cc

$(bin)$(binobj)BesEmcGeometry.o : $(BesEmcGeometry_cc_dependencies)
	$(cpp_echo) $(src)BesEmcGeometry.cc
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(EmcSim_pp_cppflags) $(lib_EmcSim_pp_cppflags) $(BesEmcGeometry_pp_cppflags) $(use_cppflags) $(EmcSim_cppflags) $(lib_EmcSim_cppflags) $(BesEmcGeometry_cppflags) $(BesEmcGeometry_cc_cppflags)  $(src)BesEmcGeometry.cc

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (-MMD -MP -MF $*.d -MQ $@,)

ifneq ($(MAKECMDGOALS),EmcSimclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)BesEmcDigitization.d

$(bin)$(binobj)BesEmcDigitization.d :

$(bin)$(binobj)BesEmcDigitization.o : $(cmt_final_setup_EmcSim)

$(bin)$(binobj)BesEmcDigitization.o : $(src)BesEmcDigitization.cc
	$(cpp_echo) $(src)BesEmcDigitization.cc
	$(cpp_silent) $(cppcomp) -MMD -MP -MF $*.d -MQ $@ -o $@ $(use_pp_cppflags) $(EmcSim_pp_cppflags) $(lib_EmcSim_pp_cppflags) $(BesEmcDigitization_pp_cppflags) $(use_cppflags) $(EmcSim_cppflags) $(lib_EmcSim_cppflags) $(BesEmcDigitization_cppflags) $(BesEmcDigitization_cc_cppflags)  $(src)BesEmcDigitization.cc
endif
endif

else
$(bin)EmcSim_dependencies.make : $(BesEmcDigitization_cc_dependencies)

$(bin)EmcSim_dependencies.make : $(src)BesEmcDigitization.cc

$(bin)$(binobj)BesEmcDigitization.o : $(BesEmcDigitization_cc_dependencies)
	$(cpp_echo) $(src)BesEmcDigitization.cc
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(EmcSim_pp_cppflags) $(lib_EmcSim_pp_cppflags) $(BesEmcDigitization_pp_cppflags) $(use_cppflags) $(EmcSim_cppflags) $(lib_EmcSim_cppflags) $(BesEmcDigitization_cppflags) $(BesEmcDigitization_cc_cppflags)  $(src)BesEmcDigitization.cc

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (-MMD -MP -MF $*.d -MQ $@,)

ifneq ($(MAKECMDGOALS),EmcSimclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)BesEmcDetectorMessenger.d

$(bin)$(binobj)BesEmcDetectorMessenger.d :

$(bin)$(binobj)BesEmcDetectorMessenger.o : $(cmt_final_setup_EmcSim)

$(bin)$(binobj)BesEmcDetectorMessenger.o : $(src)BesEmcDetectorMessenger.cc
	$(cpp_echo) $(src)BesEmcDetectorMessenger.cc
	$(cpp_silent) $(cppcomp) -MMD -MP -MF $*.d -MQ $@ -o $@ $(use_pp_cppflags) $(EmcSim_pp_cppflags) $(lib_EmcSim_pp_cppflags) $(BesEmcDetectorMessenger_pp_cppflags) $(use_cppflags) $(EmcSim_cppflags) $(lib_EmcSim_cppflags) $(BesEmcDetectorMessenger_cppflags) $(BesEmcDetectorMessenger_cc_cppflags)  $(src)BesEmcDetectorMessenger.cc
endif
endif

else
$(bin)EmcSim_dependencies.make : $(BesEmcDetectorMessenger_cc_dependencies)

$(bin)EmcSim_dependencies.make : $(src)BesEmcDetectorMessenger.cc

$(bin)$(binobj)BesEmcDetectorMessenger.o : $(BesEmcDetectorMessenger_cc_dependencies)
	$(cpp_echo) $(src)BesEmcDetectorMessenger.cc
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(EmcSim_pp_cppflags) $(lib_EmcSim_pp_cppflags) $(BesEmcDetectorMessenger_pp_cppflags) $(use_cppflags) $(EmcSim_cppflags) $(lib_EmcSim_cppflags) $(BesEmcDetectorMessenger_cppflags) $(BesEmcDetectorMessenger_cc_cppflags)  $(src)BesEmcDetectorMessenger.cc

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (-MMD -MP -MF $*.d -MQ $@,)

ifneq ($(MAKECMDGOALS),EmcSimclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)BesCrystalParameterisation.d

$(bin)$(binobj)BesCrystalParameterisation.d :

$(bin)$(binobj)BesCrystalParameterisation.o : $(cmt_final_setup_EmcSim)

$(bin)$(binobj)BesCrystalParameterisation.o : $(src)BesCrystalParameterisation.cc
	$(cpp_echo) $(src)BesCrystalParameterisation.cc
	$(cpp_silent) $(cppcomp) -MMD -MP -MF $*.d -MQ $@ -o $@ $(use_pp_cppflags) $(EmcSim_pp_cppflags) $(lib_EmcSim_pp_cppflags) $(BesCrystalParameterisation_pp_cppflags) $(use_cppflags) $(EmcSim_cppflags) $(lib_EmcSim_cppflags) $(BesCrystalParameterisation_cppflags) $(BesCrystalParameterisation_cc_cppflags)  $(src)BesCrystalParameterisation.cc
endif
endif

else
$(bin)EmcSim_dependencies.make : $(BesCrystalParameterisation_cc_dependencies)

$(bin)EmcSim_dependencies.make : $(src)BesCrystalParameterisation.cc

$(bin)$(binobj)BesCrystalParameterisation.o : $(BesCrystalParameterisation_cc_dependencies)
	$(cpp_echo) $(src)BesCrystalParameterisation.cc
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(EmcSim_pp_cppflags) $(lib_EmcSim_pp_cppflags) $(BesCrystalParameterisation_pp_cppflags) $(use_cppflags) $(EmcSim_cppflags) $(lib_EmcSim_cppflags) $(BesCrystalParameterisation_cppflags) $(BesCrystalParameterisation_cc_cppflags)  $(src)BesCrystalParameterisation.cc

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (-MMD -MP -MF $*.d -MQ $@,)

ifneq ($(MAKECMDGOALS),EmcSimclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)BesEmcEndGeometry.d

$(bin)$(binobj)BesEmcEndGeometry.d :

$(bin)$(binobj)BesEmcEndGeometry.o : $(cmt_final_setup_EmcSim)

$(bin)$(binobj)BesEmcEndGeometry.o : $(src)BesEmcEndGeometry.cc
	$(cpp_echo) $(src)BesEmcEndGeometry.cc
	$(cpp_silent) $(cppcomp) -MMD -MP -MF $*.d -MQ $@ -o $@ $(use_pp_cppflags) $(EmcSim_pp_cppflags) $(lib_EmcSim_pp_cppflags) $(BesEmcEndGeometry_pp_cppflags) $(use_cppflags) $(EmcSim_cppflags) $(lib_EmcSim_cppflags) $(BesEmcEndGeometry_cppflags) $(BesEmcEndGeometry_cc_cppflags)  $(src)BesEmcEndGeometry.cc
endif
endif

else
$(bin)EmcSim_dependencies.make : $(BesEmcEndGeometry_cc_dependencies)

$(bin)EmcSim_dependencies.make : $(src)BesEmcEndGeometry.cc

$(bin)$(binobj)BesEmcEndGeometry.o : $(BesEmcEndGeometry_cc_dependencies)
	$(cpp_echo) $(src)BesEmcEndGeometry.cc
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(EmcSim_pp_cppflags) $(lib_EmcSim_pp_cppflags) $(BesEmcEndGeometry_pp_cppflags) $(use_cppflags) $(EmcSim_cppflags) $(lib_EmcSim_cppflags) $(BesEmcEndGeometry_cppflags) $(BesEmcEndGeometry_cc_cppflags)  $(src)BesEmcEndGeometry.cc

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (-MMD -MP -MF $*.d -MQ $@,)

ifneq ($(MAKECMDGOALS),EmcSimclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)BesEmcSD.d

$(bin)$(binobj)BesEmcSD.d :

$(bin)$(binobj)BesEmcSD.o : $(cmt_final_setup_EmcSim)

$(bin)$(binobj)BesEmcSD.o : $(src)BesEmcSD.cc
	$(cpp_echo) $(src)BesEmcSD.cc
	$(cpp_silent) $(cppcomp) -MMD -MP -MF $*.d -MQ $@ -o $@ $(use_pp_cppflags) $(EmcSim_pp_cppflags) $(lib_EmcSim_pp_cppflags) $(BesEmcSD_pp_cppflags) $(use_cppflags) $(EmcSim_cppflags) $(lib_EmcSim_cppflags) $(BesEmcSD_cppflags) $(BesEmcSD_cc_cppflags)  $(src)BesEmcSD.cc
endif
endif

else
$(bin)EmcSim_dependencies.make : $(BesEmcSD_cc_dependencies)

$(bin)EmcSim_dependencies.make : $(src)BesEmcSD.cc

$(bin)$(binobj)BesEmcSD.o : $(BesEmcSD_cc_dependencies)
	$(cpp_echo) $(src)BesEmcSD.cc
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(EmcSim_pp_cppflags) $(lib_EmcSim_pp_cppflags) $(BesEmcSD_pp_cppflags) $(use_cppflags) $(EmcSim_cppflags) $(lib_EmcSim_cppflags) $(BesEmcSD_cppflags) $(BesEmcSD_cc_cppflags)  $(src)BesEmcSD.cc

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (-MMD -MP -MF $*.d -MQ $@,)

ifneq ($(MAKECMDGOALS),EmcSimclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)BesEmcParameter.d

$(bin)$(binobj)BesEmcParameter.d :

$(bin)$(binobj)BesEmcParameter.o : $(cmt_final_setup_EmcSim)

$(bin)$(binobj)BesEmcParameter.o : $(src)BesEmcParameter.cc
	$(cpp_echo) $(src)BesEmcParameter.cc
	$(cpp_silent) $(cppcomp) -MMD -MP -MF $*.d -MQ $@ -o $@ $(use_pp_cppflags) $(EmcSim_pp_cppflags) $(lib_EmcSim_pp_cppflags) $(BesEmcParameter_pp_cppflags) $(use_cppflags) $(EmcSim_cppflags) $(lib_EmcSim_cppflags) $(BesEmcParameter_cppflags) $(BesEmcParameter_cc_cppflags)  $(src)BesEmcParameter.cc
endif
endif

else
$(bin)EmcSim_dependencies.make : $(BesEmcParameter_cc_dependencies)

$(bin)EmcSim_dependencies.make : $(src)BesEmcParameter.cc

$(bin)$(binobj)BesEmcParameter.o : $(BesEmcParameter_cc_dependencies)
	$(cpp_echo) $(src)BesEmcParameter.cc
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(EmcSim_pp_cppflags) $(lib_EmcSim_pp_cppflags) $(BesEmcParameter_pp_cppflags) $(use_cppflags) $(EmcSim_cppflags) $(lib_EmcSim_cppflags) $(BesEmcParameter_cppflags) $(BesEmcParameter_cc_cppflags)  $(src)BesEmcParameter.cc

endif

#-- end of cpp_library ------------------
#-- start of cleanup_header --------------

clean :: EmcSimclean ;
#	@cd .

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(EmcSim.make) $@: No rule for such target" >&2
else
.DEFAULT::
	$(error PEDANTIC: $@: No rule for such target)
endif

EmcSimclean ::
#-- end of cleanup_header ---------------
#-- start of cleanup_library -------------
	$(cleanup_echo) library EmcSim
	-$(cleanup_silent) cd $(bin); /bin/rm -f $(library_prefix)EmcSim$(library_suffix).a $(library_prefix)EmcSim$(library_suffix).s? EmcSim.stamp EmcSim.shstamp
#-- end of cleanup_library ---------------
