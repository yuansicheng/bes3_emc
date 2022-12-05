# echo "setup TruSim TruSim-00-00-17 in /junofs/users/yuansc/bes3_emc/code/boss/workarea/Simulation/BOOST"

if ( $?CMTROOT == 0 ) then
  setenv CMTROOT /cvmfs/bes3.ihep.ac.cn/bes3sw/ExternalLib/SLC6/contrib/CMT/v1r25
endif
source ${CMTROOT}/mgr/setup.csh
set cmtTruSimtempfile=`${CMTROOT}/mgr/cmt -quiet build temporary_name`
if $status != 0 then
  set cmtTruSimtempfile=/tmp/cmt.$$
endif
${CMTROOT}/mgr/cmt setup -csh -pack=TruSim -version=TruSim-00-00-17 -path=/junofs/users/yuansc/bes3_emc/code/boss/workarea/Simulation/BOOST  -quiet -with_version_directory -no_cleanup $* >${cmtTruSimtempfile}
if ( $status != 0 ) then
  echo "${CMTROOT}/mgr/cmt setup -csh -pack=TruSim -version=TruSim-00-00-17 -path=/junofs/users/yuansc/bes3_emc/code/boss/workarea/Simulation/BOOST  -quiet -with_version_directory -no_cleanup $* >${cmtTruSimtempfile}"
  set cmtsetupstatus=2
  /bin/rm -f ${cmtTruSimtempfile}
  unset cmtTruSimtempfile
  exit $cmtsetupstatus
endif
set cmtsetupstatus=0
source ${cmtTruSimtempfile}
if ( $status != 0 ) then
  set cmtsetupstatus=2
endif
/bin/rm -f ${cmtTruSimtempfile}
unset cmtTruSimtempfile
exit $cmtsetupstatus

