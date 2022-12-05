# echo "cleanup NNGeneratorSvc NNGeneratorSvc-00-00-01 in /junofs/users/yuansc/bes3_emc/code/boss/workarea"

if ( $?CMTROOT == 0 ) then
  setenv CMTROOT /cvmfs/bes3.ihep.ac.cn/bes3sw/ExternalLib/SLC6/contrib/CMT/v1r25
endif
source ${CMTROOT}/mgr/setup.csh
set cmtNNGeneratorSvctempfile=`${CMTROOT}/mgr/cmt -quiet build temporary_name`
if $status != 0 then
  set cmtNNGeneratorSvctempfile=/tmp/cmt.$$
endif
${CMTROOT}/mgr/cmt cleanup -csh -pack=NNGeneratorSvc -version=NNGeneratorSvc-00-00-01 -path=/junofs/users/yuansc/bes3_emc/code/boss/workarea  $* >${cmtNNGeneratorSvctempfile}
if ( $status != 0 ) then
  echo "${CMTROOT}/mgr/cmt cleanup -csh -pack=NNGeneratorSvc -version=NNGeneratorSvc-00-00-01 -path=/junofs/users/yuansc/bes3_emc/code/boss/workarea  $* >${cmtNNGeneratorSvctempfile}"
  set cmtcleanupstatus=2
  /bin/rm -f ${cmtNNGeneratorSvctempfile}
  unset cmtNNGeneratorSvctempfile
  exit $cmtcleanupstatus
endif
set cmtcleanupstatus=0
source ${cmtNNGeneratorSvctempfile}
if ( $status != 0 ) then
  set cmtcleanupstatus=2
endif
/bin/rm -f ${cmtNNGeneratorSvctempfile}
unset cmtNNGeneratorSvctempfile
exit $cmtcleanupstatus

