/**************************************************************************
 Program:  {program}.sas
 Library:  Format_sumlev10f.sas
 Project:  NeighborhoodInfo DC
 Author:   P Tatian
 Created:  1/15/14
 Version:  SAS 9.2
 Environment:  Local Windows session (desktop)
 
 Description: Create $sumlev10f. format for 2010 SF1 summary levels.

 Modifications:
**************************************************************************/

%include "L:\SAS\Inc\StdLocal.sas";

** Define libraries **;
%DCData_lib( Census )

proc format library=Census_r fmtlib;
  value $sumlev10f
    "040" = "State"
    "050" = "County"
    "060" = "County Subdivision"
    "140" = "Census Tract"
    "155" = "Place-County"
    "160" = "Place"
    "320" = "State- CBSA"
    "340" = "State-Combined Statistical Area"
    "420" = "State-Urban Area"
    "500" = "Congressional District"
    "610" = "State Senate District"
    "871" = "State-5-digit ZIP Code Tabulation Area"
    "970" = "State-Unified School District"
    "100" = "Block";
  select $SUM10F $sumlev10f;

proc catalog catalog=Census_r.formats;
  modify sumlev10f (desc="Census 2010 SF1 summary levels") / entrytype=formatc;
  contents;
quit;

run;
