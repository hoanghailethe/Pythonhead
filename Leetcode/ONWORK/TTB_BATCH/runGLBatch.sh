#!/bin/bash  -eu
echo $( /usr/bin/date +"%Y%m%d %T")' Connect to Oracle'
LANG=en_EN.utf-8
locale
ORACLE_HOME=/oracle/product/11.2.0/dbhome_1
export ORACLE_HOME

PATH=/oracle/product/11.2.0/dbhome_1/bin
export PATH

ORACLE_SID=$DB_SID
export ORACLE_SID

NLS_LANG=THAI_THAILAND.TH8TISASCII
export NLS_LANG

cd /oracledata/RLOSBATCH/GL_BATCH

sqlplus rlosprd/$DB_PASSWD << EOF
whenever sqlerror exit 1;
whenever oserror exit 1;

@execProcedure
@execGL.sql

EOF

status=$?
if test $status -ne 0 ; then
   echo $( /usr/bin/date +"%Y%m%d %T")' Batch error' >> /oracledata/RLOSBATCH/GL_BATCH/log/GL_BATCH_$L_DATE.log
   exit 1
else
   echo $( /usr/bin/date +"%Y%m%d %T")' Batch OK' >> /oracledata/RLOSBATCH/GL_BATCH/log/GL_BATCH_$L_DATE.log
   cd /oracledata/RLOSBATCH/GL_BATCH/
   ./GL_BATCH_ftp.sh >> /oracledata/RLOSBATCH/GL_BATCH/log/GL_BATCH_$L_DATE.log

exit 0
fi
