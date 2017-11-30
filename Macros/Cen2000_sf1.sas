/**************************************************************************
 Program:  Cen2000_sf1.sas
 Library:  Census
 Project:  NeighborhoodInfo DC
 Author:   P. Tatian
 Created:  11/30/17
 Version:  SAS 9.2
 Environment:  Local Windows session (desktop)
 
 Description:  Autocall macro to create Census 2000 SF1 data sets.

 Modifications:
**************************************************************************/

%macro Cen2000_sf1(
  stateab=,
  revisions=%str(New file.)
);

  %local fipsst; 

  %let stateab = %lowcase( &stateab );
  %let fipsst = %sysfunc( stfips( &stateab ) );


  ** Read in raw source data **;

  %m_2000_cnvtsf1_alt(
    stateab= &stateab,
    fipsst= &fipsst,
    inpath= &_dcdata_r_path\Census\Raw\2000SF1\&stateab,
    outlib= work
  )


  ** Block-level file **;

  data Cen2000_sf1_&stateab._blks;

    set &stateab.phblks;
    
    format _all_ ;
    
    length GeoBg2000 $ 12;
    
    GeoBg2000 = GeoBlk2000;
    
    label GeoBg2000 = "Full census block group ID (2000): sscccttttttb";
    
    format sumlev $sumlev.;
    
    label
      BG    = 'Census block group ID'    
      Block = 'Census block ID'
      CMSA2 = 'Consolidated Metropolitan Statistical Area (1999)'
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
      MACC     = 'Metropolitan area central city (1999)'
      MACCI    = 'Metropolitan area central city indicator (1999)'
      MASC     = 'MSA/CMSA size code (1999)'
      MSACMSA  = 'Metropolitan Statistical Area/Consolidated Metropolitan Statistical Area (1999)'
      NECMA    = 'New England County Metropolitan Area (1999)'
      PMSA     = 'Primary Metropolitan Statistical Area (1999)'
      PUMA1    = 'Public Use Microdata Area - 1% file'
      PUMA5    = 'Public Use Microdata Area - 5% file'
      PartFlag = 'Part flag'
      PlaceCC  = 'FIPS place class code'
      PlaceDC  = 'Place Description Code'
      PlaceFP  = 'Place (FIPS)'
      PlaceSC  = 'Place size code'
      Pop100   = 'Population count (100%)'
      Region   = 'Census region'
      SDElm    = 'School district (elementary)'
      SDSec    = 'School district (secondary)'
      SDUni    = 'School district (unified)'
      Stab     = 'State abbreviation (USPS)'
      State    = 'State (FIPS)'
      StateCe  = 'State (Census)'
      TAZ      = 'Traffic Analysis Zone'
      Tract    = 'Census tract ID'
      UACP     = 'Urban area central place'
      UGA      = 'Oregon Urban Growth Area'
      UrbanRur = 'Urban/Rural'
      ZCTA3    = 'ZIP Code Tabulation Area (3 digit)'
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
      geo_id = 'Census geo ID'
    ;
    
    rename cmsa2=cmsa99 msacmsa=msacma99 necma=necma99 pmsa=pmsa99
           macc=macc99 macci=macci99 masc=masc99;

  run;

  %Finalize_data_set( 
    /** Finalize data set parameters **/
    data=Cen2000_sf1_&stateab._blks,
    out=Cen2000_sf1_&stateab._blks,
    outlib=Census,
    label="Census 2000 SF1 P & H tables, %upcase(&stateab.), blocks only",
    sortby=GeoBlk2000,
    /** Metadata parameters **/
    restrictions=None,
    revisions=%str(&revisions),
    /** File info parameters **/
    contents=Y,
    printobs=5,
    printchar=Y,
    freqvars=sumlev geocomp
  )


  ** Non-block-level file **;

  data Cen2000_sf1_&stateab._ph;

    set &stateab.ph;
    
    format _all_ ;
    
    format sumlev $sumlev.;

    label
      BG    = 'Census block group ID'    
      Block = 'Census block ID'
      CMSA2 = 'Consolidated Metropolitan Statistical Area (1999)'
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
      MACC     = 'Metropolitan area central city (1999)'
      MACCI    = 'Metropolitan area central city indicator (1999)'
      MASC     = 'MSA/CMSA size code (1999)'
      MSACMSA  = 'Metropolitan Statistical Area/Consolidated Metropolitan Statistical Area (1999)'
      NECMA    = 'New England County Metropolitan Area (1999)'
      PMSA     = 'Primary Metropolitan Statistical Area (1999)'
      PUMA1    = 'Public Use Microdata Area - 1% file'
      PUMA5    = 'Public Use Microdata Area - 5% file'
      PartFlag = 'Part flag'
      PlaceCC  = 'FIPS place class code'
      PlaceDC  = 'Place Description Code'
      PlaceFP  = 'Place (FIPS)'
      PlaceSC  = 'Place size code'
      Pop100   = 'Population count (100%)'
      Region   = 'Census region'
      SDElm    = 'School district (elementary)'
      SDSec    = 'School district (secondary)'
      SDUni    = 'School district (unified)'
      Stab     = 'State abbreviation (USPS)'
      State    = 'State (FIPS)'
      StateCe  = 'State (Census)'
      TAZ      = 'Traffic Analysis Zone'
      Tract    = 'Census tract ID'
      UACP     = 'Urban area central place'
      UGA      = 'Oregon Urban Growth Area'
      UrbanRur = 'Urban/Rural'
      ZCTA3    = 'ZIP Code Tabulation Area (3 digit)'
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
      areaname = 'Area name'
      gcuni    = 'Geographic change user note indicator'
      geo_id = 'Census geo ID'
      geocode = 'Geographic code'
      vtd  = 'Voting district'
      vtdi = 'Voting district indicator'
    ;

    rename cmsa2=cmsa99 msacmsa=msacma99 necma=necma99 pmsa=pmsa99
           macc=macc99 macci=macci99 masc=masc99;

  run;

  %Finalize_data_set( 
    /** Finalize data set parameters **/
    data=Cen2000_sf1_&stateab._ph,
    out=Cen2000_sf1_&stateab._ph,
    outlib=Census,
    label="Census 2000 SF1 P & H tables, %upcase(&stateab.), all sum levels except blocks",
    sortby=Geo_id,
    /** Metadata parameters **/
    restrictions=None,
    revisions=%str(&revisions),
    /** File info parameters **/
    contents=Y,
    printobs=5,
    printchar=Y,
    freqvars=sumlev geocomp
  )

%mend Cen2000_sf1;


