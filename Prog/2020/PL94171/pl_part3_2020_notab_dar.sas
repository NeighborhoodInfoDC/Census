/* This SAS program will make a SAS DATASET from data part 3 Segment */
/* User will have to modify the libname,data and infile statements to conform to his environment*/
/* */
libname xxx 'the location of the files on your computer';
data xxx.mpart3;
infile 'the location of the files on your computer\ms000032020.pl' lrecl = 20000 dlm='|' dsd missover pad;
LENGTH
FILEID   $6 /*File Identification*/
STUSAB   $2 /*State/US-Abbreviation (USPS)*/
CHARITER $3 /*Characteristic Iteration*/
CIFSN    $2 /*Characteristic Iteration File Sequence Number*/
LOGRECNO $7 /*Logical Record Number*/
P0050001 $9 /*Total:*/
P0050002 $9 /*Institutionalized population:*/
P0050003 $9 /*Correctional facilities for adults*/
P0050004 $9 /*Juvenile facilities*/
P0050005 $9 /*Nursing facilities/Skilled-nursing facilities*/
P0050006 $9 /*Other institutional facilities*/
P0050007 $9 /*Noninstitutionalized population:*/
P0050008 $9 /*College/University student housing*/
P0050009 $9 /*Military quarters*/
P0050010 $9 /*Other noninstitutional facilities*/
;
INPUT
FILEID   $
STUSAB   $
CHARITER $
CIFSN    $
LOGRECNO $
P0050001 $
P0050002 $
P0050003 $
P0050004 $
P0050005 $
P0050006 $
P0050007 $
P0050008 $
P0050009 $
P0050010 $
;
run;
