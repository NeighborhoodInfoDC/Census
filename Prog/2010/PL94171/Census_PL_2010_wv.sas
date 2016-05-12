/**************************************************************************
 Program:  Census_PL_2010_wv.sas
 Library:  Census
 Project:  NeighborhoodInfo DC
 Author:   P. Tatian
 Created:  08/27/12
 Version:  SAS 9.2
 Environment:  Windows
 
 Description:  Read Census 2010 PL94-171 Redistricting data.

 Virginia

 Modifications:
**************************************************************************/

%include "K:\Metro\PTatian\DCData\SAS\Inc\Stdhead.sas";

** Define libraries **;
%DCData_lib( Census )

*options obs=100;

%pl_all_3_2010_mac( wv )

run;
