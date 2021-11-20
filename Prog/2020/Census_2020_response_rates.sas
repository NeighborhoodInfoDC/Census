/**************************************************************************
 Program:  Census_2020_response_rates.sas
 Library:  Census
 Project:  Urban-Greater DC
 Author:   P. Tatian
 Created:  11/20/21
 Version:  SAS 9.4
 Environment:  Local Windows session (desktop)
 GitHub issue:  24
 
 Description:  Fetch 2020 census response rate data with Census API.
 Code requires SAS version 9.4M4 or later. 

 Modifications:
**************************************************************************/

%include "\\sas1\DCdata\SAS\Inc\StdLocal.sas";

** Define libraries **;
%DCData_lib( Census )

** Create API call **;

%let var_list = GEO_ID,SUMLEVEL,CRRALL,CRRINT,RESP_DATE;

%let for = tract:*;
%let in = state:11;

%let api_url = https://api.census.gov/data/2020/dec/responserate?get=&var_list.%nrstr(&for)=&for.%nrstr(&in)=&in.;
    
%Get_census_api(
  api="&api_url",
  out=Census_2020_response_rates
)

data Census_2020_response_rates;

  length Geo2020 $ 11;
  
  set Census_2020_response_rates;
  
  Geo2020 = trim( state ) || trim( county ) || trim( tract );
  
  _crrint = 1 * crrint;
  _crrall = 1 * crrall;
  _resp_date = input( resp_date, yymmdd10. );
  
  format _resp_date mmddyy10.;
  
  label
    Geo2020 = "Full census tract ID (2020): ssccctttttt"
    GEO_ID = "Combined codes for the reference geography"
    SUMLEVEL = "Summary Level code"
    county = "County code"
    state = "State code"
    tract = "Census tract code"
    _CRRALL = "Cumulative Self-Response Rate - Overall"
    _CRRINT = "Cumulative Self-Response Rate - Internet"
    _RESP_DATE = "Most recent data cutoff for responses received"
  ;

  rename _crrint=crrint _crrall=crrall _resp_date=resp_date;
  drop ordinal_root crrint crrall resp_date;
  
run;

proc sort data=Census_2020_response_rates;
  by Geo2020;
run;

%File_info( data=Census_2020_response_rates, printobs=40, freqvars=sumlevel )

run;
