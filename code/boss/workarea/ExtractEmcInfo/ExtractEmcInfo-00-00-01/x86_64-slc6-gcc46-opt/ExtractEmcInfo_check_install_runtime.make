#-- start of make_header -----------------

#====================================
#  Document ExtractEmcInfo_check_install_runtime
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

cmt_ExtractEmcInfo_check_install_runtime_has_no_target_tag = 1

#--------------------------------------------------------

ifdef cmt_ExtractEmcInfo_check_install_runtime_has_target_tag

tags      = $(tag),$(CMTEXTRATAGS),target_ExtractEmcInfo_check_install_runtime

ExtractEmcInfo_tag = $(tag)

#cmt_local_tagfile_ExtractEmcInfo_check_install_runtime = $(ExtractEmcInfo_tag)_ExtractEmcInfo_check_install_runtime.make
cmt_local_tagfile_ExtractEmcInfo_check_install_runtime = $(bin)$(ExtractEmcInfo_tag)_ExtractEmcInfo_check_install_runtime.make

else

tags      = $(tag),$(CMTEXTRATAGS)

ExtractEmcInfo_tag = $(tag)

#cmt_local_tagfile_ExtractEmcInfo_check_install_runtime = $(ExtractEmcInfo_tag).make
cmt_local_tagfile_ExtractEmcInfo_check_install_runtime = $(bin)$(ExtractEmcInfo_tag).make

endif

include $(cmt_local_tagfile_ExtractEmcInfo_check_install_runtime)
#-include $(cmt_local_tagfile_ExtractEmcInfo_check_install_runtime)

ifdef cmt_ExtractEmcInfo_check_install_runtime_has_target_tag

cmt_final_setup_ExtractEmcInfo_check_install_runtime = $(bin)setup_ExtractEmcInfo_check_install_runtime.make
cmt_dependencies_in_ExtractEmcInfo_check_install_runtime = $(bin)dependencies_ExtractEmcInfo_check_install_runtime.in
#cmt_final_setup_ExtractEmcInfo_check_install_runtime = $(bin)ExtractEmcInfo_ExtractEmcInfo_check_install_runtimesetup.make
cmt_local_ExtractEmcInfo_check_install_runtime_makefile = $(bin)ExtractEmcInfo_check_install_runtime.make

else

cmt_final_setup_ExtractEmcInfo_check_install_runtime = $(bin)setup.make
cmt_dependencies_in_ExtractEmcInfo_check_install_runtime = $(bin)dependencies.in
#cmt_final_setup_ExtractEmcInfo_check_install_runtime = $(bin)ExtractEmcInfosetup.make
cmt_local_ExtractEmcInfo_check_install_runtime_makefile = $(bin)ExtractEmcInfo_check_install_runtime.make

endif

#cmt_final_setup = $(bin)setup.make
#cmt_final_setup = $(bin)ExtractEmcInfosetup.make

#ExtractEmcInfo_check_install_runtime :: ;

dirs ::
	@if test ! -r requirements ; then echo "No requirements file" ; fi; \
	  if test ! -d $(bin) ; then $(mkdir) -p $(bin) ; fi

javadirs ::
	@if test ! -d $(javabin) ; then $(mkdir) -p $(javabin) ; fi

srcdirs ::
	@if test ! -d $(src) ; then $(mkdir) -p $(src) ; fi

help ::
	$(echo) 'ExtractEmcInfo_check_install_runtime'

binobj = 
ifdef STRUCTURED_OUTPUT
binobj = ExtractEmcInfo_check_install_runtime/
#ExtractEmcInfo_check_install_runtime::
#	@if test ! -d $(bin)$(binobj) ; then $(mkdir) -p $(bin)$(binobj) ; fi
#	$(echo) "STRUCTURED_OUTPUT="$(bin)$(binobj)
endif

${CMTROOT}/src/Makefile.core : ;
ifdef use_requirements
$(use_requirements) : ;
endif

#-- end of make_header ------------------
#-- start of cmt_action_runner_header ---------------

ifdef ONCE
ExtractEmcInfo_check_install_runtime_once = 1
endif

ifdef ExtractEmcInfo_check_install_runtime_once

ExtractEmcInfo_check_install_runtimeactionstamp = $(bin)ExtractEmcInfo_check_install_runtime.actionstamp
#ExtractEmcInfo_check_install_runtimeactionstamp = ExtractEmcInfo_check_install_runtime.actionstamp

ExtractEmcInfo_check_install_runtime :: $(ExtractEmcInfo_check_install_runtimeactionstamp)
	$(echo) "ExtractEmcInfo_check_install_runtime ok"
#	@echo ExtractEmcInfo_check_install_runtime ok

#$(ExtractEmcInfo_check_install_runtimeactionstamp) :: $(ExtractEmcInfo_check_install_runtime_dependencies)
$(ExtractEmcInfo_check_install_runtimeactionstamp) ::
	$(silent) /cvmfs/bes3.ihep.ac.cn/bes3sw/Boss/7.0.5/BesPolicy/BesPolicy-01-05-05/cmt/bes_check_installations.sh -files= -s=../share *.txt   -installdir=/junofs/users/yuansc/bes3_emc/code/boss/workarea/InstallArea/share
	$(silent) cat /dev/null > $(ExtractEmcInfo_check_install_runtimeactionstamp)
#	@echo ok > $(ExtractEmcInfo_check_install_runtimeactionstamp)

ExtractEmcInfo_check_install_runtimeclean ::
	$(cleanup_silent) /bin/rm -f $(ExtractEmcInfo_check_install_runtimeactionstamp)

else

#ExtractEmcInfo_check_install_runtime :: $(ExtractEmcInfo_check_install_runtime_dependencies)
ExtractEmcInfo_check_install_runtime ::
	$(silent) /cvmfs/bes3.ihep.ac.cn/bes3sw/Boss/7.0.5/BesPolicy/BesPolicy-01-05-05/cmt/bes_check_installations.sh -files= -s=../share *.txt   -installdir=/junofs/users/yuansc/bes3_emc/code/boss/workarea/InstallArea/share

endif

install ::
uninstall ::

#-- end of cmt_action_runner_header -----------------
#-- start of cleanup_header --------------

clean :: ExtractEmcInfo_check_install_runtimeclean ;
#	@cd .

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(ExtractEmcInfo_check_install_runtime.make) $@: No rule for such target" >&2
else
.DEFAULT::
	$(error PEDANTIC: $@: No rule for such target)
endif

ExtractEmcInfo_check_install_runtimeclean ::
#-- end of cleanup_header ---------------
