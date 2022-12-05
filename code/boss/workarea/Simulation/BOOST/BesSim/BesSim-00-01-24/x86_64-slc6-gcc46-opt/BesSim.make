#-- start of make_header -----------------

#====================================
#  Library BesSim
#
#   Generated Thu Dec  1 15:39:11 2022  by yuansc
#
#====================================

include ${CMTROOT}/src/Makefile.core

ifdef tag
CMTEXTRATAGS = $(tag)
else
tag       = $(CMTCONFIG)
endif

cmt_BesSim_has_no_target_tag = 1

#--------------------------------------------------------

ifdef cmt_BesSim_has_target_tag

tags      = $(tag),$(CMTEXTRATAGS),target_BesSim

BesSim_tag = $(tag)

#cmt_local_tagfile_BesSim = $(BesSim_tag)_BesSim.make
cmt_local_tagfile_BesSim = $(bin)$(BesSim_tag)_BesSim.make

else

tags      = $(tag),$(CMTEXTRATAGS)

BesSim_tag = $(tag)

#cmt_local_tagfile_BesSim = $(BesSim_tag).make
cmt_local_tagfile_BesSim = $(bin)$(BesSim_tag).make

endif

include $(cmt_local_tagfile_BesSim)
#-include $(cmt_local_tagfile_BesSim)

ifdef cmt_BesSim_has_target_tag

cmt_final_setup_BesSim = $(bin)setup_BesSim.make
cmt_dependencies_in_BesSim = $(bin)dependencies_BesSim.in
#cmt_final_setup_BesSim = $(bin)BesSim_BesSimsetup.make
cmt_local_BesSim_makefile = $(bin)BesSim.make

else

cmt_final_setup_BesSim = $(bin)setup.make
cmt_dependencies_in_BesSim = $(bin)dependencies.in
#cmt_final_setup_BesSim = $(bin)BesSimsetup.make
cmt_local_BesSim_makefile = $(bin)BesSim.make

endif

#cmt_final_setup = $(bin)setup.make
#cmt_final_setup = $(bin)BesSimsetup.make

#BesSim :: ;

dirs ::
	@if test ! -r requirements ; then echo "No requirements file" ; fi; \
	  if test ! -d $(bin) ; then $(mkdir) -p $(bin) ; fi

javadirs ::
	@if test ! -d $(javabin) ; then $(mkdir) -p $(javabin) ; fi

srcdirs ::
	@if test ! -d $(src) ; then $(mkdir) -p $(src) ; fi

help ::
	$(echo) 'BesSim'

binobj = 
ifdef STRUCTURED_OUTPUT
binobj = BesSim/
#BesSim::
#	@if test ! -d $(bin)$(binobj) ; then $(mkdir) -p $(bin)$(binobj) ; fi
#	$(echo) "STRUCTURED_OUTPUT="$(bin)$(binobj)
endif

${CMTROOT}/src/Makefile.core : ;
ifdef use_requirements
$(use_requirements) : ;
endif

#-- end of make_header ------------------
#-- start of libary_header ---------------

BesSimlibname   = $(bin)$(library_prefix)BesSim$(library_suffix)
BesSimlib       = $(BesSimlibname).a
BesSimstamp     = $(bin)BesSim.stamp
BesSimshstamp   = $(bin)BesSim.shstamp

BesSim :: dirs  BesSimLIB
	$(echo) "BesSim ok"

#-- end of libary_header ----------------

BesSimLIB :: $(BesSimlib) $(BesSimshstamp)
	@/bin/echo "------> BesSim : library ok"

$(BesSimlib) :: $(bin)BesPip.o $(bin)BesMagneticFieldMessenger.o $(bin)HadronPhysicsQGSP_BERT_CHIPS.o $(bin)BesSim.o $(bin)G4MiscLHEPBuilder_CHIPS.o $(bin)StepLimiter.o $(bin)BesRunAction.o $(bin)BesMcTruthWriter.o $(bin)BesRootIO.o $(bin)BesSCM.o $(bin)BesSteppingAction.o $(bin)BesTDSWriter.o $(bin)BesSCMParameter.o $(bin)BesAsciiIO.o $(bin)BesRawDataWriter.o $(bin)BesTuningIO.o $(bin)BesTrackingAction.o $(bin)G4SubtractionSolid.o $(bin)BesDetectorConstruction.o $(bin)BesRunActionMessenger.o $(bin)BesEventAction.o $(bin)BesLogSession.o $(bin)BesMagneticField.o $(bin)BesPipParameter.o $(bin)BesSim_entries.o $(bin)BesSim_load.o
	$(lib_echo) library
	$(lib_silent) cd $(bin); \
	  $(ar) $(BesSimlib) $?
	$(lib_silent) $(ranlib) $(BesSimlib)
	$(lib_silent) cat /dev/null >$(BesSimstamp)

#------------------------------------------------------------------
#  Future improvement? to empty the object files after
#  storing in the library
#
##	  for f in $?; do \
##	    rm $${f}; touch $${f}; \
##	  done
#------------------------------------------------------------------

$(BesSimlibname).$(shlibsuffix) :: $(BesSimlib) $(BesSimstamps)
	$(lib_silent) cd $(bin); QUIET=$(QUIET); $(make_shlib) "$(tags)" BesSim $(BesSim_shlibflags)

$(BesSimshstamp) :: $(BesSimlibname).$(shlibsuffix)
	@if test -f $(BesSimlibname).$(shlibsuffix) ; then cat /dev/null >$(BesSimshstamp) ; fi

BesSimclean ::
	$(cleanup_echo) objects
	$(cleanup_silent) cd $(bin); /bin/rm -f $(bin)BesPip.o $(bin)BesMagneticFieldMessenger.o $(bin)HadronPhysicsQGSP_BERT_CHIPS.o $(bin)BesSim.o $(bin)G4MiscLHEPBuilder_CHIPS.o $(bin)StepLimiter.o $(bin)BesRunAction.o $(bin)BesMcTruthWriter.o $(bin)BesRootIO.o $(bin)BesSCM.o $(bin)BesSteppingAction.o $(bin)BesTDSWriter.o $(bin)BesSCMParameter.o $(bin)BesAsciiIO.o $(bin)BesRawDataWriter.o $(bin)BesTuningIO.o $(bin)BesTrackingAction.o $(bin)G4SubtractionSolid.o $(bin)BesDetectorConstruction.o $(bin)BesRunActionMessenger.o $(bin)BesEventAction.o $(bin)BesLogSession.o $(bin)BesMagneticField.o $(bin)BesPipParameter.o $(bin)BesSim_entries.o $(bin)BesSim_load.o

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
BesSiminstallname = $(library_prefix)BesSim$(library_suffix).$(shlibsuffix)

