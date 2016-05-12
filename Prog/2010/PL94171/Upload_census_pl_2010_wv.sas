/**************************************************************************
 Program:  Upload_Census_PL_2010_wv.sas
 Library:  Census
 Project:  NeighborhoodInfo DC
 Author:   P. Tatian
 Created:  08/27/11
 Version:  SAS 9.2
 Environment:  Windows with SAS/Connect
 
 Description:  Upload and register Census_PL_2010_wv.

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
  outlib=Census memtype=(data);
  select Census_PL_2010_wv;
run;

%Dc_update_meta_file(
  ds_lib=Census,
  ds_name=Census_PL_2010_wv,
  creator_process=Census_PL_2010_wv.sas,
  restrictions=None,
  revisions=%str(New file.)
)

x "purge [DCDATA.CENSUS.DATA]Census_PL_2010_wv.*";

run;

endrsubmit;

** End submitting commands to remote server **;

run;

signoff;
