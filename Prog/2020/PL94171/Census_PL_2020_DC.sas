/**************************************************************************
 Project:  Urban-Greater DC
 Author:   Elizabeth Burton
 Created:  08/16/21
 Version:  SAS 9.4
 Environment:  Windows
 
 Description:  Read Census 2020 PL94-171 Redistricting data.

 District of Columbia

 Modifications: 
**************************************************************************/

%include "\\sas1\DCdata\SAS\Inc\StdLocal.sas";

** Define libraries **;
%DCData_lib( Census )

*options obs=100;

%pl_all_4_2020_mac( dc )

run;