BesSim :: BesSiminstall

install :: BesSiminstall

BesSiminstall :: $(install_dir)/$(BesSiminstallname)
	@if test ! "${installarea}" = ""; then\
	  echo "installation done"; \
	fi

$(install_dir)/$(BesSiminstallname) :: $(bin)$(BesSiminstallname)
	@if test ! "${installarea}" = ""; then \
	  cd $(bin); \
	  if test ! "$(install_dir)" = ""; then \
	    if test ! -d "$(install_dir)"; then \
	      mkdir -p $(install_dir); \
	    fi ; \
	    if test -d "$(install_dir)"; then \
	      echo "Installing library $(BesSiminstallname) into $(install_dir)"; \
	      if test -e $(install_dir)/$(BesSiminstallname); then \
	        $(cmt_uninstall_area_command) $(install_dir)/$(BesSiminstallname); \
	        $(cmt_uninstall_area_command) $(install_dir)/$(BesSiminstallname).cmtref; \
	      fi; \
	      $(cmt_install_area_command) `pwd`/$(BesSiminstallname) $(install_dir)/$(BesSiminstallname); \
	      echo `pwd`/$(BesSiminstallname) >$(install_dir)/$(BesSiminstallname).cmtref; \
	    fi \
          else \
	    echo "Cannot install library $(BesSiminstallname), no installation directory specified"; \
	  fi; \
	fi

BesSimclean :: BesSimuninstall

uninstall :: BesSimuninstall

BesSimuninstall ::
	@if test ! "${installarea}" = ""; then \
	  cd $(bin); \
	  if test ! "$(install_dir)" = ""; then \
	    if test -d "$(install_dir)"; then \
	      echo "Removing installed library $(BesSiminstallname) from $(install_dir)"; \
	      $(cmt_uninstall_area_command) $(install_dir)/$(BesSiminstallname); \
	      $(cmt_uninstall_area_command) $(install_dir)/$(BesSiminstallname).cmtref; \
	    fi \
          else \
	    echo "Cannot uninstall library $(BesSiminstallname), no installation directory specified"; \
	  fi; \
	fi




#-- start of cpp_library -----------------

ifneq (-MMD -MP -MF $*.d -MQ $@,)

ifneq ($(MAKECMDGOALS),BesSimclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)BesPip.d

$(bin)$(binobj)BesPip.d :

$(bin)$(binobj)BesPip.o : $(cmt_final_setup_BesSim)

$(bin)$(binobj)BesPip.o : $(src)BesPip.cc
	$(cpp_echo) $(src)BesPip.cc
	$(cpp_silent) $(cppcomp) -MMD -MP -MF $*.d -MQ $@ -o $@ $(use_pp_cppflags) $(BesSim_pp_cppflags) $(lib_BesSim_pp_cppflags) $(BesPip_pp_cppflags) $(use_cppflags) $(BesSim_cppflags) $(lib_BesSim_cppflags) $(BesPip_cppflags) $(BesPip_cc_cppflags)  $(src)BesPip.cc
endif
endif

else
$(bin)BesSim_dependencies.make : $(BesPip_cc_dependencies)

$(bin)BesSim_dependencies.make : $(src)BesPip.cc

$(bin)$(binobj)BesPip.o : $(BesPip_cc_dependencies)
	$(cpp_echo) $(src)BesPip.cc
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(BesSim_pp_cppflags) $(lib_BesSim_pp_cppflags) $(BesPip_pp_cppflags) $(use_cppflags) $(BesSim_cppflags) $(lib_BesSim_cppflags) $(BesPip_cppflags) $(BesPip_cc_cppflags)  $(src)BesPip.cc

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (-MMD -MP -MF $*.d -MQ $@,)

ifneq ($(MAKECMDGOALS),BesSimclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)BesMagneticFieldMessenger.d

$(bin)$(binobj)BesMagneticFieldMessenger.d :

$(bin)$(binobj)BesMagneticFieldMessenger.o : $(cmt_final_setup_BesSim)

$(bin)$(binobj)BesMagneticFieldMessenger.o : $(src)BesMagneticFieldMessenger.cc
	$(cpp_echo) $(src)BesMagneticFieldMessenger.cc
	$(cpp_silent) $(cppcomp) -MMD -MP -MF $*.d -MQ $@ -o $@ $(use_pp_cppflags) $(BesSim_pp_cppflags) $(lib_BesSim_pp_cppflags) $(BesMagneticFieldMessenger_pp_cppflags) $(use_cppflags) $(BesSim_cppflags) $(lib_BesSim_cppflags) $(BesMagneticFieldMessenger_cppflags) $(BesMagneticFieldMessenger_cc_cppflags)  $(src)BesMagneticFieldMessenger.cc
endif
endif

else
$(bin)BesSim_dependencies.make : $(BesMagneticFieldMessenger_cc_dependencies)

$(bin)BesSim_dependencies.make : $(src)BesMagneticFieldMessenger.cc

$(bin)$(binobj)BesMagneticFieldMessenger.o : $(BesMagneticFieldMessenger_cc_dependencies)
	$(cpp_echo) $(src)BesMagneticFieldMessenger.cc
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(BesSim_pp_cppflags) $(lib_BesSim_pp_cppflags) $(BesMagneticFieldMessenger_pp_cppflags) $(use_cppflags) $(BesSim_cppflags) $(lib_BesSim_cppflags) $(BesMagneticFieldMessenger_cppflags) $(BesMagneticFieldMessenger_cc_cppflags)  $(src)BesMagneticFieldMessenger.cc

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (-MMD -MP -MF $*.d -MQ $@,)

ifneq ($(MAKECMDGOALS),BesSimclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)HadronPhysicsQGSP_BERT_CHIPS.d

$(bin)$(binobj)HadronPhysicsQGSP_BERT_CHIPS.d :

$(bin)$(binobj)HadronPhysicsQGSP_BERT_CHIPS.o : $(cmt_final_setup_BesSim)

$(bin)$(binobj)HadronPhysicsQGSP_BERT_CHIPS.o : $(src)HadronPhysicsQGSP_BERT_CHIPS.cc
	$(cpp_echo) $(src)HadronPhysicsQGSP_BERT_CHIPS.cc
	$(cpp_silent) $(cppcomp) -MMD -MP -MF $*.d -MQ $@ -o $@ $(use_pp_cppflags) $(BesSim_pp_cppflags) $(lib_BesSim_pp_cppflags) $(HadronPhysicsQGSP_BERT_CHIPS_pp_cppflags) $(use_cppflags) $(BesSim_cppflags) $(lib_BesSim_cppflags) $(HadronPhysicsQGSP_BERT_CHIPS_cppflags) $(HadronPhysicsQGSP_BERT_CHIPS_cc_cppflags)  $(src)HadronPhysicsQGSP_BERT_CHIPS.cc
