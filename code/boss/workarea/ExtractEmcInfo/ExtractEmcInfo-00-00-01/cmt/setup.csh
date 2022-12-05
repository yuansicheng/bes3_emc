# echo "setup ExtractEmcInfo ExtractEmcInfo-00-00-01 in /junofs/users/yuansc/bes3_emc/code/boss/workarea"

if ( $?CMTROOT == 0 ) then
  setenv CMTROOT /cvmfs/bes3.ihep.ac.cn/bes3sw/ExternalLib/SLC6/contrib/CMT/v1r25
endif
source ${CMTROOT}/mgr/setup.csh
set cmtExtractEmcInfotempfile=`${CMTROOT}/mgr/cmt -quiet build temporary_name`
if $status != 0 then
  set cmtExtractEmcInfotempfile=/tmp/cmt.$$
endif
${CMTROOT}/mgr/cmt setup -csh -pack=ExtractEmcInfo -version=ExtractEmcInfo-00-00-01 -path=/junofs/users/yuansc/bes3_emc/code/boss/workarea  -no_cleanup $* >${cmtExtractEmcInfotempfile}
if ( $status != 0 ) then
  echo "${CMTROOT}/mgr/cmt setup -csh -pack=ExtractEmcInfo -version=ExtractEmcInfo-00-00-01 -path=/junofs/users/yuansc/bes3_emc/code/boss/workarea  -no_cleanup $* >${cmtExtractEmcInfotempfile}"
  set cmtsetupstatus=2
  /bin/rm -f ${cmtExtractEmcInfotempfile}
  unset cmtExtractEmcInfotempfile
  exit $cmtsetupstatus
endif
set cmtsetupstatus=0
source ${cmtExtractEmcInfotempfile}
if ( $status != 0 ) then
  set cmtsetupstatus=2
endif
/bin/rm -f ${cmtExtractEmcInfotempfile}
unset cmtExtractEmcInfotempfile
exit $cmtsetupstatus

