#-- start of make_header -----------------

#====================================
#  Library EmcRecLib
#
#   Generated Thu Dec  1 10:44:43 2022  by yuansc
#
#====================================

include ${CMTROOT}/src/Makefile.core

ifdef tag
CMTEXTRATAGS = $(tag)
else
tag       = $(CMTCONFIG)
endif

cmt_EmcRecLib_has_no_target_tag = 1

#--------------------------------------------------------

ifdef cmt_EmcRecLib_has_target_tag

tags      = $(tag),$(CMTEXTRATAGS),target_EmcRecLib

EmcRec_tag = $(tag)

#cmt_local_tagfile_EmcRecLib = $(EmcRec_tag)_EmcRecLib.make
cmt_local_tagfile_EmcRecLib = $(bin)$(EmcRec_tag)_EmcRecLib.make

else

tags      = $(tag),$(CMTEXTRATAGS)

EmcRec_tag = $(tag)

#cmt_local_tagfile_EmcRecLib = $(EmcRec_tag).make
cmt_local_tagfile_EmcRecLib = $(bin)$(EmcRec_tag).make

endif

include $(cmt_local_tagfile_EmcRecLib)
#-include $(cmt_local_tagfile_EmcRecLib)

ifdef cmt_EmcRecLib_has_target_tag

cmt_final_setup_EmcRecLib = $(bin)setup_EmcRecLib.make
cmt_dependencies_in_EmcRecLib = $(bin)dependencies_EmcRecLib.in
#cmt_final_setup_EmcRecLib = $(bin)EmcRec_EmcRecLibsetup.make
cmt_local_EmcRecLib_makefile = $(bin)EmcRecLib.make

else

cmt_final_setup_EmcRecLib = $(bin)setup.make
cmt_dependencies_in_EmcRecLib = $(bin)dependencies.in
#cmt_final_setup_EmcRecLib = $(bin)EmcRecsetup.make
cmt_local_EmcRecLib_makefile = $(bin)EmcRecLib.make

endif

#cmt_final_setup = $(bin)setup.make
#cmt_final_setup = $(bin)EmcRecsetup.make

#EmcRecLib :: ;

dirs ::
	@if test ! -r requirements ; then echo "No requirements file" ; fi; \
	  if test ! -d $(bin) ; then $(mkdir) -p $(bin) ; fi

javadirs ::
	@if test ! -d $(javabin) ; then $(mkdir) -p $(javabin) ; fi

srcdirs ::
	@if test ! -d $(src) ; then $(mkdir) -p $(src) ; fi

help ::
	$(echo) 'EmcRecLib'

binobj = 
ifdef STRUCTURED_OUTPUT
binobj = EmcRecLib/
#EmcRecLib::
#	@if test ! -d $(bin)$(binobj) ; then $(mkdir) -p $(bin)$(binobj) ; fi
#	$(echo) "STRUCTURED_OUTPUT="$(bin)$(binobj)
endif

${CMTROOT}/src/Makefile.core : ;
ifdef use_requirements
$(use_requirements) : ;
endif

#-- end of make_header ------------------
#-- start of libary_header ---------------

EmcRecLiblibname   = $(bin)$(library_prefix)EmcRecLib$(library_suffix)
EmcRecLiblib       = $(EmcRecLiblibname).a
EmcRecLibstamp     = $(bin)EmcRecLib.stamp
EmcRecLibshstamp   = $(bin)EmcRecLib.shstamp

EmcRecLib :: dirs  EmcRecLibLIB
	$(echo) "EmcRecLib ok"

#-- end of libary_header ----------------

EmcRecLibLIB :: $(EmcRecLiblib) $(EmcRecLibshstamp)
	@/bin/echo "------> EmcRecLib : library ok"

$(EmcRecLiblib) :: $(bin)EmcRecShowerPosLogShMax.o $(bin)EmcRecShowerPosLinShMax.o $(bin)EmcRecDigit2Hit.o $(bin)EmcRecShowerPosLin.o $(bin)EmcRecShowerPosLog.o $(bin)EmcRecHit2Cluster.o $(bin)EmcRecFastCluster2Shower.o $(bin)EmcRecSeedLocalMax.o $(bin)EmcRec.o $(bin)EmcRecSeedEThreshold.o $(bin)EmcRecTDS.o $(bin)EmcRecShowerEnergy.o $(bin)EmcRecShowerShape.o $(bin)EmcRecNeighbor.o $(bin)EmcRecTofMatch.o $(bin)EmcRecParameter.o $(bin)EmcRecShowerPosLoglin.o $(bin)EmcRecSplitWeighted.o $(bin)EmcRecCluster2Shower.o $(bin)EmcRecTofDigitCalib.o $(bin)EmcRec_load.o $(bin)EmcRec_entries.o
	$(lib_echo) library
	$(lib_silent) cd $(bin); \
	  $(ar) $(EmcRecLiblib) $?
	$(lib_silent) $(ranlib) $(EmcRecLiblib)
	$(lib_silent) cat /dev/null >$(EmcRecLibstamp)

#------------------------------------------------------------------
#  Future improvement? to empty the object files after
#  storing in the library
#
##	  for f in $?; do \
##	    rm $${f}; touch $${f}; \
##	  done
#------------------------------------------------------------------

$(EmcRecLiblibname).$(shlibsuffix) :: $(EmcRecLiblib) $(EmcRecLibstamps)
	$(lib_silent) cd $(bin); QUIET=$(QUIET); $(make_shlib) "$(tags)" EmcRecLib $(EmcRecLib_shlibflags)

$(EmcRecLibshstamp) :: $(EmcRecLiblibname).$(shlibsuffix)
	@if test -f $(EmcRecLiblibname).$(shlibsuffix) ; then cat /dev/null >$(EmcRecLibshstamp) ; fi

EmcRecLibclean ::
	$(cleanup_echo) objects
	$(cleanup_silent) cd $(bin); /bin/rm -f $(bin)EmcRecShowerPosLogShMax.o $(bin)EmcRecShowerPosLinShMax.o $(bin)EmcRecDigit2Hit.o $(bin)EmcRecShowerPosLin.o $(bin)EmcRecShowerPosLog.o $(bin)EmcRecHit2Cluster.o $(bin)EmcRecFastCluster2Shower.o $(bin)EmcRecSeedLocalMax.o $(bin)EmcRec.o $(bin)EmcRecSeedEThreshold.o $(bin)EmcRecTDS.o $(bin)EmcRecShowerEnergy.o $(bin)EmcRecShowerShape.o $(bin)EmcRecNeighbor.o $(bin)EmcRecTofMatch.o $(bin)EmcRecParameter.o $(bin)EmcRecShowerPosLoglin.o $(bin)EmcRecSplitWeighted.o $(bin)EmcRecCluster2Shower.o $(bin)EmcRecTofDigitCalib.o $(bin)EmcRec_load.o $(bin)EmcRec_entries.o

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
EmcRecLibinstallname = $(library_prefix)EmcRecLib$(library_suffix).$(shlibsuffix)

