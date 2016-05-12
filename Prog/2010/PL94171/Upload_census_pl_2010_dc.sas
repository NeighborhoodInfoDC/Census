/**************************************************************************
 Program:  Upload_Census_PL_2010_dc.sas
 Library:  Census
 Project:  NeighborhoodInfo DC
 Author:   P. Tatian
 Created:  03/28/11
 Version:  SAS 9.1
 Environment:  Windows with SAS/Connect
 
 Description:  Upload and register Census_PL_2010_dc.

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
  select Census_PL_2010_dc;
run;

%Dc_update_meta_file(
  ds_lib=Census,
  ds_name=Census_PL_2010_dc,
  creator_process=Census_PL_2010_dc.sas,
  restrictions=None,
  revisions=%str(Added GeoBlk2010, GeoBg2010, and Geo2010 vars.)
)

x "purge [DCDATA.CENSUS.DATA]Census_PL_2010_dc.*";

run;

endrsubmit;

** End submitting commands to remote server **;

run;

signoff;
