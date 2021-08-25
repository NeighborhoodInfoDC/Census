/**************************************************************************
 Program:  Blk_xwalk_2010_2020_dc.sas
 Library:  Census
 Project:  Urban-Greater DC
 Author:   Elizabeth Burton
 Created:  08/25/21
 Version:  SAS 9.4
 Environment:  Windows
 
 Description:  Read in Census 2010-2020 block crosswalk.
 
 District of Columbia
 
 Source for crosswalk:
 https://www.census.gov/geographies/reference-files/time-series/geo/relationship-files.html

 Modifications:
**************************************************************************/

%include "\\sas1\DCdata\SAS\Inc\StdLocal.sas";

** Define libraries **;
%DCData_lib( Census );

%let state = MD;
%let revisions = New File;

filename csvfile  "&_dcdata_path\Census\Raw\2020\tab2010_tab2020_st24_md.txt" ;

data Work.Blk_xwalk_2010_2020_md;

  infile csvfile dlm="|" lrecl = 500 dsd missover pad firstobs=2;
  
  length
    GeoBlk2010 $15
    GeoBlk2020 $15
    GeoBg2010 $12
    GeoBg2020 $12
    Geo2010 $11
    Geo2020 $11
    State_2010 $2
    County_2010 $3
    Tract_2010 $6
    Blk_2010 $4
    Blksf_2010 $1
    Arealand_2010 8
    Areawater_2010 8
    Block_Part_Flag_O $1
    State_2020 $2
    County_2020 $3
    Tract_2020 $6
    Blk_2020 $4
    Blksf_2020 $1
    Arealand_2020 8
    Areawater_2020 8
    Block_Part_Flag_R $1
    Arealand_Int 8
    Areawater_Int 8
  ;
  
  input
    State_2010
    County_2010
    Tract_2010
    Blk_2010
    Blksf_2010
    Arealand_2010
    Areawater_2010
    Block_Part_Flag_O
    State_2020
    County_2020
    Tract_2020
    Blk_2020
    Blksf_2020
    Arealand_2020
    Areawater_2020
    Block_Part_Flag_R
    Arealand_Int
    Areawater_Int
  ;

  Block_Part_Flag_O = upcase( Block_Part_Flag_O );
  Block_Part_Flag_R = upcase( Block_Part_Flag_R );
  
  GeoBlk2010 = State_2010 || County_2010 || Tract_2010 || Blk_2010;
  GeoBlk2020 = State_2020 || County_2020 || Tract_2020 || Blk_2020;

  GeoBg2010 = GeoBlk2010;
  GeoBg2020 = GeoBlk2020;
  
  Geo2010 = GeoBlk2010;
  Geo2020 = GeoBlk2020;

  label
    GeoBlk2010 = "Full census block ID (2010): sscccttttttbbbb"
    GeoBlk2020 = "Full census block ID (2020): sscccttttttbbbb"
    GeoBg2010 = "Full census block group ID (2010): sscccttttttb"
    GeoBg2020 = "Full census block group ID (2020): sscccttttttb"
    Geo2010 = "Full census tract ID (2010): ssccctttttt"
    Geo2020 = "Full census tract ID (2020): ssccctttttt"
    STATE_2010 = "2010 tabulation state FIPS code"
    COUNTY_2010 = "2010 tabulation county FIPS code"
    TRACT_2010 = "2010 census tract number"
    BLK_2010 = "2010 tabulation block number"
    BLKSF_2010 = "2010 tabulation block suffix"
    AREALAND_2010 = "2010 Land Area"
    AREAWATER_2010 = "2010 Water Area"
    BLOCK_PART_FLAG_O = "2010 tabulation block part flag; Blank = whole; P = part"
    STATE_2020 = "2020 tabulation state FIPS code"
    COUNTY_2020 = "2020 tabulation county FIPS code"
    TRACT_2020 = "2020 census tract number"
    BLK_2020 = "2020 tabulation block number"
    BLKSF_2020 = "2020 tabulation block suffix"
    AREALAND_2020 = "2020 Land Area"
    AREAWATER_2020 = "2020 Water Area"
    BLOCK_PART_FLAG_R = "2020 tabulation block part flag; Blank = whole; P = part"
    AREALAND_INT = "Intersection Land Area shared by the 2010 and 2020 blocks represented by the record"
    AREAWATER_INT = "Intersection Water Area shared by the 2010 and 2020 blocks represented by the record";
  
run;

  %Finalize_data_set( 
  data=Blk_xwalk_2010_2020_md,
  out=Blk_xwalk_2010_2020_md,
  outlib=Census,
  label="Census 2010-2020 block crosswalk, MD",
  sortby=GeoBlk2020,
  restrictions=None,
  printobs=25,
  freqvars=Block_Part_Flag_O Block_Part_Flag_R Blksf_2010 Blksf_2020,
  revisions=New File
  )

  /* End of Program */
