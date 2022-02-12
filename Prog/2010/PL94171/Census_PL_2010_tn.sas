/**************************************************************************
 Program:  Census_PL_2010_tn.sas
 Library:  Census
 Project:  NeighborhoodInfo DC
 Author:   P. Tatian
 Created:  02/12/22
 Version:  SAS 9.2
 Environment:  Windows
 
 Description:  Read Census 2010 PL94-171 Redistricting data.

 Tennessee

 Modifications:
**************************************************************************/

%include "\\sas1\DCdata\SAS\Inc\StdLocal.sas";

** Define libraries **;
%DCData_lib( Census )

*options obs=100;

%pl_all_3_2010_mac( tn )

run;
