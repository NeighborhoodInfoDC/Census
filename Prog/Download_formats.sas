/**************************************************************************
 Program:  Download_formats.sas
 Library:  Police
 Project:  NeighborhoodInfo DC
 Author:   P. Tatian
 Created:  07/22/12
 Version:  SAS 9.2
 Environment:  Windows with SAS/Connect
 
 Description:  Download formats from ALPHA Census library.

 Modifications:
**************************************************************************/

%include "K:\Metro\PTatian\DCData\SAS\Inc\Stdhead.sas";
%include "K:\Metro\PTatian\DCData\SAS\Inc\AlphaSignon.sas" /nosource2;

** Define libraries **;
%DCData_lib( Census )

rsubmit;

proc download status=no
	inlib=Census
	outlib=Census memtype=(catalog);
	select formats;
run;

endrsubmit;

title2 'Local Catalog';
proc catalog catalog=Census.formats;
  contents;
quit;

run;

title2;

signoff;