EmcRecLib :: EmcRecLibinstall

install :: EmcRecLibinstall

EmcRecLibinstall :: $(install_dir)/$(EmcRecLibinstallname)
	@if test ! "${installarea}" = ""; then\
	  echo "installation done"; \
	fi

$(install_dir)/$(EmcRecLibinstallname) :: $(bin)$(EmcRecLibinstallname)
	@if test ! "${installarea}" = ""; then \
	  cd $(bin); \
	  if test ! "$(install_dir)" = ""; then \
	    if test ! -d "$(install_dir)"; then \
	      mkdir -p $(install_dir); \
	    fi ; \
	    if test -d "$(install_dir)"; then \
	      echo "Installing library $(EmcRecLibinstallname) into $(install_dir)"; \
	      if test -e $(install_dir)/$(EmcRecLibinstallname); then \
	        $(cmt_uninstall_area_command) $(install_dir)/$(EmcRecLibinstallname); \
	        $(cmt_uninstall_area_command) $(install_dir)/$(EmcRecLibinstallname).cmtref; \
	      fi; \
	      $(cmt_install_area_command) `pwd`/$(EmcRecLibinstallname) $(install_dir)/$(EmcRecLibinstallname); \
	      echo `pwd`/$(EmcRecLibinstallname) >$(install_dir)/$(EmcRecLibinstallname).cmtref; \
	    fi \
          else \
	    echo "Cannot install library $(EmcRecLibinstallname), no installation directory specified"; \
	  fi; \
	fi

EmcRecLibclean :: EmcRecLibuninstall

uninstall :: EmcRecLibuninstall

EmcRecLibuninstall ::
	@if test ! "${installarea}" = ""; then \
	  cd $(bin); \
	  if test ! "$(install_dir)" = ""; then \
	    if test -d "$(install_dir)"; then \
	      echo "Removing installed library $(EmcRecLibinstallname) from $(install_dir)"; \
	      $(cmt_uninstall_area_command) $(install_dir)/$(EmcRecLibinstallname); \
	      $(cmt_uninstall_area_command) $(install_dir)/$(EmcRecLibinstallname).cmtref; \
	    fi \
          else \
	    echo "Cannot uninstall library $(EmcRecLibinstallname), no installation directory specified"; \
	  fi; \
	fi




#-- start of cpp_library -----------------

ifneq (-MMD -MP -MF $*.d -MQ $@,)

ifneq ($(MAKECMDGOALS),EmcRecLibclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)EmcRecShowerPosLogShMax.d

$(bin)$(binobj)EmcRecShowerPosLogShMax.d :

$(bin)$(binobj)EmcRecShowerPosLogShMax.o : $(cmt_final_setup_EmcRecLib)

$(bin)$(binobj)EmcRecShowerPosLogShMax.o : $(src)EmcRecShowerPosLogShMax.cxx
	$(cpp_echo) $(src)EmcRecShowerPosLogShMax.cxx
	$(cpp_silent) $(cppcomp) -MMD -MP -MF $*.d -MQ $@ -o $@ $(use_pp_cppflags) $(EmcRecLib_pp_cppflags) $(lib_EmcRecLib_pp_cppflags) $(EmcRecShowerPosLogShMax_pp_cppflags) $(use_cppflags) $(EmcRecLib_cppflags) $(lib_EmcRecLib_cppflags) $(EmcRecShowerPosLogShMax_cppflags) $(EmcRecShowerPosLogShMax_cxx_cppflags)  $(src)EmcRecShowerPosLogShMax.cxx
endif
endif

else
$(bin)EmcRecLib_dependencies.make : $(EmcRecShowerPosLogShMax_cxx_dependencies)

$(bin)EmcRecLib_dependencies.make : $(src)EmcRecShowerPosLogShMax.cxx

$(bin)$(binobj)EmcRecShowerPosLogShMax.o : $(EmcRecShowerPosLogShMax_cxx_dependencies)
	$(cpp_echo) $(src)EmcRecShowerPosLogShMax.cxx
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(EmcRecLib_pp_cppflags) $(lib_EmcRecLib_pp_cppflags) $(EmcRecShowerPosLogShMax_pp_cppflags) $(use_cppflags) $(EmcRecLib_cppflags) $(lib_EmcRecLib_cppflags) $(EmcRecShowerPosLogShMax_cppflags) $(EmcRecShowerPosLogShMax_cxx_cppflags)  $(src)EmcRecShowerPosLogShMax.cxx

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (-MMD -MP -MF $*.d -MQ $@,)

ifneq ($(MAKECMDGOALS),EmcRecLibclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)EmcRecShowerPosLinShMax.d

$(bin)$(binobj)EmcRecShowerPosLinShMax.d :

$(bin)$(binobj)EmcRecShowerPosLinShMax.o : $(cmt_final_setup_EmcRecLib)

$(bin)$(binobj)EmcRecShowerPosLinShMax.o : $(src)EmcRecShowerPosLinShMax.cxx
	$(cpp_echo) $(src)EmcRecShowerPosLinShMax.cxx
	$(cpp_silent) $(cppcomp) -MMD -MP -MF $*.d -MQ $@ -o $@ $(use_pp_cppflags) $(EmcRecLib_pp_cppflags) $(lib_EmcRecLib_pp_cppflags) $(EmcRecShowerPosLinShMax_pp_cppflags) $(use_cppflags) $(EmcRecLib_cppflags) $(lib_EmcRecLib_cppflags) $(EmcRecShowerPosLinShMax_cppflags) $(EmcRecShowerPosLinShMax_cxx_cppflags)  $(src)EmcRecShowerPosLinShMax.cxx
endif
endif

else
$(bin)EmcRecLib_dependencies.make : $(EmcRecShowerPosLinShMax_cxx_dependencies)

$(bin)EmcRecLib_dependencies.make : $(src)EmcRecShowerPosLinShMax.cxx

