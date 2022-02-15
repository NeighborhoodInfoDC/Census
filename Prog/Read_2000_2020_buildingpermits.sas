/**************************************************************************
 Program:  Read_2000_2020_buildingpermits.sas
 Library:  Census
 Project:  Urban-Greater DC
 Author:   Leah Hendey
 Created:  02/15/2022
 Version:  SAS 9.4
 Environment:  Local Windows session (desktop)
 
 Description:  Read county building permit statistics on new privately-owned residential construction from 
 https://www2.census.gov/econ/bps/County  files with COYYYYa.txt
 Adapted from Read_2000_2017_buildingpermits.sas

 NOTE: the number of counties in each year of data is inconsistent and lower than the 3,143 counties in the
 U.S. The documentation is not clear why this happens so double check any geography of interest to make
 sure it appears in all years of data. -RP

 Modifications: 
**************************************************************************/

%include "\\sas1\DCdata\SAS\Inc\StdLocal.sas";

** Define libraries **;
%DCData_lib( Census );

/* Revisions */
%let revisions = New file;

/* Path to raw data csv files and names */
%let filepath = &_dcdata_r_path.\Census\Raw\Permits\;

%macro ReadIN;

%let yearlist =2000 2001 2002 2003 2004 2005 2006 2007 2008 2009 2010 2011 2012 2013 2014 2015 2016 2017 2018 2019 2020;

%do i=1 %to 21; 

%let YYYY=%scan(&yearlist., &i.," ");
%let infile = co&YYYY.a.txt;


filename fimport "&filepath.&infile." lrecl=32767;

data Cen_building_permits_cnty_&YYYY ;

	infile FIMPORT delimiter = ',' MISSOVER DSD lrecl=32767 firstobs=4 ;

	informat year best32. ;
	informat state_fips $2. ;
	informat county_fips $3.;
	informat region best32.;
	informat division best32. ;
	informat county_name $50.;
	informat units1_building best32.;
	informat units1 best32.;
	informat units1_value best32.;
	informat units2_building best32.;
	informat units2 best32.;
	informat units2_value best32.;
	informat units34_building best32.;
	informat units34 best32.;
	informat units34_value best32.;
	informat units5p_building best32.;
	informat units5p best32.;
	informat units5p_value best32.;
	informat units1rep_building best32.;
	informat units1rep best32.;
	informat units1rep_value best32.;
	informat units2rep_building best32.;
	informat units2rep best32.;
	informat units2rep_value best32.;
	informat units34rep_building best32.;
	informat units34rep best32.;
	informat units34rep_value best32.;
	informat units5prep_building best32.;
	
	input 	
	year
	state_fips $
	county_fips $
	region 
	division
	county_name $
	units1_building 
	units1 
	units1_value 
	units2_building 
	units2 
	units2_value 
	units34_building 
	units34 
	units34_value 
	units5p_building
	units5p 
	units5p_value 
	units1rep_building 
	units1rep 
	units1rep_value 
	units2rep_building 
	units2rep 
	units2rep_value 
	units34rep_building 
	units34rep 
	units34rep_value 
	units5prep_building 
	;

	ucounty  = state_fips||county_fips;
	state = state_fips;

	drop county_fips state_fips county_fips region division  ;

   *if put( ucounty, $ctym15f. ) ^= . ;

	label 
	year  = "Survey Year"
	state = "FIPS state code"
	county_name = "County Name"
	units1_building = "Buildings with one unit, Estimates with imputation"
	units1 = "Total units for building with one unit, Estimates with imputation"
	units1_value = "Value of one unit buildings, Estimates with imputation"
	units2_building = "Buildings with two units, Estimates with imputation"
	units2 = "Total units of buildings with two untis, Estimates with imputation"
	units2_value = "Value of two unit buildings, Estimates with imputation"
	units34_building = "Buildings with 3-4 units, Estimates with imputation"
	units34 = "Total units of buildings with 3-4 units, Estimates with imputation"
    units34_value = "Value of buildings with 3-4 units, Estimates with imputation"
    units5p_building = "Buildings with 5+ units, Estimates with imputation"
    units5p = "Total units of building with 5+ units, Estimates with imputation"
    units5p_value = "Values of buildings with 5+ units, Estimates with imputation"
	units1rep_building = "Buildings with one unit, reported only"
	units1rep = "Total units for building with one unit, reported only"
	units1rep_value = "Value of one unit buildings, reported only"
	units2rep_building = "Buildings with two units, reported only"
	units2rep = "Total units of buildings with two untis, reported only"
	units2rep_value = "Value of two unit buildings, reported only"
	units34rep_building = "Buildings with 3-4 units, reported only"
	units34rep = "Total units of buildings with 3-4 units"
    units34rep_value = "Value of buildings with 3-4 units, reported only"
    units5prep_building = "Buildings with 5+ units, reported only"
	ucounty = "State-County FIPS"
	;

run;

%File_info( data=Cen_building_permits_cnty_&YYYY., stats=, freqvars=state ucounty  );
%end;
%mend;

%readin;

data allyears;
set  Cen_building_permits_cnty_2000-Cen_building_permits_cnty_2020;
where year > 0; *one obs with missing data (all vars);

run;

%Finalize_data_set( 
  data=allyears,
  out=Cen_bldg_permits_cnty_2000_2020,
  outlib=Census,
  label="Building permit statistics for all Counties reported, 2000-2020",
  sortby=year ucounty,
  restrictions=None,
  freqvars=year,
  revisions=&revisions.
  );

  /* End of program */
