/**************************************************************************
 Program:  Census_sf1_2010_md_blks.sas
 Library:  Census
 Project:  NeighborhoodInfo DC
 Author:   Rob Pitingolo
 Created:  2/26/18
 Version:  SAS 9.4
 Environment:  Local Windows session (desktop)
 
 Description: Create Census 2010 SF1 P&H data file for blocks.

 Modifications:
**************************************************************************/

%include "L:\SAS\Inc\StdLocal.sas";

** Define libraries **;
%DCData_lib( Census)

** Locations of input data sets from Missouri Census Data Center **;
libname Cen10Sf1 "&_dcdata_r_path\Census\Raw\2010\SF1";

** Metadata parameters **;
%let revisions = %str(New file.);

** State **;
%let state = MD;


** Copy file, add geo IDs, label and format vars **;

data Census_sf1_2010_&state._blks (label="Census 2010 SF1 P & H tables, &state., blocks only");

  set Cen10Sf1.&state.blocks;
  
  format _all_ ;
  informat _all_ ;
  
  length Geo2010 $ 11 GeoBg2010 $ 12 GeoBlk2010 $ 15;
  
  Geo2010 = esriid;
  GeoBg2010 = esriid;
  GeoBlk2010 = esriid;

  label
    GeoBlk2010 = 'Full census block ID (2010): sscccttttttbbbb'
    GeoBg2010 = 'Full census block group ID (2010): sscccttttttb'
    Geo2010 = 'Full census tract ID (2010): ssccctttttt';

  format
    GeoBlk2010 $blk10a.
    GeoBg2010 $bg10a.
    Geo2010 $geo10a.;

  Stab = upcase( Stab );

  label
    county = 'Full county ID: ssccc'
    BG    = 'Census block group ID'    
    Block = 'Census block ID'
    CntySC   = 'County size code'
    ConCit   = 'Consolidated city (FIPS)'
    CouSubCC = 'FIPS county subdivision class code'
    CouSubFP = 'County subdivision (FIPS)'
    CouSubSC = 'County subdivision size code'
    Division = 'Census division'
    FuncStat = 'Functional status code'
    HU100    = 'Housing unit count (100%)'
    IntPtLat = 'Internal point latitude'
    IntPtLon = 'Internal point longitude'
    LSADC    = 'Legal/statistical area description code'
    LogRecNo = 'Census file logical record number'
    PartFlag = 'Part flag'
    PlaceCC  = 'FIPS place class code'
    PlaceFP  = 'Place (FIPS)'
    PlaceSC  = 'Place size code'
    Pop100   = 'Population count (100%)'
    Region   = 'Census region'
    SDElm    = 'School district (elementary)'
    SDSec    = 'School district (secondary)'
    SDUni    = 'School district (unified)'
    Stab     = 'State abbreviation (USPS)'
    State    = 'State (FIPS)'
    Tract    = 'Census tract ID'
    UrbanRur = 'Urban/Rural'
    ZCTA5    = 'ZIP Code Tabulation Area (5 digit)'
    aianhh   = 'American Indian Area/Alaska Native Area/Hawaiian Home Land (Census)'
    aianhhcc = 'American Indian Area/Alaska Native Area/Hawaiian Home Land class code'
    aianhhfp = 'American Indian Area/Alaska Native Area/Hawaiian Home Land (FIPS)'
    aihhtli  = 'American Indian Trust Land/Hawaiian Home Land indicator'
    aits     = 'American Indian Tribal Subdivision (FIPS)'
    aitscc   = 'FIP American Indian Tribal Subdivision Class Code'
    aitsce   = 'American Indian ribal Subdivision (Census)'
    anrc     = 'Alaska Native Regional Corporation (FIPS)'
    anrccc   = 'FIP Alaska Native Regional Corporation Class Code'
    gcuni    = 'Geographic change user note indicator'
    vtd  = 'Voting district'
    vtdi = 'Voting district indicator'
  ;

  drop AreaName GeoCode esriid;
  
  rename county=ucounty;

run;

proc sort data=Census_sf1_2010_&state._blks;
  by GeoBlk2010;
run;


/** Macro Finalize - Start Definition **/

  %Finalize_data_set(
    data=Census_sf1_2010_&state._blks,
    out=Census_sf1_2010_&state._blks,
    outlib=census,
    label="Census 2010 SF1 P & H tables, &state., blocks only",
    sortby=GeoBlk2010,
    /** Metadata parameters **/
    revisions=%str(&revisions),
    /** File info parameters **/
    printobs=5
  )


/** End Macro Definition **/

