/**************************************************************************
 Program:  Cen2000_sf1_dc_blks.sas
 Library:  Census
 Project:  NeighborhoodInfo DC
 Author:   P. Tatian
 Created:  11/30/17
 Version:  SAS 9.2
 Environment:  Local Windows session (desktop)
 
 Description: Create Census 2000 SF1 block and other summary level data
 for DC.

 Modifications:
**************************************************************************/

%include "L:\SAS\Inc\StdLocal.sas";

** Define libraries **;
%DCData_lib( Census )


%Cen2000_sf1( stateab=dc, revisions=%str(Replace with new file process. (No data changes.)) )

