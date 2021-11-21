/**************************************************************************
 Program:  Census_2010_response_rates.sas
 Library:  Census
 Project:  Urban-Greater DC
 Author:   P. Tatian
 Created:  11/20/21
 Version:  SAS 9.4
 Environment:  Local Windows session (desktop)
 GitHub issue:  26
 
 Description:  Fetch 2010 census response rate data with Census API.
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

  %let var_list = GEO_ID,SUMLEVEL,FSRR2010;
  
  %let geosuf = %sysfunc( putc( &geo, $geosuf. ) );
  %let geodlbl = %sysfunc( putc( &geo, $geodlbl. ) );
  
  %if &geo = GEO2010 %then %do;
    %let stfips = %sysfunc( stfips( &st ) ); 
    %let in = state:&stfips;
    %let for = tract:*;
    %let out = Response_rates_2010_%lowcase(&st.)&geosuf;
    %let dslabel = Census 2010 final response rates, &st, &geodlbl;
  %end;
  %else %if &geo = COUNTY %then %do;
    %let in = state:11,24,51,54;
    %let for = county:*;
    %let out = Response_rates_2010_was20&geosuf;
    %let dslabel = Census 2010 final response rates, Washington region (2010), &geodlbl;
  %end;
  %else %do;
    %err_mput( macro=Create_response_rate_ds, msg=Geographic level geo=&geo not supported. );
  %end;
  
  %** Create and execute API call **;

  %let api_url = https://api.census.gov/data/2010/dec/responserate?get=&var_list.%nrstr(&for)=&for.%nrstr(&in)=&in.;
      
  %Get_census_api(
    api="&api_url",
    out=_Census_2010_response_rates
  )
  
  ** Finalize data set **;

  data &out;

    set _Census_2010_response_rates;
    
    length Ucounty $ 5;
    Ucounty = trim( state ) || trim( county );
        
    %if &geo = GEO2010 %then %do;
      
      length Geo2010 $ 11;
      Geo2010 = trim( state ) || trim( county ) || trim( tract );
    
      label 
        Geo2010 = "Full census tract ID (2010): ssccctttttt"
        tract = "Census tract code";
        
      format Geo2010 $geo20a.;

    %end;
    %else %if &geo = COUNTY %then %do;
    
      if put( ucounty, $ctym20f. ) ~= '';
      
      %metro20( ucounty )
      
      format ucounty $cnty20f.;
      
    %end; 
    
    _FSRR2010 = 1 * FSRR2010;
    
    format state $fstname.;
    
    label
      Ucounty = "Full county ID: ssccc"
      GEO_ID = "Combined codes for the reference geography (Census)"
      SUMLEVEL = "Summary Level code"
      county = "County code"
      state = "State code"
      _FSRR2010 = "Final self response rate 2010"
    ;

    rename _FSRR2010=FSRR2010 ucounty=county county=fips_county;
    drop ordinal_root FSRR2010;
    
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
    delete _Census_2010_response_rates /memtype=data;
  quit;
  
  %exit_macro:

%mend Create_response_rate_ds;

/** End Macro Definition **/

%Create_response_rate_ds( geo=county )

%Create_response_rate_ds( st=DC, geo=geo2010 )
%Create_response_rate_ds( st=MD, geo=geo2010 )
%Create_response_rate_ds( st=VA, geo=geo2010 )
%Create_response_rate_ds( st=WV, geo=geo2010 )

