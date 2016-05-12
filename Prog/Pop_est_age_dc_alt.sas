/**************************************************************************
 Program:  Pop_est_age_dc_alt.sas
 Library:  Census
 Project:  NeighborhoodInfo DC
 Author:   P. Tatian
 Created:  05/22/08
 Version:  SAS 9.1
 Environment:  Windows
 
 Description:  Read census population estimates by age and sex.
 
 Alternate file with new estimates provided by DC State Data Center.

 Modifications:
**************************************************************************/

%include "K:\Metro\PTatian\DCData\SAS\Inc\Stdhead.sas";

** Define libraries **;
%DCData_lib( Census )

%let start_yr = 2000;
%let end_yr   = 2007;

proc format;
  invalue age
    ' ' = 1
    '00' - '04' = 2
    '05' - '09' = 3
    '10' - '14' = 4
    '15' - '19' = 5
    '20' - '24' = 6
    '25' - '29' = 7
    '30' - '34' = 8
    '35' - '39' = 9
    '40' - '44' = 10
    '45' - '49' = 11
    '50' - '54' = 12
    '55' - '59' = 13
    '60' - '64' = 14
    '65' - '69' = 15
    '70' - '74' = 16
    '75' - '79' = 17
    '80' - '84' = 18
    '85' - '99' = 19
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

  data &var._dis (compress=no);

    length xage $ 40 Age_group 8;
    
    %do y = &start_yr %to &end_yr;
      length x&var._&y $ 20 &var._&y 8;
    %end;
      
    infile "&_dcdata_path\census\raw\DC Pop ESt by Age 2000-2007.csv" dsd stopover firstobs=&start_row obs=&end_row;

    input xage @;

    %do y = &start_yr %to &end_yr;
      input x&var._&y @;
      &var._&y = input( x&var._&y, comma20. );
      label &var._&y = "&label, &y";
    %end;
    
    input;
        
    if substr( xage, 1, 1 ) = '.' then xage = substr( xage, 2 );
    
    Age_group = input( put( 1 * scan( xage, 1 ), z2. ), age. );
    
    label Age_group = 'Age group';
    
    format Age_group agegroup.;
    
    drop xage x&var._: ;
    
  run;
  
  /*%File_info( data=&var._dis, printobs=100 )*/

  proc summary data=&var._dis;
    class Age_group;
    var &var: ;
    output out=&var (compress=no drop=_type_ _freq_) sum= ;
  run;
  
  /*%File_info( data=&var, printobs=50 )*/

%mend Read_sec;

/** End Macro Definition **/


** Read individual sections of table **;

%Read_sec( Pop, 4, 89, &start_yr, &end_yr, Total persons )

%Read_sec( Male, 94, 179, &start_yr, &end_yr, Males )

%Read_sec( Female, 184, 269, &start_yr, &end_yr, Females )


** Combine together **;

data Census.Pop_est_age_dc 
       (label="Census population estimates by age and sex, DC, &start_yr-&end_yr"
        sortedby=age_group);

  merge pop male female;
  by age_group;
  
  if age_group = . then age_group = 1;
  
run;

%File_info( data=Census.Pop_est_age_dc, freqvars=age_group, printobs=16 )

