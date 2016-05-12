/**************************************************************************
 Program:  Census_est_dc.sas
 Library:  Census
 Project:  NeighborhoodInfo DC
 Author:   P. Tatian
 Created:  12/26/07
 Version:  SAS 9.1
 Environment:  Windows
 
 Description:  Read census population estimates data downloaded from
 Census web site (http://www.census.gov/popest/states/asrh/).

 Modifications:
**************************************************************************/

%include "K:\Metro\PTatian\DCData\SAS\Inc\Stdhead.sas";
***%include "C:\DCData\SAS\Inc\Stdhead.sas";

** Define libraries **;
%DCData_lib( Census )

proc format;
  invalue age
    'Total' = 1
    'Under 5 years' = 2
    '5 to 9 years' = 3
    '10 to 14 years' = 4
    '15 to 19 years' = 5
    '20 to 24 years' = 6
    '25 to 29 years' = 7
    '30 to 34 years' = 8
    '35 to 39 years' = 9
    '40 to 44 years' = 10
    '45 to 49 years' = 11
    '50 to 54 years' = 12
    '55 to 59 years' = 13
    '60 to 64 years' = 14
    '65 to 69 years' = 15
    '70 to 74 years' = 16
    '75 to 79 years' = 17
    '80 to 84 years' = 18
    '85 years and over' = 19
    otherwise = .u;    

run;

proc format library=Census;
  value agegroup
    1 = 'Total'
    2 = 'Under 5 years'
    3 = '5 to 9 years'
    4 = '10 to 14 years'
    5 = '15 to 19 years'
    6 = '20 to 24 years'
    7 = '25 to 29 years'
    8 = '30 to 34 years'
    9 = '35 to 39 years'
    10 = '40 to 44 years'
    11 = '45 to 49 years'
    12 = '50 to 54 years'
    13 = '55 to 59 years'
    14 = '60 to 64 years'
    15 = '65 to 69 years'
    16 = '70 to 74 years'
    17 = '75 to 79 years'
    18 = '80 to 84 years'
    19 = '85 years and over'
;  

/** Macro Read_sec - Start Definition **/

%macro Read_sec( var, start_row, end_row, start_yr, end_yr, label );

  data &var (compress=no);

    length xage $ 40 Age_group 8;
    
    %do y = &start_yr %to &end_yr;
      length x&var._&y $ 20 &var._&y 8;
    %end;
      
    infile "&_dcdata_path\census\raw\SC-EST2006-02-11.csv" dsd stopover firstobs=&start_row obs=&end_row;

    input xage @;

    %do y = &end_yr %to &start_yr %by -1;
      input x&var._&y @;
      &var._&y = input( x&var._&y, comma20. );
      label &var._&y = "&label, 7/1/&y";
    %end;
    
    input;
        
    if _n_ = 1 then xage = 'Total';
    
    if substr( xage, 1, 1 ) = '.' then xage = substr( xage, 2 );
    
    Age_group = input( xage, age. );
    
    label Age_group = 'Age group';
    
    format Age_group agegroup.;
    
    drop xage x&var._: ;
    
  run;

  /*%File_info( data=&var, printobs=50 )*/

%mend Read_sec;

/** End Macro Definition **/


** Read individual sections of table **;

%Read_sec( Pop, 5, 23, 2000, 2006, Total persons )

%Read_sec( Male, 40, 58, 2000, 2006, Males )

%Read_sec( Female, 75, 93, 2000, 2006, Females )


** Combine together **;

data Census.Census_est_dc 
       (label="Census population estimates by age and sex, DC, 2000-2006"
        sortedby=age_group);

  merge pop male female;
  by age_group;
  
run;

%File_info( data=Census.Census_est_dc, freqvars=age_group, printobs=16 )

