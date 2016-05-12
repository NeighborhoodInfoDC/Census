/**************************************************************************
 Program:  Temp.sas
 Library:  Census
 Project:  NeighborhoodInfo DC
 Author:   P. Tatian
 Created:  03/21/11
 Version:  SAS 9.1
 Environment:  Windows
 
 Description:

 Modifications:
**************************************************************************/

%include "K:\Metro\PTatian\DCData\SAS\Inc\Stdhead.sas";

** Define libraries **;
%DCData_lib( Census )

proc freq data=Census.Census_pl_2010_md;
  where not( missing( block ) );
  tables sumlev;
  format sumlev ;
run;

proc print data=Census.Census_pl_2010_md (obs=100);
  where sumlev = "750";
  id state county tract blkgrp block;
  var P0010001;

run;

data A;
  set Census.Census_pl_2010_md (where=(sumlev="750"));
run;

%Dup_check(
  data=A,
  by=state county tract blkgrp block,
  id=p0010001,
  listdups=Y,
  count=dup_check_count,
  quiet=N,
  debug=N
)

