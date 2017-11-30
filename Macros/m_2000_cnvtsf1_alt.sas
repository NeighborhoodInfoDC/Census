/**************************************************************************
 Program:  m_2000_cnvtsf1_alt.sas
 Library:  Census
 Project:  NeighborhoodInfo DC
 Author:   P. Tatian
 Created:  09/03/04
 Version:  SAS 9.2
 Environment:  Local Windows session (desktop)
 
 Description: Autocall macro to read in SF1 data for a state.
 Adapted from U Missouri program cnvtsf1_alt.sas.
 Search for "**PT" for modifications.

 Modifications:
  11/29/17 PT Adapted from original m_cnvtsf1_alt.sas program.
**************************************************************************/


%macro m_2000_cnvtsf1_alt( 
  stateab= ,
  fipsst= ,
  inpath= ,
  outlib= ,
  maxobs=99999999,
  unzip_prg=L:\Tools\7-Zip\7z
);

  %global stab state;

  %let stab = &stateab;
  %let state = &fipsst;
  
  options noxwait;

  **PT**x cd /pub/data/sf12000/Tools;  %let pgm=cnvtsf1_alt;  filename pgm "&pgm..sas";   *<====mo only===;

  *---New alternative to the way we originally converted the files.  In this new version we keep the geographic
      codes with the data, and eliminate the slow and confusing SAS views.--;
  /*--This program will read a set of ascii csv files containing the 2000 SF1 data for a
      state (or US in the case of the national file).
      John Blodgett,  OSEDA, U. of Missouri
      Under contract with the Missouri Census Data Center.
      Part of the joint project of the national State Data Center.
      January, 2002.
      ************See module cnvtsf1_+alt.txt in this same directory for a detailed description of this
                  conversion setup, including how it differs from previous cnvtsf1.sas setup.***********
   ---*/

  /*-------Revision history:
     1-12-02:  Begin coding.  Using the cnvtsf1.sas as model to tweak.
                ==Test convert of Missouri=== 1.12
   --------*/

  *---save this report in new .lst file for each state converted---;

   /*<=========================Comment out (previous conversions)=====================================
  %let stab=de;  %let state=10;  *--Delaware--;
  %let stab=ks;  %let state=20;  *---Kansas-;
  %let stab=il;  %let state=17;  *---Illinois--;
  %let stab=mo;  %let state=29;  *--Missouri--;
  %let stab=ia;  %let state=19;  *--Iowa--;
  %let stab=us;  %let state=00;  *--Advanced National File, 1-15-2002.  Edited _select macro!======;
  %let stab=md;  %let state=24;  *---Maryland--;
  %let stab=mi;  %let state=26;  *---Michigan--;
  ===========================End commented out======================================================== */

  %let ucstab=%upcase(&stab);

