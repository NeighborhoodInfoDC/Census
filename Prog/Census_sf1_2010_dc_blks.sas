/************************************************************************
 Program:  Upload_Census_sf1_2010_dc_blks.sas
 Library:  Census
 Project:  DC Data Warehouse
 Author:   S. Litschwartz
 Created:  9/23/11
 Version:  SAS 8.2
 Environment:  Windows with SAS/Connect
 
 Description: Clean 2010 Census DC SF1 data for upload to alpha
************************************************************************/

%include "K:\Metro\PTatian\DCData\SAS\Inc\Stdhead.sas";
/*%include "K:\Metro\PTatian\DCData\SAS\Inc\AlphaSignon.sas" /nosource2;*/

** Define libraries **;
%DCData_lib( Census)

data Census.Census_sf1_2010_dc_blks
(sortedby=GeoBlk2010
label="Census 2010 SF1 P & H tables, DC, blocks only");
set Census.xtract;
format sumlev $sumlev.;
rename esriid=GeoBlk2010;
 label
    BG    = 'Census block group ID'    
    Block = 'Census block ID'
    CntySC   = 'County size code'
	CntyCC =   'FIPS County Class Code'
    ConCit   = 'Consolidated city (FIPS)'
    CouSubCC = 'FIPS county subdivision class code'
    CouSubFP = 'County subdivision (FIPS)'
    CouSubSC = 'County subdivision size code'
	County=	   'Full county ID: ssccc'
    Division = 'Census division'
    FuncStat = 'Functional status code'
    LSADC    = 'Legal/statistical area description code'
    LogRecNo = 'Census file logical record number'
    PartFlag = 'Part flag'
    PlaceCC  = 'FIPS place class code'
    PlaceFP  = 'Place (FIPS)'
    PlaceSC  = 'Place size code'
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
	SubMCD = 'Subminor Civil Division (FIPS)'
	SubMCDCC = 'Subminor Civil Division (FIPS)Class Code'
	MEMI= 'Metropolitan/Micropolitan Indicator'
	NMEMI = 'NECTA Metropolitan/Micropolitan Indicator'
	UA = 'Urban Area'
	UASC = 'Urban Area Size Code'
	UAType  = 'Urban Area Type'
	ttract= 'Tribal Census Tract'
	tblkgrp = 'Tribal Block Group'
	MetDiv = 'Metropolitan Division'
	CSA = 'Combined Statistical Area'
	NECTA = 'New England City and Town Area'
	NECTASC = 'New England City and Town Area Size Code'
	NECTADiv = 'New England City and Town Area Division'
	CNECTA = 'Combined New England City and Town Area Division'
	CBSAPCI = 'Metropolitan Statistical Area/Micropolitan Statistical Area Principal City Indicator'
	CBSA = 'Metropolitan Statistical Area/Micropolitan Statistical Area'
	CBSASC = 'Metropolitan Statistical Area/Micropolitan Statistical Area Size Code'
	esriid = 'Full census block ID (2010): sscccttttttbbbb'
  ;
  drop areaname;
run;