endif
endif

else
$(bin)BesSim_dependencies.make : $(HadronPhysicsQGSP_BERT_CHIPS_cc_dependencies)

$(bin)BesSim_dependencies.make : $(src)HadronPhysicsQGSP_BERT_CHIPS.cc

$(bin)$(binobj)HadronPhysicsQGSP_BERT_CHIPS.o : $(HadronPhysicsQGSP_BERT_CHIPS_cc_dependencies)
	$(cpp_echo) $(src)HadronPhysicsQGSP_BERT_CHIPS.cc
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(BesSim_pp_cppflags) $(lib_BesSim_pp_cppflags) $(HadronPhysicsQGSP_BERT_CHIPS_pp_cppflags) $(use_cppflags) $(BesSim_cppflags) $(lib_BesSim_cppflags) $(HadronPhysicsQGSP_BERT_CHIPS_cppflags) $(HadronPhysicsQGSP_BERT_CHIPS_cc_cppflags)  $(src)HadronPhysicsQGSP_BERT_CHIPS.cc

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (-MMD -MP -MF $*.d -MQ $@,)

ifneq ($(MAKECMDGOALS),BesSimclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)BesSim.d

$(bin)$(binobj)BesSim.d :

$(bin)$(binobj)BesSim.o : $(cmt_final_setup_BesSim)

$(bin)$(binobj)BesSim.o : $(src)BesSim.cc
	$(cpp_echo) $(src)BesSim.cc
	$(cpp_silent) $(cppcomp) -MMD -MP -MF $*.d -MQ $@ -o $@ $(use_pp_cppflags) $(BesSim_pp_cppflags) $(lib_BesSim_pp_cppflags) $(BesSim_pp_cppflags) $(use_cppflags) $(BesSim_cppflags) $(lib_BesSim_cppflags) $(BesSim_cppflags) $(BesSim_cc_cppflags)  $(src)BesSim.cc
endif
endif

else
$(bin)BesSim_dependencies.make : $(BesSim_cc_dependencies)

$(bin)BesSim_dependencies.make : $(src)BesSim.cc

$(bin)$(binobj)BesSim.o : $(BesSim_cc_dependencies)
	$(cpp_echo) $(src)BesSim.cc
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(BesSim_pp_cppflags) $(lib_BesSim_pp_cppflags) $(BesSim_pp_cppflags) $(use_cppflags) $(BesSim_cppflags) $(lib_BesSim_cppflags) $(BesSim_cppflags) $(BesSim_cc_cppflags)  $(src)BesSim.cc

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (-MMD -MP -MF $*.d -MQ $@,)

ifneq ($(MAKECMDGOALS),BesSimclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)G4MiscLHEPBuilder_CHIPS.d

$(bin)$(binobj)G4MiscLHEPBuilder_CHIPS.d :

$(bin)$(binobj)G4MiscLHEPBuilder_CHIPS.o : $(cmt_final_setup_BesSim)

$(bin)$(binobj)G4MiscLHEPBuilder_CHIPS.o : $(src)G4MiscLHEPBuilder_CHIPS.cc
	$(cpp_echo) $(src)G4MiscLHEPBuilder_CHIPS.cc
	$(cpp_silent) $(cppcomp) -MMD -MP -MF $*.d -MQ $@ -o $@ $(use_pp_cppflags) $(BesSim_pp_cppflags) $(lib_BesSim_pp_cppflags) $(G4MiscLHEPBuilder_CHIPS_pp_cppflags) $(use_cppflags) $(BesSim_cppflags) $(lib_BesSim_cppflags) $(G4MiscLHEPBuilder_CHIPS_cppflags) $(G4MiscLHEPBuilder_CHIPS_cc_cppflags)  $(src)G4MiscLHEPBuilder_CHIPS.cc
endif
endif

else
$(bin)BesSim_dependencies.make : $(G4MiscLHEPBuilder_CHIPS_cc_dependencies)

$(bin)BesSim_dependencies.make : $(src)G4MiscLHEPBuilder_CHIPS.cc

$(bin)$(binobj)G4MiscLHEPBuilder_CHIPS.o : $(G4MiscLHEPBuilder_CHIPS_cc_dependencies)
	$(cpp_echo) $(src)G4MiscLHEPBuilder_CHIPS.cc
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(BesSim_pp_cppflags) $(lib_BesSim_pp_cppflags) $(G4MiscLHEPBuilder_CHIPS_pp_cppflags) $(use_cppflags) $(BesSim_cppflags) $(lib_BesSim_cppflags) $(G4MiscLHEPBuilder_CHIPS_cppflags) $(G4MiscLHEPBuilder_CHIPS_cc_cppflags)  $(src)G4MiscLHEPBuilder_CHIPS.cc

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (-MMD -MP -MF $*.d -MQ $@,)

ifneq ($(MAKECMDGOALS),BesSimclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)StepLimiter.d

$(bin)$(binobj)StepLimiter.d :

$(bin)$(binobj)StepLimiter.o : $(cmt_final_setup_BesSim)

$(bin)$(binobj)StepLimiter.o : $(src)StepLimiter.cc
	$(cpp_echo) $(src)StepLimiter.cc
	$(cpp_silent) $(cppcomp) -MMD -MP -MF $*.d -MQ $@ -o $@ $(use_pp_cppflags) $(BesSim_pp_cppflags) $(lib_BesSim_pp_cppflags) $(StepLimiter_pp_cppflags) $(use_cppflags) $(BesSim_cppflags) $(lib_BesSim_cppflags) $(StepLimiter_cppflags) $(StepLimiter_cc_cppflags)  $(src)StepLimiter.cc
endif
endif

else
$(bin)BesSim_dependencies.make : $(StepLimiter_cc_dependencies)

$(bin)BesSim_dependencies.make : $(src)StepLimiter.cc

$(bin)$(binobj)StepLimiter.o : $(StepLimiter_cc_dependencies)
	$(cpp_echo) $(src)StepLimiter.cc
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(BesSim_pp_cppflags) $(lib_BesSim_pp_cppflags) $(StepLimiter_pp_cppflags) $(use_cppflags) $(BesSim_cppflags) $(lib_BesSim_cppflags) $(StepLimiter_cppflags) $(StepLimiter_cc_cppflags)  $(src)StepLimiter.cc

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (-MMD -MP -MF $*.d -MQ $@,)

ifneq ($(MAKECMDGOALS),BesSimclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)BesRunAction.d

$(bin)$(binobj)BesRunAction.d :

$(bin)$(binobj)BesRunAction.o : $(cmt_final_setup_BesSim)

