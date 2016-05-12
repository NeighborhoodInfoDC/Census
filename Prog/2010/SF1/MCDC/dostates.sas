
%macro dostates(
  /*--This macro is used as a "driver" to invoke a user-defined macro once for
     every state in the US or for every state whose FIPS code appears in the
     listfps parameter.  By default it will loop for all states including DC.  Specify
     N=50 to omit DC and specify N=57 to get the 6 territories as well (PR, GU,
     VI,etc).  The macro invokes the user-specified macro (default name is "doit")
     and passed 2 positional parm values: the first is the state fips code, the 2nd the
     state postal abbreviation in lower case.  The user-defined macro is named "doit" by 
     default (value of mac parm will override).  This macro should have 2 positional parms,
     the first for the state fips code (2-digit with leading 0) and the 2nd for the std 2-char 
     postal abbreviation.  ----  */
listfps, /* list of state fips code to process. If left blank it will be
          implied based on value of n parm. If n is not specified, it defaults to 51 and this parm 
          is assigned a value of 01 02 04 05 ... i.e., a list of
          all 50 state codes and DC  */
revdate=12/31/2003,
n=51,    /* number of states to process.  Only used if listfps is left blank, in which case we
            have 3 specially recognized values:
           51, to mean do all states + DC.
           52, to mean all states, DC and PR (new 5/09) 
           50, meaning do all states but not DC.
           57, means do all 50 states, DC and the 6 territories as well.
           If you specify your own list of state codes (listfps parm) the macro will calculate N as 
           the number of codes in your list  */
mac=doit,  /* name of the user-written macro that will be invoked once for each of the state
              codes specified via the listfps/n  parameters */
msgs=0,    /* specify msgs=1 to have a message generated on the log to signal the start of each
              invocation of the user-written macro  */

names=0,  /* specify names=1 to have the macro declare and assign a value to the global variable statenm
               which will contain the mixed-case name of the state during each cycle.  So, if you
               are processing Iowa and you specified names=1 then your macro will be able to
               use a statement such as :%put ***Begin processing &statenm ***. */
debug=0               
);
  
%*--- Revision History:
7-31-99: Adding determining of state name from state code via sysfunc/fipnamel.
11-14-99: Cleaning up the comments to make it useful to other people. 
11-17-99: Trivial change in comment describing names option.
  (NOTE: update value of revdate parm!!) 
  --*;

%if &msgs %then %put ***dostates macro, rev. &revdate,  Begin Execution***;

%local stabs stabs2 stfps stfps2;
%local _state _stab;

%let stabs=al ak az ar ca co ct de dc fl ga hi id il in ia ks ky la me md ma mi mn ms mo mt ne nv nh nj nm ny
 nc nd oh ok or pa ri sc sd tn tx ut vt va wa wv wi wy;

%let stfps=01 02 04 05 06 08 09 10 11 12 13 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31 32 33 34 35 36
 37 38 39 40 41 42 44 45 46 47 48 49 50 51 53 54 55 56;

%let stabs2=as gu mp pw pr vi;
%let stfps2=60 66 69 70 72 78;

%if &n=57 %then %do;  %let stfps=&stfps &stfps2;  %let stabs=&stabs &stabs2;  %end;

%if &n=52 %then %do;  %let stfps=&stfps 72;   %let stabs=&stabs pr;   %end;  

%if &listfps eq %str() %then %let listfps=&stfps;
  %else %let n=%eval( %eval(%length(&listfps)+1) /3);

%local i_;
%if &names %then  %do; %global statenm;  %end;
%*--Here is the macro invocation loop--------------------------------------*;
%let nlast=&n;  %if &nlast=50 %then %let nlast=51;
%do i_=1 %to &nlast;
   %let _state=%scan(&listfps,&i_);
   %if &listfps=&stfps %then %let _stab=%scan(&stabs,&i_);
     %else %do;
       %local _ix;
       %let _ix=%index(&stfps&stfps2,%trim(&_state));    
       %let _stab=%substr(&stabs&stabs2,&_ix,2);        %put ** dostates macro looping with: i_= &i_  _ix= &_ix _stab= &_stab;
       %end;
   %if &names %then %let statenm=%sysfunc( fipnamel(&_state));  %else %let statenm= ;


   %if &debug %then %do; 
      %put **temp debug msg: Value of var n is &n  %str(   ) value of var _stab is &_stab ****; 
      %end; 
     %if &n=50 and %superq(_stab)=dc %then ;
    %else %do;
      %if &msgs %then %put ****&mac being invoked for state &_state &_stab &statenm ****;
      %&mac(&_state,&_stab)
      %end;
   %end;
 %mend dostates;
