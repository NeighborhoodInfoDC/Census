/**************************************************************************
 Program:  Upload_census_est_dc.sas
 Library:  Census
 Project:  NeighborhoodInfo DC
 Author:   P. Tatian
 Created:  01/02/08
 Version:  SAS 9.1
 Environment:  Windows with SAS/Connect
 
 Description:  Upload and register Census_est_dc.

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
  select formats;

run;

proc upload status=no
  inlib=Census 
  outlib=Census memtype=(data);
  select Census_est_dc;

run;

%Dc_update_meta_file(
  ds_lib=Census,
  ds_name=Census_est_dc,
  creator_process=Census_est_dc.sas,
  restrictions=None,
  revisions=%str(New file.)
)

run;

endrsubmit;

** End submitting commands to remote server **;

run;

signoff;
