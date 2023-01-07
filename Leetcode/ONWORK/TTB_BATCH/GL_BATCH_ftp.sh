#!/bin/bash  -eu

echo $( /usr/bin/date +"%Y%m%d %T")' FTP to FTP Server'

HOST=$GL_HOST
USER=$GL_USER
LOCAL_DIR='/oracledata/RLOSBATCH/GL_BATCH/output/'
FTP_FOLDER='/RLOS/'$FTP_ENV'/GL_BATCH/OUT'

FILETYPE='.txt'
APPENDDATE=$L_DATE
PREFIX_FILENAME='RSL_FAH_E_'

FILENAME=$PREFIX_FILENAME$APPENDDATE'_001'$FILETYPE


errFlag=1
cd $LOCAL_DIR
[ -s $FILENAME ] && errFlag=0
if(($errFlag == 1))
then
	echo $( /usr/bin/date +"%Y%m%d %T")' GL_BATCH FTP Failed File Not Found' >> /oracledata/RLOSBATCH/GL_BATCH/log/GL_BATCH_$L_DATE.log
	exit 1
fi

echo $FILENAME
PASSWD=$GL_PASSWD

/usr/bin/ftp -i -n $HOST <<END_FTP
quote USER $USER
quote PASS $PASSWD
lcd $LOCAL_DIR
cd $FTP_FOLDER
mput $FILENAME
ls $FTP_FOLDER $FILENAME.log
bye
END_FTP
echo $( /usr/bin/date +"%Y%m%d %T")' End of FTP'
cd $LOCAL_DIR
if [ -s $FILENAME.log ]
then
	CheckFileName=`/usr/bin/grep $FILENAME $FILENAME.log|/usr/bin/wc -l`
	if test $CheckFileName -ne 0 ; then
		echo $( /usr/bin/date +"%Y%m%d %T")' GL_BATCH FTP Success' >> /oracledata/RLOSBATCH/GL_BATCH/log/GL_BATCH_$L_DATE.log
		/usr/bin/rm -f $FILENAME.log
		exit 0
	else
		echo $( /usr/bin/date +"%Y%m%d %T")' GL_BATCH FTP Failed' >> /oracledata/RLOSBATCH/GL_BATCH/log/GL_BATCH_$L_DATE.log
		/usr/bin/rm -f $FILENAME.log
		exit 1
	fi
else
	echo $( /usr/bin/date +"%Y%m%d %T")' GL_BATCH FTP Failed' >> /oracledata/RLOSBATCH/GL_BATCH/log/GL_BATCH_$L_DATE.log
	/usr/bin/rm -f $FILENAME.log
	exit 1
fi
