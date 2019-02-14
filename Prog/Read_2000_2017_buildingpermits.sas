/**************************************************************************
 Program:  Read_2000_2017_buildingpermits.sas
 Library:  Census
 Project:  NeighborhoodInfo DC
 Author:   Rob Pitingolo
 Created:  02/14/19
 Version:  SAS 9.4
 Environment:  Local Windows session (desktop)
 
 Description:  Read building permit statistics on new privately-owned residential construction from 


 Modifications: 
**************************************************************************/

%include "L:\SAS\Inc\StdLocal.sas";

** Define libraries **;
%DCData_lib( Census );

/* Path to raw data csv files and names */

%let filepath = L:\Libraries\Census\Raw\Permits\;
%let infile = permits2000_2017.csv;

filename fimport "&filepath.&infile." lrecl=32767;

data Cen_building_permits_dc_md_va_wv (where=(county in ("11001","24017","24021","24031", "24033", "51013", "51059", "51107", "51153", "51510", "51600", "51610", "51683","51685")));

	infile FIMPORT delimiter = ',' MISSOVER DSD lrecl=32767 firstobs=2 ;

	informat year best32. ;
	informat state_fips best32. ;
	informat county_code best32.;
	informat region best32.;
	informat division best32. ;
	informat buildings	$20.;
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
	informat units5prep best32.;
	informat units5prep_value best32.;
	informat county_fips best32.;

	input
	year  
	state_fips 
	county_code 
	region
	division 
	buildings $
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
    units5prep
    units5prep_value
    county_fips
	;

	county = put(county_fips,z5.);
	state = put(state_fips,z2.);

	drop county_fips state_fips county_code region division buildings ;

	label 
	year  = "Survey Year"
	state = "FIPS state code"
	units1_building = "101- Buildings, Estimates with imputation"
	units1 = "101- Units, Estimates with imputation"
	units1_value = "101- Valuation, Estimates with imputation"
	units2_building = "103 Buildings, Estimates with imputation"
	units2 = "103 Units, Estimates with imputation"
	units2_value = "103 Valuation, Estimates with imputation"
	units34_building = "104 Buildings, Estimates with imputation"
	units34 = "104 Units, Estimates with imputation"
    units34_value = "104 Valuation, Estimates with imputation"
    units5p_building = "105 Buildings, Estimates with imputation"
    units5p = "105 Units, Estimates with imputation"
    units5p_value = "105 Valuatino, Estimates with imputation"
	units1rep_building = "101 Buildings, reported only"
	units1rep = "101 Units, reported only"
	units1rep_value = "101 Valuation, reported only"
	units2rep_building = "103 Buildings, reported only"
	units2rep = "103 Units, reported only"
	units2rep_value = "103 Valuation, reported only"
	units34rep_building = "104 Buildings, reported only"
	units34rep = "104 Units, reported only"
    units34rep_value = "104 Valuation, reported only"
    units5prep_building = "105 Buildings, reported only"
    units5prep = "105 Units, reported only"
    units5prep_value = "105 Valuation, reported only"
	county = "County FIPS"
	;

run;

%File_info( data=Cen_building_permits_dc_md_va_wv, stats=, freqvars=state county  );

%Finalize_data_set( 
  data=Cen_building_permits_dc_md_va_wv,
  out=Cen_building_permits_dc_md_va_wv,
  outlib=Census,
  label="Building permit statistics for DC, MD, VA and WV",
  sortby=county,
  restrictions=None,
  revisions=New File.
  );
