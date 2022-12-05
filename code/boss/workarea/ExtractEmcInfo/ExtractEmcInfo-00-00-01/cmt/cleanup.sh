# echo "cleanup ExtractEmcInfo ExtractEmcInfo-00-00-01 in /junofs/users/yuansc/bes3_emc/code/boss/workarea"

if test "${CMTROOT}" = ""; then
  CMTROOT=/cvmfs/bes3.ihep.ac.cn/bes3sw/ExternalLib/SLC6/contrib/CMT/v1r25; export CMTROOT
fi
. ${CMTROOT}/mgr/setup.sh
cmtExtractEmcInfotempfile=`${CMTROOT}/mgr/cmt -quiet build temporary_name`
if test ! $? = 0 ; then cmtExtractEmcInfotempfile=/tmp/cmt.$$; fi
${CMTROOT}/mgr/cmt cleanup -sh -pack=ExtractEmcInfo -version=ExtractEmcInfo-00-00-01 -path=/junofs/users/yuansc/bes3_emc/code/boss/workarea  $* >${cmtExtractEmcInfotempfile}
if test $? != 0 ; then
  echo >&2 "${CMTROOT}/mgr/cmt cleanup -sh -pack=ExtractEmcInfo -version=ExtractEmcInfo-00-00-01 -path=/junofs/users/yuansc/bes3_emc/code/boss/workarea  $* >${cmtExtractEmcInfotempfile}"
  cmtcleanupstatus=2
  /bin/rm -f ${cmtExtractEmcInfotempfile}
  unset cmtExtractEmcInfotempfile
  return $cmtcleanupstatus
fi
cmtcleanupstatus=0
. ${cmtExtractEmcInfotempfile}
if test $? != 0 ; then
  cmtcleanupstatus=2
fi
/bin/rm -f ${cmtExtractEmcInfotempfile}
unset cmtExtractEmcInfotempfile
return $cmtcleanupstatus

