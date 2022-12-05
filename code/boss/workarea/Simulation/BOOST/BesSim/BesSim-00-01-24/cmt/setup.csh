# echo "setup BesSim BesSim-00-01-24 in /junofs/users/yuansc/bes3_emc/code/boss/workarea/Simulation/BOOST"

if ( $?CMTROOT == 0 ) then
  setenv CMTROOT /cvmfs/bes3.ihep.ac.cn/bes3sw/ExternalLib/SLC6/contrib/CMT/v1r25
endif
source ${CMTROOT}/mgr/setup.csh
set cmtBesSimtempfile=`${CMTROOT}/mgr/cmt -quiet build temporary_name`
if $status != 0 then
  set cmtBesSimtempfile=/tmp/cmt.$$
endif
${CMTROOT}/mgr/cmt setup -csh -pack=BesSim -version=BesSim-00-01-24 -path=/junofs/users/yuansc/bes3_emc/code/boss/workarea/Simulation/BOOST  -quiet -with_version_directory -no_cleanup $* >${cmtBesSimtempfile}
if ( $status != 0 ) then
  echo "${CMTROOT}/mgr/cmt setup -csh -pack=BesSim -version=BesSim-00-01-24 -path=/junofs/users/yuansc/bes3_emc/code/boss/workarea/Simulation/BOOST  -quiet -with_version_directory -no_cleanup $* >${cmtBesSimtempfile}"
  set cmtsetupstatus=2
  /bin/rm -f ${cmtBesSimtempfile}
  unset cmtBesSimtempfile
  exit $cmtsetupstatus
endif
set cmtsetupstatus=0
source ${cmtBesSimtempfile}
if ( $status != 0 ) then
  set cmtsetupstatus=2
endif
/bin/rm -f ${cmtBesSimtempfile}
unset cmtBesSimtempfile
exit $cmtsetupstatus

