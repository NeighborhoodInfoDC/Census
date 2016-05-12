/**************************************************************************
 Program:  Download_Cen2000_sf1_dc_blks.sas
 Library:  Census
 Project:  NeighborhoodInfo DC
 Author:   P. Tatian
 Created:  04/05/06
 Version:  SAS 8.2
 Environment:  Windows with SAS/Connect
 
 Description:  Download data set Cen2000_sf1_dc_blks from Alpha.

 Modifications:
**************************************************************************/

%include "K:\Metro\PTatian\DCData\SAS\Inc\Stdhead.sas";
%include "K:\Metro\PTatian\DCData\SAS\Inc\AlphaSignon.sas" /nosource2;

** Define libraries **;
%DCData_lib( Census )

rsubmit;

proc download status=no
  data=Census.Cen2000_sf1_dc_blks 
  out=Census.Cen2000_sf1_dc_blks;

run;

endrsubmit;

signoff;

