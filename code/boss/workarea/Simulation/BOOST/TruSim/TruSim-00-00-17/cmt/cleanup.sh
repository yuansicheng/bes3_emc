# echo "cleanup TruSim TruSim-00-00-17 in /junofs/users/yuansc/bes3_emc/code/boss/workarea/Simulation/BOOST"

if test "${CMTROOT}" = ""; then
  CMTROOT=/cvmfs/bes3.ihep.ac.cn/bes3sw/ExternalLib/SLC6/contrib/CMT/v1r25; export CMTROOT
fi
. ${CMTROOT}/mgr/setup.sh
cmtTruSimtempfile=`${CMTROOT}/mgr/cmt -quiet build temporary_name`
if test ! $? = 0 ; then cmtTruSimtempfile=/tmp/cmt.$$; fi
${CMTROOT}/mgr/cmt cleanup -sh -pack=TruSim -version=TruSim-00-00-17 -path=/junofs/users/yuansc/bes3_emc/code/boss/workarea/Simulation/BOOST  -quiet -with_version_directory $* >${cmtTruSimtempfile}
if test $? != 0 ; then
  echo >&2 "${CMTROOT}/mgr/cmt cleanup -sh -pack=TruSim -version=TruSim-00-00-17 -path=/junofs/users/yuansc/bes3_emc/code/boss/workarea/Simulation/BOOST  -quiet -with_version_directory $* >${cmtTruSimtempfile}"
  cmtcleanupstatus=2
  /bin/rm -f ${cmtTruSimtempfile}
  unset cmtTruSimtempfile
  return $cmtcleanupstatus
fi
cmtcleanupstatus=0
. ${cmtTruSimtempfile}
if test $? != 0 ; then
  cmtcleanupstatus=2
fi
/bin/rm -f ${cmtTruSimtempfile}
unset cmtTruSimtempfile
return $cmtcleanupstatus

