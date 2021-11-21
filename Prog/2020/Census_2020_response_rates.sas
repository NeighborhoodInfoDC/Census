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

%global revisions;

%let revisions = New file.;


/** Macro Create_response_rate_ds - Start Definition **/

%macro Create_response_rate_ds( st=, geo= );

  %** Initialize macro vars **;

  %local stfips var_list api_url for in out geodlbl geosuf dslabel;
  
  %let geo = %upcase( &geo );
  %let st = %upcase( &st );

  %let var_list = GEO_ID,SUMLEVEL,CRRALL,CRRINT,RESP_DATE;
  
  %let geosuf = %sysfunc( putc( &geo, $geosuf. ) );
  %let geodlbl = %sysfunc( putc( &geo, $geodlbl. ) );
  
  %if &geo = GEO2020 %then %do;
    %let stfips = %sysfunc( stfips( &st ) ); 
    %let in = state:&stfips;
    %let for = tract:*;
    %let out = Response_rates_2020_%lowcase(&st.)&geosuf;
    %let dslabel = Census 2020 final response rates, &st, &geodlbl;
  %end;
  %else %if &geo = COUNTY %then %do;
    %let in = state:11,24,51,54;
    %let for = county:*;
    %let out = Response_rates_2020_was20&geosuf;
    %let dslabel = Census 2020 final response rates, Washington region (2020), &geodlbl;
  %end;
  %else %do;
    %err_mput( macro=Create_response_rate_ds, msg=Geographic level geo=&geo not supported. );
  %end;
  
  %** Create and execute API call **;

  %let api_url = https://api.census.gov/data/2020/dec/responserate?get=&var_list.%nrstr(&for)=&for.%nrstr(&in)=&in.;
      
  %Get_census_api(
    api="&api_url",
    out=_Census_2020_response_rates
  )
  
  ** Finalize data set **;

  data &out;

    set _Census_2020_response_rates;
    
    length Ucounty $ 5;
    Ucounty = trim( state ) || trim( county );
        
    %if &geo = GEO2020 %then %do;
      
      length Geo2020 $ 11;
      Geo2020 = trim( state ) || trim( county ) || trim( tract );
    
      label 
        Geo2020 = "Full census tract ID (2020): ssccctttttt"
        tract = "Census tract code";
        
      format Geo2020 $geo20a.;

    %end;
    %else %if &geo = COUNTY %then %do;
    
      if put( ucounty, $ctym20f. ) ~= '';
      
      %metro20( ucounty )
      
      format ucounty $cnty20f.;
      
    %end; 
    
    _crrint = 1 * crrint;
    _crrall = 1 * crrall;
    _resp_date = input( resp_date, yymmdd10. );
    
    format state $fstname. _resp_date mmddyy10.;
    
    label
      Ucounty = "Full county ID: ssccc"
      GEO_ID = "Combined codes for the reference geography (Census)"
      SUMLEVEL = "Summary Level code"
      county = "County code"
      state = "State code"
      _CRRALL = "Cumulative Self-Response Rate - Overall"
      _CRRINT = "Cumulative Self-Response Rate - Internet"
      _RESP_DATE = "Most recent data cutoff for responses received"
    ;

    rename _crrint=crrint _crrall=crrall _resp_date=resp_date ucounty=county county=fips_county;
    drop ordinal_root crrint crrall resp_date;
    
  run;

  %Finalize_data_set( 
    data=&out,
    out=&out,
    outlib=Census,
    label="&dslabel",
    sortby=&geo,
    printobs=40,
    freqvars=sumlevel state,
    revisions=%str(&revisions)
  )

  run;
  
  ** Clean up temporary file **;
  
  proc datasets library=work nolist nowarn;
    delete _Census_2020_response_rates /memtype=data;
  quit;
  
  %exit_macro:

%mend Create_response_rate_ds;

/** End Macro Definition **/

%Create_response_rate_ds( geo=county )

%Create_response_rate_ds( st=DC, geo=geo2020 )
%Create_response_rate_ds( st=MD, geo=geo2020 )
%Create_response_rate_ds( st=VA, geo=geo2020 )
%Create_response_rate_ds( st=WV, geo=geo2020 )