/**PT**
  proc printto print = "&pgm&stab..lst" new;  run;
**PT**/

  **PT**filename curpath '/pub/data/sf12000/Tools';  *<===points to current directory.  We shall do some %include s below that
           reference sas label-statement modules in the same directory as the current program.--;

  /**PT**%let inpath=%str(/pub/data/sf12000); *<===path (directory) where the input raw data is stored---*; ****/
  **PT**libname sf12000 "&inpath";    *<===========output sas data sets stored is same dir as input files======;
  **PT**libname sf1     "&inpath";    *--You can use alternate name if you want.  Mix and match--;


  **PT**title "Conversion of 2000 Summary File 1 Data for &ucstab";

  /**PT**%let maxobs=99999999;**/   *<=======while testing, limits processing to this many input recs==;

  %macro afilesfx;
   %global stab filesfx;
   %if %quote(&stab)=us %then %let filesfx=u1;  %else %let filesfx=uf1;
   %mend afilesfx;
  %afilesfx
  %put filesfx= &filesfx;

  **PT**filename geos "&inpath/&stab.geo.&filesfx";   *<====assumes you have unzipped the .zip file with this inside;
  **PT**filename geos pipe "&unzip_prg -a -p &inpath\&stab.geo._&filesfx";
  x "&unzip_prg e -y -o""&inpath\unzip"" ""&inpath\&stab.geo_&filesfx..zip""";
  ****filename geos "&inpath\&stab.geo_&filesfx..zip\&stab.geo.&filesfx";
  filename geos "&inpath\unzip\&stab.geo.&filesfx";

  **PT**x cd &inpath;   *<---make it the current directory--;

  %macro select;
   %*--This macro will be invoked when reading the headers data.  It should assign a value
       of 1 to _keep to indicate that the record/observation is to be processed.  1 means
       read the data, 0 means do not.--;
    _keep=1;
    /*  if sumlev in ('040','050') then _keep=1;  else _keep=0; */  *<====For example==;
     /*<=========================Comment out=====================================
       if sumlev='070' then _keep=0;  else _keep=1;
      *************************FOR US Advanced National File do NOT keep the level 070 summaries****************;
    ===========================End commented out================================ */

    **<===add/substitute your custom code here.  You can access any variable on the geography headers file--;
    %mend select;


   data
     &outlib..&stab.geos (compress=yes sortedby=geo_id label="Census 2000 SF1 Geo Headers data for &ucstab, exc Blocks" keep=geo_id--AreaSQMI PCT)
     &outlib..&stab.ph(compress=yes sortedby=geo_id label="Census 2000 SF1 P & H Tables for &ucstab, exc Blocks)" keep=geo_id--AreaSQMI
                                    PCT p1i1--p35Ii20 h1i1--h16Ii19 )
     &outlib..&stab.pct(compress=yes sortedby=geo_id label="Census 2000 SF1 PCT tables exc PCT12r for &ucstab" keep=geo_id--AreaSQMI
                      pct1i1--pct17i75 pct13ai1--pct17Ii75)
     &outlib..&stab.pct12R(compress=yes sortedby=geo_id label="Census 2000 SF1 PCT12 Race Sfx Tables for &ucstab" keep=geo_id--AreaSQMI
                               pct12ai1--pct12oi209)
     &outlib..&stab.phblks(compress=yes sortedby=ucounty tract block
                                    label="Census 2000 SF1 P & H Tables for &ucstab - Blocks only" keep=geo_id--AreaSQMI
                                    p1i1--p35Ii20 h1i1--h16Ii19 index=(ucounty) drop=geocode areaname);

   *<-----list of variables to keep for the phng data set edited 6.18.01: h16Ii19  replaces h20i5----;

    infile geos missover lrecl=1024  obs=&maxobs;
    retain _first 1;  drop _first;
    length geo_id 5 GeoCode $44 SumLev $3 GeoComp $2 AreaName $90;  *--establish variable order -- these go first--;
    length Geo2000 $ 11 GeoBlk2000 $ 15;  **PT** Full tract & block IDs **;
    retain State "&state" Stab /**PT "&stab" **/ "&ucstab";  
    length County $5 Tract $7;    *--and then these... -;
    
    if _first then do;
      input FileId $char6.  stusab $2. @;  retain FileId stusab;  drop fileid stusab;
      if substr(FileId,2,3) ne 'SF1' then do;
         file log;  put '******Problem with input geographic headers file.  Did not find "SF1" in cols. 2-4 ' FileId= /
         '***Conversion will not run***';
         stop;
         end;
      end;

    input
   @9   SumLev $3.  geocomp $2.
   @19  LogRecNo 7.
   @26  Region $1. Division $1. StateCe $2. State $2.  Cnty $3. CntySC $2.
   @37  CouSubFP $5. CouSubCC $2. CouSubSC $2. PlaceFP $5. PlaceCC $2. PlaceDC $1. PlaceSC $2.
   @56  TractIn $6.  BG $1. Block $4. @69 ConCit  $5.
   @78 aianhh $char4.  aianhhfp $char5. aianhhcc $char2. aihhtli $1. aitsce $char3. aits $char5. aitscc $char2.
       anrc $char5.  anrccc $char2.
   @107 MSACMSA $4. MASC $2. CMSA2 $2. MACCI $1. PMSA $4. NECMA $4.
   @136 UrbanRur $1. cd106 $2. +6 (sldu sldl)($char3.) vtd $char6. vtdi $1.
   @158 ZCTA3 $3.  ZCTA5 $5.
   @173 (AreaLand AreaWatr)(14.)  AreaName $90.  FuncStat $1. gcuni $1.
   @293 Pop100 9.  HU100 9.  IntPtLat 9.6 IntPtLon 10.6 LSADC $2.
   @332 PartFlag $1. (SDElm SDSec SDUni)($5.) TAZ $6. UGA $5. PUMA5 $5. PUMA1 $5.
   @384 MACC $char5.  UACP $char5. ;

    %select ;  *<-----Invoke the macro that will filter based on value of sumlev-------------------*;
    geo_id+1;
   if cnty ne ' ' then County=state||cnty;
   *--edit the tract so that it is in xxxx.xx format with leading and trailing zeroes--;
   if TractIn ne ' ' then Tract=translate( substr(TractIn,1,4)||'.'||substr(TractIn,5,2) ,'0',' ');
    drop tractin;

  %macro concatd(g1,g2,g3,g4,g5,g6,g7,g8); %*--utility macro used to create geocode values-;
      %*--utility macro to return a SAS expression that will be the concatenation of specified char variables
          separated by dashes-;
      %local dash  gc;  %let dash=%str(||'-'||);
      %*--we build the value of local variable gc which is then "returned" as the result of invoking the macro-;
      %let gc=&g1;          %if &g2= %then %goto rtrn;
      %let gc=&gc&dash&g2;  %if &g3= %then %goto rtrn;
      %let gc=&gc&dash&g3;  %if &g4= %then %goto rtrn;
      %let gc=&gc&dash&g4;  %if &g5= %then %goto rtrn;
      %let gc=&gc&dash&g5;  %if &g6= %then %goto rtrn;
      %let gc=&gc&dash&g6;  %if &g7= %then %goto rtrn;
      %let gc=&gc&dash&g7;  %if &g8= %then %goto rtrn;
      %let gc=&gc&dash&g8;
    %rtrn:
      &gc
      %mend concatd;

   select(SumLev);  *---Assign the standardized Geographic Code to uniquely ID the geographic area--;
     when('010') geocode=' ';
     when('020') geocode=region;
     when('030') geocode=division;
     when('040') geocode=state;
     when('050') geocode=county;
     when('060') geocode=%concatd(county,cousubfp);
     when('070') geocode=%concatd(county,cousubfp,placefp);
     when('080') geocode=%concatd(county,cousubfp,placefp,tract);
     when('091') geocode=%concatd(county,cousubfp,placefp,tract,aianhhfp,anrc,cd106,bg);  ***????***;
     when('101') geocode=%concatd(county,tract,block);

     when('140') geocode=%concatd(county,tract);
     when('144') geocode=%concatd(county,tract,aianhhfp);
     when('150') geocode=%concatd(county,tract,bg);
     when('154') geocode=%concatd(county,tract,bg,aianhhfp);
     when('155') do;
                 geocode=%concatd(county,placefp);

