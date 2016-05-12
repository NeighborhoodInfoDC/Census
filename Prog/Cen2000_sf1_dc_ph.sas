************************************************************************
* Program:  Cen2000_sf1_dc_ph.sas
* Library:  Census
* Project:  DC Data Warehouse
* Author:   P. Tatian
* Created:  09/01/06
* Version:  SAS 8.12
* Environment:  Windows with SAS/Connect
* 
* Description:  Copy Census 2000 SF1 P&H data & formats for DC to
* Warehouse library.  Upload to Alpha.
*
* Modifications:
************************************************************************;

%include "K:\Metro\PTatian\DCData\SAS\Inc\Stdhead.sas";
%include "K:\Metro\PTatian\DCData\SAS\Inc\AlphaSignon.sas" /nosource2;

** Define libraries **;
%DCData_lib( Census )

%Concat_lib( Cen00sf1, D:\Data\Census2000\SF1\Data )

** Copy and rename data set **;

proc copy out=Census in=Cen00Sf1;
  select dcph /memtype=data;

proc datasets library=Census memtype=data;
  delete Cen2000_sf1_dc_ph; 
  change dcph=Cen2000_sf1_dc_ph;
  modify Cen2000_sf1_dc_ph 
    (label="Census 2000 SF1 P & H tables, DC, all sum levels except blocks"
     sortedby=GeoBlk2000);
  format sumlev $sumlev.;
  index delete _all_;
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
    geo_id   = ' '
    vtd  = 'Voting district'
    vtdi = 'Voting district indicator'
  ;
  rename cmsa2=cmsa99 msacmsa=msacma99 necma=necma99 pmsa=pmsa99
         macc=macc99 macci=macci99 masc=masc99;
  drop UGA puma1 puma5 geo_id pct;
quit;

** Copy formats **;

proc catalog catalog=Cen00Sf1.formats;
  copy out=Census.formats;
  select sumlev /et=formatc;
quit;

%File_info( data=Census.Cen2000_sf1_dc_ph, printobs=5, printchar=y, freqvars=_character_ )

rsubmit;

proc upload status=no
  data=Census.Cen2000_sf1_dc_ph 
  out=Census.Cen2000_sf1_dc_ph;

x "purge [dcdata.census.data]Cen2000_sf1_dc_ph.*";

proc upload status=no
	inlib=Census
	outlib=Work memtype=(catalog);
	select formats;

proc catalog catalog=work.formats;
  copy out=Census.formats;
  select sumlev /et=formatc;
quit;

%Dc_update_meta_file(
  ds_lib=Census,
  ds_name=Cen2000_sf1_dc_ph,
  creator_process=Cen2000_sf1_dc_ph.sas,
  restrictions=None,
  revisions=%str(New file.)
)

endrsubmit;

signoff;