$(bin)$(binobj)EmcRecShowerPosLinShMax.o : $(EmcRecShowerPosLinShMax_cxx_dependencies)
	$(cpp_echo) $(src)EmcRecShowerPosLinShMax.cxx
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(EmcRecLib_pp_cppflags) $(lib_EmcRecLib_pp_cppflags) $(EmcRecShowerPosLinShMax_pp_cppflags) $(use_cppflags) $(EmcRecLib_cppflags) $(lib_EmcRecLib_cppflags) $(EmcRecShowerPosLinShMax_cppflags) $(EmcRecShowerPosLinShMax_cxx_cppflags)  $(src)EmcRecShowerPosLinShMax.cxx

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (-MMD -MP -MF $*.d -MQ $@,)

ifneq ($(MAKECMDGOALS),EmcRecLibclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)EmcRecDigit2Hit.d

$(bin)$(binobj)EmcRecDigit2Hit.d :

$(bin)$(binobj)EmcRecDigit2Hit.o : $(cmt_final_setup_EmcRecLib)

$(bin)$(binobj)EmcRecDigit2Hit.o : $(src)EmcRecDigit2Hit.cxx
	$(cpp_echo) $(src)EmcRecDigit2Hit.cxx
	$(cpp_silent) $(cppcomp) -MMD -MP -MF $*.d -MQ $@ -o $@ $(use_pp_cppflags) $(EmcRecLib_pp_cppflags) $(lib_EmcRecLib_pp_cppflags) $(EmcRecDigit2Hit_pp_cppflags) $(use_cppflags) $(EmcRecLib_cppflags) $(lib_EmcRecLib_cppflags) $(EmcRecDigit2Hit_cppflags) $(EmcRecDigit2Hit_cxx_cppflags)  $(src)EmcRecDigit2Hit.cxx
endif
endif

else
$(bin)EmcRecLib_dependencies.make : $(EmcRecDigit2Hit_cxx_dependencies)

$(bin)EmcRecLib_dependencies.make : $(src)EmcRecDigit2Hit.cxx

$(bin)$(binobj)EmcRecDigit2Hit.o : $(EmcRecDigit2Hit_cxx_dependencies)
	$(cpp_echo) $(src)EmcRecDigit2Hit.cxx
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(EmcRecLib_pp_cppflags) $(lib_EmcRecLib_pp_cppflags) $(EmcRecDigit2Hit_pp_cppflags) $(use_cppflags) $(EmcRecLib_cppflags) $(lib_EmcRecLib_cppflags) $(EmcRecDigit2Hit_cppflags) $(EmcRecDigit2Hit_cxx_cppflags)  $(src)EmcRecDigit2Hit.cxx

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (-MMD -MP -MF $*.d -MQ $@,)

ifneq ($(MAKECMDGOALS),EmcRecLibclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)EmcRecShowerPosLin.d

$(bin)$(binobj)EmcRecShowerPosLin.d :

$(bin)$(binobj)EmcRecShowerPosLin.o : $(cmt_final_setup_EmcRecLib)

$(bin)$(binobj)EmcRecShowerPosLin.o : $(src)EmcRecShowerPosLin.cxx
	$(cpp_echo) $(src)EmcRecShowerPosLin.cxx
	$(cpp_silent) $(cppcomp) -MMD -MP -MF $*.d -MQ $@ -o $@ $(use_pp_cppflags) $(EmcRecLib_pp_cppflags) $(lib_EmcRecLib_pp_cppflags) $(EmcRecShowerPosLin_pp_cppflags) $(use_cppflags) $(EmcRecLib_cppflags) $(lib_EmcRecLib_cppflags) $(EmcRecShowerPosLin_cppflags) $(EmcRecShowerPosLin_cxx_cppflags)  $(src)EmcRecShowerPosLin.cxx
endif
endif

else
$(bin)EmcRecLib_dependencies.make : $(EmcRecShowerPosLin_cxx_dependencies)

$(bin)EmcRecLib_dependencies.make : $(src)EmcRecShowerPosLin.cxx

$(bin)$(binobj)EmcRecShowerPosLin.o : $(EmcRecShowerPosLin_cxx_dependencies)
	$(cpp_echo) $(src)EmcRecShowerPosLin.cxx
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(EmcRecLib_pp_cppflags) $(lib_EmcRecLib_pp_cppflags) $(EmcRecShowerPosLin_pp_cppflags) $(use_cppflags) $(EmcRecLib_cppflags) $(lib_EmcRecLib_cppflags) $(EmcRecShowerPosLin_cppflags) $(EmcRecShowerPosLin_cxx_cppflags)  $(src)EmcRecShowerPosLin.cxx

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (-MMD -MP -MF $*.d -MQ $@,)

ifneq ($(MAKECMDGOALS),EmcRecLibclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)EmcRecShowerPosLog.d

$(bin)$(binobj)EmcRecShowerPosLog.d :

$(bin)$(binobj)EmcRecShowerPosLog.o : $(cmt_final_setup_EmcRecLib)

$(bin)$(binobj)EmcRecShowerPosLog.o : $(src)EmcRecShowerPosLog.cxx
	$(cpp_echo) $(src)EmcRecShowerPosLog.cxx
	$(cpp_silent) $(cppcomp) -MMD -MP -MF $*.d -MQ $@ -o $@ $(use_pp_cppflags) $(EmcRecLib_pp_cppflags) $(lib_EmcRecLib_pp_cppflags) $(EmcRecShowerPosLog_pp_cppflags) $(use_cppflags) $(EmcRecLib_cppflags) $(lib_EmcRecLib_cppflags) $(EmcRecShowerPosLog_cppflags) $(EmcRecShowerPosLog_cxx_cppflags)  $(src)EmcRecShowerPosLog.cxx
endif
endif

else
$(bin)EmcRecLib_dependencies.make : $(EmcRecShowerPosLog_cxx_dependencies)

$(bin)EmcRecLib_dependencies.make : $(src)EmcRecShowerPosLog.cxx

$(bin)$(binobj)EmcRecShowerPosLog.o : $(EmcRecShowerPosLog_cxx_dependencies)
	$(cpp_echo) $(src)EmcRecShowerPosLog.cxx
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(EmcRecLib_pp_cppflags) $(lib_EmcRecLib_pp_cppflags) $(EmcRecShowerPosLog_pp_cppflags) $(use_cppflags) $(EmcRecLib_cppflags) $(lib_EmcRecLib_cppflags) $(EmcRecShowerPosLog_cppflags) $(EmcRecShowerPosLog_cxx_cppflags)  $(src)EmcRecShowerPosLog.cxx

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (-MMD -MP -MF $*.d -MQ $@,)

ifneq ($(MAKECMDGOALS),EmcRecLibclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)EmcRecHit2Cluster.d

$(bin)$(binobj)EmcRecHit2Cluster.d :

$(bin)$(binobj)EmcRecHit2Cluster.o : $(cmt_final_setup_EmcRecLib)