$(bin)$(binobj)BesRunAction.o : $(src)BesRunAction.cc
	$(cpp_echo) $(src)BesRunAction.cc
	$(cpp_silent) $(cppcomp) -MMD -MP -MF $*.d -MQ $@ -o $@ $(use_pp_cppflags) $(BesSim_pp_cppflags) $(lib_BesSim_pp_cppflags) $(BesRunAction_pp_cppflags) $(use_cppflags) $(BesSim_cppflags) $(lib_BesSim_cppflags) $(BesRunAction_cppflags) $(BesRunAction_cc_cppflags)  $(src)BesRunAction.cc
endif
endif

else
$(bin)BesSim_dependencies.make : $(BesRunAction_cc_dependencies)

$(bin)BesSim_dependencies.make : $(src)BesRunAction.cc

$(bin)$(binobj)BesRunAction.o : $(BesRunAction_cc_dependencies)
	$(cpp_echo) $(src)BesRunAction.cc
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(BesSim_pp_cppflags) $(lib_BesSim_pp_cppflags) $(BesRunAction_pp_cppflags) $(use_cppflags) $(BesSim_cppflags) $(lib_BesSim_cppflags) $(BesRunAction_cppflags) $(BesRunAction_cc_cppflags)  $(src)BesRunAction.cc

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (-MMD -MP -MF $*.d -MQ $@,)

ifneq ($(MAKECMDGOALS),BesSimclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)BesMcTruthWriter.d

$(bin)$(binobj)BesMcTruthWriter.d :

$(bin)$(binobj)BesMcTruthWriter.o : $(cmt_final_setup_BesSim)

$(bin)$(binobj)BesMcTruthWriter.o : $(src)BesMcTruthWriter.cc
	$(cpp_echo) $(src)BesMcTruthWriter.cc
	$(cpp_silent) $(cppcomp) -MMD -MP -MF $*.d -MQ $@ -o $@ $(use_pp_cppflags) $(BesSim_pp_cppflags) $(lib_BesSim_pp_cppflags) $(BesMcTruthWriter_pp_cppflags) $(use_cppflags) $(BesSim_cppflags) $(lib_BesSim_cppflags) $(BesMcTruthWriter_cppflags) $(BesMcTruthWriter_cc_cppflags)  $(src)BesMcTruthWriter.cc
endif
endif

else
$(bin)BesSim_dependencies.make : $(BesMcTruthWriter_cc_dependencies)

$(bin)BesSim_dependencies.make : $(src)BesMcTruthWriter.cc

$(bin)$(binobj)BesMcTruthWriter.o : $(BesMcTruthWriter_cc_dependencies)
	$(cpp_echo) $(src)BesMcTruthWriter.cc
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(BesSim_pp_cppflags) $(lib_BesSim_pp_cppflags) $(BesMcTruthWriter_pp_cppflags) $(use_cppflags) $(BesSim_cppflags) $(lib_BesSim_cppflags) $(BesMcTruthWriter_cppflags) $(BesMcTruthWriter_cc_cppflags)  $(src)BesMcTruthWriter.cc

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (-MMD -MP -MF $*.d -MQ $@,)

ifneq ($(MAKECMDGOALS),BesSimclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)BesRootIO.d

$(bin)$(binobj)BesRootIO.d :

$(bin)$(binobj)BesRootIO.o : $(cmt_final_setup_BesSim)

$(bin)$(binobj)BesRootIO.o : $(src)BesRootIO.cc
	$(cpp_echo) $(src)BesRootIO.cc
	$(cpp_silent) $(cppcomp) -MMD -MP -MF $*.d -MQ $@ -o $@ $(use_pp_cppflags) $(BesSim_pp_cppflags) $(lib_BesSim_pp_cppflags) $(BesRootIO_pp_cppflags) $(use_cppflags) $(BesSim_cppflags) $(lib_BesSim_cppflags) $(BesRootIO_cppflags) $(BesRootIO_cc_cppflags)  $(src)BesRootIO.cc
endif
endif

else
$(bin)BesSim_dependencies.make : $(BesRootIO_cc_dependencies)

$(bin)BesSim_dependencies.make : $(src)BesRootIO.cc

$(bin)$(binobj)BesRootIO.o : $(BesRootIO_cc_dependencies)
	$(cpp_echo) $(src)BesRootIO.cc
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(BesSim_pp_cppflags) $(lib_BesSim_pp_cppflags) $(BesRootIO_pp_cppflags) $(use_cppflags) $(BesSim_cppflags) $(lib_BesSim_cppflags) $(BesRootIO_cppflags) $(BesRootIO_cc_cppflags)  $(src)BesRootIO.cc

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (-MMD -MP -MF $*.d -MQ $@,)

ifneq ($(MAKECMDGOALS),BesSimclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)BesSCM.d

$(bin)$(binobj)BesSCM.d :

$(bin)$(binobj)BesSCM.o : $(cmt_final_setup_BesSim)

$(bin)$(binobj)BesSCM.o : $(src)BesSCM.cc
	$(cpp_echo) $(src)BesSCM.cc
	$(cpp_silent) $(cppcomp) -MMD -MP -MF $*.d -MQ $@ -o $@ $(use_pp_cppflags) $(BesSim_pp_cppflags) $(lib_BesSim_pp_cppflags) $(BesSCM_pp_cppflags) $(use_cppflags) $(BesSim_cppflags) $(lib_BesSim_cppflags) $(BesSCM_cppflags) $(BesSCM_cc_cppflags)  $(src)BesSCM.cc
endif
endif

else
$(bin)BesSim_dependencies.make : $(BesSCM_cc_dependencies)

$(bin)BesSim_dependencies.make : $(src)BesSCM.cc

$(bin)$(binobj)BesSCM.o : $(BesSCM_cc_dependencies)
	$(cpp_echo) $(src)BesSCM.cc
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(BesSim_pp_cppflags) $(lib_BesSim_pp_cppflags) $(BesSCM_pp_cppflags) $(use_cppflags) $(BesSim_cppflags) $(lib_BesSim_cppflags) $(BesSCM_cppflags) $(BesSCM_cc_cppflags)  $(src)BesSCM.cc

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (-MMD -MP -MF $*.d -MQ $@,)

ifneq ($(MAKECMDGOALS),BesSimclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)BesSteppingAction.d

$(bin)$(binobj)BesSteppingAction.d :

$(bin)$(binobj)BesSteppingAction.o : $(cmt_final_setup_BesSim)

