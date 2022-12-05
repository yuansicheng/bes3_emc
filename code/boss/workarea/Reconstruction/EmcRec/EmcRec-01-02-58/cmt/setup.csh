# echo "setup EmcRec EmcRec-01-02-58 in /junofs/users/yuansc/bes3_emc/code/boss/workarea/Reconstruction"

if ( $?CMTROOT == 0 ) then
  setenv CMTROOT /cvmfs/bes3.ihep.ac.cn/bes3sw/ExternalLib/SLC6/contrib/CMT/v1r25
endif
source ${CMTROOT}/mgr/setup.csh
set cmtEmcRectempfile=`${CMTROOT}/mgr/cmt -quiet build temporary_name`
if $status != 0 then
  set cmtEmcRectempfile=/tmp/cmt.$$
endif
${CMTROOT}/mgr/cmt setup -csh -pack=EmcRec -version=EmcRec-01-02-58 -path=/junofs/users/yuansc/bes3_emc/code/boss/workarea/Reconstruction  -quiet -with_version_directory -no_cleanup $* >${cmtEmcRectempfile}
if ( $status != 0 ) then
  echo "${CMTROOT}/mgr/cmt setup -csh -pack=EmcRec -version=EmcRec-01-02-58 -path=/junofs/users/yuansc/bes3_emc/code/boss/workarea/Reconstruction  -quiet -with_version_directory -no_cleanup $* >${cmtEmcRectempfile}"
  set cmtsetupstatus=2
  /bin/rm -f ${cmtEmcRectempfile}
  unset cmtEmcRectempfile
  exit $cmtsetupstatus
endif
set cmtsetupstatus=0
source ${cmtEmcRectempfile}
if ( $status != 0 ) then
  set cmtsetupstatus=2
endif
/bin/rm -f ${cmtEmcRectempfile}
unset cmtEmcRectempfile
exit $cmtsetupstatus