$(bin)$(binobj)EmcRecHit2Cluster.o : $(src)EmcRecHit2Cluster.cxx
	$(cpp_echo) $(src)EmcRecHit2Cluster.cxx
	$(cpp_silent) $(cppcomp) -MMD -MP -MF $*.d -MQ $@ -o $@ $(use_pp_cppflags) $(EmcRecLib_pp_cppflags) $(lib_EmcRecLib_pp_cppflags) $(EmcRecHit2Cluster_pp_cppflags) $(use_cppflags) $(EmcRecLib_cppflags) $(lib_EmcRecLib_cppflags) $(EmcRecHit2Cluster_cppflags) $(EmcRecHit2Cluster_cxx_cppflags)  $(src)EmcRecHit2Cluster.cxx
endif
endif

else
$(bin)EmcRecLib_dependencies.make : $(EmcRecHit2Cluster_cxx_dependencies)

$(bin)EmcRecLib_dependencies.make : $(src)EmcRecHit2Cluster.cxx

$(bin)$(binobj)EmcRecHit2Cluster.o : $(EmcRecHit2Cluster_cxx_dependencies)
	$(cpp_echo) $(src)EmcRecHit2Cluster.cxx
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(EmcRecLib_pp_cppflags) $(lib_EmcRecLib_pp_cppflags) $(EmcRecHit2Cluster_pp_cppflags) $(use_cppflags) $(EmcRecLib_cppflags) $(lib_EmcRecLib_cppflags) $(EmcRecHit2Cluster_cppflags) $(EmcRecHit2Cluster_cxx_cppflags)  $(src)EmcRecHit2Cluster.cxx

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (-MMD -MP -MF $*.d -MQ $@,)

ifneq ($(MAKECMDGOALS),EmcRecLibclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)EmcRecFastCluster2Shower.d

$(bin)$(binobj)EmcRecFastCluster2Shower.d :

$(bin)$(binobj)EmcRecFastCluster2Shower.o : $(cmt_final_setup_EmcRecLib)

$(bin)$(binobj)EmcRecFastCluster2Shower.o : $(src)EmcRecFastCluster2Shower.cxx
	$(cpp_echo) $(src)EmcRecFastCluster2Shower.cxx
	$(cpp_silent) $(cppcomp) -MMD -MP -MF $*.d -MQ $@ -o $@ $(use_pp_cppflags) $(EmcRecLib_pp_cppflags) $(lib_EmcRecLib_pp_cppflags) $(EmcRecFastCluster2Shower_pp_cppflags) $(use_cppflags) $(EmcRecLib_cppflags) $(lib_EmcRecLib_cppflags) $(EmcRecFastCluster2Shower_cppflags) $(EmcRecFastCluster2Shower_cxx_cppflags)  $(src)EmcRecFastCluster2Shower.cxx
endif
endif

else
$(bin)EmcRecLib_dependencies.make : $(EmcRecFastCluster2Shower_cxx_dependencies)

$(bin)EmcRecLib_dependencies.make : $(src)EmcRecFastCluster2Shower.cxx

$(bin)$(binobj)EmcRecFastCluster2Shower.o : $(EmcRecFastCluster2Shower_cxx_dependencies)
	$(cpp_echo) $(src)EmcRecFastCluster2Shower.cxx
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(EmcRecLib_pp_cppflags) $(lib_EmcRecLib_pp_cppflags) $(EmcRecFastCluster2Shower_pp_cppflags) $(use_cppflags) $(EmcRecLib_cppflags) $(lib_EmcRecLib_cppflags) $(EmcRecFastCluster2Shower_cppflags) $(EmcRecFastCluster2Shower_cxx_cppflags)  $(src)EmcRecFastCluster2Shower.cxx

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (-MMD -MP -MF $*.d -MQ $@,)

ifneq ($(MAKECMDGOALS),EmcRecLibclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)EmcRecSeedLocalMax.d

$(bin)$(binobj)EmcRecSeedLocalMax.d :

$(bin)$(binobj)EmcRecSeedLocalMax.o : $(cmt_final_setup_EmcRecLib)

$(bin)$(binobj)EmcRecSeedLocalMax.o : $(src)EmcRecSeedLocalMax.cxx
	$(cpp_echo) $(src)EmcRecSeedLocalMax.cxx
	$(cpp_silent) $(cppcomp) -MMD -MP -MF $*.d -MQ $@ -o $@ $(use_pp_cppflags) $(EmcRecLib_pp_cppflags) $(lib_EmcRecLib_pp_cppflags) $(EmcRecSeedLocalMax_pp_cppflags) $(use_cppflags) $(EmcRecLib_cppflags) $(lib_EmcRecLib_cppflags) $(EmcRecSeedLocalMax_cppflags) $(EmcRecSeedLocalMax_cxx_cppflags)  $(src)EmcRecSeedLocalMax.cxx
endif
endif

else
$(bin)EmcRecLib_dependencies.make : $(EmcRecSeedLocalMax_cxx_dependencies)

$(bin)EmcRecLib_dependencies.make : $(src)EmcRecSeedLocalMax.cxx

$(bin)$(binobj)EmcRecSeedLocalMax.o : $(EmcRecSeedLocalMax_cxx_dependencies)
	$(cpp_echo) $(src)EmcRecSeedLocalMax.cxx
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(EmcRecLib_pp_cppflags) $(lib_EmcRecLib_pp_cppflags) $(EmcRecSeedLocalMax_pp_cppflags) $(use_cppflags) $(EmcRecLib_cppflags) $(lib_EmcRecLib_cppflags) $(EmcRecSeedLocalMax_cppflags) $(EmcRecSeedLocalMax_cxx_cppflags)  $(src)EmcRecSeedLocalMax.cxx

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (-MMD -MP -MF $*.d -MQ $@,)

ifneq ($(MAKECMDGOALS),EmcRecLibclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)EmcRec.d

$(bin)$(binobj)EmcRec.d :

$(bin)$(binobj)EmcRec.o : $(cmt_final_setup_EmcRecLib)

$(bin)$(binobj)EmcRec.o : $(src)EmcRec.cxx
	$(cpp_echo) $(src)EmcRec.cxx
	$(cpp_silent) $(cppcomp) -MMD -MP -MF $*.d -MQ $@ -o $@ $(use_pp_cppflags) $(EmcRecLib_pp_cppflags) $(lib_EmcRecLib_pp_cppflags) $(EmcRec_pp_cppflags) $(use_cppflags) $(EmcRecLib_cppflags) $(lib_EmcRecLib_cppflags) $(EmcRec_cppflags) $(EmcRec_cxx_cppflags)  $(src)EmcRec.cxx
