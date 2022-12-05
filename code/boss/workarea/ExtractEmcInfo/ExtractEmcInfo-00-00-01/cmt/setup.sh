# echo "setup ExtractEmcInfo ExtractEmcInfo-00-00-01 in /junofs/users/yuansc/bes3_emc/code/boss/workarea"

if test "${CMTROOT}" = ""; then
  CMTROOT=/cvmfs/bes3.ihep.ac.cn/bes3sw/ExternalLib/SLC6/contrib/CMT/v1r25; export CMTROOT
fi
. ${CMTROOT}/mgr/setup.sh
cmtExtractEmcInfotempfile=`${CMTROOT}/mgr/cmt -quiet build temporary_name`
if test ! $? = 0 ; then cmtExtractEmcInfotempfile=/tmp/cmt.$$; fi
${CMTROOT}/mgr/cmt setup -sh -pack=ExtractEmcInfo -version=ExtractEmcInfo-00-00-01 -path=/junofs/users/yuansc/bes3_emc/code/boss/workarea  -no_cleanup $* >${cmtExtractEmcInfotempfile}
if test $? != 0 ; then
  echo >&2 "${CMTROOT}/mgr/cmt setup -sh -pack=ExtractEmcInfo -version=ExtractEmcInfo-00-00-01 -path=/junofs/users/yuansc/bes3_emc/code/boss/workarea  -no_cleanup $* >${cmtExtractEmcInfotempfile}"
  cmtsetupstatus=2
  /bin/rm -f ${cmtExtractEmcInfotempfile}
  unset cmtExtractEmcInfotempfile
  return $cmtsetupstatus
fi
cmtsetupstatus=0
. ${cmtExtractEmcInfotempfile}
if test $? != 0 ; then
  cmtsetupstatus=2
fi
/bin/rm -f ${cmtExtractEmcInfotempfile}
unset cmtExtractEmcInfotempfile
return $cmtsetupstatus