$(bin)$(binobj)BesSteppingAction.o : $(src)BesSteppingAction.cc
	$(cpp_echo) $(src)BesSteppingAction.cc
	$(cpp_silent) $(cppcomp) -MMD -MP -MF $*.d -MQ $@ -o $@ $(use_pp_cppflags) $(BesSim_pp_cppflags) $(lib_BesSim_pp_cppflags) $(BesSteppingAction_pp_cppflags) $(use_cppflags) $(BesSim_cppflags) $(lib_BesSim_cppflags) $(BesSteppingAction_cppflags) $(BesSteppingAction_cc_cppflags)  $(src)BesSteppingAction.cc
endif
endif

else
$(bin)BesSim_dependencies.make : $(BesSteppingAction_cc_dependencies)

$(bin)BesSim_dependencies.make : $(src)BesSteppingAction.cc

$(bin)$(binobj)BesSteppingAction.o : $(BesSteppingAction_cc_dependencies)
	$(cpp_echo) $(src)BesSteppingAction.cc
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(BesSim_pp_cppflags) $(lib_BesSim_pp_cppflags) $(BesSteppingAction_pp_cppflags) $(use_cppflags) $(BesSim_cppflags) $(lib_BesSim_cppflags) $(BesSteppingAction_cppflags) $(BesSteppingAction_cc_cppflags)  $(src)BesSteppingAction.cc

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (-MMD -MP -MF $*.d -MQ $@,)

ifneq ($(MAKECMDGOALS),BesSimclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)BesTDSWriter.d

$(bin)$(binobj)BesTDSWriter.d :

$(bin)$(binobj)BesTDSWriter.o : $(cmt_final_setup_BesSim)

$(bin)$(binobj)BesTDSWriter.o : $(src)BesTDSWriter.cc
	$(cpp_echo) $(src)BesTDSWriter.cc
	$(cpp_silent) $(cppcomp) -MMD -MP -MF $*.d -MQ $@ -o $@ $(use_pp_cppflags) $(BesSim_pp_cppflags) $(lib_BesSim_pp_cppflags) $(BesTDSWriter_pp_cppflags) $(use_cppflags) $(BesSim_cppflags) $(lib_BesSim_cppflags) $(BesTDSWriter_cppflags) $(BesTDSWriter_cc_cppflags)  $(src)BesTDSWriter.cc
endif
endif

else
$(bin)BesSim_dependencies.make : $(BesTDSWriter_cc_dependencies)

$(bin)BesSim_dependencies.make : $(src)BesTDSWriter.cc

$(bin)$(binobj)BesTDSWriter.o : $(BesTDSWriter_cc_dependencies)
	$(cpp_echo) $(src)BesTDSWriter.cc
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(BesSim_pp_cppflags) $(lib_BesSim_pp_cppflags) $(BesTDSWriter_pp_cppflags) $(use_cppflags) $(BesSim_cppflags) $(lib_BesSim_cppflags) $(BesTDSWriter_cppflags) $(BesTDSWriter_cc_cppflags)  $(src)BesTDSWriter.cc

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (-MMD -MP -MF $*.d -MQ $@,)

ifneq ($(MAKECMDGOALS),BesSimclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)BesSCMParameter.d

$(bin)$(binobj)BesSCMParameter.d :

$(bin)$(binobj)BesSCMParameter.o : $(cmt_final_setup_BesSim)

$(bin)$(binobj)BesSCMParameter.o : $(src)BesSCMParameter.cc
	$(cpp_echo) $(src)BesSCMParameter.cc
	$(cpp_silent) $(cppcomp) -MMD -MP -MF $*.d -MQ $@ -o $@ $(use_pp_cppflags) $(BesSim_pp_cppflags) $(lib_BesSim_pp_cppflags) $(BesSCMParameter_pp_cppflags) $(use_cppflags) $(BesSim_cppflags) $(lib_BesSim_cppflags) $(BesSCMParameter_cppflags) $(BesSCMParameter_cc_cppflags)  $(src)BesSCMParameter.cc
endif
endif

else
$(bin)BesSim_dependencies.make : $(BesSCMParameter_cc_dependencies)

$(bin)BesSim_dependencies.make : $(src)BesSCMParameter.cc

$(bin)$(binobj)BesSCMParameter.o : $(BesSCMParameter_cc_dependencies)
	$(cpp_echo) $(src)BesSCMParameter.cc
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(BesSim_pp_cppflags) $(lib_BesSim_pp_cppflags) $(BesSCMParameter_pp_cppflags) $(use_cppflags) $(BesSim_cppflags) $(lib_BesSim_cppflags) $(BesSCMParameter_cppflags) $(BesSCMParameter_cc_cppflags)  $(src)BesSCMParameter.cc

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (-MMD -MP -MF $*.d -MQ $@,)

ifneq ($(MAKECMDGOALS),BesSimclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)BesAsciiIO.d

$(bin)$(binobj)BesAsciiIO.d :

$(bin)$(binobj)BesAsciiIO.o : $(cmt_final_setup_BesSim)

$(bin)$(binobj)BesAsciiIO.o : $(src)BesAsciiIO.cc
	$(cpp_echo) $(src)BesAsciiIO.cc
	$(cpp_silent) $(cppcomp) -MMD -MP -MF $*.d -MQ $@ -o $@ $(use_pp_cppflags) $(BesSim_pp_cppflags) $(lib_BesSim_pp_cppflags) $(BesAsciiIO_pp_cppflags) $(use_cppflags) $(BesSim_cppflags) $(lib_BesSim_cppflags) $(BesAsciiIO_cppflags) $(BesAsciiIO_cc_cppflags)  $(src)BesAsciiIO.cc
endif
endif

else
$(bin)BesSim_dependencies.make : $(BesAsciiIO_cc_dependencies)

$(bin)BesSim_dependencies.make : $(src)BesAsciiIO.cc

$(bin)$(binobj)BesAsciiIO.o : $(BesAsciiIO_cc_dependencies)
	$(cpp_echo) $(src)BesAsciiIO.cc
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(BesSim_pp_cppflags) $(lib_BesSim_pp_cppflags) $(BesAsciiIO_pp_cppflags) $(use_cppflags) $(BesSim_cppflags) $(lib_BesSim_cppflags) $(BesAsciiIO_cppflags) $(BesAsciiIO_cc_cppflags)  $(src)BesAsciiIO.cc

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (-MMD -MP -MF $*.d -MQ $@,)

ifneq ($(MAKECMDGOALS),BesSimclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)BesRawDataWriter.d

$(bin)$(binobj)BesRawDataWriter.d :

$(bin)$(binobj)BesRawDataWriter.o : $(cmt_final_setup_BesSim)