endif
endif

else
$(bin)EmcRecLib_dependencies.make : $(EmcRec_cxx_dependencies)

$(bin)EmcRecLib_dependencies.make : $(src)EmcRec.cxx

$(bin)$(binobj)EmcRec.o : $(EmcRec_cxx_dependencies)
	$(cpp_echo) $(src)EmcRec.cxx
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(EmcRecLib_pp_cppflags) $(lib_EmcRecLib_pp_cppflags) $(EmcRec_pp_cppflags) $(use_cppflags) $(EmcRecLib_cppflags) $(lib_EmcRecLib_cppflags) $(EmcRec_cppflags) $(EmcRec_cxx_cppflags)  $(src)EmcRec.cxx

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (-MMD -MP -MF $*.d -MQ $@,)

ifneq ($(MAKECMDGOALS),EmcRecLibclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)EmcRecSeedEThreshold.d

$(bin)$(binobj)EmcRecSeedEThreshold.d :

$(bin)$(binobj)EmcRecSeedEThreshold.o : $(cmt_final_setup_EmcRecLib)

$(bin)$(binobj)EmcRecSeedEThreshold.o : $(src)EmcRecSeedEThreshold.cxx
	$(cpp_echo) $(src)EmcRecSeedEThreshold.cxx
	$(cpp_silent) $(cppcomp) -MMD -MP -MF $*.d -MQ $@ -o $@ $(use_pp_cppflags) $(EmcRecLib_pp_cppflags) $(lib_EmcRecLib_pp_cppflags) $(EmcRecSeedEThreshold_pp_cppflags) $(use_cppflags) $(EmcRecLib_cppflags) $(lib_EmcRecLib_cppflags) $(EmcRecSeedEThreshold_cppflags) $(EmcRecSeedEThreshold_cxx_cppflags)  $(src)EmcRecSeedEThreshold.cxx
endif
endif

else
$(bin)EmcRecLib_dependencies.make : $(EmcRecSeedEThreshold_cxx_dependencies)

$(bin)EmcRecLib_dependencies.make : $(src)EmcRecSeedEThreshold.cxx

$(bin)$(binobj)EmcRecSeedEThreshold.o : $(EmcRecSeedEThreshold_cxx_dependencies)
	$(cpp_echo) $(src)EmcRecSeedEThreshold.cxx
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(EmcRecLib_pp_cppflags) $(lib_EmcRecLib_pp_cppflags) $(EmcRecSeedEThreshold_pp_cppflags) $(use_cppflags) $(EmcRecLib_cppflags) $(lib_EmcRecLib_cppflags) $(EmcRecSeedEThreshold_cppflags) $(EmcRecSeedEThreshold_cxx_cppflags)  $(src)EmcRecSeedEThreshold.cxx

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (-MMD -MP -MF $*.d -MQ $@,)

ifneq ($(MAKECMDGOALS),EmcRecLibclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)EmcRecTDS.d

$(bin)$(binobj)EmcRecTDS.d :

$(bin)$(binobj)EmcRecTDS.o : $(cmt_final_setup_EmcRecLib)

$(bin)$(binobj)EmcRecTDS.o : $(src)EmcRecTDS.cxx
	$(cpp_echo) $(src)EmcRecTDS.cxx
	$(cpp_silent) $(cppcomp) -MMD -MP -MF $*.d -MQ $@ -o $@ $(use_pp_cppflags) $(EmcRecLib_pp_cppflags) $(lib_EmcRecLib_pp_cppflags) $(EmcRecTDS_pp_cppflags) $(use_cppflags) $(EmcRecLib_cppflags) $(lib_EmcRecLib_cppflags) $(EmcRecTDS_cppflags) $(EmcRecTDS_cxx_cppflags)  $(src)EmcRecTDS.cxx
endif
endif

else
$(bin)EmcRecLib_dependencies.make : $(EmcRecTDS_cxx_dependencies)

$(bin)EmcRecLib_dependencies.make : $(src)EmcRecTDS.cxx

$(bin)$(binobj)EmcRecTDS.o : $(EmcRecTDS_cxx_dependencies)
	$(cpp_echo) $(src)EmcRecTDS.cxx
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(EmcRecLib_pp_cppflags) $(lib_EmcRecLib_pp_cppflags) $(EmcRecTDS_pp_cppflags) $(use_cppflags) $(EmcRecLib_cppflags) $(lib_EmcRecLib_cppflags) $(EmcRecTDS_cppflags) $(EmcRecTDS_cxx_cppflags)  $(src)EmcRecTDS.cxx

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (-MMD -MP -MF $*.d -MQ $@,)

ifneq ($(MAKECMDGOALS),EmcRecLibclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)EmcRecShowerEnergy.d

$(bin)$(binobj)EmcRecShowerEnergy.d :

$(bin)$(binobj)EmcRecShowerEnergy.o : $(cmt_final_setup_EmcRecLib)

$(bin)$(binobj)EmcRecShowerEnergy.o : $(src)EmcRecShowerEnergy.cxx
	$(cpp_echo) $(src)EmcRecShowerEnergy.cxx
	$(cpp_silent) $(cppcomp) -MMD -MP -MF $*.d -MQ $@ -o $@ $(use_pp_cppflags) $(EmcRecLib_pp_cppflags) $(lib_EmcRecLib_pp_cppflags) $(EmcRecShowerEnergy_pp_cppflags) $(use_cppflags) $(EmcRecLib_cppflags) $(lib_EmcRecLib_cppflags) $(EmcRecShowerEnergy_cppflags) $(EmcRecShowerEnergy_cxx_cppflags)  $(src)EmcRecShowerEnergy.cxx
endif
endif

else
$(bin)EmcRecLib_dependencies.make : $(EmcRecShowerEnergy_cxx_dependencies)

$(bin)EmcRecLib_dependencies.make : $(src)EmcRecShowerEnergy.cxx

$(bin)$(binobj)EmcRecShowerEnergy.o : $(EmcRecShowerEnergy_cxx_dependencies)
	$(cpp_echo) $(src)EmcRecShowerEnergy.cxx
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(EmcRecLib_pp_cppflags) $(lib_EmcRecLib_pp_cppflags) $(EmcRecShowerEnergy_pp_cppflags) $(use_cppflags) $(EmcRecLib_cppflags) $(lib_EmcRecLib_cppflags) $(EmcRecShowerEnergy_cppflags) $(EmcRecShowerEnergy_cxx_cppflags)  $(src)EmcRecShowerEnergy.cxx

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (-MMD -MP -MF $*.d -MQ $@,)

