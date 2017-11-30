/**************************************************************************
 Program:  Cen2000_sf1_md.sas
 Library:  Census
 Project:  NeighborhoodInfo DC
 Author:   P. Tatian
 Created:  11/30/17
 Version:  SAS 9.2
 Environment:  Local Windows session (desktop)
 
 Description: Create Census 2000 SF1 block and other summary level data
 for MD.

 Modifications:
**************************************************************************/

%include "L:\SAS\Inc\StdLocal.sas";

** Define libraries **;
%DCData_lib( Census )


%Cen2000_sf1( stateab=md )