$(bin)$(binobj)BesRawDataWriter.o : $(src)BesRawDataWriter.cc
	$(cpp_echo) $(src)BesRawDataWriter.cc
	$(cpp_silent) $(cppcomp) -MMD -MP -MF $*.d -MQ $@ -o $@ $(use_pp_cppflags) $(BesSim_pp_cppflags) $(lib_BesSim_pp_cppflags) $(BesRawDataWriter_pp_cppflags) $(use_cppflags) $(BesSim_cppflags) $(lib_BesSim_cppflags) $(BesRawDataWriter_cppflags) $(BesRawDataWriter_cc_cppflags)  $(src)BesRawDataWriter.cc
endif
endif

else
$(bin)BesSim_dependencies.make : $(BesRawDataWriter_cc_dependencies)

$(bin)BesSim_dependencies.make : $(src)BesRawDataWriter.cc

$(bin)$(binobj)BesRawDataWriter.o : $(BesRawDataWriter_cc_dependencies)
	$(cpp_echo) $(src)BesRawDataWriter.cc
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(BesSim_pp_cppflags) $(lib_BesSim_pp_cppflags) $(BesRawDataWriter_pp_cppflags) $(use_cppflags) $(BesSim_cppflags) $(lib_BesSim_cppflags) $(BesRawDataWriter_cppflags) $(BesRawDataWriter_cc_cppflags)  $(src)BesRawDataWriter.cc

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (-MMD -MP -MF $*.d -MQ $@,)

ifneq ($(MAKECMDGOALS),BesSimclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)BesTuningIO.d

$(bin)$(binobj)BesTuningIO.d :

$(bin)$(binobj)BesTuningIO.o : $(cmt_final_setup_BesSim)

$(bin)$(binobj)BesTuningIO.o : $(src)BesTuningIO.cc
	$(cpp_echo) $(src)BesTuningIO.cc
	$(cpp_silent) $(cppcomp) -MMD -MP -MF $*.d -MQ $@ -o $@ $(use_pp_cppflags) $(BesSim_pp_cppflags) $(lib_BesSim_pp_cppflags) $(BesTuningIO_pp_cppflags) $(use_cppflags) $(BesSim_cppflags) $(lib_BesSim_cppflags) $(BesTuningIO_cppflags) $(BesTuningIO_cc_cppflags)  $(src)BesTuningIO.cc
endif
endif

else
$(bin)BesSim_dependencies.make : $(BesTuningIO_cc_dependencies)

$(bin)BesSim_dependencies.make : $(src)BesTuningIO.cc

$(bin)$(binobj)BesTuningIO.o : $(BesTuningIO_cc_dependencies)
	$(cpp_echo) $(src)BesTuningIO.cc
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(BesSim_pp_cppflags) $(lib_BesSim_pp_cppflags) $(BesTuningIO_pp_cppflags) $(use_cppflags) $(BesSim_cppflags) $(lib_BesSim_cppflags) $(BesTuningIO_cppflags) $(BesTuningIO_cc_cppflags)  $(src)BesTuningIO.cc

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (-MMD -MP -MF $*.d -MQ $@,)

ifneq ($(MAKECMDGOALS),BesSimclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)BesTrackingAction.d

$(bin)$(binobj)BesTrackingAction.d :

$(bin)$(binobj)BesTrackingAction.o : $(cmt_final_setup_BesSim)

$(bin)$(binobj)BesTrackingAction.o : $(src)BesTrackingAction.cc
	$(cpp_echo) $(src)BesTrackingAction.cc
	$(cpp_silent) $(cppcomp) -MMD -MP -MF $*.d -MQ $@ -o $@ $(use_pp_cppflags) $(BesSim_pp_cppflags) $(lib_BesSim_pp_cppflags) $(BesTrackingAction_pp_cppflags) $(use_cppflags) $(BesSim_cppflags) $(lib_BesSim_cppflags) $(BesTrackingAction_cppflags) $(BesTrackingAction_cc_cppflags)  $(src)BesTrackingAction.cc
endif
endif

else
$(bin)BesSim_dependencies.make : $(BesTrackingAction_cc_dependencies)

$(bin)BesSim_dependencies.make : $(src)BesTrackingAction.cc

$(bin)$(binobj)BesTrackingAction.o : $(BesTrackingAction_cc_dependencies)
	$(cpp_echo) $(src)BesTrackingAction.cc
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(BesSim_pp_cppflags) $(lib_BesSim_pp_cppflags) $(BesTrackingAction_pp_cppflags) $(use_cppflags) $(BesSim_cppflags) $(lib_BesSim_cppflags) $(BesTrackingAction_cppflags) $(BesTrackingAction_cc_cppflags)  $(src)BesTrackingAction.cc

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (-MMD -MP -MF $*.d -MQ $@,)

ifneq ($(MAKECMDGOALS),BesSimclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)G4SubtractionSolid.d

$(bin)$(binobj)G4SubtractionSolid.d :

$(bin)$(binobj)G4SubtractionSolid.o : $(cmt_final_setup_BesSim)

$(bin)$(binobj)G4SubtractionSolid.o : $(src)G4SubtractionSolid.cc
	$(cpp_echo) $(src)G4SubtractionSolid.cc
	$(cpp_silent) $(cppcomp) -MMD -MP -MF $*.d -MQ $@ -o $@ $(use_pp_cppflags) $(BesSim_pp_cppflags) $(lib_BesSim_pp_cppflags) $(G4SubtractionSolid_pp_cppflags) $(use_cppflags) $(BesSim_cppflags) $(lib_BesSim_cppflags) $(G4SubtractionSolid_cppflags) $(G4SubtractionSolid_cc_cppflags)  $(src)G4SubtractionSolid.cc
endif
endif

else
$(bin)BesSim_dependencies.make : $(G4SubtractionSolid_cc_dependencies)

$(bin)BesSim_dependencies.make : $(src)G4SubtractionSolid.cc

$(bin)$(binobj)G4SubtractionSolid.o : $(G4SubtractionSolid_cc_dependencies)
	$(cpp_echo) $(src)G4SubtractionSolid.cc
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(BesSim_pp_cppflags) $(lib_BesSim_pp_cppflags) $(G4SubtractionSolid_pp_cppflags) $(use_cppflags) $(BesSim_cppflags) $(lib_BesSim_cppflags) $(G4SubtractionSolid_cppflags) $(G4SubtractionSolid_cc_cppflags)  $(src)G4SubtractionSolid.cc

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (-MMD -MP -MF $*.d -MQ $@,)

ifneq ($(MAKECMDGOALS),BesSimclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)BesDetectorConstruction.d

$(bin)$(binobj)BesDetectorConstruction.d :

$(bin)$(binobj)BesDetectorConstruction.o : $(cmt_final_setup_BesSim)

