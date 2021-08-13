/* This SAS program will make a SAS DATASET from the data part1 Segment */
/* User will have to modify the libname,data and infile statements to conform to his environment*/
/* */
libname xxx 'the location of the files on your computer';
data xxx.mpart1;
infile 'the location of the files on your computer\ms000012020.pl' lrecl = 20000 dlm='|' dsd missover pad;
LENGTH
FILEID   $6 /*File Identification*/
STUSAB   $2 /*State/US-Abbreviation (USPS)*/
CHARITER $3 /*Characteristic Iteration*/
CIFSN    $2 /*Characteristic Iteration File Sequence Number*/
LOGRECNO $7 /*Logical Record Number*/
P0010001 $9 /*Total:*/
P0010002 $9 /*Population of one race:*/
P0010003 $9 /*White alone*/
P0010004 $9 /*Black or African American alone*/
P0010005 $9 /*American Indian and Alaska Native alone*/
P0010006 $9 /*Asian alone*/
P0010007 $9 /*Native Hawaiian and Other Pacific Islander alone*/
P0010008 $9 /*Some Other Race alone*/
P0010009 $9 /*Population of two or more races:*/
P0010010 $9 /*Population of two races:*/
P0010011 $9 /*White; Black or African American*/
P0010012 $9 /*White; American Indian and Alaska Native*/
P0010013 $9 /*White; Asian*/
P0010014 $9 /*White; Native Hawaiian and Other Pacific Islander*/
P0010015 $9 /*White; Some Other Race*/
P0010016 $9 /*Black or African American; American Indian and Alaska Native*/
P0010017 $9 /*Black or African American; Asian*/
P0010018 $9 /*Black or African American; Native Hawaiian and Other Pacific Islander*/
P0010019 $9 /*Black or African American; Some Other Race*/
P0010020 $9 /*American Indian and Alaska Native; Asian*/
P0010021 $9 /*American Indian and Alaska Native; Native Hawaiian and Other Pacific Islander*/
P0010022 $9 /*American Indian and Alaska Native; Some Other Race*/
P0010023 $9 /*Asian; Native Hawaiian and Other Pacific Islander*/
P0010024 $9 /*Asian; Some Other Race*/
P0010025 $9 /*Native Hawaiian and Other Pacific Islander; Some Other Race*/
P0010026 $9 /*Population of three races:*/
P0010027 $9 /*White; Black or African American; American Indian and Alaska Native*/
P0010028 $9 /*White; Black or African American; Asian*/
P0010029 $9 /*White; Black or African American; Native Hawaiian and Other Pacific Islander*/
P0010030 $9 /*White; Black or African American; Some Other Race*/
P0010031 $9 /*White; American Indian and Alaska Native; Asian*/
P0010032 $9 /*White; American Indian and Alaska Native; Native Hawaiian and Other Pacific Islander*/
P0010033 $9 /*White; American Indian and Alaska Native; Some Other Race*/
P0010034 $9 /*White; Asian; Native Hawaiian and Other Pacific Islander*/
P0010035 $9 /*White; Asian; Some Other Race*/
P0010036 $9 /*White; Native Hawaiian and Other Pacific Islander; Some Other Race*/
P0010037 $9 /*Black or African American; American Indian and Alaska Native; Asian*/
P0010038 $9 /*Black or African American; American Indian and Alaska Native; Native Hawaiian and Other Pacific Islander*/
P0010039 $9 /*Black or African American; American Indian and Alaska Native; Some Other Race*/
P0010040 $9 /*Black or African American; Asian; Native Hawaiian and Other Pacific Islander*/
P0010041 $9 /*Black or African American; Asian; Some Other Race*/
P0010042 $9 /*Black or African American; Native Hawaiian and Other Pacific Islander; Some Other Race*/
P0010043 $9 /*American Indian and Alaska Native; Asian; Native Hawaiian and Other Pacific Islander*/
P0010044 $9 /*American Indian and Alaska Native; Asian; Some Other Race*/
P0010045 $9 /*American Indian and Alaska Native; Native Hawaiian and Other Pacific Islander; Some Other Race*/
P0010046 $9 /*Asian; Native Hawaiian and Other Pacific Islander; Some Other Race*/
P0010047 $9 /*Population of four races:*/
P0010048 $9 /*White; Black or African American; American Indian and Alaska Native; Asian*/
P0010049 $9 /*White; Black or African American; American Indian and Alaska Native; Native Hawaiian and Other Pacific Islander*/
P0010050 $9 /*White; Black or African American; American Indian and Alaska Native; Some Other Race*/
P0010051 $9 /*White; Black or African American; Asian; Native Hawaiian and Other Pacific Islander*/
P0010052 $9 /*White; Black or African American; Asian; Some Other Race*/
P0010053 $9 /*White; Black or African American; Native Hawaiian and Other Pacific Islander; Some Other Race*/
P0010054 $9 /*White; American Indian and Alaska Native; Asian; Native Hawaiian and Other Pacific Islander*/
P0010055 $9 /*White; American Indian and Alaska Native; Asian; Some Other Race*/
P0010056 $9 /*White; American Indian and Alaska Native; Native Hawaiian and Other Pacific Islander; Some Other Race*/
P0010057 $9 /*White; Asian; Native Hawaiian and Other Pacific Islander; Some Other Race*/
P0010058 $9 /*Black or African American; American Indian and Alaska Native; Asian; Native Hawaiian and Other Pacific Islander*/
P0010059 $9 /*Black or African American; American Indian and Alaska Native; Asian; Some Other Race*/
P0010060 $9 /*Black or African American; American Indian and Alaska Native; Native Hawaiian and Other Pacific Islander; Some Other Race*/
P0010061 $9 /*Black or African American; Asian; Native Hawaiian and Other Pacific Islander; Some Other Race*/
P0010062 $9 /*American Indian and Alaska Native; Asian; Native Hawaiian and Other Pacific Islander; Some Other Race*/
P0010063 $9 /*Population of five races:*/
P0010064 $9 /*White; Black or African American; American Indian and Alaska Native; Asian; Native Hawaiian and Other Pacific Islander*/
P0010065 $9 /*White; Black or African American; American Indian and Alaska Native; Asian; Some Other Race*/
P0010066 $9 /*White; Black or African American; American Indian and Alaska Native; Native Hawaiian and Other Pacific Islander; Some Other Race*/
P0010067 $9 /*White; Black or African American; Asian; Native Hawaiian and Other Pacific Islander; Some Other Race*/
P0010068 $9 /*White; American Indian and Alaska Native; Asian; Native Hawaiian and Other Pacific Islander; Some Other Race*/
P0010069 $9 /*Black or African American; American Indian and Alaska Native; Asian; Native Hawaiian and Other Pacific Islander; Some Other Race*/
P0010070 $9 /*Population of six races:*/
P0010071 $9 /*White; Black or African American; American Indian and Alaska Native; Asian; Native Hawaiian and Other Pacific Islander; Some Other Race*/
P0020001 $9 /*Total:*/
P0020002 $9 /*Hispanic or Latino*/
P0020003 $9 /*Not Hispanic or Latino:*/
P0020004 $9 /*Population of one race:*/
P0020005 $9 /*White alone*/
P0020006 $9 /*Black or African American alone*/
P0020007 $9 /*American Indian and Alaska Native alone*/
P0020008 $9 /*Asian alone*/
P0020009 $9 /*Native Hawaiian and Other Pacific Islander alone*/
P0020010 $9 /*Some Other Race alone*/
P0020011 $9 /*Population of two or more races:*/
P0020012 $9 /*Population of two races:*/
P0020013 $9 /*White; Black or African American*/
P0020014 $9 /*White; American Indian and Alaska Native*/
P0020015 $9 /*White; Asian*/
P0020016 $9 /*White; Native Hawaiian and Other Pacific Islander*/
P0020017 $9 /*White; Some Other Race*/
P0020018 $9 /*Black or African American; American Indian and Alaska Native*/
P0020019 $9 /*Black or African American; Asian*/
P0020020 $9 /*Black or African American; Native Hawaiian and Other Pacific Islander*/
P0020021 $9 /*Black or African American; Some Other Race*/
P0020022 $9 /*American Indian and Alaska Native; Asian*/
P0020023 $9 /*American Indian and Alaska Native; Native Hawaiian and Other Pacific Islander*/
P0020024 $9 /*American Indian and Alaska Native; Some Other Race*/
P0020025 $9 /*Asian; Native Hawaiian and Other Pacific Islander*/
P0020026 $9 /*Asian; Some Other Race*/
P0020027 $9 /*Native Hawaiian and Other Pacific Islander; Some Other Race*/
P0020028 $9 /*Population of three races:*/
P0020029 $9 /*White; Black or African American; American Indian and Alaska Native*/
P0020030 $9 /*White; Black or African American; Asian*/
P0020031 $9 /*White; Black or African American; Native Hawaiian and Other Pacific Islander*/
P0020032 $9 /*White; Black or African American; Some Other Race*/
P0020033 $9 /*White; American Indian and Alaska Native; Asian*/
P0020034 $9 /*White; American Indian and Alaska Native; Native Hawaiian and Other Pacific Islander*/
P0020035 $9 /*White; American Indian and Alaska Native; Some Other Race*/
P0020036 $9 /*White; Asian; Native Hawaiian and Other Pacific Islander*/
P0020037 $9 /*White; Asian; Some Other Race*/
P0020038 $9 /*White; Native Hawaiian and Other Pacific Islander; Some Other Race*/
P0020039 $9 /*Black or African American; American Indian and Alaska Native; Asian*/
P0020040 $9 /*Black or African American; American Indian and Alaska Native; Native Hawaiian and Other Pacific Islander*/
P0020041 $9 /*Black or African American; American Indian and Alaska Native; Some Other Race*/
P0020042 $9 /*Black or African American; Asian; Native Hawaiian and Other Pacific Islander*/
P0020043 $9 /*Black or African American; Asian; Some Other Race*/
P0020044 $9 /*Black or African American; Native Hawaiian and Other Pacific Islander; Some Other Race*/
P0020045 $9 /*American Indian and Alaska Native; Asian; Native Hawaiian and Other Pacific Islander*/
P0020046 $9 /*American Indian and Alaska Native; Asian; Some Other Race*/
P0020047 $9 /*American Indian and Alaska Native; Native Hawaiian and Other Pacific Islander; Some Other Race*/
P0020048 $9 /*Asian; Native Hawaiian and Other Pacific Islander; Some Other Race*/
P0020049 $9 /*Population of four races:*/
P0020050 $9 /*White; Black or African American; American Indian and Alaska Native; Asian*/
P0020051 $9 /*White; Black or African American; American Indian and Alaska Native; Native Hawaiian and Other Pacific Islander*/
P0020052 $9 /*White; Black or African American; American Indian and Alaska Native; Some Other Race*/
P0020053 $9 /*White; Black or African American; Asian; Native Hawaiian and Other Pacific Islander*/
P0020054 $9 /*White; Black or African American; Asian; Some Other Race*/
P0020055 $9 /*White; Black or African American; Native Hawaiian and Other Pacific Islander; Some Other Race*/
P0020056 $9 /*White; American Indian and Alaska Native; Asian; Native Hawaiian and Other Pacific Islander*/
P0020057 $9 /*White; American Indian and Alaska Native; Asian; Some Other Race*/
P0020058 $9 /*White; American Indian and Alaska Native; Native Hawaiian and Other Pacific Islander; Some Other Race*/
P0020059 $9 /*White; Asian; Native Hawaiian and Other Pacific Islander; Some Other Race*/
P0020060 $9 /*Black or African American; American Indian and Alaska Native; Asian; Native Hawaiian and Other Pacific Islander*/
P0020061 $9 /*Black or African American; American Indian and Alaska Native; Asian; Some Other Race*/
P0020062 $9 /*Black or African American; American Indian and Alaska Native; Native Hawaiian and Other Pacific Islander; Some Other Race*/
P0020063 $9 /*Black or African American; Asian; Native Hawaiian and Other Pacific Islander; Some Other Race*/
P0020064 $9 /*American Indian and Alaska Native; Asian; Native Hawaiian and Other Pacific Islander; Some Other Race*/
P0020065 $9 /*Population of five races:*/
P0020066 $9 /*White; Black or African American; American Indian and Alaska Native; Asian; Native Hawaiian and Other Pacific Islander*/
P0020067 $9 /*White; Black or African American; American Indian and Alaska Native; Asian; Some Other Race*/
P0020068 $9 /*White; Black or African American; American Indian and Alaska Native; Native Hawaiian and Other Pacific Islander; Some Other Race*/
P0020069 $9 /*White; Black or African American; Asian; Native Hawaiian and Other Pacific Islander; Some Other Race*/
P0020070 $9 /*White; American Indian and Alaska Native; Asian; Native Hawaiian and Other Pacific Islander; Some Other Race*/
P0020071 $9 /*Black or African American; American Indian and Alaska Native; Asian; Native Hawaiian and Other Pacific Islander; Some Other Race*/
P0020072 $9 /*Population of six races:*/
P0020073 $9 /*White; Black or African American; American Indian and Alaska Native; Asian; Native Hawaiian and Other Pacific Islander; Some Other Race*/
;
INPUT
FILEID   $
STUSAB   $
CHARITER $
CIFSN    $
LOGRECNO $
P0010001 $
P0010002 $
P0010003 $
P0010004 $
P0010005 $
P0010006 $
P0010007 $
P0010008 $
P0010009 $
P0010010 $
P0010011 $
P0010012 $
P0010013 $
P0010014 $
P0010015 $
P0010016 $
P0010017 $
P0010018 $
P0010019 $
P0010020 $
P0010021 $
P0010022 $
P0010023 $
P0010024 $
P0010025 $
P0010026 $
P0010027 $
P0010028 $
P0010029 $
P0010030 $
P0010031 $
P0010032 $
P0010033 $
P0010034 $
P0010035 $
P0010036 $
P0010037 $
P0010038 $
P0010039 $
P0010040 $
P0010041 $
P0010042 $
P0010043 $
P0010044 $
P0010045 $
P0010046 $
P0010047 $
P0010048 $
P0010049 $
P0010050 $
P0010051 $
P0010052 $
P0010053 $
P0010054 $
P0010055 $
P0010056 $
P0010057 $
P0010058 $
P0010059 $
P0010060 $
P0010061 $
P0010062 $
P0010063 $
P0010064 $
P0010065 $
P0010066 $
P0010067 $
P0010068 $
P0010069 $
P0010070 $
P0010071 $
P0020001 $
P0020002 $
P0020003 $
P0020004 $
P0020005 $
P0020006 $
P0020007 $
P0020008 $
P0020009 $
P0020010 $
P0020011 $
P0020012 $
P0020013 $
P0020014 $
P0020015 $
P0020016 $
P0020017 $
P0020018 $
P0020019 $
P0020020 $
P0020021 $
P0020022 $
P0020023 $
P0020024 $
P0020025 $
P0020026 $
P0020027 $
P0020028 $
P0020029 $
P0020030 $
P0020031 $
P0020032 $
P0020033 $
P0020034 $
P0020035 $
P0020036 $
P0020037 $
P0020038 $
P0020039 $
P0020040 $
P0020041 $
P0020042 $
P0020043 $
P0020044 $
P0020045 $
P0020046 $
P0020047 $
P0020048 $
P0020049 $
P0020050 $
P0020051 $
P0020052 $
P0020053 $
P0020054 $
P0020055 $
P0020056 $
P0020057 $
P0020058 $
P0020059 $
P0020060 $
P0020061 $
P0020062 $
P0020063 $
P0020064 $
P0020065 $
P0020066 $
P0020067 $
P0020068 $
P0020069 $
P0020070 $
P0020071 $
P0020072 $
P0020073 $;
run;
