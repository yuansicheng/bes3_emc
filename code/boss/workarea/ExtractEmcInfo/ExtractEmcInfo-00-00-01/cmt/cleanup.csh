# echo "cleanup ExtractEmcInfo ExtractEmcInfo-00-00-01 in /junofs/users/yuansc/bes3_emc/code/boss/workarea"

if ( $?CMTROOT == 0 ) then
  setenv CMTROOT /cvmfs/bes3.ihep.ac.cn/bes3sw/ExternalLib/SLC6/contrib/CMT/v1r25
endif
source ${CMTROOT}/mgr/setup.csh
set cmtExtractEmcInfotempfile=`${CMTROOT}/mgr/cmt -quiet build temporary_name`
if $status != 0 then
  set cmtExtractEmcInfotempfile=/tmp/cmt.$$
endif
${CMTROOT}/mgr/cmt cleanup -csh -pack=ExtractEmcInfo -version=ExtractEmcInfo-00-00-01 -path=/junofs/users/yuansc/bes3_emc/code/boss/workarea  $* >${cmtExtractEmcInfotempfile}
if ( $status != 0 ) then
  echo "${CMTROOT}/mgr/cmt cleanup -csh -pack=ExtractEmcInfo -version=ExtractEmcInfo-00-00-01 -path=/junofs/users/yuansc/bes3_emc/code/boss/workarea  $* >${cmtExtractEmcInfotempfile}"
  set cmtcleanupstatus=2
  /bin/rm -f ${cmtExtractEmcInfotempfile}
  unset cmtExtractEmcInfotempfile
  exit $cmtcleanupstatus
endif
set cmtcleanupstatus=0
source ${cmtExtractEmcInfotempfile}
if ( $status != 0 ) then
  set cmtcleanupstatus=2
endif
/bin/rm -f ${cmtExtractEmcInfotempfile}
unset cmtExtractEmcInfotempfile
exit $cmtcleanupstatus

