/**************************************************************************
 Program:  Census_PL_2010_va.sas
 Library:  Census
 Project:  NeighborhoodInfo DC
 Author:   P. Tatian
 Created:  03/28/11
 Version:  SAS 9.1
 Environment:  Windows
 
 Description:  Read Census 2010 PL94-171 Redistricting data.

 Virginia

 Modifications:
  06/11/11 PAT Added GeoBlk2010, GeoBg2010, and Geo2010 vars.
**************************************************************************/

%include "K:\Metro\PTatian\DCData\SAS\Inc\Stdhead.sas";

** Define libraries **;
%DCData_lib( Census )

*options obs=100;

%pl_all_3_2010_mac( va )

run;
