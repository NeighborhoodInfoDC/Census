/**************************************************************************
 Project:  Urban-Greater DC
 Author:   Peter Tatian
 Created:  02/12/22
 Version:  SAS 9.4
 Environment:  Windows
 
 Description:  Read Census 2020 PL94-171 Redistricting data.

 Washington (state)

 Modifications:
**************************************************************************/

%include "\\sas1\DCdata\SAS\Inc\StdLocal.sas";

** Define libraries **;
%DCData_lib( Census )

*options obs=100;

%pl_all_4_2020_mac( wa )

run;