$(bin)$(binobj)BesDetectorConstruction.o : $(src)BesDetectorConstruction.cc
	$(cpp_echo) $(src)BesDetectorConstruction.cc
	$(cpp_silent) $(cppcomp) -MMD -MP -MF $*.d -MQ $@ -o $@ $(use_pp_cppflags) $(BesSim_pp_cppflags) $(lib_BesSim_pp_cppflags) $(BesDetectorConstruction_pp_cppflags) $(use_cppflags) $(BesSim_cppflags) $(lib_BesSim_cppflags) $(BesDetectorConstruction_cppflags) $(BesDetectorConstruction_cc_cppflags)  $(src)BesDetectorConstruction.cc
endif
endif

else
$(bin)BesSim_dependencies.make : $(BesDetectorConstruction_cc_dependencies)

$(bin)BesSim_dependencies.make : $(src)BesDetectorConstruction.cc

$(bin)$(binobj)BesDetectorConstruction.o : $(BesDetectorConstruction_cc_dependencies)
	$(cpp_echo) $(src)BesDetectorConstruction.cc
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(BesSim_pp_cppflags) $(lib_BesSim_pp_cppflags) $(BesDetectorConstruction_pp_cppflags) $(use_cppflags) $(BesSim_cppflags) $(lib_BesSim_cppflags) $(BesDetectorConstruction_cppflags) $(BesDetectorConstruction_cc_cppflags)  $(src)BesDetectorConstruction.cc

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (-MMD -MP -MF $*.d -MQ $@,)

ifneq ($(MAKECMDGOALS),BesSimclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)BesRunActionMessenger.d

$(bin)$(binobj)BesRunActionMessenger.d :

$(bin)$(binobj)BesRunActionMessenger.o : $(cmt_final_setup_BesSim)

$(bin)$(binobj)BesRunActionMessenger.o : $(src)BesRunActionMessenger.cc
	$(cpp_echo) $(src)BesRunActionMessenger.cc
	$(cpp_silent) $(cppcomp) -MMD -MP -MF $*.d -MQ $@ -o $@ $(use_pp_cppflags) $(BesSim_pp_cppflags) $(lib_BesSim_pp_cppflags) $(BesRunActionMessenger_pp_cppflags) $(use_cppflags) $(BesSim_cppflags) $(lib_BesSim_cppflags) $(BesRunActionMessenger_cppflags) $(BesRunActionMessenger_cc_cppflags)  $(src)BesRunActionMessenger.cc
endif
endif

else
$(bin)BesSim_dependencies.make : $(BesRunActionMessenger_cc_dependencies)

$(bin)BesSim_dependencies.make : $(src)BesRunActionMessenger.cc

$(bin)$(binobj)BesRunActionMessenger.o : $(BesRunActionMessenger_cc_dependencies)
	$(cpp_echo) $(src)BesRunActionMessenger.cc
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(BesSim_pp_cppflags) $(lib_BesSim_pp_cppflags) $(BesRunActionMessenger_pp_cppflags) $(use_cppflags) $(BesSim_cppflags) $(lib_BesSim_cppflags) $(BesRunActionMessenger_cppflags) $(BesRunActionMessenger_cc_cppflags)  $(src)BesRunActionMessenger.cc

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (-MMD -MP -MF $*.d -MQ $@,)

ifneq ($(MAKECMDGOALS),BesSimclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)BesEventAction.d

$(bin)$(binobj)BesEventAction.d :

$(bin)$(binobj)BesEventAction.o : $(cmt_final_setup_BesSim)

$(bin)$(binobj)BesEventAction.o : $(src)BesEventAction.cc
	$(cpp_echo) $(src)BesEventAction.cc
	$(cpp_silent) $(cppcomp) -MMD -MP -MF $*.d -MQ $@ -o $@ $(use_pp_cppflags) $(BesSim_pp_cppflags) $(lib_BesSim_pp_cppflags) $(BesEventAction_pp_cppflags) $(use_cppflags) $(BesSim_cppflags) $(lib_BesSim_cppflags) $(BesEventAction_cppflags) $(BesEventAction_cc_cppflags)  $(src)BesEventAction.cc
endif
endif

else
$(bin)BesSim_dependencies.make : $(BesEventAction_cc_dependencies)

$(bin)BesSim_dependencies.make : $(src)BesEventAction.cc

$(bin)$(binobj)BesEventAction.o : $(BesEventAction_cc_dependencies)
	$(cpp_echo) $(src)BesEventAction.cc
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(BesSim_pp_cppflags) $(lib_BesSim_pp_cppflags) $(BesEventAction_pp_cppflags) $(use_cppflags) $(BesSim_cppflags) $(lib_BesSim_cppflags) $(BesEventAction_cppflags) $(BesEventAction_cc_cppflags)  $(src)BesEventAction.cc

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (-MMD -MP -MF $*.d -MQ $@,)

ifneq ($(MAKECMDGOALS),BesSimclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)BesLogSession.d

$(bin)$(binobj)BesLogSession.d :

$(bin)$(binobj)BesLogSession.o : $(cmt_final_setup_BesSim)

$(bin)$(binobj)BesLogSession.o : $(src)BesLogSession.cc
	$(cpp_echo) $(src)BesLogSession.cc
	$(cpp_silent) $(cppcomp) -MMD -MP -MF $*.d -MQ $@ -o $@ $(use_pp_cppflags) $(BesSim_pp_cppflags) $(lib_BesSim_pp_cppflags) $(BesLogSession_pp_cppflags) $(use_cppflags) $(BesSim_cppflags) $(lib_BesSim_cppflags) $(BesLogSession_cppflags) $(BesLogSession_cc_cppflags)  $(src)BesLogSession.cc
endif
endif

else
$(bin)BesSim_dependencies.make : $(BesLogSession_cc_dependencies)

$(bin)BesSim_dependencies.make : $(src)BesLogSession.cc

$(bin)$(binobj)BesLogSession.o : $(BesLogSession_cc_dependencies)
	$(cpp_echo) $(src)BesLogSession.cc
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(BesSim_pp_cppflags) $(lib_BesSim_pp_cppflags) $(BesLogSession_pp_cppflags) $(use_cppflags) $(BesSim_cppflags) $(lib_BesSim_cppflags) $(BesLogSession_cppflags) $(BesLogSession_cc_cppflags)  $(src)BesLogSession.cc

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (-MMD -MP -MF $*.d -MQ $@,)

ifneq ($(MAKECMDGOALS),BesSimclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)BesMagneticField.d

$(bin)$(binobj)BesMagneticField.d :

$(bin)$(binobj)BesMagneticField.o : $(cmt_final_setup_BesSim)

