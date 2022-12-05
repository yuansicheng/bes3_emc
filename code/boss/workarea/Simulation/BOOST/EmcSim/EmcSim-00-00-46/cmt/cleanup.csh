# echo "cleanup EmcSim EmcSim-00-00-46 in /junofs/users/yuansc/bes3_emc/code/boss/workarea/Simulation/BOOST"

if ( $?CMTROOT == 0 ) then
  setenv CMTROOT /cvmfs/bes3.ihep.ac.cn/bes3sw/ExternalLib/SLC6/contrib/CMT/v1r25
endif
source ${CMTROOT}/mgr/setup.csh
set cmtEmcSimtempfile=`${CMTROOT}/mgr/cmt -quiet build temporary_name`
if $status != 0 then
  set cmtEmcSimtempfile=/tmp/cmt.$$
endif
${CMTROOT}/mgr/cmt cleanup -csh -pack=EmcSim -version=EmcSim-00-00-46 -path=/junofs/users/yuansc/bes3_emc/code/boss/workarea/Simulation/BOOST  -quiet -with_version_directory $* >${cmtEmcSimtempfile}
if ( $status != 0 ) then
  echo "${CMTROOT}/mgr/cmt cleanup -csh -pack=EmcSim -version=EmcSim-00-00-46 -path=/junofs/users/yuansc/bes3_emc/code/boss/workarea/Simulation/BOOST  -quiet -with_version_directory $* >${cmtEmcSimtempfile}"
  set cmtcleanupstatus=2
  /bin/rm -f ${cmtEmcSimtempfile}
  unset cmtEmcSimtempfile
  exit $cmtcleanupstatus
endif
set cmtcleanupstatus=0
source ${cmtEmcSimtempfile}
if ( $status != 0 ) then
  set cmtcleanupstatus=2
endif
/bin/rm -f ${cmtEmcSimtempfile}
unset cmtEmcSimtempfile
exit $cmtcleanupstatus

