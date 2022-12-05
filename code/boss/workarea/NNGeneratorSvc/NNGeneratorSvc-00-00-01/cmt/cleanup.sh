# echo "cleanup NNGeneratorSvc NNGeneratorSvc-00-00-01 in /junofs/users/yuansc/bes3_emc/code/boss/workarea"

if test "${CMTROOT}" = ""; then
  CMTROOT=/cvmfs/bes3.ihep.ac.cn/bes3sw/ExternalLib/SLC6/contrib/CMT/v1r25; export CMTROOT
fi
. ${CMTROOT}/mgr/setup.sh
cmtNNGeneratorSvctempfile=`${CMTROOT}/mgr/cmt -quiet build temporary_name`
if test ! $? = 0 ; then cmtNNGeneratorSvctempfile=/tmp/cmt.$$; fi
${CMTROOT}/mgr/cmt cleanup -sh -pack=NNGeneratorSvc -version=NNGeneratorSvc-00-00-01 -path=/junofs/users/yuansc/bes3_emc/code/boss/workarea  $* >${cmtNNGeneratorSvctempfile}
if test $? != 0 ; then
  echo >&2 "${CMTROOT}/mgr/cmt cleanup -sh -pack=NNGeneratorSvc -version=NNGeneratorSvc-00-00-01 -path=/junofs/users/yuansc/bes3_emc/code/boss/workarea  $* >${cmtNNGeneratorSvctempfile}"
  cmtcleanupstatus=2
  /bin/rm -f ${cmtNNGeneratorSvctempfile}
  unset cmtNNGeneratorSvctempfile
  return $cmtcleanupstatus
fi
cmtcleanupstatus=0
. ${cmtNNGeneratorSvctempfile}
if test $? != 0 ; then
  cmtcleanupstatus=2
fi
/bin/rm -f ${cmtNNGeneratorSvctempfile}
unset cmtNNGeneratorSvctempfile
return $cmtcleanupstatus

