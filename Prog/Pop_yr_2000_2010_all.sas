/**************************************************************************
 Program:  Pop_2000_2010_all.sas
 Library:  Census
 Project:  NeighborhoodInfo DC
 Author:   P. Tatian
 Created:  05/04/11
 Version:  SAS 9.1
 Environment:  Windows with SAS/Connect
 
 Description:  Create files for all DC geographies with estimated
 population totals from 2000 to 2010 using straight line
 interpolation of decennial census numbers.
 
 NOTE: THIS PROGRAM NOT COMPLETED.

 Modifications:
**************************************************************************/

%include "K:\Metro\PTatian\DCData\SAS\Inc\Stdhead.sas";
%include "K:\Metro\PTatian\DCData\SAS\Inc\AlphaSignon.sas" /nosource2;

** Define libraries **;
%DCData_lib( Census )

** Start submitting commands to remote server **;

rsubmit;

%let revisions = New file.;
%let register = N;

/** Macro Pop_2000_2010_geo - Start Definition **/

%macro Pop_2000_2010_geo( geo=, revisions=, register=N );

  %let register = %upcase( &register );
  %let geo = %upcase( &geo );

  %if %sysfunc( putc( &geo, $geoval. ) ) ~= %then %do;
    %let geosuf = %sysfunc( putc( &geo, $geosuf. ) );
    %let geodlbl = %sysfunc( putc( &geo, $geodlbl. ) );
    %let geofmt = %sysfunc( putc( &geo, $geoafmt. ) );
    %let geobk0m = %sysfunc( putc( &geo, $geobk0m. ) );
    %let geobk1m = %sysfunc( putc( &geo, $geobk1m. ) );
  %end;
  %else %do;
    %err_mput( macro=Create_sum_geo, msg=Invalid or missing value of GEO= parameter (GEO=&geo). )
    %goto exit_macro;
  %end;
  
  %put _local_;
  
  ** Create 2000 population totals **;
  
  data Pop2000_blk;
  
    set Census.Cen2000_sf1_dc_blks (keep=geoblk2000 p1i1);
    
    %&geobk0m()
    
    keep &geo p1i1;
    
  run;
      
  proc summary data=Pop2000_blk nway;
    class &geo;
    var p1i1;
    output out=Pop2000&geosuf sum=TotPop_2000;
  run;
  
  %File_info( data=Pop2000&geosuf, contents=N, stats= )
  
  ** Create 2010 population totals **;
  
  data Pop2010_blk;
  
    set Census.Census_pl_2010_dc 
          (where=(sumlev='750') 
           keep=state county tract block sumlev p0010001);
    
    length GeoBlk2010 $ 15;
    
    GeoBlk2010 = state || county || tract || block;
    
    %&geobk1m()
    
    keep &geo p0010001;
    
  run;
      
  proc summary data=Pop2010_blk nway;
    class &geo;
    var p0010001;
    output out=Pop2010&geosuf sum=TotPop_2010;
  run;
  
  %File_info( data=Pop2010&geosuf, contents=N, stats= )
  
  %exit_macro:

%mend Pop_2000_2010_geo;

/** End Macro Definition **/


%Pop_2000_2010_geo( geo=ward2002, revisions=&revisions, register=&register )


run;

endrsubmit;

** End submitting commands to remote server **;




run;

signoff;
