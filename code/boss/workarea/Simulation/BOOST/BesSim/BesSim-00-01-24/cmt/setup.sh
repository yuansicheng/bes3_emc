# echo "setup BesSim BesSim-00-01-24 in /junofs/users/yuansc/bes3_emc/code/boss/workarea/Simulation/BOOST"

if test "${CMTROOT}" = ""; then
  CMTROOT=/cvmfs/bes3.ihep.ac.cn/bes3sw/ExternalLib/SLC6/contrib/CMT/v1r25; export CMTROOT
fi
. ${CMTROOT}/mgr/setup.sh
cmtBesSimtempfile=`${CMTROOT}/mgr/cmt -quiet build temporary_name`
if test ! $? = 0 ; then cmtBesSimtempfile=/tmp/cmt.$$; fi
${CMTROOT}/mgr/cmt setup -sh -pack=BesSim -version=BesSim-00-01-24 -path=/junofs/users/yuansc/bes3_emc/code/boss/workarea/Simulation/BOOST  -quiet -with_version_directory -no_cleanup $* >${cmtBesSimtempfile}
if test $? != 0 ; then
  echo >&2 "${CMTROOT}/mgr/cmt setup -sh -pack=BesSim -version=BesSim-00-01-24 -path=/junofs/users/yuansc/bes3_emc/code/boss/workarea/Simulation/BOOST  -quiet -with_version_directory -no_cleanup $* >${cmtBesSimtempfile}"
  cmtsetupstatus=2
  /bin/rm -f ${cmtBesSimtempfile}
  unset cmtBesSimtempfile
  return $cmtsetupstatus
fi
cmtsetupstatus=0
. ${cmtBesSimtempfile}
if test $? != 0 ; then
  cmtsetupstatus=2
fi
/bin/rm -f ${cmtBesSimtempfile}
unset cmtBesSimtempfile
return $cmtsetupstatus

