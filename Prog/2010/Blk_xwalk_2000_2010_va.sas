/**************************************************************************
 Program:  Blk_xwalk_2000_2010_va.sas
 Library:  Census
 Project:  NeighborhoodInfo DC
 Author:   Rob Pitingolo
 Created:  12/1/17
 Version:  SAS 9.4
 Environment:  Windows
 
 Description:  Read in Census 2000-2010 block crosswalk.
 
 Maryland
 
 Source for crosswalk:
 http://www.census.gov/geo/www/2010census/t00t10.html

 Modifications:
**************************************************************************/

%include "L:\SAS\Inc\StdLocal.sas";

** Define libraries **;
%DCData_lib( Census );

%let state = VA;
%let revisions = New File;

filename csvfile  "&_dcdata_path\Census\Raw\2010\TAB2000_TAB2010_ST_51_v2.txt" lrecl=2000;

data Blk_xwalk_2000_2010_&state. ;

  infile csvfile dsd stopover firstobs=2;
  
  length
    GeoBlk2000 $15
    GeoBlk2010 $15
    GeoBg2000 $12
    GeoBg2010 $12
    Geo2000 $11
    Geo2010 $11
    State_2000 $2
    County_2000 $3
    Tract_2000 $6
    Blk_2000 $4
    Blksf_2000 $1
    Arealand_2000 8
    Areawater_2000 8
    Block_Part_Flag_O $1
    State_2010 $2
    County_2010 $3
    Tract_2010 $6
    Blk_2010 $4
    Blksf_2010 $1
    Arealand_2010 8
    Areawater_2010 8
    Block_Part_Flag_R $1
    Arealand_Int 8
    Areawater_Int 8
  ;
  
  input
    State_2000
    County_2000
    Tract_2000
    Blk_2000
    Blksf_2000
    Arealand_2000
    Areawater_2000
    Block_Part_Flag_O
    State_2010
    County_2010
    Tract_2010
    Blk_2010
    Blksf_2010
    Arealand_2010
    Areawater_2010
    Block_Part_Flag_R
    Arealand_Int
    Areawater_Int
  ;

  Block_Part_Flag_O = upcase( Block_Part_Flag_O );
  Block_Part_Flag_R = upcase( Block_Part_Flag_R );
  
  GeoBlk2000 = State_2000 || County_2000 || Tract_2000 || Blk_2000;
  GeoBlk2010 = State_2010 || County_2010 || Tract_2010 || Blk_2010;

  GeoBg2000 = GeoBlk2000;
  GeoBg2010 = GeoBlk2010;
  
  Geo2000 = GeoBlk2000;
  Geo2010 = GeoBlk2010;

  label
    GeoBlk2000 = "Full census block ID (2000): sscccttttttbbbb"
    GeoBlk2010 = "Full census block ID (2010): sscccttttttbbbb"
    GeoBg2000 = "Full census block group ID (2000): sscccttttttb"
    GeoBg2010 = "Full census block group ID (2010): sscccttttttb"
    Geo2000 = "Full census tract ID (2000): ssccctttttt"
    Geo2010 = "Full census tract ID (2010): ssccctttttt"
    STATE_2000 = "2000 tabulation state FIPS code"
    COUNTY_2000 = "2000 tabulation county FIPS code"
    TRACT_2000 = "2000 census tract number"
    BLK_2000 = "2000 tabulation block number"
    BLKSF_2000 = "2000 tabulation block suffix"
    AREALAND_2000 = "2000 Land Area"
    AREAWATER_2000 = "2000 Water Area"
    BLOCK_PART_FLAG_O = "2000 tabulation block part flag; Blank = whole; P = part"
    STATE_2010 = "2010 tabulation state FIPS code"
    COUNTY_2010 = "2010 tabulation county FIPS code"
    TRACT_2010 = "2010 census tract number"
    BLK_2010 = "2010 tabulation block number"
    BLKSF_2010 = "2010 tabulation block suffix"
    AREALAND_2010 = "2010 Land Area"
    AREAWATER_2010 = "2010 Water Area"
    BLOCK_PART_FLAG_R = "2010 tabulation block part flag; Blank = whole; P = part"
    AREALAND_INT = "Intersection Land Area shared by the 2000 and 2010 blocks represented by the record"
    AREAWATER_INT = "Intersection Water Area shared by the 2000 and 2010 blocks represented by the record";
  
run;

  %Finalize_data_set(
    data=Blk_xwalk_2000_2010_&state.,
    out=Blk_xwalk_2000_2010_&state.,
    outlib=Census,
    label="Census 2000-2010 block crosswalk, &state.",
    sortby=Geo2010,
    /** Metadata parameters **/
    revisions=%str(&revisions),
    /** File info parameters **/
    printobs=5,
    freqvars=
  )


  /* End of Program */
