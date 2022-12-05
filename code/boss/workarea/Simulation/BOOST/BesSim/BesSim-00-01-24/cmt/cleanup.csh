# echo "cleanup BesSim BesSim-00-01-24 in /junofs/users/yuansc/bes3_emc/code/boss/workarea/Simulation/BOOST"

if ( $?CMTROOT == 0 ) then
  setenv CMTROOT /cvmfs/bes3.ihep.ac.cn/bes3sw/ExternalLib/SLC6/contrib/CMT/v1r25
endif
source ${CMTROOT}/mgr/setup.csh
set cmtBesSimtempfile=`${CMTROOT}/mgr/cmt -quiet build temporary_name`
if $status != 0 then
  set cmtBesSimtempfile=/tmp/cmt.$$
endif
${CMTROOT}/mgr/cmt cleanup -csh -pack=BesSim -version=BesSim-00-01-24 -path=/junofs/users/yuansc/bes3_emc/code/boss/workarea/Simulation/BOOST  -quiet -with_version_directory $* >${cmtBesSimtempfile}
if ( $status != 0 ) then
  echo "${CMTROOT}/mgr/cmt cleanup -csh -pack=BesSim -version=BesSim-00-01-24 -path=/junofs/users/yuansc/bes3_emc/code/boss/workarea/Simulation/BOOST  -quiet -with_version_directory $* >${cmtBesSimtempfile}"
  set cmtcleanupstatus=2
  /bin/rm -f ${cmtBesSimtempfile}
  unset cmtBesSimtempfile
  exit $cmtcleanupstatus
endif
set cmtcleanupstatus=0
source ${cmtBesSimtempfile}
if ( $status != 0 ) then
  set cmtcleanupstatus=2
endif
/bin/rm -f ${cmtBesSimtempfile}
unset cmtBesSimtempfile
exit $cmtcleanupstatus

