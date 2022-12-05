# echo "cleanup EmcSim EmcSim-00-00-46 in /junofs/users/yuansc/bes3_emc/code/boss/workarea/Simulation/BOOST"

if test "${CMTROOT}" = ""; then
  CMTROOT=/cvmfs/bes3.ihep.ac.cn/bes3sw/ExternalLib/SLC6/contrib/CMT/v1r25; export CMTROOT
fi
. ${CMTROOT}/mgr/setup.sh
cmtEmcSimtempfile=`${CMTROOT}/mgr/cmt -quiet build temporary_name`
if test ! $? = 0 ; then cmtEmcSimtempfile=/tmp/cmt.$$; fi
${CMTROOT}/mgr/cmt cleanup -sh -pack=EmcSim -version=EmcSim-00-00-46 -path=/junofs/users/yuansc/bes3_emc/code/boss/workarea/Simulation/BOOST  -quiet -with_version_directory $* >${cmtEmcSimtempfile}
if test $? != 0 ; then
  echo >&2 "${CMTROOT}/mgr/cmt cleanup -sh -pack=EmcSim -version=EmcSim-00-00-46 -path=/junofs/users/yuansc/bes3_emc/code/boss/workarea/Simulation/BOOST  -quiet -with_version_directory $* >${cmtEmcSimtempfile}"
  cmtcleanupstatus=2
  /bin/rm -f ${cmtEmcSimtempfile}
  unset cmtEmcSimtempfile
  return $cmtcleanupstatus
fi
cmtcleanupstatus=0
. ${cmtEmcSimtempfile}
if test $? != 0 ; then
  cmtcleanupstatus=2
fi
/bin/rm -f ${cmtEmcSimtempfile}
unset cmtEmcSimtempfile
return $cmtcleanupstatus

