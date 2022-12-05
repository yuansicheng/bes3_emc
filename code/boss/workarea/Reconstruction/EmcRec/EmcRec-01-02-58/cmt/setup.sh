# echo "setup EmcRec EmcRec-01-02-58 in /junofs/users/yuansc/bes3_emc/code/boss/workarea/Reconstruction"

if test "${CMTROOT}" = ""; then
  CMTROOT=/cvmfs/bes3.ihep.ac.cn/bes3sw/ExternalLib/SLC6/contrib/CMT/v1r25; export CMTROOT
fi
. ${CMTROOT}/mgr/setup.sh
cmtEmcRectempfile=`${CMTROOT}/mgr/cmt -quiet build temporary_name`
if test ! $? = 0 ; then cmtEmcRectempfile=/tmp/cmt.$$; fi
${CMTROOT}/mgr/cmt setup -sh -pack=EmcRec -version=EmcRec-01-02-58 -path=/junofs/users/yuansc/bes3_emc/code/boss/workarea/Reconstruction  -quiet -with_version_directory -no_cleanup $* >${cmtEmcRectempfile}
if test $? != 0 ; then
  echo >&2 "${CMTROOT}/mgr/cmt setup -sh -pack=EmcRec -version=EmcRec-01-02-58 -path=/junofs/users/yuansc/bes3_emc/code/boss/workarea/Reconstruction  -quiet -with_version_directory -no_cleanup $* >${cmtEmcRectempfile}"
  cmtsetupstatus=2
  /bin/rm -f ${cmtEmcRectempfile}
  unset cmtEmcRectempfile
  return $cmtsetupstatus
fi
cmtsetupstatus=0
. ${cmtEmcRectempfile}
if test $? != 0 ; then
  cmtsetupstatus=2
fi
/bin/rm -f ${cmtEmcRectempfile}
unset cmtEmcRectempfile
return $cmtsetupstatus

