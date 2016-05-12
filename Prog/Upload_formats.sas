/**************************************************************************
 Program:  Upload_formats.sas
 Library:  Census
 Project:  NeighborhoodInfo DC
 Author:   P. Tatian
 Created:  03/28/11
 Version:  SAS 9.1
 Environment:  Windows with SAS/Connect
 
 Description:  Upload Census format catalog to Alpha.

 Modifications:
**************************************************************************/

%include "K:\Metro\PTatian\DCData\SAS\Inc\Stdhead.sas";
%include "K:\Metro\PTatian\DCData\SAS\Inc\AlphaSignon.sas" /nosource2;

** Define libraries **;
%DCData_lib( Census )

** Start submitting commands to remote server **;

rsubmit;

proc upload status=no
  inlib=Census 
  outlib=Census memtype=(catalog);
run;

proc catalog catalog=Census.formats;
  contents;
quit;

run;

endrsubmit;

** End submitting commands to remote server **;

run;

signoff;