ifneq ($(MAKECMDGOALS),EmcRecLibclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)EmcRecShowerShape.d

$(bin)$(binobj)EmcRecShowerShape.d :

$(bin)$(binobj)EmcRecShowerShape.o : $(cmt_final_setup_EmcRecLib)

$(bin)$(binobj)EmcRecShowerShape.o : $(src)EmcRecShowerShape.cxx
	$(cpp_echo) $(src)EmcRecShowerShape.cxx
	$(cpp_silent) $(cppcomp) -MMD -MP -MF $*.d -MQ $@ -o $@ $(use_pp_cppflags) $(EmcRecLib_pp_cppflags) $(lib_EmcRecLib_pp_cppflags) $(EmcRecShowerShape_pp_cppflags) $(use_cppflags) $(EmcRecLib_cppflags) $(lib_EmcRecLib_cppflags) $(EmcRecShowerShape_cppflags) $(EmcRecShowerShape_cxx_cppflags)  $(src)EmcRecShowerShape.cxx
endif
endif

else
$(bin)EmcRecLib_dependencies.make : $(EmcRecShowerShape_cxx_dependencies)

$(bin)EmcRecLib_dependencies.make : $(src)EmcRecShowerShape.cxx

$(bin)$(binobj)EmcRecShowerShape.o : $(EmcRecShowerShape_cxx_dependencies)
	$(cpp_echo) $(src)EmcRecShowerShape.cxx
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(EmcRecLib_pp_cppflags) $(lib_EmcRecLib_pp_cppflags) $(EmcRecShowerShape_pp_cppflags) $(use_cppflags) $(EmcRecLib_cppflags) $(lib_EmcRecLib_cppflags) $(EmcRecShowerShape_cppflags) $(EmcRecShowerShape_cxx_cppflags)  $(src)EmcRecShowerShape.cxx

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (-MMD -MP -MF $*.d -MQ $@,)

ifneq ($(MAKECMDGOALS),EmcRecLibclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)EmcRecNeighbor.d

$(bin)$(binobj)EmcRecNeighbor.d :

$(bin)$(binobj)EmcRecNeighbor.o : $(cmt_final_setup_EmcRecLib)

$(bin)$(binobj)EmcRecNeighbor.o : $(src)EmcRecNeighbor.cxx
	$(cpp_echo) $(src)EmcRecNeighbor.cxx
	$(cpp_silent) $(cppcomp) -MMD -MP -MF $*.d -MQ $@ -o $@ $(use_pp_cppflags) $(EmcRecLib_pp_cppflags) $(lib_EmcRecLib_pp_cppflags) $(EmcRecNeighbor_pp_cppflags) $(use_cppflags) $(EmcRecLib_cppflags) $(lib_EmcRecLib_cppflags) $(EmcRecNeighbor_cppflags) $(EmcRecNeighbor_cxx_cppflags)  $(src)EmcRecNeighbor.cxx
endif
endif

else
$(bin)EmcRecLib_dependencies.make : $(EmcRecNeighbor_cxx_dependencies)

$(bin)EmcRecLib_dependencies.make : $(src)EmcRecNeighbor.cxx

$(bin)$(binobj)EmcRecNeighbor.o : $(EmcRecNeighbor_cxx_dependencies)
	$(cpp_echo) $(src)EmcRecNeighbor.cxx
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(EmcRecLib_pp_cppflags) $(lib_EmcRecLib_pp_cppflags) $(EmcRecNeighbor_pp_cppflags) $(use_cppflags) $(EmcRecLib_cppflags) $(lib_EmcRecLib_cppflags) $(EmcRecNeighbor_cppflags) $(EmcRecNeighbor_cxx_cppflags)  $(src)EmcRecNeighbor.cxx

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (-MMD -MP -MF $*.d -MQ $@,)

ifneq ($(MAKECMDGOALS),EmcRecLibclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)EmcRecTofMatch.d

$(bin)$(binobj)EmcRecTofMatch.d :

$(bin)$(binobj)EmcRecTofMatch.o : $(cmt_final_setup_EmcRecLib)

$(bin)$(binobj)EmcRecTofMatch.o : $(src)EmcRecTofMatch.cxx
	$(cpp_echo) $(src)EmcRecTofMatch.cxx
	$(cpp_silent) $(cppcomp) -MMD -MP -MF $*.d -MQ $@ -o $@ $(use_pp_cppflags) $(EmcRecLib_pp_cppflags) $(lib_EmcRecLib_pp_cppflags) $(EmcRecTofMatch_pp_cppflags) $(use_cppflags) $(EmcRecLib_cppflags) $(lib_EmcRecLib_cppflags) $(EmcRecTofMatch_cppflags) $(EmcRecTofMatch_cxx_cppflags)  $(src)EmcRecTofMatch.cxx
endif
endif

else
$(bin)EmcRecLib_dependencies.make : $(EmcRecTofMatch_cxx_dependencies)

$(bin)EmcRecLib_dependencies.make : $(src)EmcRecTofMatch.cxx

$(bin)$(binobj)EmcRecTofMatch.o : $(EmcRecTofMatch_cxx_dependencies)
	$(cpp_echo) $(src)EmcRecTofMatch.cxx
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(EmcRecLib_pp_cppflags) $(lib_EmcRecLib_pp_cppflags) $(EmcRecTofMatch_pp_cppflags) $(use_cppflags) $(EmcRecLib_cppflags) $(lib_EmcRecLib_cppflags) $(EmcRecTofMatch_cppflags) $(EmcRecTofMatch_cxx_cppflags)  $(src)EmcRecTofMatch.cxx

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (-MMD -MP -MF $*.d -MQ $@,)

ifneq ($(MAKECMDGOALS),EmcRecLibclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)EmcRecParameter.d

$(bin)$(binobj)EmcRecParameter.d :

$(bin)$(binobj)EmcRecParameter.o : $(cmt_final_setup_EmcRecLib)

$(bin)$(binobj)EmcRecParameter.o : $(src)EmcRecParameter.cxx
	$(cpp_echo) $(src)EmcRecParameter.cxx
	$(cpp_silent) $(cppcomp) -MMD -MP -MF $*.d -MQ $@ -o $@ $(use_pp_cppflags) $(EmcRecLib_pp_cppflags) $(lib_EmcRecLib_pp_cppflags) $(EmcRecParameter_pp_cppflags) $(use_cppflags) $(EmcRecLib_cppflags) $(lib_EmcRecLib_cppflags) $(EmcRecParameter_cppflags) $(EmcRecParameter_cxx_cppflags)  $(src)EmcRecParameter.cxx