/*******
     *<===Override areaname to make it the name of the place rather than the county.To leave as-is delete this + next 4 lines;
                 length _arg $7; _arg=state||placefp;
                 drop _arg;
                 areaname=put(_arg,$fplace.);
                 if areaname=_arg then areaname='Place '||placefp;
********/
                 end;
     when('158') geocode=%concatd(state,placefp,cnty,tract);
     when('160') geocode=%concatd(state,placefp);
     when('170') geocode=%concatd(state,concit);
     when('172') geocode=%concatd(state,concit,placefp);
     when('250') geocode=aianhh;
     when('260') geocode=%concatd(aianhhfp,state);
     when('270') geocode=%concatd(aianhhfp,cnty);
     when('271') geocode=%concatd(aianhhfp,cnty,cousubfp);
     when('273') geocode=%concatd(aianhhfp,cnty,cousubfp,placefp);

     when('252') geocode=aianhh;
     when('262') geocode=%concatd(aianhhfp,state);
     when('272') geocode=%concatd(aianhhfp,cnty);
     when('275') geocode=%concatd(aianhhfp,cnty,cousubfp);
     when('276') geocode=%concatd(aianhhfp,cnty,cousubfp,placefp);

     when('254') geocode=aianhh;
     when('264') geocode=%concatd(aianhhfp,state);
     when('274') geocode=%concatd(aianhhfp,cnty);
     when('277') geocode=%concatd(aianhhfp,cnty,cousubfp);
     when('278') geocode=%concatd(aianhhfp,cnty,cousubfp,placefp);

     when('256','291','292') geocode=%concatd(aianhhfp,tract);
     when('258','293','294') geocode=%concatd(aianhhfp,tract,bg);

     when('251','253','255') geocode=%concatd(aianhhfp,aits);
     when('257') geocode=%concatd(aianhhfp,aits,tract);
     when('259') geocode=%concatd(aianhhfp,aits,tract,bg);
     when('290') geocode=%concatd(aianhhfp,aits,state);


     when('280','283','286') geocode=%concatd(state,aianhhfp);
     when('282','285','288') geocode=%concatd(state,aianhhfp,cnty);
     when('261','265','267') geocode=%concatd(state,aianhhfp,cnty,cousubfp);
     when('263','266','268') geocode=%concatd(state,aianhhfp,cnty,cousubfp,placefp);
     when('281','284','287') geocode=%concatd(state,aianhhfp,aits);
     when('230') geocode=%concatd(state,anrc);
     when('380') geocode=msacmsa;
     when('381') geocode=%concatd(msacmsa,state);
     when('382') geocode=%concatd(msacmsa,state,placefp);
     when('383') geocode=%concatd(msacmsa,state,cnty);
     when('384') geocode=%concatd(msacmsa,state,cousubfp);
     when('385') geocode=pmsa;
     when('386') geocode=%concatd(pmsa,state);
     when('387') geocode=%concatd(pmsa,state,cnty);
     when('388') geocode=%concatd(pmsa,state,cousubfp);

     when('370') geocode=necma;
     when('371') geocode=%concatd(necma,state);
     when('372') geocode=%concatd(pmsa,state,placefp);
     when('373') geocode=%concatd(pmsa,state,cnty);


     when('390') geocode=%concatd(state,msacmsa);
     when('391') geocode=%concatd(state,msacmsa,placefp);
     when('392') geocode=%concatd(state,msacmsa,cnty);
     when('393') geocode=%concatd(state,msacmsa,cnty,cousubfp);
     when('395') geocode=%concatd(state,msacmsa,pmsa);
     when('396') geocode=%concatd(state,msacmsa,pmsa,cnty);
     when('397') geocode=%concatd(state,msacmsa,pmsa,cnty,cousubfp);
     when('374') geocode=%concatd(state,necma);
     when('375') geocode=%concatd(state,necma,placefp);
     when('376') geocode=%concatd(state,necma,cnty);
     when('500') geocode=%concatd(state,cd106);
     when('510') geocode=%concatd(state,cd106,cnty);
     when('511') geocode=%concatd(state,cd106,cnty,tract);
     when('521') geocode=%concatd(state,cd106,cnty,cousubfp);
     when('531') geocode=%concatd(state,cd106,placefp);
     when('541') geocode=%concatd(state,cd106,concit,placefp);
     when('550','551','552') geocode=%concatd(state,cd106,aianhhfp);
     when('553','554','555') geocode=%concatd(state,cd106,aianhhfp,aits);
     when('850') geocode=zcta3;
     when('860') geocode=zcta5;


     when('851') geocode=%concatd(state,zcta3);
     when('852') geocode=%concatd(state,zcta3,cnty);
     when('871') geocode=%concatd(state,zcta5);
     when('881') geocode=%concatd(state,zcta5,cnty);

     otherwise  do;
         if sumlev ne lag(sumlev) then do;
           _badsl+1;  drop _badsl;
           if _badsl le 50 then put '**Unrecognized SUMLEV: ' sumlev;
           end;
         end;
     end;  *--select group--;
   geocode=compress(geocode,' ');  *--remove any blanks from geocode-----------------(mod 4.21.01)---;
   
   **PT UCOUNTY var **;
   rename county = Ucounty;
   
   **PT Create Geo2000 and GeoBlk2000 for appropriate summary levels **;

   if SumLev in ( '101' ) then do;
     GeoBlk2000 = compress( county || tract || block, " ." );
   end;

   if SumLev in ( '080', '091', '101', '140', '144', '150', '154',
                  '158', '256', '257', '258', '259', '291', '292', 
                  '293', '294', '511' ) then do;
     Geo2000 = compress( county || tract, " ." );
   end;

   %macro astab;
   %*---Adding this macro code 12-4-01 to define the stab (State Abbreviation) variable when converting a
        national file---*;
   %if %quote(&Ucstab) eq US %then %do;
     if state='  ' then stab=' ';
     else stab=put(state,$fipstab.);  *<====requires the $fipstab format code be defined.
                         See http://mcdc2.missouri.edu/sastools/sas_formats/Sfipstab.sas --;
     %end;
     %*--otherwise we have a retain statement above that causes variable stab to have a value of "&stab"-;
     %mend astab;
   %astab

    *--Set flag to indicate whether this summary level will have data for the CT tables--;
    *_readPCT= ( sumlev not in ('091','101','150','154','258','293','294','259') );   *--subtract geo summmary levels--;
    _readPCT= ( sumlev not in ('091','101','150','154') );   *--Tribal block groups are not sub-tract apparently--;
    attrib  PCT length=3 format=1. label='PCT data flag';

    PCT=_readPCT;    *<--------save the flag on the geos data set-------------------------;

   ***temporary diagnostic *****  put geocode= _N_= areaname= sumlev= _readPCT=;

   *--Create land and total area values in square miles. --;
   LandSQMI=AreaLand/2589988;  AreaSQMI=LandSQMI + (AreaWatr/2589988);
   format LandSQMI AreaSQMI 9.2;
   format IntPtLon 11.6 IntPtLat 10.6;  *<--added 7-13-01-;

   **PT** Geographic ID labels **;
   label SumLev='Geographic Summary Level' GeoComp='Geographic Component';
   label cnty='County code';
   label LandSQMI='Land Area Sq Mls' AreaSQMI='Total Area Sq Mls'
         AreaLand='Land Area Sq Meters' AreaWatr='Water Area Sq Meters';
   label cd106='Cong District - 106th (1998)' sldu='State Leg District Upper Chbr'
         sldl='State Leg District Lower Chbr';
   **PT** New labels **;
   label 
     ZCTA5='ZIP Census Tabulation Area (5-digit)'
     county='Full county ID:  ssccc'
     Geo2000 = "Full census tract ID (2000): ssccctttttt"
     GeoBlk2000 = "Full census block ID (2000): sscccttttttbbbb"
   ;

   *---For processing zip codes on the national files we assign the "primary" state code associated with the zip or
       zip center (zcta5 or zcta3) using the builtin SAS functions zipfips and zipstate--;
   if sumlev in ('850','860') then do;
     length _ziparg $5 ;
     if sumlev='850' then _ziparg=zcta3||'01';  else _ziparg=zcta5;
     if sumlev='860' and substr(zcta5,4,2) in ("XX","HH") then _ziparg=substr(zcta5,1,3)||'01';
     state= put ( zipfips(_ziparg), z2. );
     stab = lowcase ( zipstate(_ziparg) );
     if stab=' ' then do;
       _error_=0;
       file log;  _nziperr+1;
       if _nziperr=1 then put '****ZIP codes not assigned to states****';
       put +2 _ziparg $5.  @@;
       end;
     drop _ziparg _nziperr;
     end;


    *---Use a length statement to set up the variables in order in the PDV (program data vector).  Then we can
        used "double-dash" variable intervals in the input statements and SAS will know
        which variables are in those intervals----*;

  %*--assign the macro vars containing the first and last variables in each input file--;

    length p1i1 p2i1 - p2i6 p3i1-p3i71  p4i1-p4i73  p5i1-p5i71 5;
    %let fvar1=p1i1;  %let lvar1=p5i71;

    length p6i1-p6i73  p7i1-p7i8 p8i1-p8i17 p9i1-p9i7 p10i1-p10i15 p11i1 p12i1-p12i49
           p13i1-p13i3 p14i1-p14i43 p15i1 p16i1 p17i1 p18i1-p18i19 5;
    %let fvar2=p6i1;  %let lvar2=p18i19;

    length p19i1-p19i19 p20i1-p20i31 p21i1-p21i19 p22i1-p22i11 p23i1-p23i11 p24i1-p24i11
           p25i1-p25i3 p26i1-p26i16 p27i1-p27i27 p28i1-p28i17 p29i1-p29i46 p30i1-p30i22
           p31i1 p32i1 p33i1 5;
    %let fvar3=p19i1; %let lvar3=p33i1;

    length p34i1-p34i20 p35i1-p35i20 p36i1-p36i20 p37i1-p37i9 p38i1-p38i57 p39i1-p39i5
           p40i1-p40i3 p41i1-p41i3 p42i1-p42i3 p43i1-p43i3 p44i1-p44i3 p45i1-p45i3 5;
    %let fvar4=p34i1;  %let lvar4=p45i3;

    length p12ai1-p12ai49 p12bi1-p12bi49 p12ci1-p12ci49 p12di1-p12di49 p12ei1-p12ei49 5;
    %let fvar5=p12ai1;  %let lvar5=p12ei49;

    length p12fi1-p12fi49 p12gi1-p12gi49 p12hi1-p12hi49 p12Ii1-p12Ii49 p13ai1-p13ai3
           p13bi1-p13bi3 p13ci1-p13ci3 p13di1-p13di3 p13ei1-p13ei3 p13fi1-p13fi3 p13gi1-p13gi3
           p13hi1-p13hi3 p13Ii1-p13Ii3 p15ai1 p15bi1 p15ci1 p15di1 p15ei1 p15fi1 p15gi1 p15hi1
           p15Ii1 p16ai1 p16bi1 p16ci1 p16di1 p16ei1 p16fi1 p16gi1 p16Hi1 p16Ii1 5;
    %let fvar6=p12fi1;  %let lvar6=p16Ii1;

    length p17ai1 p17bi1 p17ci1 p17di1 p17ei1 p17fi1 p17gi1 p17hi1 p17Ii1 p26ai1-p26ai16
           p26bi1-p26bi16 p26ci1-p26ci16 p26di1-p26di16 p26ei1-p26ei16 p26fi1-p26fi16
           p26gi1-p26gi16 p26hi1-p26hi16 p26Ii1-p26Ii16 p27ai1-p27ai27 p27bi1-p27bi27
           p27ci1-p27ci27 5;
    %let fvar7=p17ai1;  %let lvar7=p27ci27;

    length p27di1-p27di27 p27ei1-p27ei27 p27fi1-p27fi27 p27gi1-p27gi27 p27hi1-p27hi27
           p27Ii1-p27Ii27 p28ai1-p28ai17 p28bi1-p28bi17 p28ci1-p28ci17 p28di1-p28di17 p28ei1-p28ei17 5;
    %let fvar8=p27di1;  %let lvar8=p28ei17;

    length p28fi1-p28fi17 p28gi1-p28gi17 p28hi1-p28hi17 p28Ii1-p28Ii17 p30ai1-p30ai22
           p30bi1-p30bi22 p30ci1-p30ci22 p30di1-p30di22 p30ei1-p30ei22 p30fi1-p30fi22
           p30gi1-p30gi22 p30hi1-p30hi22 5;
    %let fvar9=p28fi1;  %let lvar9=p30hi22;

    length p30Ii1-p30Ii22 p31ai1 p31bi1 p31ci1 p31di1 p31ei1 p31fi1 p31gi1 p31hi1 p31Ii1 p32ai1
           p32bi1 p32ci1 p32di1 p32ei1 p32fi1 p32gi1 p32hi1 p32Ii1 p33ai1 p33bi1 p33ci1 p33di1
           p33ei1 p33fi1 p33gi1 p33hi1 p33Ii1 p34ai1-p34ai20 p34bi1-p34bi20 p34ci1-p34ci20
           p34di1-p34di20  p34ei1-p34ei20 p34fi1-p34fi20 p34gi1-p34gi20 p34hi1-p34hi20
           p34Ii1-p34Ii20 5;
    %let fvar10=p30Ii1;  %let lvar10=p34Ii20;

    length p35ai1-p35ai20 p35bi1-p35bi20 p35ci1-p35ci20 p35di1-p35di20 p35ei1-p35ei20
           p35fi1-p35fi20 p35gi1-p35gi20 p35hi1-p35hi20 p35Ii1-p35Ii20 5;
    %let fvar11=p35ai1;  %let lvar11=p35Ii20;

    length pct1i1-pct1i47 pct2i1-pct2i47 pct3i1-pct3i47 pct4i1-pct4i9 pct5i1-pct5i19
           pct6i1-pct6i19 pct7i1-pct7i19 pct8i1-pct8i14 pct9i1-pct9i14 5;
    %let fvar12=pct1i1;   %let lvar12=pct9i14;

    length pct10i1-pct10i14 pct11i1-pct11i31 5;
    %let fvar13=pct10i1;  %let lvar13=pct11i31;

    length pct12i1-pct12i209 5;
    %let fvar14=pct12i1;  %let lvar14=pct12i209;


    length pct13i1-pct13i49 pct14i1-pct14i7 pct15i1-pct15i13 pct16i1-pct16i52 pct17i1-pct17i75 5;
    %let fvar15=pct13i1;  %let lvar15=pct17i75;

    length pct12ai1-pct12ai209 5;
    %let fvar16=pct12ai1;  %let lvar16=pct12ai209;

    length pct12bi1-pct12bi209 5;
    %let fvar17=pct12bi1;  %let lvar17=pct12bi209;

    length pct12ci1-pct12ci209 5;
    %let fvar18=pct12ci1;  %let lvar18=pct12ci209;

    length pct12di1-pct12di209 5;
    %let fvar19=pct12di1;  %let lvar19=pct12di209;

    length pct12ei1-pct12ei209 5;
    %let fvar20=pct12ei1;  %let lvar20=pct12ei209;

    length pct12fi1-pct12fi209 5;
    %let fvar21=pct12fi1;  %let lvar21=pct12fi209;

    length pct12gi1-pct12gi209 5;
    %let fvar22=pct12gi1;  %let lvar22=pct12gi209;

    length pct12hi1-pct12hi209 5;
    %let fvar23=pct12hi1;  %let lvar23=pct12hi209;

    length pct12Ii1-pct12Ii209 5;
    %let fvar24=pct12Ii1;  %let lvar24=pct12Ii209;

    length pct12ji1-pct12ji209 5;
    %let fvar25=pct12ji1;  %let lvar25=pct12ji209;

    length pct12ki1-pct12ki209 5;
    %let fvar26=pct12ki1;  %let lvar26=pct12ki209;

    length pct12li1-pct12li209 5;
    %let fvar27=pct12li1;  %let lvar27=pct12li209;

    length pct12mi1-pct12mi209 5;
    %let fvar28=pct12mi1;  %let lvar28=pct12mi209;

    length pct12ni1-pct12ni209 5;
    %let fvar29=pct12ni1;  %let lvar29=pct12ni209;

    length pct12oi1-pct12oi209 5;
    %let fvar30=pct12oi1;  %let lvar30=pct12oi209;

    length pct13ai1-pct13ai49 pct13bi1-pct13bi49  pct13ci1-pct13ci49 pct13di1-pct13di49
           pct13ei1-pct13ei49 5;
    %let fvar31=pct13ai1;  %let lvar31=pct13ei49;


    length pct13fi1-pct13fi49 pct13gi1-pct13gi49  pct13hi1-pct13hi49 pct13Ii1-pct13Ii49
           pct15ai1-pct15ai13 pct15bi1-pct15bi13 pct15ci1-pct15ci13 5;
    %let fvar32=pct13fi1;  %let lvar32=pct15ci13;


    length pct15di1-pct15di13 pct15ei1-pct15ei13  pct15fi1-pct15fi13 pct15gi1-pct15gi13
           pct15hi1-pct15hi13 pct15Ii1-pct15Ii13 pct17ai1-pct17ai75 pct17bi1-pct17bi75 5;
    %let fvar33=pct15di1;  %let lvar33=pct17bi75;



    length pct17ci1-pct17ci75 pct17di1-pct17di75  pct17ei1-pct17ei75 5;
    %let fvar34=pct17ci1;  %let lvar34=pct17ei75;


    length pct17fi1-pct17fi75 pct17gi1-pct17gi75  pct17hi1-pct17hi75 5;
    %let fvar35=pct17fi1;  %let lvar35=pct17hi75;


    length pct17Ii1-pct17Ii75 5;
    %let fvar36=pct17Ii1;  %let lvar36=pct17Ii75;


    length h1i1 h2i1-h2i6 h3i1-h3i3 h4i1-h4i3 h5i1-h5i7 h6i1-h6i8 h7i1-h7i17 h8i1-h8i7
           h9i1-h9i15 h10i1 h11i1-h11i3 h12i1-h12i3 h13i1-h13i8 h14i1-h14i17 h15i1-h15i17
           h16i1-h16i19 h17i1-h17i69 h18i1-h18i3 h19i1-h19i5 h20i1-h20i5 5;
    %let fvar37=h1i1;  %let lvar37=h20i5;


    length h11ai1-h11ai3 h11bi1-h11bi3 h11ci1-h11ci3 h11di1-h11di3 h11ei1-h11ei3 h11fi1-h11fi3
           h11gi1-h11gi3 h11hi1-h11hi3 h11Ii1-h11Ii3 h12ai1-h12ai3 h12bi1-h12bi3 h12ci1-h12ci3
           h12di1-h12di3 h12ei1-h12ei3 h12fi1-h12fi3 h12gi1-h12gi3 h12hi1-h12hi3 h12Ii1-h12Ii3
           h15ai1-h15ai17 h15bi1-h15bi17 h15ci1-h15ci17 h15di1-h15di17 h15ei1-h15ei17
           h15fi1-h15fi17 h15gi1-h15gi17 h15hi1-h15hi17 h15Ii1-h15Ii17 5;
    %let fvar38=h11ai1;  %let lvar38=h15Ii17;


    length h16ai1-h16ai19 h16bi1-h16bi19 h16ci1-h16ci19 h16di1-h16di19 h16ei1-h16ei19
           h16fi1-h16fi19 h16gi1-h16gi19 h16hi1-h16hi19 h16Ii1-h16Ii19 5;
    %let fvar39=h16ai1;  %let lvar39=h16Ii19;

  *---You can comment out or delete these 2 statements if you do not want or need the variable labels.
      These modules created by Roy Williams, MISER, Mass. SDC from the SF1 data dictionary file. -----*;
    **PT**%include curpath(phlabs)/nosource2;  *--include sas label statements for the P and H tables--;
    **PT**%include curpath(pctlabs)/nosource2;   *--include sas label statements for the PCT tables (except pct12r).--;
    **PT**%include curpath(pct12rlabs)/nosource2;   *--include sas label statements for the PCT12r tables.--;
    %include phlabs /nosource2;  *--include sas label statements for the P and H tables--;
    %include pctlabs /nosource2;   *--include sas label statements for the PCT tables (except pct12r).--;
    %include pct12rlabs /nosource2;   *--include sas label statements for the PCT12r tables.--;

   %macro readloop;

   %local ifile i2;
   %*----loop to read from all 39 input files -- at least those that are relevant----*;
  %do ifile=1 %to 39;
    %if &ifile < 10 %then %let  i2=0&ifile;  %else %let i2=&ifile;
    **PT**filename in&ifile pipe "&unzip_prg -a -p &inpath\&stab.000&i2._&filesfx";   %*<==========NOTE====================;
    x "&unzip_prg e -y -o""&inpath\unzip"" ""&inpath/&stab.000&i2._&filesfx..zip""";
    filename in&ifile "&inpath\unzip\&stab.000&i2..&filesfx";
    _iseg="&i2";
    _isegck='  ';  %*--in case we do not read the segment because it is a PCT segment for a below-tract sumlev--;
    infile in&ifile  obs=&maxobs dsd missover lrecl=2048; %*<===lrecl may need to be increased for larger areas==;
    %if %substr(&&fvar&ifile , 1,3) =pct %then %let pctfile=1; %else %let pctfile=0;

    %*--We read the variables associated with the ith input file.  Except that for certain
       summary levels and certain input files there will not be any data.  We check for
       this with the _readPCT flag and generate that extra conditions when we detect that
       we have a file with pct variables-;
    if _keep
        %if &pctfile  %then %str( and _readPCT );
        then input _fileid $ _stateid $ _000 $  _isegck $2. +1 logrecnock 7. +1
          &&fvar&ifile -- &&lvar&ifile ;     *<--------here is where we reap reward for decaring all vars in order-;
     %if &pctfile %then %str( else if _readPCT then input; );
      %else %str( else input;);
    %*then input _first12  $char12.  _isegck $2. +1 logrecnock 7. +1 ;   %*<=====old code, replace 11-01===;
         %*--to flush the record when _keep=0---;
    if _isegck ne ' ' then link cklogrecno;

     %end;   %*--do ifile loop--------*;
     %mend readloop;

     options mprint;
     *-------------------Here is the big loop where we read up to 39 files (segments)-------------------*;
     %readloop
     ;
     _first=0;
     if _keep;  *---subsetting if.  No observation output if _keep=0---;
     *--Set tables p2 and h2 (Urban and Rural) to missing values if not the final national file--;
     if FileId ne 'uSF1F' then do;
       array p2(6) p2i1-p2i6;   array h2(6) h2i1-h2i6;
       do _i=2 to 5;
         p2(_i)=.;    h2(_i)=.;
         end;
       drop _i;
       end;
     *-----output the data sets.  THIS IS WHERE WE HAVE CHANGED THINGS DRAMATICALLY FROM EARLIER VERSION---------------*;

     if SumLev ne '101' then output  &outlib..&stab.geos;   *--All except blocks to the geos set-;
     if SumLev ne '101' then output  &outlib..&stab.ph;  else output &outlib..&stab.phblks; *--always to 1 or the other-;
     if _readPCT then do;
       output &outlib..&stab.pct;
       output &outlib..&stab.pct12R;
       end;

     drop logrecnock _isegck _iseg _readPCT  _keep  _fileid _stateid _000 ;  **_first12;
     return;
  cklogrecno:
    if logrecno ne logrecnock or _isegck ne _iseg then do;
       file log;
       put ///"********Problem with file synching: LogRecNo on segment " _iseg " does not match the geo headers value "
              "or segment code not expected. ******"
           /
        "Reading seg file " _iseg +1 'found segment code '  _isegck  /
        LogRecNo=  logrecnock=  _n_=  /
        _all_ / '******Job is aborting*********************************' ;
        stop;
        end;
     return;

     run;

   *-----------Create datasets indices to allow for quicker queries--------------------*;
  proc datasets library=&outlib nolist;
   modify &stab.ph;
   index create SumLev;
   index create ucounty;
   index create sumcnty=(SumLev ucounty);
   modify &stab.geos;
   index create SumLev;
   index create ucounty;
   modify &stab.pct;
   index create SumLev;
   index create ucounty;
  %macro usmods;
   %*--This is code that is conditionally executed or not based on whether we are doing a us file convert-;
   %global state;
   %if &state=00 %then %do;
    modify usph;  index create state;
    modify uspct; index create state;
    modify uspct12r;  index create state;
    delete usphblks;
    %end;
    %mend usmods;

   %usmods

   quit;

/**PT**
  proc contents data=&outlib.._all_ details nods;
    run cancel;
**PT**/

  data sumlevs/view=sumlevs;  
   set &outlib..&stab.geos(keep=SumLev State geocomp pop100);
   sumlev_code=sumlev;
   if geocomp='00';
   run;

  proc tabulate data=sumlevs noseps;
    class sumlev_code sumlev;
    var pop100;
    format sumlev $sumlev.;
    **PT**table sumlev_code*SumLev=' '*pop100*(n*f=comma7.  sum*f=comma12.) ;
    table sumlev_code*SumLev=' ', pop100*(n*f=comma7.  sum*f=comma12.) 
      /indent=3 rts=60;
    title2 'Proc Tabulate Report: Geography Summary Levels: # Occurrences & Total Pops';
    title3 '(excludes cases where geocomp is not 00)';
    title4 'Note: Does not include census block level summaries (code 101) Stored on Separate Dataset';
    run;

   **PT**%include sascode(notify);
   
   %** Clean up **;
   
   x "rmdir /s/q ""&inpath\unzip""";
   
%mend m_2000_cnvtsf1_alt;

