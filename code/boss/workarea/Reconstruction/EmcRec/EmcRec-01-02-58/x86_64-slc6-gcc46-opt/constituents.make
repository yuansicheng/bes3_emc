
#-- start of constituents_header ------

include ${CMTROOT}/src/Makefile.core

ifdef tag
CMTEXTRATAGS = $(tag)
else
tag       = $(CMTCONFIG)
endif

tags      = $(tag),$(CMTEXTRATAGS)

EmcRec_tag = $(tag)

#cmt_local_tagfile = $(EmcRec_tag).make
cmt_local_tagfile = $(bin)$(EmcRec_tag).make

#-include $(cmt_local_tagfile)
include $(cmt_local_tagfile)

#cmt_local_setup = $(bin)setup$$$$.make
#cmt_local_setup = $(bin)$(package)setup$$$$.make
#cmt_final_setup = $(bin)EmcRecsetup.make
cmt_final_setup = $(bin)setup.make
#cmt_final_setup = $(bin)$(package)setup.make

cmt_build_library_linksstamp = $(bin)cmt_build_library_links.stamp
#--------------------------------------------------------

#cmt_lock_setup = /tmp/lock$(cmt_lock_pid).make
#cmt_temp_tag = /tmp/tag$(cmt_lock_pid).make

#first :: $(cmt_local_tagfile)
#	@echo $(cmt_local_tagfile) ok
#ifndef QUICK
#first :: $(cmt_final_setup) ;
#else
#first :: ;
#endif

##	@bin=`$(cmtexe) show macro_value bin`

#$(cmt_local_tagfile) : $(cmt_lock_setup)
#	@echo "#CMT> Error: $@: No such file" >&2; exit 1
#$(cmt_local_tagfile) :
#	@echo "#CMT> Warning: $@: No such file" >&2; exit
#	@echo "#CMT> Info: $@: No need to rebuild file" >&2; exit

#$(cmt_final_setup) : $(cmt_local_tagfile) 
#	$(echo) "(constituents.make) Rebuilding $@"
#	@if test ! -d $(@D); then $(mkdir) -p $(@D); fi; \
#	  if test -f $(cmt_local_setup); then /bin/rm -f $(cmt_local_setup); fi; \
#	  trap '/bin/rm -f $(cmt_local_setup)' 0 1 2 15; \
#	  $(cmtexe) -tag=$(tags) show setup >>$(cmt_local_setup); \
#	  if test ! -f $@; then \
#	    mv $(cmt_local_setup) $@; \
#	  else \
#	    if /usr/bin/diff $(cmt_local_setup) $@ >/dev/null ; then \
#	      : ; \
#	    else \
#	      mv $(cmt_local_setup) $@; \
#	    fi; \
#	  fi

#	@/bin/echo $@ ok   

#config :: checkuses
#	@exit 0
#checkuses : ;

env.make ::
	printenv >env.make.tmp; $(cmtexe) check files env.make.tmp env.make

ifndef QUICK
all :: build_library_links ;
else
all :: $(cmt_build_library_linksstamp) ;
endif

javadirs ::
	@if test ! -d $(javabin) ; then $(mkdir) -p $(javabin) ; fi

srcdirs ::
	@if test ! -d $(src) ; then $(mkdir) -p $(src) ; fi

dirs :: requirements
	@if test ! -d $(bin) ; then $(mkdir) -p $(bin) ; fi
#	@if test ! -r requirements ; then echo "No requirements file" ; fi; \
#	  if test ! -d $(bin) ; then $(mkdir) -p $(bin) ; fi

#requirements :
#	@if test ! -r requirements ; then echo "No requirements file" ; fi

build_library_links : dirs
	$(echo) "(constituents.make) Rebuilding library links"; \
	 $(build_library_links)
#	if test ! -d $(bin) ; then $(mkdir) -p $(bin) ; fi; \
#	$(build_library_links)

$(cmt_build_library_linksstamp) : $(cmt_final_setup) $(cmt_local_tagfile) $(bin)library_links.in
	$(echo) "(constituents.make) Rebuilding library links"; \
	 $(build_library_links) -f=$(bin)library_links.in -without_cmt
	$(silent) \touch $@

ifndef PEDANTIC
.DEFAULT ::
#.DEFAULT :
	$(echo) "(constituents.make) $@: No rule for such target" >&2
endif

${CMTROOT}/src/Makefile.core : ;
ifdef use_requirements
$(use_requirements) : ;
endif

#-- end of constituents_header ------
#-- start of group ------

all_groups :: all

all :: $(all_dependencies)  $(all_pre_constituents) $(all_constituents)  $(all_post_constituents)
	$(echo) "all ok."

#	@/bin/echo " all ok."

clean :: allclean

allclean ::  $(all_constituentsclean)
	$(echo) $(all_constituentsclean)
	$(echo) "allclean ok."

#	@echo $(all_constituentsclean)
#	@/bin/echo " allclean ok."

#-- end of group ------
#-- start of group ------

all_groups :: cmt_actions

cmt_actions :: $(cmt_actions_dependencies)  $(cmt_actions_pre_constituents) $(cmt_actions_constituents)  $(cmt_actions_post_constituents)
	$(echo) "cmt_actions ok."

#	@/bin/echo " cmt_actions ok."

clean :: allclean

cmt_actionsclean ::  $(cmt_actions_constituentsclean)
	$(echo) $(cmt_actions_constituentsclean)
	$(echo) "cmt_actionsclean ok."

#	@echo $(cmt_actions_constituentsclean)
#	@/bin/echo " cmt_actionsclean ok."

#-- end of group ------
#-- start of constituent ------

cmt_EmcRecLib_has_no_target_tag = 1

#--------------------------------------------------------

ifdef cmt_EmcRecLib_has_target_tag

#cmt_local_tagfile_EmcRecLib = $(EmcRec_tag)_EmcRecLib.make
cmt_local_tagfile_EmcRecLib = $(bin)$(EmcRec_tag)_EmcRecLib.make
cmt_local_setup_EmcRecLib = $(bin)setup_EmcRecLib$$$$.make
cmt_final_setup_EmcRecLib = $(bin)setup_EmcRecLib.make
#cmt_final_setup_EmcRecLib = $(bin)EmcRec_EmcRecLibsetup.make
cmt_local_EmcRecLib_makefile = $(bin)EmcRecLib.make

EmcRecLib_extratags = -tag_add=target_EmcRecLib

#$(cmt_local_tagfile_EmcRecLib) : $(cmt_lock_setup)
ifndef QUICK
$(cmt_local_tagfile_EmcRecLib) ::
else
$(cmt_local_tagfile_EmcRecLib) :
endif
	$(echo) "(constituents.make) Rebuilding $@"; \
	  if test -f $(cmt_local_tagfile_EmcRecLib); then /bin/rm -f $(cmt_local_tagfile_EmcRecLib); fi ; \
	  $(cmtexe) -tag=$(tags) $(EmcRecLib_extratags) build tag_makefile >>$(cmt_local_tagfile_EmcRecLib)
	$(echo) "(constituents.make) Rebuilding $(cmt_final_setup_EmcRecLib)"; \
	  test ! -f $(cmt_local_setup_EmcRecLib) || \rm -f $(cmt_local_setup_EmcRecLib); \
	  trap '\rm -f $(cmt_local_setup_EmcRecLib)' 0 1 2 15; \
	  $(cmtexe) -tag=$(tags) $(EmcRecLib_extratags) show setup >$(cmt_local_setup_EmcRecLib) && \
	  if [ -f $(cmt_final_setup_EmcRecLib) ] && \
	    \cmp -s $(cmt_final_setup_EmcRecLib) $(cmt_local_setup_EmcRecLib); then \
	    \rm $(cmt_local_setup_EmcRecLib); else \
	    \mv -f $(cmt_local_setup_EmcRecLib) $(cmt_final_setup_EmcRecLib); fi

else

#cmt_local_tagfile_EmcRecLib = $(EmcRec_tag).make
cmt_local_tagfile_EmcRecLib = $(bin)$(EmcRec_tag).make
cmt_final_setup_EmcRecLib = $(bin)setup.make
#cmt_final_setup_EmcRecLib = $(bin)EmcRecsetup.make
cmt_local_EmcRecLib_makefile = $(bin)EmcRecLib.make

endif

not_EmcRecLib_dependencies = { n=0; for p in $?; do m=0; for d in $(EmcRecLib_dependencies); do if [ $$p = $$d ]; then m=1; break; fi; done; if [ $$m -eq 0 ]; then n=1; break; fi; done; [ $$n -eq 1 ]; }

ifdef STRUCTURED_OUTPUT
EmcRecLibdirs :
	@if test ! -d $(bin)EmcRecLib; then $(mkdir) -p $(bin)EmcRecLib; fi
	$(echo) "STRUCTURED_OUTPUT="$(bin)EmcRecLib
else
EmcRecLibdirs : ;
endif

#ifndef QUICK
#ifdef STRUCTURED_OUTPUT
# EmcRecLibdirs ::
#	@if test ! -d $(bin)EmcRecLib; then $(mkdir) -p $(bin)EmcRecLib; fi
#	$(echo) "STRUCTURED_OUTPUT="$(bin)EmcRecLib
#
#$(cmt_local_EmcRecLib_makefile) :: $(EmcRecLib_dependencies) $(cmt_local_tagfile_EmcRecLib) build_library_links dirs EmcRecLibdirs
#else
#$(cmt_local_EmcRecLib_makefile) :: $(EmcRecLib_dependencies) $(cmt_local_tagfile_EmcRecLib) build_library_links dirs
#endif
#else
#$(cmt_local_EmcRecLib_makefile) :: $(cmt_local_tagfile_EmcRecLib)
#endif

ifdef cmt_EmcRecLib_has_target_tag

ifndef QUICK
$(cmt_local_EmcRecLib_makefile) : $(EmcRecLib_dependencies) build_library_links
	$(echo) "(constituents.make) Building EmcRecLib.make"; \
	  $(cmtexe) -tag=$(tags) $(EmcRecLib_extratags) build constituent_config -out=$(cmt_local_EmcRecLib_makefile) EmcRecLib