endif
endif

else
$(bin)EmcRecLib_dependencies.make : $(EmcRecParameter_cxx_dependencies)

$(bin)EmcRecLib_dependencies.make : $(src)EmcRecParameter.cxx

$(bin)$(binobj)EmcRecParameter.o : $(EmcRecParameter_cxx_dependencies)
	$(cpp_echo) $(src)EmcRecParameter.cxx
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(EmcRecLib_pp_cppflags) $(lib_EmcRecLib_pp_cppflags) $(EmcRecParameter_pp_cppflags) $(use_cppflags) $(EmcRecLib_cppflags) $(lib_EmcRecLib_cppflags) $(EmcRecParameter_cppflags) $(EmcRecParameter_cxx_cppflags)  $(src)EmcRecParameter.cxx

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (-MMD -MP -MF $*.d -MQ $@,)

ifneq ($(MAKECMDGOALS),EmcRecLibclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)EmcRecShowerPosLoglin.d

$(bin)$(binobj)EmcRecShowerPosLoglin.d :

$(bin)$(binobj)EmcRecShowerPosLoglin.o : $(cmt_final_setup_EmcRecLib)

$(bin)$(binobj)EmcRecShowerPosLoglin.o : $(src)EmcRecShowerPosLoglin.cxx
	$(cpp_echo) $(src)EmcRecShowerPosLoglin.cxx
	$(cpp_silent) $(cppcomp) -MMD -MP -MF $*.d -MQ $@ -o $@ $(use_pp_cppflags) $(EmcRecLib_pp_cppflags) $(lib_EmcRecLib_pp_cppflags) $(EmcRecShowerPosLoglin_pp_cppflags) $(use_cppflags) $(EmcRecLib_cppflags) $(lib_EmcRecLib_cppflags) $(EmcRecShowerPosLoglin_cppflags) $(EmcRecShowerPosLoglin_cxx_cppflags)  $(src)EmcRecShowerPosLoglin.cxx
endif
endif

else
$(bin)EmcRecLib_dependencies.make : $(EmcRecShowerPosLoglin_cxx_dependencies)

$(bin)EmcRecLib_dependencies.make : $(src)EmcRecShowerPosLoglin.cxx

$(bin)$(binobj)EmcRecShowerPosLoglin.o : $(EmcRecShowerPosLoglin_cxx_dependencies)
	$(cpp_echo) $(src)EmcRecShowerPosLoglin.cxx
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(EmcRecLib_pp_cppflags) $(lib_EmcRecLib_pp_cppflags) $(EmcRecShowerPosLoglin_pp_cppflags) $(use_cppflags) $(EmcRecLib_cppflags) $(lib_EmcRecLib_cppflags) $(EmcRecShowerPosLoglin_cppflags) $(EmcRecShowerPosLoglin_cxx_cppflags)  $(src)EmcRecShowerPosLoglin.cxx

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (-MMD -MP -MF $*.d -MQ $@,)

ifneq ($(MAKECMDGOALS),EmcRecLibclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)EmcRecSplitWeighted.d

$(bin)$(binobj)EmcRecSplitWeighted.d :

$(bin)$(binobj)EmcRecSplitWeighted.o : $(cmt_final_setup_EmcRecLib)

$(bin)$(binobj)EmcRecSplitWeighted.o : $(src)EmcRecSplitWeighted.cxx
	$(cpp_echo) $(src)EmcRecSplitWeighted.cxx
	$(cpp_silent) $(cppcomp) -MMD -MP -MF $*.d -MQ $@ -o $@ $(use_pp_cppflags) $(EmcRecLib_pp_cppflags) $(lib_EmcRecLib_pp_cppflags) $(EmcRecSplitWeighted_pp_cppflags) $(use_cppflags) $(EmcRecLib_cppflags) $(lib_EmcRecLib_cppflags) $(EmcRecSplitWeighted_cppflags) $(EmcRecSplitWeighted_cxx_cppflags)  $(src)EmcRecSplitWeighted.cxx
endif
endif

else
$(bin)EmcRecLib_dependencies.make : $(EmcRecSplitWeighted_cxx_dependencies)

$(bin)EmcRecLib_dependencies.make : $(src)EmcRecSplitWeighted.cxx

$(bin)$(binobj)EmcRecSplitWeighted.o : $(EmcRecSplitWeighted_cxx_dependencies)
	$(cpp_echo) $(src)EmcRecSplitWeighted.cxx
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(EmcRecLib_pp_cppflags) $(lib_EmcRecLib_pp_cppflags) $(EmcRecSplitWeighted_pp_cppflags) $(use_cppflags) $(EmcRecLib_cppflags) $(lib_EmcRecLib_cppflags) $(EmcRecSplitWeighted_cppflags) $(EmcRecSplitWeighted_cxx_cppflags)  $(src)EmcRecSplitWeighted.cxx

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (-MMD -MP -MF $*.d -MQ $@,)

ifneq ($(MAKECMDGOALS),EmcRecLibclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)EmcRecCluster2Shower.d

$(bin)$(binobj)EmcRecCluster2Shower.d :

$(bin)$(binobj)EmcRecCluster2Shower.o : $(cmt_final_setup_EmcRecLib)

$(bin)$(binobj)EmcRecCluster2Shower.o : $(src)EmcRecCluster2Shower.cxx
	$(cpp_echo) $(src)EmcRecCluster2Shower.cxx
	$(cpp_silent) $(cppcomp) -MMD -MP -MF $*.d -MQ $@ -o $@ $(use_pp_cppflags) $(EmcRecLib_pp_cppflags) $(lib_EmcRecLib_pp_cppflags) $(EmcRecCluster2Shower_pp_cppflags) $(use_cppflags) $(EmcRecLib_cppflags) $(lib_EmcRecLib_cppflags) $(EmcRecCluster2Shower_cppflags) $(EmcRecCluster2Shower_cxx_cppflags)  $(src)EmcRecCluster2Shower.cxx
endif
endif

else
$(bin)EmcRecLib_dependencies.make : $(EmcRecCluster2Shower_cxx_dependencies)

$(bin)EmcRecLib_dependencies.make : $(src)EmcRecCluster2Shower.cxx

$(bin)$(binobj)EmcRecCluster2Shower.o : $(EmcRecCluster2Shower_cxx_dependencies)
	$(cpp_echo) $(src)EmcRecCluster2Shower.cxx
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(EmcRecLib_pp_cppflags) $(lib_EmcRecLib_pp_cppflags) $(EmcRecCluster2Shower_pp_cppflags) $(use_cppflags) $(EmcRecLib_cppflags) $(lib_EmcRecLib_cppflags) $(EmcRecCluster2Shower_cppflags) $(EmcRecCluster2Shower_cxx_cppflags)  $(src)EmcRecCluster2Shower.cxx

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (-MMD -MP -MF $*.d -MQ $@,)

