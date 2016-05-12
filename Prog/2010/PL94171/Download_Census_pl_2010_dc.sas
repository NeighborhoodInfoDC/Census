/**************************************************************************
 Program:  Download_Census_pl_2010_dc.sas
 Library:  Census
 Project:  NeighborhoodInfo DC
 Author:   P. Tatian
 Created:  12/06/12
 Version:  SAS 9.2
 Environment:  Windows with SAS/Connect
 
 Description:  Download data set Census.Census_pl_2010_dc from Alpha.

 Modifications:
**************************************************************************/

%include "K:\Metro\PTatian\DCData\SAS\Inc\Stdhead.sas";
%include "K:\Metro\PTatian\DCData\SAS\Inc\AlphaSignon.sas" /nosource2;

** Define libraries **;
%DCData_lib( Census )

rsubmit;

proc download status=no
  data=Census.Census_pl_2010_dc 
  out=Census.Census_pl_2010_dc;

run;

endrsubmit;

signoff;

