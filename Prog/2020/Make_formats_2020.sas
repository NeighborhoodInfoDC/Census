/**************************************************************************
 Program:  Make_formats.sas
 Library:  Census
 Project:  NeighborhoodInfo DC
 Author:   P. Tatian
 Created:  03/05/11
 Version:  SAS 9.1
 Environment:  Windows
 
 Description:  Create Census 2020 formats.

 Modifications:
  03/28/11 PAT Updated $sum20f.
**************************************************************************/

%include "\\sas1\DCdata\SAS\Inc\StdLocal.sas";


** Define libraries **;
%DCData_lib( Census )

proc format library=Census;
  value $sum20f
    040 = "State"
    500 = "State-Congr Dist"
    510 = "State-Congr Dist-County"
    511 = "State-Congr Dist-County-Tract"
    521 = "State-Congr Dist-County-County Subd"
    531 = "State-Congr Dist-Place/Rem"
    541 = "State-Congr Dist-Consolidated City"
    550 = "State-Congr Dist-Am Indian Area/AK Native Area/HI Home Land"
    553 = "State-Congr Dist-Am Indian Area-Tribal Subd/Rem"
    570 = "State-Congr Dist-School Dist (Elementary)/Rem"
    571 = "State-Congr Dist-School Dist (Secondary)/Rem"
    572 = "State-Congr Dist-School Dist (Unified)/Rem State-St Legisl Dist (Upper)"
    610 = "State-St Legisl Dist (Upper)"
    612 = "State-St Legisl Dist (Upper)-County"
    613 = "State-St Legisl Dist (Upper)-County-County Subd"
    632 = "State-St Legisl Dist (Upper)-County-County Subd-Subminor Civil Div"
    630 = "State-St Legisl Dist (Upper)-County-Voting Dist/Rem"
    631 = "State-St Legisl Dist (Upper)-County-Tract"
    614 = "State-St Legisl Dist (Upper)-Place/Rem"
    615 = "State-St Legisl Dist (Upper)-Consolidated City"
    616 = "State-St Legisl Dist (Upper)-Am Indian Area/AK Native Area/HI Home Land"
    633 = "State-St Legisl Dist (Upper)-Am Indian Area-Tribal Subd/Rem"
    634 = "State-St Legisl Dist (Upper)-AK Native Regional Corporation"
    617 = "State-St Legisl Dist (Upper)-School Dist (Elementary)/Rem"
    618 = "State-St Legisl Dist (Upper)-School Dist (Secondary)/Rem"
    619 = "State-St Legisl Dist (Upper)-School Dist (Unified)/Rem"
    620 = "State-St Legisl Dist (Lower)"
    622 = "State-St Legisl Dist (Lower)-County"
    623 = "State-St Legisl Dist (Lower)-County-County Subd"
    637 = "State-St Legisl Dist (Lower)-County-County Subd-Subminor Civil Div"
    635 = "State-St Legisl Dist (Lower)-County-Voting Dist/Rem"
    636 = "State-St Legisl Dist (Lower)-County-Tract"
    624 = "State-St Legisl Dist (Lower)-Place/Rem"
    625 = "State-St Legisl Dist (Lower)-Consolidated City"
    626 = "State-St Legisl Dist (Lower)-Am Indian Area/AK Native Area/HI Home Land"
    638 = "State-St Legisl Dist (Lower)-Am Indian Area-Tribal Subd/Rem"
    639 = "State-St Legisl Dist (Lower)-AK Native Regional Corporation"
    627 = "State-St Legisl Dist (Lower)-School Dist (Elementary)/Rem"
    628 = "State-St Legisl Dist (Lower)-School Dist (Secondary)/Rem"
    629 = "State-St Legisl Dist (Lower)-School Dist (Unified)/Rem"
    050 = "State-County"
    060 = "State-County-County Subd"
    067 = "State-County-County Subd-Subminor Civil Div"
    512 = "State-County-Congr Dist"
    640 = "State-County-St Legisl Dist (Upper)"
    641 = "State-County-St Legisl Dist (Lower)"
    140 = "State-County-Tract"
    150 = "State-County-Tract-Block Group"
    700 = "State-County-Voting Dist/Rem"
    701 = "State-County-Voting Dist/Rem-Place/Rem"
    702 = "State-County-Voting Dist/Rem-Consolidated City"
    703 = "State-County-Voting Dist/Rem-Am Indian Area/AK Native Area/HI Home Land"
    704 = "State-County-Voting Dist/Rem-Am Indian Area-Tribal Subd/Rem"
    705 = "State-County-Voting Dist/Rem-AK Native Regional Corporation"
    706 = "State-County-Voting Dist/Rem-School Dist (Elementary)/Rem"
    707 = "State-County-Voting Dist/Rem-School Dist (Secondary)/Rem"
    708 = "State-County-Voting Dist/Rem-School Dist (Unified)/Rem"
    709 = "State-County-Voting Dist/Rem-Tract"
    710 = "State-County-Voting Dist/Rem-County Subd"
    720 = "State-County-Voting Dist/Rem-County Subd-Place/Rem"
    730 = "State-County-Voting Dist/Rem-County Subd-Place/Rem-Tract"
    740 = "State-County-Voting Dist/Rem-County Subd-Place/Rem-Tract-Block Group"
    750 = "State-County-Voting Dist/Rem-County Subd-Place/Rem-Tract-Block Group-Block"
    715 = "State-County-Voting Dist/Rem-County Subd-Subminor Civil Div"
    735 = "State-County-Voting Dist/Rem-County Subd-Subminor Civil Div-Tract"
    745 = "State-County-Voting Dist/Rem-County Subd-Subminor Civil Div-Tract-Block Group"
    755 = "State-County-Voting Dist/Rem-County Subd-Subminor Civil Div-Tract-Block Group-Block"
    160 = "State-Place"
    155 = "State-Place-County"
    532 = "State-Place-Congr Dist"
    642 = "State-Place-St Legisl Dist (Upper)"
    643 = "State-Place-St Legisl Dist (Lower)"
    170 = "State-Consolidated City"
    172 = "State-Consolidated City-Place within Consolidated City"
    280 = "State-Am Indian Area/AK Native Area/HI Home Land"
    281 = "State-Am Indian Area-Tribal Subd/Rem"
    282 = "State-Am Indian Area/AK Native Area/HI Home Land-County"
    283 = "State-Am Indian Area/AK Native Area (Res or Statistical Entity Only)"
    286 = "State-Am Indian Area (Off-Res Trust Land Only)/HI Home Land"
    288 = "State-Am Indian Area (Off-Res Trust Land Only)/HI Home Land-County"
    230 = "State-AK Native Regional Corporation"
    950 = "State-School Dist (Elementary)/Rem"
    960 = "State-School Dist (Secondary)/Rem"
    970 = "State-School Dist (Unified)/Rem"
      