ifneq ($(MAKECMDGOALS),EmcRecLibclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)EmcRecTofDigitCalib.d

$(bin)$(binobj)EmcRecTofDigitCalib.d :

$(bin)$(binobj)EmcRecTofDigitCalib.o : $(cmt_final_setup_EmcRecLib)

$(bin)$(binobj)EmcRecTofDigitCalib.o : $(src)EmcRecTofDigitCalib.cxx
	$(cpp_echo) $(src)EmcRecTofDigitCalib.cxx
	$(cpp_silent) $(cppcomp) -MMD -MP -MF $*.d -MQ $@ -o $@ $(use_pp_cppflags) $(EmcRecLib_pp_cppflags) $(lib_EmcRecLib_pp_cppflags) $(EmcRecTofDigitCalib_pp_cppflags) $(use_cppflags) $(EmcRecLib_cppflags) $(lib_EmcRecLib_cppflags) $(EmcRecTofDigitCalib_cppflags) $(EmcRecTofDigitCalib_cxx_cppflags)  $(src)EmcRecTofDigitCalib.cxx
endif
endif

else
$(bin)EmcRecLib_dependencies.make : $(EmcRecTofDigitCalib_cxx_dependencies)

$(bin)EmcRecLib_dependencies.make : $(src)EmcRecTofDigitCalib.cxx

$(bin)$(binobj)EmcRecTofDigitCalib.o : $(EmcRecTofDigitCalib_cxx_dependencies)
	$(cpp_echo) $(src)EmcRecTofDigitCalib.cxx
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(EmcRecLib_pp_cppflags) $(lib_EmcRecLib_pp_cppflags) $(EmcRecTofDigitCalib_pp_cppflags) $(use_cppflags) $(EmcRecLib_cppflags) $(lib_EmcRecLib_cppflags) $(EmcRecTofDigitCalib_cppflags) $(EmcRecTofDigitCalib_cxx_cppflags)  $(src)EmcRecTofDigitCalib.cxx

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (-MMD -MP -MF $*.d -MQ $@,)

ifneq ($(MAKECMDGOALS),EmcRecLibclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)EmcRec_load.d

$(bin)$(binobj)EmcRec_load.d :

$(bin)$(binobj)EmcRec_load.o : $(cmt_final_setup_EmcRecLib)

$(bin)$(binobj)EmcRec_load.o : $(src)components/EmcRec_load.cxx
	$(cpp_echo) $(src)components/EmcRec_load.cxx
	$(cpp_silent) $(cppcomp) -MMD -MP -MF $*.d -MQ $@ -o $@ $(use_pp_cppflags) $(EmcRecLib_pp_cppflags) $(lib_EmcRecLib_pp_cppflags) $(EmcRec_load_pp_cppflags) $(use_cppflags) $(EmcRecLib_cppflags) $(lib_EmcRecLib_cppflags) $(EmcRec_load_cppflags) $(EmcRec_load_cxx_cppflags) -I../src/components $(src)components/EmcRec_load.cxx
endif
endif

else
$(bin)EmcRecLib_dependencies.make : $(EmcRec_load_cxx_dependencies)

$(bin)EmcRecLib_dependencies.make : $(src)components/EmcRec_load.cxx

$(bin)$(binobj)EmcRec_load.o : $(EmcRec_load_cxx_dependencies)
	$(cpp_echo) $(src)components/EmcRec_load.cxx
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(EmcRecLib_pp_cppflags) $(lib_EmcRecLib_pp_cppflags) $(EmcRec_load_pp_cppflags) $(use_cppflags) $(EmcRecLib_cppflags) $(lib_EmcRecLib_cppflags) $(EmcRec_load_cppflags) $(EmcRec_load_cxx_cppflags) -I../src/components $(src)components/EmcRec_load.cxx

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (-MMD -MP -MF $*.d -MQ $@,)

ifneq ($(MAKECMDGOALS),EmcRecLibclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)EmcRec_entries.d

$(bin)$(binobj)EmcRec_entries.d :

$(bin)$(binobj)EmcRec_entries.o : $(cmt_final_setup_EmcRecLib)

$(bin)$(binobj)EmcRec_entries.o : $(src)components/EmcRec_entries.cxx
	$(cpp_echo) $(src)components/EmcRec_entries.cxx
	$(cpp_silent) $(cppcomp) -MMD -MP -MF $*.d -MQ $@ -o $@ $(use_pp_cppflags) $(EmcRecLib_pp_cppflags) $(lib_EmcRecLib_pp_cppflags) $(EmcRec_entries_pp_cppflags) $(use_cppflags) $(EmcRecLib_cppflags) $(lib_EmcRecLib_cppflags) $(EmcRec_entries_cppflags) $(EmcRec_entries_cxx_cppflags) -I../src/components $(src)components/EmcRec_entries.cxx
endif
endif

else
$(bin)EmcRecLib_dependencies.make : $(EmcRec_entries_cxx_dependencies)

$(bin)EmcRecLib_dependencies.make : $(src)components/EmcRec_entries.cxx

$(bin)$(binobj)EmcRec_entries.o : $(EmcRec_entries_cxx_dependencies)
	$(cpp_echo) $(src)components/EmcRec_entries.cxx
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(EmcRecLib_pp_cppflags) $(lib_EmcRecLib_pp_cppflags) $(EmcRec_entries_pp_cppflags) $(use_cppflags) $(EmcRecLib_cppflags) $(lib_EmcRecLib_cppflags) $(EmcRec_entries_cppflags) $(EmcRec_entries_cxx_cppflags) -I../src/components $(src)components/EmcRec_entries.cxx

endif

#-- end of cpp_library ------------------
#-- start of cleanup_header --------------

clean :: EmcRecLibclean ;
#	@cd .

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(EmcRecLib.make) $@: No rule for such target" >&2
else
.DEFAULT::
	$(error PEDANTIC: $@: No rule for such target)
endif

EmcRecLibclean ::
#-- end of cleanup_header ---------------
#-- start of cleanup_library -------------
	$(cleanup_echo) library EmcRecLib
	-$(cleanup_silent) cd $(bin); /bin/rm -f $(library_prefix)EmcRecLib$(library_suffix).a $(library_prefix)EmcRecLib$(library_suffix).s? EmcRecLib.stamp EmcRecLib.shstamp
#-- end of cleanup_library ---------------
