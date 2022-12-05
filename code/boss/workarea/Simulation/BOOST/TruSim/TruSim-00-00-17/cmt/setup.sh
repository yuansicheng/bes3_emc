# echo "setup TruSim TruSim-00-00-17 in /junofs/users/yuansc/bes3_emc/code/boss/workarea/Simulation/BOOST"

if test "${CMTROOT}" = ""; then
  CMTROOT=/cvmfs/bes3.ihep.ac.cn/bes3sw/ExternalLib/SLC6/contrib/CMT/v1r25; export CMTROOT
fi
. ${CMTROOT}/mgr/setup.sh
cmtTruSimtempfile=`${CMTROOT}/mgr/cmt -quiet build temporary_name`
if test ! $? = 0 ; then cmtTruSimtempfile=/tmp/cmt.$$; fi
${CMTROOT}/mgr/cmt setup -sh -pack=TruSim -version=TruSim-00-00-17 -path=/junofs/users/yuansc/bes3_emc/code/boss/workarea/Simulation/BOOST  -quiet -with_version_directory -no_cleanup $* >${cmtTruSimtempfile}
if test $? != 0 ; then
  echo >&2 "${CMTROOT}/mgr/cmt setup -sh -pack=TruSim -version=TruSim-00-00-17 -path=/junofs/users/yuansc/bes3_emc/code/boss/workarea/Simulation/BOOST  -quiet -with_version_directory -no_cleanup $* >${cmtTruSimtempfile}"
  cmtsetupstatus=2
  /bin/rm -f ${cmtTruSimtempfile}
  unset cmtTruSimtempfile
  return $cmtsetupstatus
fi
cmtsetupstatus=0
. ${cmtTruSimtempfile}
if test $? != 0 ; then
  cmtsetupstatus=2
fi
/bin/rm -f ${cmtTruSimtempfile}
unset cmtTruSimtempfile
return $cmtsetupstatus