/*  
    "643" = "State-Place-State Legislative District (Lower Chamber)"
    "700" = "State-County-Voting District/Remainder"
    "701" = "State-County-Voting District/Remainder-Place/Remainder"
    "702" = "State-County-Voting District/Remainder-Consolidated City"
    "703" = "State-County-Voting District/Remainder-American Indian Area/Alaska Native Area/Hawaiian Home Land"
    "704" = "State-County-Voting District/Remainder-American Indian Area-Tribal Subdivision/Remainder"
    "705" = "State-County-Voting District/Remainder-Alaska Native Regional Corporation"
    "706" = "State-County-Voting District/Remainder-School District (Elementary)/Remainder"
    "710" = "State-County-Voting District/Remainder-County Subdivision"
    "720" = "State-County-Voting District/Remainder-County Subdivision-Place/Remainder"
    "730" = "State-County-Voting District/Remainder-County Subdivision-Place/Remainder-Census Tract"
    "740" = "State-County-Voting District/Remainder-County Subdivision-Place/Remainder-Census Tract-Block Group"
    "750" = "State-County-Voting District/Remainder-County Subdivision-Place/Remainder-Census Tract-Block Group-Block"
*/    
  ;

run;

proc catalog catalog=Census.formats;
  modify sum20f (desc="Census 2020 summary levels (SUMLEV)") / entrytype=formatc;
  contents;
quit;


