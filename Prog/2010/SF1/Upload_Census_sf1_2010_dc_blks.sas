/************************************************************************
 Program:  Upload_Census_sf1_2010_dc_blks.sas
 Library:  Census
 Project:  DC Data Warehouse
 Author:   S. Litschwartz
 Created:  9/23/11
 Version:  SAS 8.2
 Environment:  Windows with SAS/Connect
 
 Description: Upload 2010 Census DC SF1 data to alpha
************************************************************************/

%include "K:\Metro\PTatian\DCData\SAS\Inc\Stdhead.sas";
%include "K:\Metro\PTatian\DCData\SAS\Inc\AlphaSignon.sas" /nosource2;

** Define libraries **;
%DCData_lib( Census)

** Upload 2010 SF1 data set to Alpha **;

rsubmit;

proc upload status=no
  inlib=Census
  outlib=Census memtype=(data);
  select Census_sf1_2010_dc_blks;

run;


endrsubmit;

run;
