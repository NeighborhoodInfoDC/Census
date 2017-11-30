/**************************************************************************
 Program:  Cen2000_sf1_dc.sas
 Library:  Census
 Project:  NeighborhoodInfo DC
 Author:   P. Tatian
 Created:  11/29/17
 Version:  SAS 9.2
 Environment:  Local Windows session (desktop)
 
 Description: Read Census 2000 SF1 data for DC.

 NOTE:  ZipMagic must be enabled before running this program.
 
 ZIP files containing raw data files must be saved in 
 D:\Data\Census2000\SF1\Raw\DC.

 Modifications:
**************************************************************************/

%include "L:\SAS\Inc\StdLocal.sas";

** Define libraries **;
%DCData_lib( Census )


%m_2000_cnvtsf1_alt(
  stateab= dc,
  fipsst= 11,
  inpath= &_dcdata_r_path\Census\Raw\2000SF1\DC,
  outlib= census_l
)

%File_info( data=census_l.dcgeos, printchar=y )

%File_info( data=census_l.dcpct, printchar=y, freqvars=sumlev )

%File_info( data=census_l.dcpct12r, printchar=y, freqvars=sumlev )

%File_info( data=census_l.dcph, printchar=y, freqvars=sumlev )

%File_info( data=census_l.dcphblks, printobs=6, printchar=y, freqvars=sumlev )

