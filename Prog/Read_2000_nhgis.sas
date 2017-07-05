/**************************************************************************
 Program:  Read_2000_nhgis.sas
 Library:  Census
 Project:  NeighborhoodInfo DC
 Author:   Rob Pitingolo
 Created:  07/03/17
 Version:  SAS 9.4
 Environment:  Local Windows session (desktop)
 
 Description:  Read block-level DC, MD, VA and WV data from NHGIS


 Modifications: 
**************************************************************************/

%include "L:\SAS\Inc\StdLocal.sas";

** Define libraries **;
%DCData_lib( Census );

/* Path to raw data csv files and names */

%let filepath = &_dcdata_r_path\Census\Raw\NHGIS\;
%let infile = nhgis0007_ds147_2000_block.csv;

filename fimport "&filepath.&infile." lrecl=2000;

data Cen2000_nhgis_blks_dc_md_va_wv;

	infile FIMPORT delimiter = ',' MISSOVER DSD lrecl=32767 firstobs=2 ;

	informat GISJOIN $20. ;
	informat YEAR best32. ;
	informat STATE $40. ;
	informat STATEA_ best32.;
	informat COUNTY $40. ;
	informat COUNTYA_	best32.;
	informat CTY_SUBA_	best32.;
	informat PLACEA_ best32.;
	informat TRACTA_ best32.;
	informat BLCK_GRPA_ best32.;
	informat BLOCKA_ best32.;
	informat AIANHHA_ best32.;
	informat NAME $20.;
	informat FXS001 best32.;

	input
	GISJOIN $ 
	YEAR 
	STATE $
	STATEA_
	COUNTY $
	COUNTYA_
	CTY_SUBA_
	PLACEA_
	TRACTA_
	BLCK_GRPA_
	BLOCKA_
	AIANHHA_
	NAME $
	FXS001
	;

	STATEA = put(STATEA_,z2.);
	COUNTYA = put(COUNTYA_,z3.);
	CTY_SUBA = put(CTY_SUBA_,Z5.);
	PLACEA = put(PLACEA_,z5.);
	TRACTA = put(TRACTA_,z6.);
	BLCK_GRPA = put(BLCK_GRPA_,z1.);
	BLOCKA = put(BLOCKA_,z4.);
	AIANHHA = put(AIANHHA_,z4.);

	drop STATEA_ COUNTYA_ CTY_SUBA_ PLACEA_ TRACTA_ BLCK_GRPA_ BLOCKA_ AIANHHA_;

	GeoBlk2000 = STATEA || COUNTYA || TRACTA || BLOCKA ;
	Geo2000 = STATEA || COUNTYA || TRACTA ;

	label 
	GISJOIN = "GIS Join Match Code"
	YEAR = "Data File Year"
	STATE = "State Name"
	STATEA = "State Code"
	COUNTY = "County Name"
	COUNTYA = "County Code"
	CTY_SUBA = "County Subdivision Code"
	PLACEA = "Place Code" 
	TRACTA = "Census Tract Code"
	BLCK_GRPA = "Block Group Code"
	BLOCKA  = "Block Code" 
	AIANHHA = "American Indian Area/Alaska Native Area/Hawaiian Home Land Code"
	NAME = "Area Name-Legal/Statistical Area Description (LSAD) Term-Part Indicator"
	FXS001 = "Total Population"
	GeoBlk2000 = "Full census block ID (2000): sscccttttttbbbb"
	Geo2000 = "Full census tract ID (2000): ssccctttttt"
	;

run;

%File_info( data=Cen2000_nhgis_blks_dc_md_va_wv, stats=, freqvars=state county  );

%Finalize_data_set( 
  data=Cen2000_nhgis_blks_dc_md_va_wv,
  out=Cen2000_nhgis_blks_dc_md_va_wv,
  outlib=Census,
  label="Census 2010 block population for DC, MD, VA and WV",
  sortby=GeoBlk2000,
  restrictions=None,
  revisions=New File.
  );