$(bin)$(binobj)BesMagneticField.o : $(src)BesMagneticField.cc
	$(cpp_echo) $(src)BesMagneticField.cc
	$(cpp_silent) $(cppcomp) -MMD -MP -MF $*.d -MQ $@ -o $@ $(use_pp_cppflags) $(BesSim_pp_cppflags) $(lib_BesSim_pp_cppflags) $(BesMagneticField_pp_cppflags) $(use_cppflags) $(BesSim_cppflags) $(lib_BesSim_cppflags) $(BesMagneticField_cppflags) $(BesMagneticField_cc_cppflags)  $(src)BesMagneticField.cc
endif
endif

else
$(bin)BesSim_dependencies.make : $(BesMagneticField_cc_dependencies)

$(bin)BesSim_dependencies.make : $(src)BesMagneticField.cc

$(bin)$(binobj)BesMagneticField.o : $(BesMagneticField_cc_dependencies)
	$(cpp_echo) $(src)BesMagneticField.cc
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(BesSim_pp_cppflags) $(lib_BesSim_pp_cppflags) $(BesMagneticField_pp_cppflags) $(use_cppflags) $(BesSim_cppflags) $(lib_BesSim_cppflags) $(BesMagneticField_cppflags) $(BesMagneticField_cc_cppflags)  $(src)BesMagneticField.cc

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (-MMD -MP -MF $*.d -MQ $@,)

ifneq ($(MAKECMDGOALS),BesSimclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)BesPipParameter.d

$(bin)$(binobj)BesPipParameter.d :

$(bin)$(binobj)BesPipParameter.o : $(cmt_final_setup_BesSim)

$(bin)$(binobj)BesPipParameter.o : $(src)BesPipParameter.cc
	$(cpp_echo) $(src)BesPipParameter.cc
	$(cpp_silent) $(cppcomp) -MMD -MP -MF $*.d -MQ $@ -o $@ $(use_pp_cppflags) $(BesSim_pp_cppflags) $(lib_BesSim_pp_cppflags) $(BesPipParameter_pp_cppflags) $(use_cppflags) $(BesSim_cppflags) $(lib_BesSim_cppflags) $(BesPipParameter_cppflags) $(BesPipParameter_cc_cppflags)  $(src)BesPipParameter.cc
endif
endif

else
$(bin)BesSim_dependencies.make : $(BesPipParameter_cc_dependencies)

$(bin)BesSim_dependencies.make : $(src)BesPipParameter.cc

$(bin)$(binobj)BesPipParameter.o : $(BesPipParameter_cc_dependencies)
	$(cpp_echo) $(src)BesPipParameter.cc
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(BesSim_pp_cppflags) $(lib_BesSim_pp_cppflags) $(BesPipParameter_pp_cppflags) $(use_cppflags) $(BesSim_cppflags) $(lib_BesSim_cppflags) $(BesPipParameter_cppflags) $(BesPipParameter_cc_cppflags)  $(src)BesPipParameter.cc

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (-MMD -MP -MF $*.d -MQ $@,)

ifneq ($(MAKECMDGOALS),BesSimclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)BesSim_entries.d

$(bin)$(binobj)BesSim_entries.d :

$(bin)$(binobj)BesSim_entries.o : $(cmt_final_setup_BesSim)

$(bin)$(binobj)BesSim_entries.o : $(src)components/BesSim_entries.cxx
	$(cpp_echo) $(src)components/BesSim_entries.cxx
	$(cpp_silent) $(cppcomp) -MMD -MP -MF $*.d -MQ $@ -o $@ $(use_pp_cppflags) $(BesSim_pp_cppflags) $(lib_BesSim_pp_cppflags) $(BesSim_entries_pp_cppflags) $(use_cppflags) $(BesSim_cppflags) $(lib_BesSim_cppflags) $(BesSim_entries_cppflags) $(BesSim_entries_cxx_cppflags) -I../src/components $(src)components/BesSim_entries.cxx
endif
endif

else
$(bin)BesSim_dependencies.make : $(BesSim_entries_cxx_dependencies)

$(bin)BesSim_dependencies.make : $(src)components/BesSim_entries.cxx

$(bin)$(binobj)BesSim_entries.o : $(BesSim_entries_cxx_dependencies)
	$(cpp_echo) $(src)components/BesSim_entries.cxx
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(BesSim_pp_cppflags) $(lib_BesSim_pp_cppflags) $(BesSim_entries_pp_cppflags) $(use_cppflags) $(BesSim_cppflags) $(lib_BesSim_cppflags) $(BesSim_entries_cppflags) $(BesSim_entries_cxx_cppflags) -I../src/components $(src)components/BesSim_entries.cxx

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (-MMD -MP -MF $*.d -MQ $@,)

ifneq ($(MAKECMDGOALS),BesSimclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)BesSim_load.d

$(bin)$(binobj)BesSim_load.d :

$(bin)$(binobj)BesSim_load.o : $(cmt_final_setup_BesSim)

$(bin)$(binobj)BesSim_load.o : $(src)components/BesSim_load.cxx
	$(cpp_echo) $(src)components/BesSim_load.cxx
	$(cpp_silent) $(cppcomp) -MMD -MP -MF $*.d -MQ $@ -o $@ $(use_pp_cppflags) $(BesSim_pp_cppflags) $(lib_BesSim_pp_cppflags) $(BesSim_load_pp_cppflags) $(use_cppflags) $(BesSim_cppflags) $(lib_BesSim_cppflags) $(BesSim_load_cppflags) $(BesSim_load_cxx_cppflags) -I../src/components $(src)components/BesSim_load.cxx
endif
endif

else
$(bin)BesSim_dependencies.make : $(BesSim_load_cxx_dependencies)

$(bin)BesSim_dependencies.make : $(src)components/BesSim_load.cxx

$(bin)$(binobj)BesSim_load.o : $(BesSim_load_cxx_dependencies)
	$(cpp_echo) $(src)components/BesSim_load.cxx
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(BesSim_pp_cppflags) $(lib_BesSim_pp_cppflags) $(BesSim_load_pp_cppflags) $(use_cppflags) $(BesSim_cppflags) $(lib_BesSim_cppflags) $(BesSim_load_cppflags) $(BesSim_load_cxx_cppflags) -I../src/components $(src)components/BesSim_load.cxx

endif

#-- end of cpp_library ------------------
#-- start of cleanup_header --------------

clean :: BesSimclean ;
#	@cd .

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(BesSim.make) $@: No rule for such target" >&2
else
.DEFAULT::
	$(error PEDANTIC: $@: No rule for such target)
endif

BesSimclean ::
#-- end of cleanup_header ---------------
#-- start of cleanup_library -------------
	$(cleanup_echo) library BesSim
	-$(cleanup_silent) cd $(bin); /bin/rm -f $(library_prefix)BesSim$(library_suffix).a $(library_prefix)BesSim$(library_suffix).s? BesSim.stamp BesSim.shstamp
#-- end of cleanup_library ---------------
