/**************************************************************************
 Program:  Upload_Blk_xwalk_2000_2010_dc.sas
 Library:  Census
 Project:  NeighborhoodInfo DC
 Author:   P. Tatian
 Created:  07/11/11
 Version:  SAS 9.1
 Environment:  Windows with SAS/Connect
 
 Description:  Upload Blk_xwalk_2000_2010_dc data set to Alpha and
 register metadata.

 Modifications:
**************************************************************************/

%include "K:\Metro\PTatian\DCData\SAS\Inc\Stdhead.sas";
%include "K:\Metro\PTatian\DCData\SAS\Inc\AlphaSignon.sas" /nosource2;

** Define libraries **;
%DCData_lib( Census )

** Start submitting commands to remote server **;

rsubmit;

proc upload status=no
  data=Census.Blk_xwalk_2000_2010_dc 
  out=Census.Blk_xwalk_2000_2010_dc;
run;

%Dc_update_meta_file(
  ds_lib=Census,
  ds_name=Blk_xwalk_2000_2010_dc,
  creator_process=Blk_xwalk_2000_2010_dc.sas,
  restrictions=None,
  revisions=%str(New file.)
)

run;

endrsubmit;

** End submitting commands to remote server **;

run;

signoff;