else
$(cmt_local_EmcRecLib_makefile) : $(EmcRecLib_dependencies) $(cmt_build_library_linksstamp) $(use_requirements)
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_EmcRecLib) ] || \
	  [ ! -f $(cmt_final_setup_EmcRecLib) ] || \
	  $(not_EmcRecLib_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building EmcRecLib.make"; \
	  $(cmtexe) -tag=$(tags) $(EmcRecLib_extratags) build constituent_config -out=$(cmt_local_EmcRecLib_makefile) EmcRecLib; \
	  fi
endif

else

ifndef QUICK
$(cmt_local_EmcRecLib_makefile) : $(EmcRecLib_dependencies) build_library_links
	$(echo) "(constituents.make) Building EmcRecLib.make"; \
	  $(cmtexe) -f=$(bin)EmcRecLib.in -tag=$(tags) $(EmcRecLib_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_EmcRecLib_makefile) EmcRecLib
else
$(cmt_local_EmcRecLib_makefile) : $(EmcRecLib_dependencies) $(cmt_build_library_linksstamp) $(bin)EmcRecLib.in
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_EmcRecLib) ] || \
	  [ ! -f $(cmt_final_setup_EmcRecLib) ] || \
	  $(not_EmcRecLib_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building EmcRecLib.make"; \
	  $(cmtexe) -f=$(bin)EmcRecLib.in -tag=$(tags) $(EmcRecLib_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_EmcRecLib_makefile) EmcRecLib; \
	  fi
endif

endif

#	  $(cmtexe) -tag=$(tags) $(EmcRecLib_extratags) build constituent_makefile -out=$(cmt_local_EmcRecLib_makefile) EmcRecLib

EmcRecLib :: $(EmcRecLib_dependencies) $(cmt_local_EmcRecLib_makefile) dirs EmcRecLibdirs
	$(echo) "(constituents.make) Starting EmcRecLib"
	@if test -f $(cmt_local_EmcRecLib_makefile); then \
	  $(MAKE) -f $(cmt_local_EmcRecLib_makefile) EmcRecLib; \
	  fi
#	@$(MAKE) -f $(cmt_local_EmcRecLib_makefile) EmcRecLib
	$(echo) "(constituents.make) EmcRecLib done"

clean :: EmcRecLibclean

EmcRecLibclean :: $(EmcRecLibclean_dependencies) ##$(cmt_local_EmcRecLib_makefile)
	$(echo) "(constituents.make) Starting EmcRecLibclean"
	@-if test -f $(cmt_local_EmcRecLib_makefile); then \
	  $(MAKE) -f $(cmt_local_EmcRecLib_makefile) EmcRecLibclean; \
	fi
	$(echo) "(constituents.make) EmcRecLibclean done"
#	@-$(MAKE) -f $(cmt_local_EmcRecLib_makefile) EmcRecLibclean

##	  /bin/rm -f $(cmt_local_EmcRecLib_makefile) $(bin)EmcRecLib_dependencies.make

install :: EmcRecLibinstall

EmcRecLibinstall :: $(EmcRecLib_dependencies) $(cmt_local_EmcRecLib_makefile)
	$(echo) "(constituents.make) Starting install EmcRecLib"
	@-$(MAKE) -f $(cmt_local_EmcRecLib_makefile) install
	$(echo) "(constituents.make) install EmcRecLib done"

uninstall : EmcRecLibuninstall

$(foreach d,$(EmcRecLib_dependencies),$(eval $(d)uninstall_dependencies += EmcRecLibuninstall))

EmcRecLibuninstall : $(EmcRecLibuninstall_dependencies) ##$(cmt_local_EmcRecLib_makefile)
	$(echo) "(constituents.make) Starting uninstall EmcRecLib"
	@if test -f $(cmt_local_EmcRecLib_makefile); then \
	  $(MAKE) -f $(cmt_local_EmcRecLib_makefile) uninstall; \
	  fi
#	@$(MAKE) -f $(cmt_local_EmcRecLib_makefile) uninstall
	$(echo) "(constituents.make) uninstall EmcRecLib done"

remove_library_links :: EmcRecLibuninstall

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(constituents.make) Starting $@ EmcRecLib"
	$(echo) Using default action for $@
	$(echo) "(constituents.make) $@ EmcRecLib done"
endif

#-- end of constituent ------
#-- start of constituent ------

cmt_EmcRec_has_no_target_tag = 1

#--------------------------------------------------------

ifdef cmt_EmcRec_has_target_tag

#cmt_local_tagfile_EmcRec = $(EmcRec_tag)_EmcRec.make
cmt_local_tagfile_EmcRec = $(bin)$(EmcRec_tag)_EmcRec.make
cmt_local_setup_EmcRec = $(bin)setup_EmcRec$$$$.make
cmt_final_setup_EmcRec = $(bin)setup_EmcRec.make
#cmt_final_setup_EmcRec = $(bin)EmcRec_EmcRecsetup.make
cmt_local_EmcRec_makefile = $(bin)EmcRec.make

EmcRec_extratags = -tag_add=target_EmcRec

#$(cmt_local_tagfile_EmcRec) : $(cmt_lock_setup)
ifndef QUICK
$(cmt_local_tagfile_EmcRec) ::
else
$(cmt_local_tagfile_EmcRec) :
endif
	$(echo) "(constituents.make) Rebuilding $@"; \
	  if test -f $(cmt_local_tagfile_EmcRec); then /bin/rm -f $(cmt_local_tagfile_EmcRec); fi ; \
	  $(cmtexe) -tag=$(tags) $(EmcRec_extratags) build tag_makefile >>$(cmt_local_tagfile_EmcRec)
	$(echo) "(constituents.make) Rebuilding $(cmt_final_setup_EmcRec)"; \
	  test ! -f $(cmt_local_setup_EmcRec) || \rm -f $(cmt_local_setup_EmcRec); \
	  trap '\rm -f $(cmt_local_setup_EmcRec)' 0 1 2 15; \
	  $(cmtexe) -tag=$(tags) $(EmcRec_extratags) show setup >$(cmt_local_setup_EmcRec) && \
	  if [ -f $(cmt_final_setup_EmcRec) ] && \
	    \cmp -s $(cmt_final_setup_EmcRec) $(cmt_local_setup_EmcRec); then \
	    \rm $(cmt_local_setup_EmcRec); else \
	    \mv -f $(cmt_local_setup_EmcRec) $(cmt_final_setup_EmcRec); fi

else

#cmt_local_tagfile_EmcRec = $(EmcRec_tag).make
cmt_local_tagfile_EmcRec = $(bin)$(EmcRec_tag).make
cmt_final_setup_EmcRec = $(bin)setup.make
#cmt_final_setup_EmcRec = $(bin)EmcRecsetup.make
cmt_local_EmcRec_makefile = $(bin)EmcRec.make

endif

not_EmcRec_dependencies = { n=0; for p in $?; do m=0; for d in $(EmcRec_dependencies); do if [ $$p = $$d ]; then m=1; break; fi; done; if [ $$m -eq 0 ]; then n=1; break; fi; done; [ $$n -eq 1 ]; }

ifdef STRUCTURED_OUTPUT
EmcRecdirs :
	@if test ! -d $(bin)EmcRec; then $(mkdir) -p $(bin)EmcRec; fi
	$(echo) "STRUCTURED_OUTPUT="$(bin)EmcRec
else
EmcRecdirs : ;
endif

#ifndef QUICK
#ifdef STRUCTURED_OUTPUT
# EmcRecdirs ::
#	@if test ! -d $(bin)EmcRec; then $(mkdir) -p $(bin)EmcRec; fi
#	$(echo) "STRUCTURED_OUTPUT="$(bin)EmcRec
#
#$(cmt_local_EmcRec_makefile) :: $(EmcRec_dependencies) $(cmt_local_tagfile_EmcRec) build_library_links dirs EmcRecdirs
#else
#$(cmt_local_EmcRec_makefile) :: $(EmcRec_dependencies) $(cmt_local_tagfile_EmcRec) build_library_links dirs
#endif
#else
#$(cmt_local_EmcRec_makefile) :: $(cmt_local_tagfile_EmcRec)
#endif

ifdef cmt_EmcRec_has_target_tag

ifndef QUICK
$(cmt_local_EmcRec_makefile) : $(EmcRec_dependencies) build_library_links
	$(echo) "(constituents.make) Building EmcRec.make"; \
	  $(cmtexe) -tag=$(tags) $(EmcRec_extratags) build constituent_config -out=$(cmt_local_EmcRec_makefile) EmcRec
else
$(cmt_local_EmcRec_makefile) : $(EmcRec_dependencies) $(cmt_build_library_linksstamp) $(use_requirements)
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_EmcRec) ] || \
	  [ ! -f $(cmt_final_setup_EmcRec) ] || \
	  $(not_EmcRec_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building EmcRec.make"; \
	  $(cmtexe) -tag=$(tags) $(EmcRec_extratags) build constituent_config -out=$(cmt_local_EmcRec_makefile) EmcRec; \
	  fi
endif

else

ifndef QUICK
$(cmt_local_EmcRec_makefile) : $(EmcRec_dependencies) build_library_links
	$(echo) "(constituents.make) Building EmcRec.make"; \
	  $(cmtexe) -f=$(bin)EmcRec.in -tag=$(tags) $(EmcRec_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_EmcRec_makefile) EmcRec
else
$(cmt_local_EmcRec_makefile) : $(EmcRec_dependencies) $(cmt_build_library_linksstamp) $(bin)EmcRec.in
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_EmcRec) ] || \
	  [ ! -f $(cmt_final_setup_EmcRec) ] || \
	  $(not_EmcRec_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building EmcRec.make"; \
	  $(cmtexe) -f=$(bin)EmcRec.in -tag=$(tags) $(EmcRec_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_EmcRec_makefile) EmcRec; \
	  fi
endif

endif

#	  $(cmtexe) -tag=$(tags) $(EmcRec_extratags) build constituent_makefile -out=$(cmt_local_EmcRec_makefile) EmcRec

EmcRec :: $(EmcRec_dependencies) $(cmt_local_EmcRec_makefile) dirs EmcRecdirs
	$(echo) "(constituents.make) Starting EmcRec"
	@if test -f $(cmt_local_EmcRec_makefile); then \
	  $(MAKE) -f $(cmt_local_EmcRec_makefile) EmcRec; \
	  fi
#	@$(MAKE) -f $(cmt_local_EmcRec_makefile) EmcRec
	$(echo) "(constituents.make) EmcRec done"

clean :: EmcRecclean

EmcRecclean :: $(EmcRecclean_dependencies) ##$(cmt_local_EmcRec_makefile)
	$(echo) "(constituents.make) Starting EmcRecclean"
	@-if test -f $(cmt_local_EmcRec_makefile); then \
	  $(MAKE) -f $(cmt_local_EmcRec_makefile) EmcRecclean; \
	fi
	$(echo) "(constituents.make) EmcRecclean done"
#	@-$(MAKE) -f $(cmt_local_EmcRec_makefile) EmcRecclean

##	  /bin/rm -f $(cmt_local_EmcRec_makefile) $(bin)EmcRec_dependencies.make

install :: EmcRecinstall

EmcRecinstall :: $(EmcRec_dependencies) $(cmt_local_EmcRec_makefile)
	$(echo) "(constituents.make) Starting install EmcRec"
	@-$(MAKE) -f $(cmt_local_EmcRec_makefile) install
	$(echo) "(constituents.make) install EmcRec done"

uninstall : EmcRecuninstall

$(foreach d,$(EmcRec_dependencies),$(eval $(d)uninstall_dependencies += EmcRecuninstall))

EmcRecuninstall : $(EmcRecuninstall_dependencies) ##$(cmt_local_EmcRec_makefile)
	$(echo) "(constituents.make) Starting uninstall EmcRec"
	@if test -f $(cmt_local_EmcRec_makefile); then \
	  $(MAKE) -f $(cmt_local_EmcRec_makefile) uninstall; \
	  fi
#	@$(MAKE) -f $(cmt_local_EmcRec_makefile) uninstall
	$(echo) "(constituents.make) uninstall EmcRec done"

remove_library_links :: EmcRecuninstall

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(constituents.make) Starting $@ EmcRec"
	$(echo) Using default action for $@
	$(echo) "(constituents.make) $@ EmcRec done"
endif

#-- end of constituent ------
#-- start of constituent ------

cmt_config_has_no_target_tag = 1

#--------------------------------------------------------

ifdef cmt_config_has_target_tag

#cmt_local_tagfile_config = $(EmcRec_tag)_config.make
cmt_local_tagfile_config = $(bin)$(EmcRec_tag)_config.make
cmt_local_setup_config = $(bin)setup_config$$$$.make
cmt_final_setup_config = $(bin)setup_config.make
#cmt_final_setup_config = $(bin)EmcRec_configsetup.make
cmt_local_config_makefile = $(bin)config.make

config_extratags = -tag_add=target_config

#$(cmt_local_tagfile_config) : $(cmt_lock_setup)
ifndef QUICK
$(cmt_local_tagfile_config) ::
else
$(cmt_local_tagfile_config) :
endif
	$(echo) "(constituents.make) Rebuilding $@"; \
	  if test -f $(cmt_local_tagfile_config); then /bin/rm -f $(cmt_local_tagfile_config); fi ; \
	  $(cmtexe) -tag=$(tags) $(config_extratags) build tag_makefile >>$(cmt_local_tagfile_config)
	$(echo) "(constituents.make) Rebuilding $(cmt_final_setup_config)"; \
	  test ! -f $(cmt_local_setup_config) || \rm -f $(cmt_local_setup_config); \
	  trap '\rm -f $(cmt_local_setup_config)' 0 1 2 15; \
	  $(cmtexe) -tag=$(tags) $(config_extratags) show setup >$(cmt_local_setup_config) && \
	  if [ -f $(cmt_final_setup_config) ] && \
	    \cmp -s $(cmt_final_setup_config) $(cmt_local_setup_config); then \
	    \rm $(cmt_local_setup_config); else \
	    \mv -f $(cmt_local_setup_config) $(cmt_final_setup_config); fi

else

#cmt_local_tagfile_config = $(EmcRec_tag).make
cmt_local_tagfile_config = $(bin)$(EmcRec_tag).make
cmt_final_setup_config = $(bin)setup.make
#cmt_final_setup_config = $(bin)EmcRecsetup.make
cmt_local_config_makefile = $(bin)config.make

endif

not_config_dependencies = { n=0; for p in $?; do m=0; for d in $(config_dependencies); do if [ $$p = $$d ]; then m=1; break; fi; done; if [ $$m -eq 0 ]; then n=1; break; fi; done; [ $$n -eq 1 ]; }

ifdef STRUCTURED_OUTPUT
configdirs :
	@if test ! -d $(bin)config; then $(mkdir) -p $(bin)config; fi
	$(echo) "STRUCTURED_OUTPUT="$(bin)config
else
configdirs : ;
endif

#ifndef QUICK
#ifdef STRUCTURED_OUTPUT
# configdirs ::
#	@if test ! -d $(bin)config; then $(mkdir) -p $(bin)config; fi
#	$(echo) "STRUCTURED_OUTPUT="$(bin)config
#
#$(cmt_local_config_makefile) :: $(config_dependencies) $(cmt_local_tagfile_config) build_library_links dirs configdirs
#else
#$(cmt_local_config_makefile) :: $(config_dependencies) $(cmt_local_tagfile_config) build_library_links dirs
#endif
#else
#$(cmt_local_config_makefile) :: $(cmt_local_tagfile_config)
#endif

ifdef cmt_config_has_target_tag

ifndef QUICK
$(cmt_local_config_makefile) : $(config_dependencies) build_library_links
	$(echo) "(constituents.make) Building config.make"; \
	  $(cmtexe) -tag=$(tags) $(config_extratags) build constituent_config -out=$(cmt_local_config_makefile) config
else
$(cmt_local_config_makefile) : $(config_dependencies) $(cmt_build_library_linksstamp) $(use_requirements)
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_config) ] || \
	  [ ! -f $(cmt_final_setup_config) ] || \
	  $(not_config_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building config.make"; \
	  $(cmtexe) -tag=$(tags) $(config_extratags) build constituent_config -out=$(cmt_local_config_makefile) config; \
	  fi
endif

else

ifndef QUICK
$(cmt_local_config_makefile) : $(config_dependencies) build_library_links
	$(echo) "(constituents.make) Building config.make"; \
	  $(cmtexe) -f=$(bin)config.in -tag=$(tags) $(config_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_config_makefile) config
else
$(cmt_local_config_makefile) : $(config_dependencies) $(cmt_build_library_linksstamp) $(bin)config.in
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_config) ] || \
	  [ ! -f $(cmt_final_setup_config) ] || \
	  $(not_config_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building config.make"; \
	  $(cmtexe) -f=$(bin)config.in -tag=$(tags) $(config_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_config_makefile) config; \
	  fi
endif

endif

#	  $(cmtexe) -tag=$(tags) $(config_extratags) build constituent_makefile -out=$(cmt_local_config_makefile) config

config :: $(config_dependencies) $(cmt_local_config_makefile) dirs configdirs
	$(echo) "(constituents.make) Starting config"
	@if test -f $(cmt_local_config_makefile); then \
	  $(MAKE) -f $(cmt_local_config_makefile) config; \
	  fi
#	@$(MAKE) -f $(cmt_local_config_makefile) config
	$(echo) "(constituents.make) config done"

clean :: configclean

configclean :: $(configclean_dependencies) ##$(cmt_local_config_makefile)
	$(echo) "(constituents.make) Starting configclean"
	@-if test -f $(cmt_local_config_makefile); then \
	  $(MAKE) -f $(cmt_local_config_makefile) configclean; \
	fi
	$(echo) "(constituents.make) configclean done"
#	@-$(MAKE) -f $(cmt_local_config_makefile) configclean

##	  /bin/rm -f $(cmt_local_config_makefile) $(bin)config_dependencies.make

install :: configinstall

configinstall :: $(config_dependencies) $(cmt_local_config_makefile)
	$(echo) "(constituents.make) Starting install config"
	@-$(MAKE) -f $(cmt_local_config_makefile) install
	$(echo) "(constituents.make) install config done"

uninstall : configuninstall

$(foreach d,$(config_dependencies),$(eval $(d)uninstall_dependencies += configuninstall))

configuninstall : $(configuninstall_dependencies) ##$(cmt_local_config_makefile)
	$(echo) "(constituents.make) Starting uninstall config"
	@if test -f $(cmt_local_config_makefile); then \
	  $(MAKE) -f $(cmt_local_config_makefile) uninstall; \
	  fi
#	@$(MAKE) -f $(cmt_local_config_makefile) uninstall
	$(echo) "(constituents.make) uninstall config done"

remove_library_links :: configuninstall

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(constituents.make) Starting $@ config"
	$(echo) Using default action for $@
	$(echo) "(constituents.make) $@ config done"
endif

#-- end of constituent ------
#-- start of constituent ------

cmt_install_includes_has_no_target_tag = 1

#--------------------------------------------------------

ifdef cmt_install_includes_has_target_tag

#cmt_local_tagfile_install_includes = $(EmcRec_tag)_install_includes.make
cmt_local_tagfile_install_includes = $(bin)$(EmcRec_tag)_install_includes.make
cmt_local_setup_install_includes = $(bin)setup_install_includes$$$$.make
cmt_final_setup_install_includes = $(bin)setup_install_includes.make
#cmt_final_setup_install_includes = $(bin)EmcRec_install_includessetup.make
cmt_local_install_includes_makefile = $(bin)install_includes.make

install_includes_extratags = -tag_add=target_install_includes

#$(cmt_local_tagfile_install_includes) : $(cmt_lock_setup)
ifndef QUICK
$(cmt_local_tagfile_install_includes) ::
else
$(cmt_local_tagfile_install_includes) :
endif
	$(echo) "(constituents.make) Rebuilding $@"; \
	  if test -f $(cmt_local_tagfile_install_includes); then /bin/rm -f $(cmt_local_tagfile_install_includes); fi ; \
	  $(cmtexe) -tag=$(tags) $(install_includes_extratags) build tag_makefile >>$(cmt_local_tagfile_install_includes)
	$(echo) "(constituents.make) Rebuilding $(cmt_final_setup_install_includes)"; \
	  test ! -f $(cmt_local_setup_install_includes) || \rm -f $(cmt_local_setup_install_includes); \
	  trap '\rm -f $(cmt_local_setup_install_includes)' 0 1 2 15; \
	  $(cmtexe) -tag=$(tags) $(install_includes_extratags) show setup >$(cmt_local_setup_install_includes) && \
	  if [ -f $(cmt_final_setup_install_includes) ] && \
	    \cmp -s $(cmt_final_setup_install_includes) $(cmt_local_setup_install_includes); then \
	    \rm $(cmt_local_setup_install_includes); else \
	    \mv -f $(cmt_local_setup_install_includes) $(cmt_final_setup_install_includes); fi

else

#cmt_local_tagfile_install_includes = $(EmcRec_tag).make
cmt_local_tagfile_install_includes = $(bin)$(EmcRec_tag).make
cmt_final_setup_install_includes = $(bin)setup.make
#cmt_final_setup_install_includes = $(bin)EmcRecsetup.make
cmt_local_install_includes_makefile = $(bin)install_includes.make

endif

not_install_includes_dependencies = { n=0; for p in $?; do m=0; for d in $(install_includes_dependencies); do if [ $$p = $$d ]; then m=1; break; fi; done; if [ $$m -eq 0 ]; then n=1; break; fi; done; [ $$n -eq 1 ]; }

ifdef STRUCTURED_OUTPUT
install_includesdirs :
	@if test ! -d $(bin)install_includes; then $(mkdir) -p $(bin)install_includes; fi
	$(echo) "STRUCTURED_OUTPUT="$(bin)install_includes
else
install_includesdirs : ;
endif

#ifndef QUICK
#ifdef STRUCTURED_OUTPUT
# install_includesdirs ::
#	@if test ! -d $(bin)install_includes; then $(mkdir) -p $(bin)install_includes; fi
#	$(echo) "STRUCTURED_OUTPUT="$(bin)install_includes
#
#$(cmt_local_install_includes_makefile) :: $(install_includes_dependencies) $(cmt_local_tagfile_install_includes) build_library_links dirs install_includesdirs
#else
#$(cmt_local_install_includes_makefile) :: $(install_includes_dependencies) $(cmt_local_tagfile_install_includes) build_library_links dirs
#endif
#else
#$(cmt_local_install_includes_makefile) :: $(cmt_local_tagfile_install_includes)
#endif

ifdef cmt_install_includes_has_target_tag

ifndef QUICK
$(cmt_local_install_includes_makefile) : $(install_includes_dependencies) build_library_links
	$(echo) "(constituents.make) Building install_includes.make"; \
	  $(cmtexe) -tag=$(tags) $(install_includes_extratags) build constituent_config -out=$(cmt_local_install_includes_makefile) install_includes
else
$(cmt_local_install_includes_makefile) : $(install_includes_dependencies) $(cmt_build_library_linksstamp) $(use_requirements)
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_install_includes) ] || \
	  [ ! -f $(cmt_final_setup_install_includes) ] || \
	  $(not_install_includes_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building install_includes.make"; \
	  $(cmtexe) -tag=$(tags) $(install_includes_extratags) build constituent_config -out=$(cmt_local_install_includes_makefile) install_includes; \
	  fi
endif

else

ifndef QUICK
$(cmt_local_install_includes_makefile) : $(install_includes_dependencies) build_library_links
	$(echo) "(constituents.make) Building install_includes.make"; \
	  $(cmtexe) -f=$(bin)install_includes.in -tag=$(tags) $(install_includes_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_install_includes_makefile) install_includes
else
$(cmt_local_install_includes_makefile) : $(install_includes_dependencies) $(cmt_build_library_linksstamp) $(bin)install_includes.in
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_install_includes) ] || \
	  [ ! -f $(cmt_final_setup_install_includes) ] || \
	  $(not_install_includes_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building install_includes.make"; \
	  $(cmtexe) -f=$(bin)install_includes.in -tag=$(tags) $(install_includes_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_install_includes_makefile) install_includes; \
	  fi
endif

endif

#	  $(cmtexe) -tag=$(tags) $(install_includes_extratags) build constituent_makefile -out=$(cmt_local_install_includes_makefile) install_includes

install_includes :: $(install_includes_dependencies) $(cmt_local_install_includes_makefile) dirs install_includesdirs
	$(echo) "(constituents.make) Starting install_includes"
	@if test -f $(cmt_local_install_includes_makefile); then \
	  $(MAKE) -f $(cmt_local_install_includes_makefile) install_includes; \
	  fi
#	@$(MAKE) -f $(cmt_local_install_includes_makefile) install_includes
	$(echo) "(constituents.make) install_includes done"

clean :: install_includesclean

install_includesclean :: $(install_includesclean_dependencies) ##$(cmt_local_install_includes_makefile)
	$(echo) "(constituents.make) Starting install_includesclean"
	@-if test -f $(cmt_local_install_includes_makefile); then \
	  $(MAKE) -f $(cmt_local_install_includes_makefile) install_includesclean; \
	fi
	$(echo) "(constituents.make) install_includesclean done"
#	@-$(MAKE) -f $(cmt_local_install_includes_makefile) install_includesclean

##	  /bin/rm -f $(cmt_local_install_includes_makefile) $(bin)install_includes_dependencies.make

install :: install_includesinstall

install_includesinstall :: $(install_includes_dependencies) $(cmt_local_install_includes_makefile)
	$(echo) "(constituents.make) Starting install install_includes"
	@-$(MAKE) -f $(cmt_local_install_includes_makefile) install
	$(echo) "(constituents.make) install install_includes done"

uninstall : install_includesuninstall

$(foreach d,$(install_includes_dependencies),$(eval $(d)uninstall_dependencies += install_includesuninstall))

install_includesuninstall : $(install_includesuninstall_dependencies) ##$(cmt_local_install_includes_makefile)
	$(echo) "(constituents.make) Starting uninstall install_includes"
	@if test -f $(cmt_local_install_includes_makefile); then \
	  $(MAKE) -f $(cmt_local_install_includes_makefile) uninstall; \
	  fi
#	@$(MAKE) -f $(cmt_local_install_includes_makefile) uninstall
	$(echo) "(constituents.make) uninstall install_includes done"

remove_library_links :: install_includesuninstall

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(constituents.make) Starting $@ install_includes"
	$(echo) Using default action for $@
	$(echo) "(constituents.make) $@ install_includes done"
endif

#-- end of constituent ------
#-- start of constituent ------

cmt_make_has_no_target_tag = 1

#--------------------------------------------------------

ifdef cmt_make_has_target_tag

#cmt_local_tagfile_make = $(EmcRec_tag)_make.make
cmt_local_tagfile_make = $(bin)$(EmcRec_tag)_make.make
cmt_local_setup_make = $(bin)setup_make$$$$.make
cmt_final_setup_make = $(bin)setup_make.make
#cmt_final_setup_make = $(bin)EmcRec_makesetup.make
cmt_local_make_makefile = $(bin)make.make

make_extratags = -tag_add=target_make

#$(cmt_local_tagfile_make) : $(cmt_lock_setup)
ifndef QUICK
$(cmt_local_tagfile_make) ::
else
$(cmt_local_tagfile_make) :
endif
	$(echo) "(constituents.make) Rebuilding $@"; \
	  if test -f $(cmt_local_tagfile_make); then /bin/rm -f $(cmt_local_tagfile_make); fi ; \
	  $(cmtexe) -tag=$(tags) $(make_extratags) build tag_makefile >>$(cmt_local_tagfile_make)
	$(echo) "(constituents.make) Rebuilding $(cmt_final_setup_make)"; \
	  test ! -f $(cmt_local_setup_make) || \rm -f $(cmt_local_setup_make); \
	  trap '\rm -f $(cmt_local_setup_make)' 0 1 2 15; \
	  $(cmtexe) -tag=$(tags) $(make_extratags) show setup >$(cmt_local_setup_make) && \
	  if [ -f $(cmt_final_setup_make) ] && \
	    \cmp -s $(cmt_final_setup_make) $(cmt_local_setup_make); then \
	    \rm $(cmt_local_setup_make); else \
	    \mv -f $(cmt_local_setup_make) $(cmt_final_setup_make); fi

else

#cmt_local_tagfile_make = $(EmcRec_tag).make
cmt_local_tagfile_make = $(bin)$(EmcRec_tag).make
cmt_final_setup_make = $(bin)setup.make
#cmt_final_setup_make = $(bin)EmcRecsetup.make
cmt_local_make_makefile = $(bin)make.make

endif

not_make_dependencies = { n=0; for p in $?; do m=0; for d in $(make_dependencies); do if [ $$p = $$d ]; then m=1; break; fi; done; if [ $$m -eq 0 ]; then n=1; break; fi; done; [ $$n -eq 1 ]; }

ifdef STRUCTURED_OUTPUT
makedirs :
	@if test ! -d $(bin)make; then $(mkdir) -p $(bin)make; fi
	$(echo) "STRUCTURED_OUTPUT="$(bin)make
else
makedirs : ;
endif

#ifndef QUICK
#ifdef STRUCTURED_OUTPUT
# makedirs ::
#	@if test ! -d $(bin)make; then $(mkdir) -p $(bin)make; fi
#	$(echo) "STRUCTURED_OUTPUT="$(bin)make
#
#$(cmt_local_make_makefile) :: $(make_dependencies) $(cmt_local_tagfile_make) build_library_links dirs makedirs
#else
#$(cmt_local_make_makefile) :: $(make_dependencies) $(cmt_local_tagfile_make) build_library_links dirs
#endif
#else
#$(cmt_local_make_makefile) :: $(cmt_local_tagfile_make)
#endif

ifdef cmt_make_has_target_tag

ifndef QUICK
$(cmt_local_make_makefile) : $(make_dependencies) build_library_links
	$(echo) "(constituents.make) Building make.make"; \
	  $(cmtexe) -tag=$(tags) $(make_extratags) build constituent_config -out=$(cmt_local_make_makefile) make
else
$(cmt_local_make_makefile) : $(make_dependencies) $(cmt_build_library_linksstamp) $(use_requirements)
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_make) ] || \
	  [ ! -f $(cmt_final_setup_make) ] || \
	  $(not_make_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building make.make"; \
	  $(cmtexe) -tag=$(tags) $(make_extratags) build constituent_config -out=$(cmt_local_make_makefile) make; \
	  fi
endif

else

ifndef QUICK
$(cmt_local_make_makefile) : $(make_dependencies) build_library_links
	$(echo) "(constituents.make) Building make.make"; \
	  $(cmtexe) -f=$(bin)make.in -tag=$(tags) $(make_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_make_makefile) make
else
$(cmt_local_make_makefile) : $(make_dependencies) $(cmt_build_library_linksstamp) $(bin)make.in
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_make) ] || \
	  [ ! -f $(cmt_final_setup_make) ] || \
	  $(not_make_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building make.make"; \
	  $(cmtexe) -f=$(bin)make.in -tag=$(tags) $(make_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_make_makefile) make; \
	  fi
endif

endif

#	  $(cmtexe) -tag=$(tags) $(make_extratags) build constituent_makefile -out=$(cmt_local_make_makefile) make

make :: $(make_dependencies) $(cmt_local_make_makefile) dirs makedirs
	$(echo) "(constituents.make) Starting make"
	@if test -f $(cmt_local_make_makefile); then \
	  $(MAKE) -f $(cmt_local_make_makefile) make; \
	  fi
#	@$(MAKE) -f $(cmt_local_make_makefile) make
	$(echo) "(constituents.make) make done"

clean :: makeclean

makeclean :: $(makeclean_dependencies) ##$(cmt_local_make_makefile)
	$(echo) "(constituents.make) Starting makeclean"
	@-if test -f $(cmt_local_make_makefile); then \
	  $(MAKE) -f $(cmt_local_make_makefile) makeclean; \
	fi
	$(echo) "(constituents.make) makeclean done"
#	@-$(MAKE) -f $(cmt_local_make_makefile) makeclean

##	  /bin/rm -f $(cmt_local_make_makefile) $(bin)make_dependencies.make

install :: makeinstall

makeinstall :: $(make_dependencies) $(cmt_local_make_makefile)
	$(echo) "(constituents.make) Starting install make"
	@-$(MAKE) -f $(cmt_local_make_makefile) install
	$(echo) "(constituents.make) install make done"

uninstall : makeuninstall

$(foreach d,$(make_dependencies),$(eval $(d)uninstall_dependencies += makeuninstall))

makeuninstall : $(makeuninstall_dependencies) ##$(cmt_local_make_makefile)
	$(echo) "(constituents.make) Starting uninstall make"
	@if test -f $(cmt_local_make_makefile); then \
	  $(MAKE) -f $(cmt_local_make_makefile) uninstall; \
	  fi
#	@$(MAKE) -f $(cmt_local_make_makefile) uninstall
	$(echo) "(constituents.make) uninstall make done"

remove_library_links :: makeuninstall

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(constituents.make) Starting $@ make"
	$(echo) Using default action for $@
	$(echo) "(constituents.make) $@ make done"
endif

#-- end of constituent ------
#-- start of constituent ------

cmt_CompilePython_has_no_target_tag = 1

#--------------------------------------------------------

ifdef cmt_CompilePython_has_target_tag

#cmt_local_tagfile_CompilePython = $(EmcRec_tag)_CompilePython.make
cmt_local_tagfile_CompilePython = $(bin)$(EmcRec_tag)_CompilePython.make
cmt_local_setup_CompilePython = $(bin)setup_CompilePython$$$$.make
cmt_final_setup_CompilePython = $(bin)setup_CompilePython.make
#cmt_final_setup_CompilePython = $(bin)EmcRec_CompilePythonsetup.make
cmt_local_CompilePython_makefile = $(bin)CompilePython.make

CompilePython_extratags = -tag_add=target_CompilePython

#$(cmt_local_tagfile_CompilePython) : $(cmt_lock_setup)
ifndef QUICK
$(cmt_local_tagfile_CompilePython) ::
else
$(cmt_local_tagfile_CompilePython) :
endif
	$(echo) "(constituents.make) Rebuilding $@"; \
	  if test -f $(cmt_local_tagfile_CompilePython); then /bin/rm -f $(cmt_local_tagfile_CompilePython); fi ; \
	  $(cmtexe) -tag=$(tags) $(CompilePython_extratags) build tag_makefile >>$(cmt_local_tagfile_CompilePython)
	$(echo) "(constituents.make) Rebuilding $(cmt_final_setup_CompilePython)"; \
	  test ! -f $(cmt_local_setup_CompilePython) || \rm -f $(cmt_local_setup_CompilePython); \
	  trap '\rm -f $(cmt_local_setup_CompilePython)' 0 1 2 15; \
	  $(cmtexe) -tag=$(tags) $(CompilePython_extratags) show setup >$(cmt_local_setup_CompilePython) && \
	  if [ -f $(cmt_final_setup_CompilePython) ] && \
	    \cmp -s $(cmt_final_setup_CompilePython) $(cmt_local_setup_CompilePython); then \
	    \rm $(cmt_local_setup_CompilePython); else \
	    \mv -f $(cmt_local_setup_CompilePython) $(cmt_final_setup_CompilePython); fi

else

#cmt_local_tagfile_CompilePython = $(EmcRec_tag).make
cmt_local_tagfile_CompilePython = $(bin)$(EmcRec_tag).make
cmt_final_setup_CompilePython = $(bin)setup.make
#cmt_final_setup_CompilePython = $(bin)EmcRecsetup.make
cmt_local_CompilePython_makefile = $(bin)CompilePython.make

endif

not_CompilePython_dependencies = { n=0; for p in $?; do m=0; for d in $(CompilePython_dependencies); do if [ $$p = $$d ]; then m=1; break; fi; done; if [ $$m -eq 0 ]; then n=1; break; fi; done; [ $$n -eq 1 ]; }

ifdef STRUCTURED_OUTPUT
CompilePythondirs :
	@if test ! -d $(bin)CompilePython; then $(mkdir) -p $(bin)CompilePython; fi
	$(echo) "STRUCTURED_OUTPUT="$(bin)CompilePython
else
CompilePythondirs : ;
endif

#ifndef QUICK
#ifdef STRUCTURED_OUTPUT
# CompilePythondirs ::
#	@if test ! -d $(bin)CompilePython; then $(mkdir) -p $(bin)CompilePython; fi
#	$(echo) "STRUCTURED_OUTPUT="$(bin)CompilePython
#
#$(cmt_local_CompilePython_makefile) :: $(CompilePython_dependencies) $(cmt_local_tagfile_CompilePython) build_library_links dirs CompilePythondirs
#else
#$(cmt_local_CompilePython_makefile) :: $(CompilePython_dependencies) $(cmt_local_tagfile_CompilePython) build_library_links dirs
#endif
#else
#$(cmt_local_CompilePython_makefile) :: $(cmt_local_tagfile_CompilePython)
#endif

ifdef cmt_CompilePython_has_target_tag

ifndef QUICK
$(cmt_local_CompilePython_makefile) : $(CompilePython_dependencies) build_library_links
	$(echo) "(constituents.make) Building CompilePython.make"; \
	  $(cmtexe) -tag=$(tags) $(CompilePython_extratags) build constituent_config -out=$(cmt_local_CompilePython_makefile) CompilePython
else
$(cmt_local_CompilePython_makefile) : $(CompilePython_dependencies) $(cmt_build_library_linksstamp) $(use_requirements)
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_CompilePython) ] || \
	  [ ! -f $(cmt_final_setup_CompilePython) ] || \
	  $(not_CompilePython_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building CompilePython.make"; \
	  $(cmtexe) -tag=$(tags) $(CompilePython_extratags) build constituent_config -out=$(cmt_local_CompilePython_makefile) CompilePython; \
	  fi
endif

else

ifndef QUICK
$(cmt_local_CompilePython_makefile) : $(CompilePython_dependencies) build_library_links
	$(echo) "(constituents.make) Building CompilePython.make"; \
	  $(cmtexe) -f=$(bin)CompilePython.in -tag=$(tags) $(CompilePython_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_CompilePython_makefile) CompilePython
else
$(cmt_local_CompilePython_makefile) : $(CompilePython_dependencies) $(cmt_build_library_linksstamp) $(bin)CompilePython.in
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_CompilePython) ] || \
	  [ ! -f $(cmt_final_setup_CompilePython) ] || \
	  $(not_CompilePython_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building CompilePython.make"; \
	  $(cmtexe) -f=$(bin)CompilePython.in -tag=$(tags) $(CompilePython_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_CompilePython_makefile) CompilePython; \
	  fi
endif

endif

#	  $(cmtexe) -tag=$(tags) $(CompilePython_extratags) build constituent_makefile -out=$(cmt_local_CompilePython_makefile) CompilePython

CompilePython :: $(CompilePython_dependencies) $(cmt_local_CompilePython_makefile) dirs CompilePythondirs
	$(echo) "(constituents.make) Starting CompilePython"
	@if test -f $(cmt_local_CompilePython_makefile); then \
	  $(MAKE) -f $(cmt_local_CompilePython_makefile) CompilePython; \
	  fi
#	@$(MAKE) -f $(cmt_local_CompilePython_makefile) CompilePython
	$(echo) "(constituents.make) CompilePython done"

clean :: CompilePythonclean

CompilePythonclean :: $(CompilePythonclean_dependencies) ##$(cmt_local_CompilePython_makefile)
	$(echo) "(constituents.make) Starting CompilePythonclean"
	@-if test -f $(cmt_local_CompilePython_makefile); then \
	  $(MAKE) -f $(cmt_local_CompilePython_makefile) CompilePythonclean; \
	fi
	$(echo) "(constituents.make) CompilePythonclean done"
#	@-$(MAKE) -f $(cmt_local_CompilePython_makefile) CompilePythonclean

##	  /bin/rm -f $(cmt_local_CompilePython_makefile) $(bin)CompilePython_dependencies.make

install :: CompilePythoninstall

CompilePythoninstall :: $(CompilePython_dependencies) $(cmt_local_CompilePython_makefile)
	$(echo) "(constituents.make) Starting install CompilePython"
	@-$(MAKE) -f $(cmt_local_CompilePython_makefile) install
	$(echo) "(constituents.make) install CompilePython done"

uninstall : CompilePythonuninstall

$(foreach d,$(CompilePython_dependencies),$(eval $(d)uninstall_dependencies += CompilePythonuninstall))

CompilePythonuninstall : $(CompilePythonuninstall_dependencies) ##$(cmt_local_CompilePython_makefile)
	$(echo) "(constituents.make) Starting uninstall CompilePython"
	@if test -f $(cmt_local_CompilePython_makefile); then \
	  $(MAKE) -f $(cmt_local_CompilePython_makefile) uninstall; \
	  fi
#	@$(MAKE) -f $(cmt_local_CompilePython_makefile) uninstall
	$(echo) "(constituents.make) uninstall CompilePython done"

remove_library_links :: CompilePythonuninstall

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(constituents.make) Starting $@ CompilePython"
	$(echo) Using default action for $@
	$(echo) "(constituents.make) $@ CompilePython done"
endif

#-- end of constituent ------
#-- start of constituent ------

cmt_qmtest_run_has_no_target_tag = 1

#--------------------------------------------------------

ifdef cmt_qmtest_run_has_target_tag

#cmt_local_tagfile_qmtest_run = $(EmcRec_tag)_qmtest_run.make
cmt_local_tagfile_qmtest_run = $(bin)$(EmcRec_tag)_qmtest_run.make
cmt_local_setup_qmtest_run = $(bin)setup_qmtest_run$$$$.make
cmt_final_setup_qmtest_run = $(bin)setup_qmtest_run.make
#cmt_final_setup_qmtest_run = $(bin)EmcRec_qmtest_runsetup.make
cmt_local_qmtest_run_makefile = $(bin)qmtest_run.make

qmtest_run_extratags = -tag_add=target_qmtest_run

#$(cmt_local_tagfile_qmtest_run) : $(cmt_lock_setup)
ifndef QUICK
$(cmt_local_tagfile_qmtest_run) ::
else
$(cmt_local_tagfile_qmtest_run) :
endif
	$(echo) "(constituents.make) Rebuilding $@"; \
	  if test -f $(cmt_local_tagfile_qmtest_run); then /bin/rm -f $(cmt_local_tagfile_qmtest_run); fi ; \
	  $(cmtexe) -tag=$(tags) $(qmtest_run_extratags) build tag_makefile >>$(cmt_local_tagfile_qmtest_run)
	$(echo) "(constituents.make) Rebuilding $(cmt_final_setup_qmtest_run)"; \
	  test ! -f $(cmt_local_setup_qmtest_run) || \rm -f $(cmt_local_setup_qmtest_run); \
	  trap '\rm -f $(cmt_local_setup_qmtest_run)' 0 1 2 15; \
	  $(cmtexe) -tag=$(tags) $(qmtest_run_extratags) show setup >$(cmt_local_setup_qmtest_run) && \
	  if [ -f $(cmt_final_setup_qmtest_run) ] && \
	    \cmp -s $(cmt_final_setup_qmtest_run) $(cmt_local_setup_qmtest_run); then \
	    \rm $(cmt_local_setup_qmtest_run); else \
	    \mv -f $(cmt_local_setup_qmtest_run) $(cmt_final_setup_qmtest_run); fi

else

#cmt_local_tagfile_qmtest_run = $(EmcRec_tag).make
cmt_local_tagfile_qmtest_run = $(bin)$(EmcRec_tag).make
cmt_final_setup_qmtest_run = $(bin)setup.make
#cmt_final_setup_qmtest_run = $(bin)EmcRecsetup.make
cmt_local_qmtest_run_makefile = $(bin)qmtest_run.make

endif

not_qmtest_run_dependencies = { n=0; for p in $?; do m=0; for d in $(qmtest_run_dependencies); do if [ $$p = $$d ]; then m=1; break; fi; done; if [ $$m -eq 0 ]; then n=1; break; fi; done; [ $$n -eq 1 ]; }

ifdef STRUCTURED_OUTPUT
qmtest_rundirs :
	@if test ! -d $(bin)qmtest_run; then $(mkdir) -p $(bin)qmtest_run; fi
	$(echo) "STRUCTURED_OUTPUT="$(bin)qmtest_run
else
qmtest_rundirs : ;
endif

#ifndef QUICK
#ifdef STRUCTURED_OUTPUT
# qmtest_rundirs ::
#	@if test ! -d $(bin)qmtest_run; then $(mkdir) -p $(bin)qmtest_run; fi
#	$(echo) "STRUCTURED_OUTPUT="$(bin)qmtest_run
#
#$(cmt_local_qmtest_run_makefile) :: $(qmtest_run_dependencies) $(cmt_local_tagfile_qmtest_run) build_library_links dirs qmtest_rundirs
#else
#$(cmt_local_qmtest_run_makefile) :: $(qmtest_run_dependencies) $(cmt_local_tagfile_qmtest_run) build_library_links dirs
#endif
#else
#$(cmt_local_qmtest_run_makefile) :: $(cmt_local_tagfile_qmtest_run)
#endif

ifdef cmt_qmtest_run_has_target_tag

ifndef QUICK
$(cmt_local_qmtest_run_makefile) : $(qmtest_run_dependencies) build_library_links
	$(echo) "(constituents.make) Building qmtest_run.make"; \
	  $(cmtexe) -tag=$(tags) $(qmtest_run_extratags) build constituent_config -out=$(cmt_local_qmtest_run_makefile) qmtest_run
else
$(cmt_local_qmtest_run_makefile) : $(qmtest_run_dependencies) $(cmt_build_library_linksstamp) $(use_requirements)
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_qmtest_run) ] || \
	  [ ! -f $(cmt_final_setup_qmtest_run) ] || \
	  $(not_qmtest_run_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building qmtest_run.make"; \
	  $(cmtexe) -tag=$(tags) $(qmtest_run_extratags) build constituent_config -out=$(cmt_local_qmtest_run_makefile) qmtest_run; \
	  fi
endif

else

ifndef QUICK
$(cmt_local_qmtest_run_makefile) : $(qmtest_run_dependencies) build_library_links
	$(echo) "(constituents.make) Building qmtest_run.make"; \
	  $(cmtexe) -f=$(bin)qmtest_run.in -tag=$(tags) $(qmtest_run_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_qmtest_run_makefile) qmtest_run
else
$(cmt_local_qmtest_run_makefile) : $(qmtest_run_dependencies) $(cmt_build_library_linksstamp) $(bin)qmtest_run.in
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_qmtest_run) ] || \
	  [ ! -f $(cmt_final_setup_qmtest_run) ] || \
	  $(not_qmtest_run_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building qmtest_run.make"; \
	  $(cmtexe) -f=$(bin)qmtest_run.in -tag=$(tags) $(qmtest_run_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_qmtest_run_makefile) qmtest_run; \
	  fi
endif

endif

#	  $(cmtexe) -tag=$(tags) $(qmtest_run_extratags) build constituent_makefile -out=$(cmt_local_qmtest_run_makefile) qmtest_run

qmtest_run :: $(qmtest_run_dependencies) $(cmt_local_qmtest_run_makefile) dirs qmtest_rundirs
	$(echo) "(constituents.make) Starting qmtest_run"
	@if test -f $(cmt_local_qmtest_run_makefile); then \
	  $(MAKE) -f $(cmt_local_qmtest_run_makefile) qmtest_run; \
	  fi
#	@$(MAKE) -f $(cmt_local_qmtest_run_makefile) qmtest_run
	$(echo) "(constituents.make) qmtest_run done"

clean :: qmtest_runclean

qmtest_runclean :: $(qmtest_runclean_dependencies) ##$(cmt_local_qmtest_run_makefile)
	$(echo) "(constituents.make) Starting qmtest_runclean"
	@-if test -f $(cmt_local_qmtest_run_makefile); then \
	  $(MAKE) -f $(cmt_local_qmtest_run_makefile) qmtest_runclean; \
	fi
	$(echo) "(constituents.make) qmtest_runclean done"
#	@-$(MAKE) -f $(cmt_local_qmtest_run_makefile) qmtest_runclean

##	  /bin/rm -f $(cmt_local_qmtest_run_makefile) $(bin)qmtest_run_dependencies.make

install :: qmtest_runinstall

qmtest_runinstall :: $(qmtest_run_dependencies) $(cmt_local_qmtest_run_makefile)
	$(echo) "(constituents.make) Starting install qmtest_run"
	@-$(MAKE) -f $(cmt_local_qmtest_run_makefile) install
	$(echo) "(constituents.make) install qmtest_run done"

uninstall : qmtest_rununinstall

$(foreach d,$(qmtest_run_dependencies),$(eval $(d)uninstall_dependencies += qmtest_rununinstall))

qmtest_rununinstall : $(qmtest_rununinstall_dependencies) ##$(cmt_local_qmtest_run_makefile)
	$(echo) "(constituents.make) Starting uninstall qmtest_run"
	@if test -f $(cmt_local_qmtest_run_makefile); then \
	  $(MAKE) -f $(cmt_local_qmtest_run_makefile) uninstall; \
	  fi
#	@$(MAKE) -f $(cmt_local_qmtest_run_makefile) uninstall
	$(echo) "(constituents.make) uninstall qmtest_run done"

remove_library_links :: qmtest_rununinstall

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(constituents.make) Starting $@ qmtest_run"
	$(echo) Using default action for $@
	$(echo) "(constituents.make) $@ qmtest_run done"
endif

#-- end of constituent ------
#-- start of constituent ------

cmt_qmtest_summarize_has_no_target_tag = 1

#--------------------------------------------------------

ifdef cmt_qmtest_summarize_has_target_tag

#cmt_local_tagfile_qmtest_summarize = $(EmcRec_tag)_qmtest_summarize.make
cmt_local_tagfile_qmtest_summarize = $(bin)$(EmcRec_tag)_qmtest_summarize.make
cmt_local_setup_qmtest_summarize = $(bin)setup_qmtest_summarize$$$$.make
cmt_final_setup_qmtest_summarize = $(bin)setup_qmtest_summarize.make
#cmt_final_setup_qmtest_summarize = $(bin)EmcRec_qmtest_summarizesetup.make
cmt_local_qmtest_summarize_makefile = $(bin)qmtest_summarize.make

qmtest_summarize_extratags = -tag_add=target_qmtest_summarize

#$(cmt_local_tagfile_qmtest_summarize) : $(cmt_lock_setup)
ifndef QUICK
$(cmt_local_tagfile_qmtest_summarize) ::
else
$(cmt_local_tagfile_qmtest_summarize) :
endif
	$(echo) "(constituents.make) Rebuilding $@"; \
	  if test -f $(cmt_local_tagfile_qmtest_summarize); then /bin/rm -f $(cmt_local_tagfile_qmtest_summarize); fi ; \
	  $(cmtexe) -tag=$(tags) $(qmtest_summarize_extratags) build tag_makefile >>$(cmt_local_tagfile_qmtest_summarize)
	$(echo) "(constituents.make) Rebuilding $(cmt_final_setup_qmtest_summarize)"; \
	  test ! -f $(cmt_local_setup_qmtest_summarize) || \rm -f $(cmt_local_setup_qmtest_summarize); \
	  trap '\rm -f $(cmt_local_setup_qmtest_summarize)' 0 1 2 15; \
	  $(cmtexe) -tag=$(tags) $(qmtest_summarize_extratags) show setup >$(cmt_local_setup_qmtest_summarize) && \
	  if [ -f $(cmt_final_setup_qmtest_summarize) ] && \
	    \cmp -s $(cmt_final_setup_qmtest_summarize) $(cmt_local_setup_qmtest_summarize); then \
	    \rm $(cmt_local_setup_qmtest_summarize); else \
	    \mv -f $(cmt_local_setup_qmtest_summarize) $(cmt_final_setup_qmtest_summarize); fi

else

#cmt_local_tagfile_qmtest_summarize = $(EmcRec_tag).make
cmt_local_tagfile_qmtest_summarize = $(bin)$(EmcRec_tag).make
cmt_final_setup_qmtest_summarize = $(bin)setup.make
#cmt_final_setup_qmtest_summarize = $(bin)EmcRecsetup.make
cmt_local_qmtest_summarize_makefile = $(bin)qmtest_summarize.make

endif

not_qmtest_summarize_dependencies = { n=0; for p in $?; do m=0; for d in $(qmtest_summarize_dependencies); do if [ $$p = $$d ]; then m=1; break; fi; done; if [ $$m -eq 0 ]; then n=1; break; fi; done; [ $$n -eq 1 ]; }

ifdef STRUCTURED_OUTPUT
qmtest_summarizedirs :
	@if test ! -d $(bin)qmtest_summarize; then $(mkdir) -p $(bin)qmtest_summarize; fi
	$(echo) "STRUCTURED_OUTPUT="$(bin)qmtest_summarize
else
qmtest_summarizedirs : ;
endif

#ifndef QUICK
#ifdef STRUCTURED_OUTPUT
# qmtest_summarizedirs ::
#	@if test ! -d $(bin)qmtest_summarize; then $(mkdir) -p $(bin)qmtest_summarize; fi
#	$(echo) "STRUCTURED_OUTPUT="$(bin)qmtest_summarize
#
#$(cmt_local_qmtest_summarize_makefile) :: $(qmtest_summarize_dependencies) $(cmt_local_tagfile_qmtest_summarize) build_library_links dirs qmtest_summarizedirs
#else
#$(cmt_local_qmtest_summarize_makefile) :: $(qmtest_summarize_dependencies) $(cmt_local_tagfile_qmtest_summarize) build_library_links dirs
#endif
#else
#$(cmt_local_qmtest_summarize_makefile) :: $(cmt_local_tagfile_qmtest_summarize)
#endif

ifdef cmt_qmtest_summarize_has_target_tag

ifndef QUICK
$(cmt_local_qmtest_summarize_makefile) : $(qmtest_summarize_dependencies) build_library_links
	$(echo) "(constituents.make) Building qmtest_summarize.make"; \
	  $(cmtexe) -tag=$(tags) $(qmtest_summarize_extratags) build constituent_config -out=$(cmt_local_qmtest_summarize_makefile) qmtest_summarize
else
$(cmt_local_qmtest_summarize_makefile) : $(qmtest_summarize_dependencies) $(cmt_build_library_linksstamp) $(use_requirements)
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_qmtest_summarize) ] || \
	  [ ! -f $(cmt_final_setup_qmtest_summarize) ] || \
	  $(not_qmtest_summarize_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building qmtest_summarize.make"; \
	  $(cmtexe) -tag=$(tags) $(qmtest_summarize_extratags) build constituent_config -out=$(cmt_local_qmtest_summarize_makefile) qmtest_summarize; \
	  fi
endif

else

ifndef QUICK
$(cmt_local_qmtest_summarize_makefile) : $(qmtest_summarize_dependencies) build_library_links
	$(echo) "(constituents.make) Building qmtest_summarize.make"; \
	  $(cmtexe) -f=$(bin)qmtest_summarize.in -tag=$(tags) $(qmtest_summarize_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_qmtest_summarize_makefile) qmtest_summarize
else
$(cmt_local_qmtest_summarize_makefile) : $(qmtest_summarize_dependencies) $(cmt_build_library_linksstamp) $(bin)qmtest_summarize.in
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_qmtest_summarize) ] || \
	  [ ! -f $(cmt_final_setup_qmtest_summarize) ] || \
	  $(not_qmtest_summarize_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building qmtest_summarize.make"; \
	  $(cmtexe) -f=$(bin)qmtest_summarize.in -tag=$(tags) $(qmtest_summarize_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_qmtest_summarize_makefile) qmtest_summarize; \
	  fi
endif

endif

#	  $(cmtexe) -tag=$(tags) $(qmtest_summarize_extratags) build constituent_makefile -out=$(cmt_local_qmtest_summarize_makefile) qmtest_summarize

qmtest_summarize :: $(qmtest_summarize_dependencies) $(cmt_local_qmtest_summarize_makefile) dirs qmtest_summarizedirs
	$(echo) "(constituents.make) Starting qmtest_summarize"
	@if test -f $(cmt_local_qmtest_summarize_makefile); then \
	  $(MAKE) -f $(cmt_local_qmtest_summarize_makefile) qmtest_summarize; \
	  fi
#	@$(MAKE) -f $(cmt_local_qmtest_summarize_makefile) qmtest_summarize
	$(echo) "(constituents.make) qmtest_summarize done"

clean :: qmtest_summarizeclean

qmtest_summarizeclean :: $(qmtest_summarizeclean_dependencies) ##$(cmt_local_qmtest_summarize_makefile)
	$(echo) "(constituents.make) Starting qmtest_summarizeclean"
	@-if test -f $(cmt_local_qmtest_summarize_makefile); then \
	  $(MAKE) -f $(cmt_local_qmtest_summarize_makefile) qmtest_summarizeclean; \
	fi
	$(echo) "(constituents.make) qmtest_summarizeclean done"
#	@-$(MAKE) -f $(cmt_local_qmtest_summarize_makefile) qmtest_summarizeclean

##	  /bin/rm -f $(cmt_local_qmtest_summarize_makefile) $(bin)qmtest_summarize_dependencies.make

install :: qmtest_summarizeinstall

qmtest_summarizeinstall :: $(qmtest_summarize_dependencies) $(cmt_local_qmtest_summarize_makefile)
	$(echo) "(constituents.make) Starting install qmtest_summarize"
	@-$(MAKE) -f $(cmt_local_qmtest_summarize_makefile) install
	$(echo) "(constituents.make) install qmtest_summarize done"

uninstall : qmtest_summarizeuninstall

$(foreach d,$(qmtest_summarize_dependencies),$(eval $(d)uninstall_dependencies += qmtest_summarizeuninstall))

qmtest_summarizeuninstall : $(qmtest_summarizeuninstall_dependencies) ##$(cmt_local_qmtest_summarize_makefile)
	$(echo) "(constituents.make) Starting uninstall qmtest_summarize"
	@if test -f $(cmt_local_qmtest_summarize_makefile); then \
	  $(MAKE) -f $(cmt_local_qmtest_summarize_makefile) uninstall; \
	  fi
#	@$(MAKE) -f $(cmt_local_qmtest_summarize_makefile) uninstall
	$(echo) "(constituents.make) uninstall qmtest_summarize done"

remove_library_links :: qmtest_summarizeuninstall

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(constituents.make) Starting $@ qmtest_summarize"
	$(echo) Using default action for $@
	$(echo) "(constituents.make) $@ qmtest_summarize done"
endif

#-- end of constituent ------
#-- start of constituent ------

cmt_TestPackage_has_no_target_tag = 1

#--------------------------------------------------------

ifdef cmt_TestPackage_has_target_tag

#cmt_local_tagfile_TestPackage = $(EmcRec_tag)_TestPackage.make
cmt_local_tagfile_TestPackage = $(bin)$(EmcRec_tag)_TestPackage.make
cmt_local_setup_TestPackage = $(bin)setup_TestPackage$$$$.make
cmt_final_setup_TestPackage = $(bin)setup_TestPackage.make
#cmt_final_setup_TestPackage = $(bin)EmcRec_TestPackagesetup.make
cmt_local_TestPackage_makefile = $(bin)TestPackage.make

TestPackage_extratags = -tag_add=target_TestPackage

#$(cmt_local_tagfile_TestPackage) : $(cmt_lock_setup)
ifndef QUICK
$(cmt_local_tagfile_TestPackage) ::
else
$(cmt_local_tagfile_TestPackage) :
endif
	$(echo) "(constituents.make) Rebuilding $@"; \
	  if test -f $(cmt_local_tagfile_TestPackage); then /bin/rm -f $(cmt_local_tagfile_TestPackage); fi ; \
	  $(cmtexe) -tag=$(tags) $(TestPackage_extratags) build tag_makefile >>$(cmt_local_tagfile_TestPackage)
	$(echo) "(constituents.make) Rebuilding $(cmt_final_setup_TestPackage)"; \
	  test ! -f $(cmt_local_setup_TestPackage) || \rm -f $(cmt_local_setup_TestPackage); \
	  trap '\rm -f $(cmt_local_setup_TestPackage)' 0 1 2 15; \
	  $(cmtexe) -tag=$(tags) $(TestPackage_extratags) show setup >$(cmt_local_setup_TestPackage) && \
	  if [ -f $(cmt_final_setup_TestPackage) ] && \
	    \cmp -s $(cmt_final_setup_TestPackage) $(cmt_local_setup_TestPackage); then \
	    \rm $(cmt_local_setup_TestPackage); else \
	    \mv -f $(cmt_local_setup_TestPackage) $(cmt_final_setup_TestPackage); fi

else

#cmt_local_tagfile_TestPackage = $(EmcRec_tag).make
cmt_local_tagfile_TestPackage = $(bin)$(EmcRec_tag).make
cmt_final_setup_TestPackage = $(bin)setup.make
#cmt_final_setup_TestPackage = $(bin)EmcRecsetup.make
cmt_local_TestPackage_makefile = $(bin)TestPackage.make

endif

not_TestPackage_dependencies = { n=0; for p in $?; do m=0; for d in $(TestPackage_dependencies); do if [ $$p = $$d ]; then m=1; break; fi; done; if [ $$m -eq 0 ]; then n=1; break; fi; done; [ $$n -eq 1 ]; }

ifdef STRUCTURED_OUTPUT
TestPackagedirs :
	@if test ! -d $(bin)TestPackage; then $(mkdir) -p $(bin)TestPackage; fi
	$(echo) "STRUCTURED_OUTPUT="$(bin)TestPackage
else
TestPackagedirs : ;
endif

#ifndef QUICK
#ifdef STRUCTURED_OUTPUT
# TestPackagedirs ::
#	@if test ! -d $(bin)TestPackage; then $(mkdir) -p $(bin)TestPackage; fi
#	$(echo) "STRUCTURED_OUTPUT="$(bin)TestPackage
#
#$(cmt_local_TestPackage_makefile) :: $(TestPackage_dependencies) $(cmt_local_tagfile_TestPackage) build_library_links dirs TestPackagedirs
#else
#$(cmt_local_TestPackage_makefile) :: $(TestPackage_dependencies) $(cmt_local_tagfile_TestPackage) build_library_links dirs
#endif
#else
#$(cmt_local_TestPackage_makefile) :: $(cmt_local_tagfile_TestPackage)
#endif

ifdef cmt_TestPackage_has_target_tag

ifndef QUICK
$(cmt_local_TestPackage_makefile) : $(TestPackage_dependencies) build_library_links
	$(echo) "(constituents.make) Building TestPackage.make"; \
	  $(cmtexe) -tag=$(tags) $(TestPackage_extratags) build constituent_config -out=$(cmt_local_TestPackage_makefile) TestPackage
else
$(cmt_local_TestPackage_makefile) : $(TestPackage_dependencies) $(cmt_build_library_linksstamp) $(use_requirements)
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_TestPackage) ] || \
	  [ ! -f $(cmt_final_setup_TestPackage) ] || \
	  $(not_TestPackage_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building TestPackage.make"; \
	  $(cmtexe) -tag=$(tags) $(TestPackage_extratags) build constituent_config -out=$(cmt_local_TestPackage_makefile) TestPackage; \
	  fi
endif

else

ifndef QUICK
$(cmt_local_TestPackage_makefile) : $(TestPackage_dependencies) build_library_links
	$(echo) "(constituents.make) Building TestPackage.make"; \
	  $(cmtexe) -f=$(bin)TestPackage.in -tag=$(tags) $(TestPackage_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_TestPackage_makefile) TestPackage
else
$(cmt_local_TestPackage_makefile) : $(TestPackage_dependencies) $(cmt_build_library_linksstamp) $(bin)TestPackage.in
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_TestPackage) ] || \
	  [ ! -f $(cmt_final_setup_TestPackage) ] || \
	  $(not_TestPackage_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building TestPackage.make"; \
	  $(cmtexe) -f=$(bin)TestPackage.in -tag=$(tags) $(TestPackage_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_TestPackage_makefile) TestPackage; \
	  fi
endif

endif

#	  $(cmtexe) -tag=$(tags) $(TestPackage_extratags) build constituent_makefile -out=$(cmt_local_TestPackage_makefile) TestPackage

TestPackage :: $(TestPackage_dependencies) $(cmt_local_TestPackage_makefile) dirs TestPackagedirs
	$(echo) "(constituents.make) Starting TestPackage"
	@if test -f $(cmt_local_TestPackage_makefile); then \
	  $(MAKE) -f $(cmt_local_TestPackage_makefile) TestPackage; \
	  fi
#	@$(MAKE) -f $(cmt_local_TestPackage_makefile) TestPackage
	$(echo) "(constituents.make) TestPackage done"

clean :: TestPackageclean

TestPackageclean :: $(TestPackageclean_dependencies) ##$(cmt_local_TestPackage_makefile)
	$(echo) "(constituents.make) Starting TestPackageclean"
	@-if test -f $(cmt_local_TestPackage_makefile); then \
	  $(MAKE) -f $(cmt_local_TestPackage_makefile) TestPackageclean; \
	fi
	$(echo) "(constituents.make) TestPackageclean done"
#	@-$(MAKE) -f $(cmt_local_TestPackage_makefile) TestPackageclean

##	  /bin/rm -f $(cmt_local_TestPackage_makefile) $(bin)TestPackage_dependencies.make

install :: TestPackageinstall

TestPackageinstall :: $(TestPackage_dependencies) $(cmt_local_TestPackage_makefile)
	$(echo) "(constituents.make) Starting install TestPackage"
	@-$(MAKE) -f $(cmt_local_TestPackage_makefile) install
	$(echo) "(constituents.make) install TestPackage done"

uninstall : TestPackageuninstall

$(foreach d,$(TestPackage_dependencies),$(eval $(d)uninstall_dependencies += TestPackageuninstall))

TestPackageuninstall : $(TestPackageuninstall_dependencies) ##$(cmt_local_TestPackage_makefile)
	$(echo) "(constituents.make) Starting uninstall TestPackage"
	@if test -f $(cmt_local_TestPackage_makefile); then \
	  $(MAKE) -f $(cmt_local_TestPackage_makefile) uninstall; \
	  fi
#	@$(MAKE) -f $(cmt_local_TestPackage_makefile) uninstall
	$(echo) "(constituents.make) uninstall TestPackage done"

remove_library_links :: TestPackageuninstall

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(constituents.make) Starting $@ TestPackage"
	$(echo) Using default action for $@
	$(echo) "(constituents.make) $@ TestPackage done"
endif

#-- end of constituent ------
#-- start of constituent ------

cmt_TestProject_has_no_target_tag = 1

#--------------------------------------------------------

ifdef cmt_TestProject_has_target_tag

#cmt_local_tagfile_TestProject = $(EmcRec_tag)_TestProject.make
cmt_local_tagfile_TestProject = $(bin)$(EmcRec_tag)_TestProject.make
cmt_local_setup_TestProject = $(bin)setup_TestProject$$$$.make
cmt_final_setup_TestProject = $(bin)setup_TestProject.make
#cmt_final_setup_TestProject = $(bin)EmcRec_TestProjectsetup.make
cmt_local_TestProject_makefile = $(bin)TestProject.make

TestProject_extratags = -tag_add=target_TestProject

#$(cmt_local_tagfile_TestProject) : $(cmt_lock_setup)
ifndef QUICK
$(cmt_local_tagfile_TestProject) ::
else
$(cmt_local_tagfile_TestProject) :
endif
	$(echo) "(constituents.make) Rebuilding $@"; \
	  if test -f $(cmt_local_tagfile_TestProject); then /bin/rm -f $(cmt_local_tagfile_TestProject); fi ; \
	  $(cmtexe) -tag=$(tags) $(TestProject_extratags) build tag_makefile >>$(cmt_local_tagfile_TestProject)
	$(echo) "(constituents.make) Rebuilding $(cmt_final_setup_TestProject)"; \
	  test ! -f $(cmt_local_setup_TestProject) || \rm -f $(cmt_local_setup_TestProject); \
	  trap '\rm -f $(cmt_local_setup_TestProject)' 0 1 2 15; \
	  $(cmtexe) -tag=$(tags) $(TestProject_extratags) show setup >$(cmt_local_setup_TestProject) && \
	  if [ -f $(cmt_final_setup_TestProject) ] && \
	    \cmp -s $(cmt_final_setup_TestProject) $(cmt_local_setup_TestProject); then \
	    \rm $(cmt_local_setup_TestProject); else \
	    \mv -f $(cmt_local_setup_TestProject) $(cmt_final_setup_TestProject); fi

else

#cmt_local_tagfile_TestProject = $(EmcRec_tag).make
cmt_local_tagfile_TestProject = $(bin)$(EmcRec_tag).make
cmt_final_setup_TestProject = $(bin)setup.make
#cmt_final_setup_TestProject = $(bin)EmcRecsetup.make
cmt_local_TestProject_makefile = $(bin)TestProject.make

endif

not_TestProject_dependencies = { n=0; for p in $?; do m=0; for d in $(TestProject_dependencies); do if [ $$p = $$d ]; then m=1; break; fi; done; if [ $$m -eq 0 ]; then n=1; break; fi; done; [ $$n -eq 1 ]; }

ifdef STRUCTURED_OUTPUT
TestProjectdirs :
	@if test ! -d $(bin)TestProject; then $(mkdir) -p $(bin)TestProject; fi
	$(echo) "STRUCTURED_OUTPUT="$(bin)TestProject
else
TestProjectdirs : ;
endif

#ifndef QUICK
#ifdef STRUCTURED_OUTPUT
# TestProjectdirs ::
#	@if test ! -d $(bin)TestProject; then $(mkdir) -p $(bin)TestProject; fi
#	$(echo) "STRUCTURED_OUTPUT="$(bin)TestProject
#
#$(cmt_local_TestProject_makefile) :: $(TestProject_dependencies) $(cmt_local_tagfile_TestProject) build_library_links dirs TestProjectdirs
#else
#$(cmt_local_TestProject_makefile) :: $(TestProject_dependencies) $(cmt_local_tagfile_TestProject) build_library_links dirs
#endif
#else
#$(cmt_local_TestProject_makefile) :: $(cmt_local_tagfile_TestProject)
#endif

ifdef cmt_TestProject_has_target_tag

ifndef QUICK
$(cmt_local_TestProject_makefile) : $(TestProject_dependencies) build_library_links
	$(echo) "(constituents.make) Building TestProject.make"; \
	  $(cmtexe) -tag=$(tags) $(TestProject_extratags) build constituent_config -out=$(cmt_local_TestProject_makefile) TestProject
else
$(cmt_local_TestProject_makefile) : $(TestProject_dependencies) $(cmt_build_library_linksstamp) $(use_requirements)
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_TestProject) ] || \
	  [ ! -f $(cmt_final_setup_TestProject) ] || \
	  $(not_TestProject_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building TestProject.make"; \
	  $(cmtexe) -tag=$(tags) $(TestProject_extratags) build constituent_config -out=$(cmt_local_TestProject_makefile) TestProject; \
	  fi
endif

else

ifndef QUICK
$(cmt_local_TestProject_makefile) : $(TestProject_dependencies) build_library_links
	$(echo) "(constituents.make) Building TestProject.make"; \
	  $(cmtexe) -f=$(bin)TestProject.in -tag=$(tags) $(TestProject_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_TestProject_makefile) TestProject
else
$(cmt_local_TestProject_makefile) : $(TestProject_dependencies) $(cmt_build_library_linksstamp) $(bin)TestProject.in
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_TestProject) ] || \
	  [ ! -f $(cmt_final_setup_TestProject) ] || \
	  $(not_TestProject_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building TestProject.make"; \
	  $(cmtexe) -f=$(bin)TestProject.in -tag=$(tags) $(TestProject_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_TestProject_makefile) TestProject; \
	  fi
endif

endif

#	  $(cmtexe) -tag=$(tags) $(TestProject_extratags) build constituent_makefile -out=$(cmt_local_TestProject_makefile) TestProject

TestProject :: $(TestProject_dependencies) $(cmt_local_TestProject_makefile) dirs TestProjectdirs
	$(echo) "(constituents.make) Starting TestProject"
	@if test -f $(cmt_local_TestProject_makefile); then \
	  $(MAKE) -f $(cmt_local_TestProject_makefile) TestProject; \
	  fi
#	@$(MAKE) -f $(cmt_local_TestProject_makefile) TestProject
	$(echo) "(constituents.make) TestProject done"

clean :: TestProjectclean

TestProjectclean :: $(TestProjectclean_dependencies) ##$(cmt_local_TestProject_makefile)
	$(echo) "(constituents.make) Starting TestProjectclean"
	@-if test -f $(cmt_local_TestProject_makefile); then \
	  $(MAKE) -f $(cmt_local_TestProject_makefile) TestProjectclean; \
	fi
	$(echo) "(constituents.make) TestProjectclean done"
#	@-$(MAKE) -f $(cmt_local_TestProject_makefile) TestProjectclean

##	  /bin/rm -f $(cmt_local_TestProject_makefile) $(bin)TestProject_dependencies.make

install :: TestProjectinstall

TestProjectinstall :: $(TestProject_dependencies) $(cmt_local_TestProject_makefile)
	$(echo) "(constituents.make) Starting install TestProject"
	@-$(MAKE) -f $(cmt_local_TestProject_makefile) install
	$(echo) "(constituents.make) install TestProject done"

uninstall : TestProjectuninstall

$(foreach d,$(TestProject_dependencies),$(eval $(d)uninstall_dependencies += TestProjectuninstall))

TestProjectuninstall : $(TestProjectuninstall_dependencies) ##$(cmt_local_TestProject_makefile)
	$(echo) "(constituents.make) Starting uninstall TestProject"
	@if test -f $(cmt_local_TestProject_makefile); then \
	  $(MAKE) -f $(cmt_local_TestProject_makefile) uninstall; \
	  fi
#	@$(MAKE) -f $(cmt_local_TestProject_makefile) uninstall
	$(echo) "(constituents.make) uninstall TestProject done"

remove_library_links :: TestProjectuninstall

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(constituents.make) Starting $@ TestProject"
	$(echo) Using default action for $@
	$(echo) "(constituents.make) $@ TestProject done"
endif

#-- end of constituent ------
#-- start of constituent ------

cmt_new_rootsys_has_no_target_tag = 1

#--------------------------------------------------------

ifdef cmt_new_rootsys_has_target_tag

#cmt_local_tagfile_new_rootsys = $(EmcRec_tag)_new_rootsys.make
cmt_local_tagfile_new_rootsys = $(bin)$(EmcRec_tag)_new_rootsys.make
cmt_local_setup_new_rootsys = $(bin)setup_new_rootsys$$$$.make
cmt_final_setup_new_rootsys = $(bin)setup_new_rootsys.make
#cmt_final_setup_new_rootsys = $(bin)EmcRec_new_rootsyssetup.make
cmt_local_new_rootsys_makefile = $(bin)new_rootsys.make

new_rootsys_extratags = -tag_add=target_new_rootsys

#$(cmt_local_tagfile_new_rootsys) : $(cmt_lock_setup)
ifndef QUICK
$(cmt_local_tagfile_new_rootsys) ::
else
$(cmt_local_tagfile_new_rootsys) :
endif
	$(echo) "(constituents.make) Rebuilding $@"; \
	  if test -f $(cmt_local_tagfile_new_rootsys); then /bin/rm -f $(cmt_local_tagfile_new_rootsys); fi ; \
	  $(cmtexe) -tag=$(tags) $(new_rootsys_extratags) build tag_makefile >>$(cmt_local_tagfile_new_rootsys)
	$(echo) "(constituents.make) Rebuilding $(cmt_final_setup_new_rootsys)"; \
	  test ! -f $(cmt_local_setup_new_rootsys) || \rm -f $(cmt_local_setup_new_rootsys); \
	  trap '\rm -f $(cmt_local_setup_new_rootsys)' 0 1 2 15; \
	  $(cmtexe) -tag=$(tags) $(new_rootsys_extratags) show setup >$(cmt_local_setup_new_rootsys) && \
	  if [ -f $(cmt_final_setup_new_rootsys) ] && \
	    \cmp -s $(cmt_final_setup_new_rootsys) $(cmt_local_setup_new_rootsys); then \
	    \rm $(cmt_local_setup_new_rootsys); else \
	    \mv -f $(cmt_local_setup_new_rootsys) $(cmt_final_setup_new_rootsys); fi

else

#cmt_local_tagfile_new_rootsys = $(EmcRec_tag).make
cmt_local_tagfile_new_rootsys = $(bin)$(EmcRec_tag).make
cmt_final_setup_new_rootsys = $(bin)setup.make
#cmt_final_setup_new_rootsys = $(bin)EmcRecsetup.make
cmt_local_new_rootsys_makefile = $(bin)new_rootsys.make

endif

not_new_rootsys_dependencies = { n=0; for p in $?; do m=0; for d in $(new_rootsys_dependencies); do if [ $$p = $$d ]; then m=1; break; fi; done; if [ $$m -eq 0 ]; then n=1; break; fi; done; [ $$n -eq 1 ]; }

ifdef STRUCTURED_OUTPUT
new_rootsysdirs :
	@if test ! -d $(bin)new_rootsys; then $(mkdir) -p $(bin)new_rootsys; fi
	$(echo) "STRUCTURED_OUTPUT="$(bin)new_rootsys
else
new_rootsysdirs : ;
endif

#ifndef QUICK
#ifdef STRUCTURED_OUTPUT
# new_rootsysdirs ::
#	@if test ! -d $(bin)new_rootsys; then $(mkdir) -p $(bin)new_rootsys; fi
#	$(echo) "STRUCTURED_OUTPUT="$(bin)new_rootsys
#
#$(cmt_local_new_rootsys_makefile) :: $(new_rootsys_dependencies) $(cmt_local_tagfile_new_rootsys) build_library_links dirs new_rootsysdirs
#else
#$(cmt_local_new_rootsys_makefile) :: $(new_rootsys_dependencies) $(cmt_local_tagfile_new_rootsys) build_library_links dirs
#endif
#else
#$(cmt_local_new_rootsys_makefile) :: $(cmt_local_tagfile_new_rootsys)
#endif

ifdef cmt_new_rootsys_has_target_tag

ifndef QUICK
$(cmt_local_new_rootsys_makefile) : $(new_rootsys_dependencies) build_library_links
	$(echo) "(constituents.make) Building new_rootsys.make"; \
	  $(cmtexe) -tag=$(tags) $(new_rootsys_extratags) build constituent_config -out=$(cmt_local_new_rootsys_makefile) new_rootsys
else
$(cmt_local_new_rootsys_makefile) : $(new_rootsys_dependencies) $(cmt_build_library_linksstamp) $(use_requirements)
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_new_rootsys) ] || \
	  [ ! -f $(cmt_final_setup_new_rootsys) ] || \
	  $(not_new_rootsys_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building new_rootsys.make"; \
	  $(cmtexe) -tag=$(tags) $(new_rootsys_extratags) build constituent_config -out=$(cmt_local_new_rootsys_makefile) new_rootsys; \
	  fi
endif

else

ifndef QUICK
$(cmt_local_new_rootsys_makefile) : $(new_rootsys_dependencies) build_library_links
	$(echo) "(constituents.make) Building new_rootsys.make"; \
	  $(cmtexe) -f=$(bin)new_rootsys.in -tag=$(tags) $(new_rootsys_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_new_rootsys_makefile) new_rootsys
else
$(cmt_local_new_rootsys_makefile) : $(new_rootsys_dependencies) $(cmt_build_library_linksstamp) $(bin)new_rootsys.in
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_new_rootsys) ] || \
	  [ ! -f $(cmt_final_setup_new_rootsys) ] || \
	  $(not_new_rootsys_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building new_rootsys.make"; \
	  $(cmtexe) -f=$(bin)new_rootsys.in -tag=$(tags) $(new_rootsys_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_new_rootsys_makefile) new_rootsys; \
	  fi
endif

endif

#	  $(cmtexe) -tag=$(tags) $(new_rootsys_extratags) build constituent_makefile -out=$(cmt_local_new_rootsys_makefile) new_rootsys

new_rootsys :: $(new_rootsys_dependencies) $(cmt_local_new_rootsys_makefile) dirs new_rootsysdirs
	$(echo) "(constituents.make) Starting new_rootsys"
	@if test -f $(cmt_local_new_rootsys_makefile); then \
	  $(MAKE) -f $(cmt_local_new_rootsys_makefile) new_rootsys; \
	  fi
#	@$(MAKE) -f $(cmt_local_new_rootsys_makefile) new_rootsys
	$(echo) "(constituents.make) new_rootsys done"

clean :: new_rootsysclean

new_rootsysclean :: $(new_rootsysclean_dependencies) ##$(cmt_local_new_rootsys_makefile)
	$(echo) "(constituents.make) Starting new_rootsysclean"
	@-if test -f $(cmt_local_new_rootsys_makefile); then \
	  $(MAKE) -f $(cmt_local_new_rootsys_makefile) new_rootsysclean; \
	fi
	$(echo) "(constituents.make) new_rootsysclean done"
#	@-$(MAKE) -f $(cmt_local_new_rootsys_makefile) new_rootsysclean

##	  /bin/rm -f $(cmt_local_new_rootsys_makefile) $(bin)new_rootsys_dependencies.make

install :: new_rootsysinstall

new_rootsysinstall :: $(new_rootsys_dependencies) $(cmt_local_new_rootsys_makefile)
	$(echo) "(constituents.make) Starting install new_rootsys"
	@-$(MAKE) -f $(cmt_local_new_rootsys_makefile) install
	$(echo) "(constituents.make) install new_rootsys done"

uninstall : new_rootsysuninstall

$(foreach d,$(new_rootsys_dependencies),$(eval $(d)uninstall_dependencies += new_rootsysuninstall))

new_rootsysuninstall : $(new_rootsysuninstall_dependencies) ##$(cmt_local_new_rootsys_makefile)
	$(echo) "(constituents.make) Starting uninstall new_rootsys"
	@if test -f $(cmt_local_new_rootsys_makefile); then \
	  $(MAKE) -f $(cmt_local_new_rootsys_makefile) uninstall; \
	  fi
#	@$(MAKE) -f $(cmt_local_new_rootsys_makefile) uninstall
	$(echo) "(constituents.make) uninstall new_rootsys done"

remove_library_links :: new_rootsysuninstall

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(constituents.make) Starting $@ new_rootsys"
	$(echo) Using default action for $@
	$(echo) "(constituents.make) $@ new_rootsys done"
endif

#-- end of constituent ------
#-- start of constituent ------

cmt_DatabaseSvc_check_install_scripts_has_no_target_tag = 1

#--------------------------------------------------------

ifdef cmt_DatabaseSvc_check_install_scripts_has_target_tag

#cmt_local_tagfile_DatabaseSvc_check_install_scripts = $(EmcRec_tag)_DatabaseSvc_check_install_scripts.make
cmt_local_tagfile_DatabaseSvc_check_install_scripts = $(bin)$(EmcRec_tag)_DatabaseSvc_check_install_scripts.make
cmt_local_setup_DatabaseSvc_check_install_scripts = $(bin)setup_DatabaseSvc_check_install_scripts$$$$.make
cmt_final_setup_DatabaseSvc_check_install_scripts = $(bin)setup_DatabaseSvc_check_install_scripts.make
#cmt_final_setup_DatabaseSvc_check_install_scripts = $(bin)EmcRec_DatabaseSvc_check_install_scriptssetup.make
cmt_local_DatabaseSvc_check_install_scripts_makefile = $(bin)DatabaseSvc_check_install_scripts.make

DatabaseSvc_check_install_scripts_extratags = -tag_add=target_DatabaseSvc_check_install_scripts

#$(cmt_local_tagfile_DatabaseSvc_check_install_scripts) : $(cmt_lock_setup)
ifndef QUICK
$(cmt_local_tagfile_DatabaseSvc_check_install_scripts) ::
else
$(cmt_local_tagfile_DatabaseSvc_check_install_scripts) :
endif
	$(echo) "(constituents.make) Rebuilding $@"; \
	  if test -f $(cmt_local_tagfile_DatabaseSvc_check_install_scripts); then /bin/rm -f $(cmt_local_tagfile_DatabaseSvc_check_install_scripts); fi ; \
	  $(cmtexe) -tag=$(tags) $(DatabaseSvc_check_install_scripts_extratags) build tag_makefile >>$(cmt_local_tagfile_DatabaseSvc_check_install_scripts)
	$(echo) "(constituents.make) Rebuilding $(cmt_final_setup_DatabaseSvc_check_install_scripts)"; \
	  test ! -f $(cmt_local_setup_DatabaseSvc_check_install_scripts) || \rm -f $(cmt_local_setup_DatabaseSvc_check_install_scripts); \
	  trap '\rm -f $(cmt_local_setup_DatabaseSvc_check_install_scripts)' 0 1 2 15; \
	  $(cmtexe) -tag=$(tags) $(DatabaseSvc_check_install_scripts_extratags) show setup >$(cmt_local_setup_DatabaseSvc_check_install_scripts) && \
	  if [ -f $(cmt_final_setup_DatabaseSvc_check_install_scripts) ] && \
	    \cmp -s $(cmt_final_setup_DatabaseSvc_check_install_scripts) $(cmt_local_setup_DatabaseSvc_check_install_scripts); then \
	    \rm $(cmt_local_setup_DatabaseSvc_check_install_scripts); else \
	    \mv -f $(cmt_local_setup_DatabaseSvc_check_install_scripts) $(cmt_final_setup_DatabaseSvc_check_install_scripts); fi

else

#cmt_local_tagfile_DatabaseSvc_check_install_scripts = $(EmcRec_tag).make
cmt_local_tagfile_DatabaseSvc_check_install_scripts = $(bin)$(EmcRec_tag).make
cmt_final_setup_DatabaseSvc_check_install_scripts = $(bin)setup.make
#cmt_final_setup_DatabaseSvc_check_install_scripts = $(bin)EmcRecsetup.make
cmt_local_DatabaseSvc_check_install_scripts_makefile = $(bin)DatabaseSvc_check_install_scripts.make

endif

not_DatabaseSvc_check_install_scripts_dependencies = { n=0; for p in $?; do m=0; for d in $(DatabaseSvc_check_install_scripts_dependencies); do if [ $$p = $$d ]; then m=1; break; fi; done; if [ $$m -eq 0 ]; then n=1; break; fi; done; [ $$n -eq 1 ]; }

ifdef STRUCTURED_OUTPUT
DatabaseSvc_check_install_scriptsdirs :
	@if test ! -d $(bin)DatabaseSvc_check_install_scripts; then $(mkdir) -p $(bin)DatabaseSvc_check_install_scripts; fi
	$(echo) "STRUCTURED_OUTPUT="$(bin)DatabaseSvc_check_install_scripts
else
DatabaseSvc_check_install_scriptsdirs : ;
endif

#ifndef QUICK
#ifdef STRUCTURED_OUTPUT
# DatabaseSvc_check_install_scriptsdirs ::
#	@if test ! -d $(bin)DatabaseSvc_check_install_scripts; then $(mkdir) -p $(bin)DatabaseSvc_check_install_scripts; fi
#	$(echo) "STRUCTURED_OUTPUT="$(bin)DatabaseSvc_check_install_scripts
#
#$(cmt_local_DatabaseSvc_check_install_scripts_makefile) :: $(DatabaseSvc_check_install_scripts_dependencies) $(cmt_local_tagfile_DatabaseSvc_check_install_scripts) build_library_links dirs DatabaseSvc_check_install_scriptsdirs
#else
#$(cmt_local_DatabaseSvc_check_install_scripts_makefile) :: $(DatabaseSvc_check_install_scripts_dependencies) $(cmt_local_tagfile_DatabaseSvc_check_install_scripts) build_library_links dirs
#endif
#else
#$(cmt_local_DatabaseSvc_check_install_scripts_makefile) :: $(cmt_local_tagfile_DatabaseSvc_check_install_scripts)
#endif

ifdef cmt_DatabaseSvc_check_install_scripts_has_target_tag

ifndef QUICK
$(cmt_local_DatabaseSvc_check_install_scripts_makefile) : $(DatabaseSvc_check_install_scripts_dependencies) build_library_links
	$(echo) "(constituents.make) Building DatabaseSvc_check_install_scripts.make"; \
	  $(cmtexe) -tag=$(tags) $(DatabaseSvc_check_install_scripts_extratags) build constituent_config -out=$(cmt_local_DatabaseSvc_check_install_scripts_makefile) DatabaseSvc_check_install_scripts
else
$(cmt_local_DatabaseSvc_check_install_scripts_makefile) : $(DatabaseSvc_check_install_scripts_dependencies) $(cmt_build_library_linksstamp) $(use_requirements)
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_DatabaseSvc_check_install_scripts) ] || \
	  [ ! -f $(cmt_final_setup_DatabaseSvc_check_install_scripts) ] || \
	  $(not_DatabaseSvc_check_install_scripts_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building DatabaseSvc_check_install_scripts.make"; \
	  $(cmtexe) -tag=$(tags) $(DatabaseSvc_check_install_scripts_extratags) build constituent_config -out=$(cmt_local_DatabaseSvc_check_install_scripts_makefile) DatabaseSvc_check_install_scripts; \
	  fi
endif

else

ifndef QUICK
$(cmt_local_DatabaseSvc_check_install_scripts_makefile) : $(DatabaseSvc_check_install_scripts_dependencies) build_library_links
	$(echo) "(constituents.make) Building DatabaseSvc_check_install_scripts.make"; \
	  $(cmtexe) -f=$(bin)DatabaseSvc_check_install_scripts.in -tag=$(tags) $(DatabaseSvc_check_install_scripts_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_DatabaseSvc_check_install_scripts_makefile) DatabaseSvc_check_install_scripts
else
$(cmt_local_DatabaseSvc_check_install_scripts_makefile) : $(DatabaseSvc_check_install_scripts_dependencies) $(cmt_build_library_linksstamp) $(bin)DatabaseSvc_check_install_scripts.in
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_DatabaseSvc_check_install_scripts) ] || \
	  [ ! -f $(cmt_final_setup_DatabaseSvc_check_install_scripts) ] || \
	  $(not_DatabaseSvc_check_install_scripts_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building DatabaseSvc_check_install_scripts.make"; \
	  $(cmtexe) -f=$(bin)DatabaseSvc_check_install_scripts.in -tag=$(tags) $(DatabaseSvc_check_install_scripts_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_DatabaseSvc_check_install_scripts_makefile) DatabaseSvc_check_install_scripts; \
	  fi
endif

endif

#	  $(cmtexe) -tag=$(tags) $(DatabaseSvc_check_install_scripts_extratags) build constituent_makefile -out=$(cmt_local_DatabaseSvc_check_install_scripts_makefile) DatabaseSvc_check_install_scripts

DatabaseSvc_check_install_scripts :: $(DatabaseSvc_check_install_scripts_dependencies) $(cmt_local_DatabaseSvc_check_install_scripts_makefile) dirs DatabaseSvc_check_install_scriptsdirs
	$(echo) "(constituents.make) Starting DatabaseSvc_check_install_scripts"
	@if test -f $(cmt_local_DatabaseSvc_check_install_scripts_makefile); then \
	  $(MAKE) -f $(cmt_local_DatabaseSvc_check_install_scripts_makefile) DatabaseSvc_check_install_scripts; \
	  fi
#	@$(MAKE) -f $(cmt_local_DatabaseSvc_check_install_scripts_makefile) DatabaseSvc_check_install_scripts
	$(echo) "(constituents.make) DatabaseSvc_check_install_scripts done"

clean :: DatabaseSvc_check_install_scriptsclean

DatabaseSvc_check_install_scriptsclean :: $(DatabaseSvc_check_install_scriptsclean_dependencies) ##$(cmt_local_DatabaseSvc_check_install_scripts_makefile)
	$(echo) "(constituents.make) Starting DatabaseSvc_check_install_scriptsclean"
	@-if test -f $(cmt_local_DatabaseSvc_check_install_scripts_makefile); then \
	  $(MAKE) -f $(cmt_local_DatabaseSvc_check_install_scripts_makefile) DatabaseSvc_check_install_scriptsclean; \
	fi
	$(echo) "(constituents.make) DatabaseSvc_check_install_scriptsclean done"
#	@-$(MAKE) -f $(cmt_local_DatabaseSvc_check_install_scripts_makefile) DatabaseSvc_check_install_scriptsclean

##	  /bin/rm -f $(cmt_local_DatabaseSvc_check_install_scripts_makefile) $(bin)DatabaseSvc_check_install_scripts_dependencies.make

install :: DatabaseSvc_check_install_scriptsinstall

DatabaseSvc_check_install_scriptsinstall :: $(DatabaseSvc_check_install_scripts_dependencies) $(cmt_local_DatabaseSvc_check_install_scripts_makefile)
	$(echo) "(constituents.make) Starting install DatabaseSvc_check_install_scripts"
	@-$(MAKE) -f $(cmt_local_DatabaseSvc_check_install_scripts_makefile) install
	$(echo) "(constituents.make) install DatabaseSvc_check_install_scripts done"

uninstall : DatabaseSvc_check_install_scriptsuninstall

$(foreach d,$(DatabaseSvc_check_install_scripts_dependencies),$(eval $(d)uninstall_dependencies += DatabaseSvc_check_install_scriptsuninstall))

DatabaseSvc_check_install_scriptsuninstall : $(DatabaseSvc_check_install_scriptsuninstall_dependencies) ##$(cmt_local_DatabaseSvc_check_install_scripts_makefile)
	$(echo) "(constituents.make) Starting uninstall DatabaseSvc_check_install_scripts"
	@if test -f $(cmt_local_DatabaseSvc_check_install_scripts_makefile); then \
	  $(MAKE) -f $(cmt_local_DatabaseSvc_check_install_scripts_makefile) uninstall; \
	  fi
#	@$(MAKE) -f $(cmt_local_DatabaseSvc_check_install_scripts_makefile) uninstall
	$(echo) "(constituents.make) uninstall DatabaseSvc_check_install_scripts done"

remove_library_links :: DatabaseSvc_check_install_scriptsuninstall

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(constituents.make) Starting $@ DatabaseSvc_check_install_scripts"
	$(echo) Using default action for $@
	$(echo) "(constituents.make) $@ DatabaseSvc_check_install_scripts done"
endif

#-- end of constituent ------

clean :: remove_library_links

remove_library_links ::
	@echo "Removing library links"; \
	  $(remove_library_links); \

makefilesclean ::
	@/bin/rm -f checkuses

#	/bin/rm -f *.make*

clean :: makefilesclean

binclean :: clean
	if test ! "$(bin)" = "./"; then /bin/rm -rf $(bin); fi

