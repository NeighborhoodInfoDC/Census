/* This SAS program will make a SAS DATASET from the four Segment files *.pl */
/* User will have to modify the libname,data and infile statements to conform to his environment*/
/* This modification needs to be done in each of the four infile statements */
/* Also change dataset name in the merge stage at the end of the program to conform the user's dataset name*/
/* Checks are made on LOGRECNO as the three files are combined */
/* User should check SAS log*/
/* */
libname xxx 'the location of the files on your computer';
data work.header;
infile 'the location of the files on your computer\msgeo2020.pl' dlm='|' lrecl = 500 dsd missover pad;
LENGTH
FILEID     $6  /* File Identification */
STUSAB     $2  /* State/US-Abbreviation (USPS) */
SUMLEV     $3  /* Summary Level */
GEOVAR     $2  /* Geographic Variant */
GEOCOMP    $2  /* Geographic Component */
CHARITER   $3  /* Characteristic Iteration */
CIFSN      $2  /* Characteristic Iteration File Sequence Number */
LOGRECNO   $7  /* Logical Record Number */
GEOID     $60  /* Geographic Record Identifier */
GEOCODE   $51  /* Geographic Code Identifier */
REGION     $1  /* Region */
DIVISION   $1  /* Division */
STATE      $2  /* State (FIPS) */
STATENS    $8  /* State (NS) */
COUNTY     $3  /* County (FIPS) */
COUNTYCC   $2  /* FIPS County Class Code */
COUNTYNS   $8  /* County (NS) */
COUSUB     $5  /* County Subdivision (FIPS) */
COUSUBCC   $2  /* FIPS County Subdivision Class Code */
COUSUBNS   $8  /* County Subdivision (NS) */
SUBMCD     $5  /* Subminor Civil Division (FIPS) */
SUBMCDCC   $2  /* FIPS Subminor Civil Division Class Code */
SUBMCDNS   $8  /* Subminor Civil Division (NS) */
ESTATE     $5  /* Estate (FIPS) */
ESTATECC   $2  /* FIPS Estate Class Code */
ESTATENS   $8  /* Estate (NS) */
CONCIT     $5  /* Consolidated City (FIPS) */
CONCITCC   $2  /* FIPS Consolidated City Class Code */
CONCITNS   $8  /* Consolidated City (NS) */
PLACE      $5  /* Place (FIPS) */
PLACECC    $2  /* FIPS Place Class Code */
PLACENS    $8  /* Place (NS) */
TRACT      $6  /* Census Tract */
BLKGRP     $1  /* Block Group */
BLOCK      $4  /* Block */
AIANHH     $4  /* American Indian Area/Alaska Native Area/Hawaiian Home Land (Census) */
AIHHTLI    $1  /* American Indian Trust Land/Hawaiian Home Land Indicator */
AIANHHFP   $5  /* American Indian Area/Alaska Native Area/Hawaiian Home Land (FIPS) */
AIANHHCC   $2  /* FIPS American Indian Area/Alaska Native Area/Hawaiian Home Land Class Code */
AIANHHNS   $8  /* American Indian Area/Alaska Native Area/Hawaiian Home Land (NS) */
AITS       $3  /* American Indian Tribal Subdivision (Census) */
AITSFP     $5  /* American Indian Tribal Subdivision (FIPS) */
AITSCC     $2  /* FIPS American Indian Tribal Subdivision Class Code */
AITSNS     $8  /* American Indian Tribal Subdivision (NS) */
TTRACT     $6  /* Tribal Census Tract */
TBLKGRP    $1  /* Tribal Block Group */
ANRC       $5  /* Alaska Native Regional Corporation (FIPS) */
ANRCCC     $2  /* FIPS Alaska Native Regional Corporation Class Code */
ANRCNS     $8  /* Alaska Native Regional Corporation (NS) */
CBSA       $5  /* Metropolitan Statistical Area/Micropolitan Statistical Area */
MEMI       $1  /* Metropolitan/Micropolitan Indicator */
CSA        $3  /* Combined Statistical Area */
METDIV     $5  /* Metropolitan Division */
NECTA      $5  /* New England City and Town Area */
NMEMI      $1  /* NECTA Metropolitan/Micropolitan Indicator */
CNECTA     $3  /* Combined New England City and Town Area */
NECTADIV   $5  /* New England City and Town Area Division */
CBSAPCI    $1  /* Metropolitan Statistical Area/Micropolitan Statistical Area Principal City Indicator */
NECTAPCI   $1  /* New England City and Town Area Principal City Indicator */
UA         $5  /* Urban Area */
UATYPE     $1  /* Urban Area Type */
UR         $1  /* Urban/Rural */
CD116      $2  /* Congressional District (116th) */
CD118      $2  /* Congressional District (118th) */
CD119      $2  /* Congressional District (119th) */
CD120      $2  /* Congressional District (120th) */
CD121      $2  /* Congressional District (121st) */
SLDU18     $3  /* State Legislative District (Upper Chamber) (2018) */
SLDU22     $3  /* State Legislative District (Upper Chamber) (2022) */
SLDU24     $3  /* State Legislative District (Upper Chamber) (2024) */
SLDU26     $3  /* State Legislative District (Upper Chamber) (2026) */
SLDU28     $3  /* State Legislative District (Upper Chamber) (2028) */
SLDL18     $3  /* State Legislative District (Lower Chamber) (2018) */
SLDL22     $3  /* State Legislative District (Lower Chamber) (2022) */
SLDL24     $3  /* State Legislative District (Lower Chamber) (2024) */
SLDL26     $3  /* State Legislative District (Lower Chamber) (2026) */
SLDL28     $3  /* State Legislative District (Lower Chamber) (2028) */
VTD        $6  /* Voting District */
VTDI       $1  /* Voting District Indicator */
ZCTA       $5  /* ZIP Code Tabulation Area (5-Digit) */
SDELM      $5  /* School District (Elementary) */
SDSEC      $5  /* School District (Secondary) */
SDUNI      $5  /* School District (Unified) */
PUMA       $5  /* Public Use Microdata Area */
AREALAND  $14  /* Area (Land) */
AREAWATR  $14  /* Area (Water) */
BASENAME $100  /* Area Base Name */
NAME     $125  /* Area Name-Legal/Statistical Area Description (LSAD) Term-Part Indicator */
FUNCSTAT   $1  /* Functional Status Code */
GCUNI      $1  /* Geographic Change User Note Indicator */
POP100     $9  /* Population Count (100%) */
HU100      $9  /* Housing Unit Count (100%) */
INTPTLAT  $11  /* Internal Point (Latitude) */
INTPTLON  $12  /* Internal Point (Longitude) */
LSADC      $2  /* Legal/Statistical Area Description Code */
PARTFLAG   $1  /* Part Flag */
UGA        $5  /* Urban Growth Area */
;

input
FILEID     $
STUSAB     $
SUMLEV     $
GEOVAR     $
GEOCOMP    $
CHARITER   $
CIFSN      $
LOGRECNO   $
GEOID      $
GEOCODE    $
REGION     $
DIVISION   $
STATE      $
STATENS    $
COUNTY     $
COUNTYCC   $
COUNTYNS   $
COUSUB     $
COUSUBCC   $
COUSUBNS   $
SUBMCD     $
SUBMCDCC   $
SUBMCDNS   $
ESTATE     $
ESTATECC   $
ESTATENS   $
CONCIT     $
CONCITCC   $
CONCITNS   $
PLACE      $
PLACECC    $
PLACENS    $
TRACT      $
BLKGRP     $
BLOCK      $
AIANHH     $
AIHHTLI    $
AIANHHFP   $
AIANHHCC   $
AIANHHNS   $
AITS       $
AITSFP     $
AITSCC     $
AITSNS     $
TTRACT     $
TBLKGRP    $
ANRC       $
ANRCCC     $
ANRCNS     $
CBSA       $
MEMI       $
CSA        $
METDIV     $
NECTA      $
NMEMI      $
CNECTA     $
NECTADIV   $
CBSAPCI    $
NECTAPCI   $
UA         $
UATYPE     $
UR         $
CD116      $
CD118      $
CD119      $
CD120      $
CD121      $
SLDU18     $
SLDU22     $
SLDU24     $
SLDU26     $
SLDU28     $
SLDL18     $
SLDL22     $
SLDL24     $
SLDL26     $
SLDL28     $
VTD        $
VTDI       $
ZCTA       $
SDELM      $
SDSEC      $
SDUNI      $
PUMA       $
AREALAND   $
AREAWATR   $
BASENAME   $
NAME       $
FUNCSTAT   $
GCUNI      $
POP100     $
HU100      $
INTPTLAT   $
INTPTLON   $
LSADC      $
PARTFLAG   $
UGA        $;
run;

data work.part1;
infile 'the location of the files on your computer\ms000012020.pl' lrecl = 20000 dlm='|' dsd missover pad;
LENGTH
FILEID   $6 /*File Identification*/
STUSAB   $2 /*State/US-Abbreviation (USPS)*/
CHARITER $3 /*Characteristic Iteration*/
CIFSN    $2 /*Characteristic Iteration File Sequence Number*/
LOGRECNO $7 /*Logical Record Number*/
P0010001 $9 /*Total:*/
P0010002 $9 /*Population of one race:*/
P0010003 $9 /*White alone*/
P0010004 $9 /*Black or African American alone*/
P0010005 $9 /*American Indian and Alaska Native alone*/
P0010006 $9 /*Asian alone*/
P0010007 $9 /*Native Hawaiian and Other Pacific Islander alone*/
P0010008 $9 /*Some Other Race alone*/
P0010009 $9 /*Population of two or more races:*/
P0010010 $9 /*Population of two races:*/
P0010011 $9 /*White; Black or African American*/
P0010012 $9 /*White; American Indian and Alaska Native*/
P0010013 $9 /*White; Asian*/
P0010014 $9 /*White; Native Hawaiian and Other Pacific Islander*/
P0010015 $9 /*White; Some Other Race*/
P0010016 $9 /*Black or African American; American Indian and Alaska Native*/
P0010017 $9 /*Black or African American; Asian*/
P0010018 $9 /*Black or African American; Native Hawaiian and Other Pacific Islander*/
P0010019 $9 /*Black or African American; Some Other Race*/
P0010020 $9 /*American Indian and Alaska Native; Asian*/
P0010021 $9 /*American Indian and Alaska Native; Native Hawaiian and Other Pacific Islander*/
P0010022 $9 /*American Indian and Alaska Native; Some Other Race*/
P0010023 $9 /*Asian; Native Hawaiian and Other Pacific Islander*/
P0010024 $9 /*Asian; Some Other Race*/
P0010025 $9 /*Native Hawaiian and Other Pacific Islander; Some Other Race*/
P0010026 $9 /*Population of three races:*/
P0010027 $9 /*White; Black or African American; American Indian and Alaska Native*/
P0010028 $9 /*White; Black or African American; Asian*/
P0010029 $9 /*White; Black or African American; Native Hawaiian and Other Pacific Islander*/
P0010030 $9 /*White; Black or African American; Some Other Race*/
P0010031 $9 /*White; American Indian and Alaska Native; Asian*/
P0010032 $9 /*White; American Indian and Alaska Native; Native Hawaiian and Other Pacific Islander*/
P0010033 $9 /*White; American Indian and Alaska Native; Some Other Race*/
P0010034 $9 /*White; Asian; Native Hawaiian and Other Pacific Islander*/
P0010035 $9 /*White; Asian; Some Other Race*/
P0010036 $9 /*White; Native Hawaiian and Other Pacific Islander; Some Other Race*/
P0010037 $9 /*Black or African American; American Indian and Alaska Native; Asian*/
P0010038 $9 /*Black or African American; American Indian and Alaska Native; Native Hawaiian and Other Pacific Islander*/
P0010039 $9 /*Black or African American; American Indian and Alaska Native; Some Other Race*/
P0010040 $9 /*Black or African American; Asian; Native Hawaiian and Other Pacific Islander*/
P0010041 $9 /*Black or African American; Asian; Some Other Race*/
P0010042 $9 /*Black or African American; Native Hawaiian and Other Pacific Islander; Some Other Race*/
P0010043 $9 /*American Indian and Alaska Native; Asian; Native Hawaiian and Other Pacific Islander*/
P0010044 $9 /*American Indian and Alaska Native; Asian; Some Other Race*/
P0010045 $9 /*American Indian and Alaska Native; Native Hawaiian and Other Pacific Islander; Some Other Race*/
P0010046 $9 /*Asian; Native Hawaiian and Other Pacific Islander; Some Other Race*/
P0010047 $9 /*Population of four races:*/
P0010048 $9 /*White; Black or African American; American Indian and Alaska Native; Asian*/
P0010049 $9 /*White; Black or African American; American Indian and Alaska Native; Native Hawaiian and Other Pacific Islander*/
P0010050 $9 /*White; Black or African American; American Indian and Alaska Native; Some Other Race*/
P0010051 $9 /*White; Black or African American; Asian; Native Hawaiian and Other Pacific Islander*/
P0010052 $9 /*White; Black or African American; Asian; Some Other Race*/
P0010053 $9 /*White; Black or African American; Native Hawaiian and Other Pacific Islander; Some Other Race*/
P0010054 $9 /*White; American Indian and Alaska Native; Asian; Native Hawaiian and Other Pacific Islander*/
P0010055 $9 /*White; American Indian and Alaska Native; Asian; Some Other Race*/
P0010056 $9 /*White; American Indian and Alaska Native; Native Hawaiian and Other Pacific Islander; Some Other Race*/
P0010057 $9 /*White; Asian; Native Hawaiian and Other Pacific Islander; Some Other Race*/
P0010058 $9 /*Black or African American; American Indian and Alaska Native; Asian; Native Hawaiian and Other Pacific Islander*/
P0010059 $9 /*Black or African American; American Indian and Alaska Native; Asian; Some Other Race*/
P0010060 $9 /*Black or African American; American Indian and Alaska Native; Native Hawaiian and Other Pacific Islander; Some Other Race*/
P0010061 $9 /*Black or African American; Asian; Native Hawaiian and Other Pacific Islander; Some Other Race*/
P0010062 $9 /*American Indian and Alaska Native; Asian; Native Hawaiian and Other Pacific Islander; Some Other Race*/
P0010063 $9 /*Population of five races:*/
P0010064 $9 /*White; Black or African American; American Indian and Alaska Native; Asian; Native Hawaiian and Other Pacific Islander*/
P0010065 $9 /*White; Black or African American; American Indian and Alaska Native; Asian; Some Other Race*/
P0010066 $9 /*White; Black or African American; American Indian and Alaska Native; Native Hawaiian and Other Pacific Islander; Some Other Race*/
P0010067 $9 /*White; Black or African American; Asian; Native Hawaiian and Other Pacific Islander; Some Other Race*/
P0010068 $9 /*White; American Indian and Alaska Native; Asian; Native Hawaiian and Other Pacific Islander; Some Other Race*/
P0010069 $9 /*Black or African American; American Indian and Alaska Native; Asian; Native Hawaiian and Other Pacific Islander; Some Other Race*/
P0010070 $9 /*Population of six races:*/
P0010071 $9 /*White; Black or African American; American Indian and Alaska Native; Asian; Native Hawaiian and Other Pacific Islander; Some Other Race*/
P0020001 $9 /*Total:*/
P0020002 $9 /*Hispanic or Latino*/
P0020003 $9 /*Not Hispanic or Latino:*/
P0020004 $9 /*Population of one race:*/
P0020005 $9 /*White alone*/
P0020006 $9 /*Black or African American alone*/
P0020007 $9 /*American Indian and Alaska Native alone*/
P0020008 $9 /*Asian alone*/
P0020009 $9 /*Native Hawaiian and Other Pacific Islander alone*/
P0020010 $9 /*Some Other Race alone*/
P0020011 $9 /*Population of two or more races:*/
P0020012 $9 /*Population of two races:*/
P0020013 $9 /*White; Black or African American*/
P0020014 $9 /*White; American Indian and Alaska Native*/
P0020015 $9 /*White; Asian*/
P0020016 $9 /*White; Native Hawaiian and Other Pacific Islander*/
P0020017 $9 /*White; Some Other Race*/
P0020018 $9 /*Black or African American; American Indian and Alaska Native*/
P0020019 $9 /*Black or African American; Asian*/
P0020020 $9 /*Black or African American; Native Hawaiian and Other Pacific Islander*/
P0020021 $9 /*Black or African American; Some Other Race*/
P0020022 $9 /*American Indian and Alaska Native; Asian*/
P0020023 $9 /*American Indian and Alaska Native; Native Hawaiian and Other Pacific Islander*/
P0020024 $9 /*American Indian and Alaska Native; Some Other Race*/
P0020025 $9 /*Asian; Native Hawaiian and Other Pacific Islander*/
P0020026 $9 /*Asian; Some Other Race*/
P0020027 $9 /*Native Hawaiian and Other Pacific Islander; Some Other Race*/
P0020028 $9 /*Population of three races:*/
P0020029 $9 /*White; Black or African American; American Indian and Alaska Native*/
P0020030 $9 /*White; Black or African American; Asian*/
P0020031 $9 /*White; Black or African American; Native Hawaiian and Other Pacific Islander*/
P0020032 $9 /*White; Black or African American; Some Other Race*/
P0020033 $9 /*White; American Indian and Alaska Native; Asian*/
P0020034 $9 /*White; American Indian and Alaska Native; Native Hawaiian and Other Pacific Islander*/
P0020035 $9 /*White; American Indian and Alaska Native; Some Other Race*/
P0020036 $9 /*White; Asian; Native Hawaiian and Other Pacific Islander*/
P0020037 $9 /*White; Asian; Some Other Race*/
P0020038 $9 /*White; Native Hawaiian and Other Pacific Islander; Some Other Race*/
P0020039 $9 /*Black or African American; American Indian and Alaska Native; Asian*/
P0020040 $9 /*Black or African American; American Indian and Alaska Native; Native Hawaiian and Other Pacific Islander*/
P0020041 $9 /*Black or African American; American Indian and Alaska Native; Some Other Race*/
P0020042 $9 /*Black or African American; Asian; Native Hawaiian and Other Pacific Islander*/
P0020043 $9 /*Black or African American; Asian; Some Other Race*/
P0020044 $9 /*Black or African American; Native Hawaiian and Other Pacific Islander; Some Other Race*/
P0020045 $9 /*American Indian and Alaska Native; Asian; Native Hawaiian and Other Pacific Islander*/
P0020046 $9 /*American Indian and Alaska Native; Asian; Some Other Race*/
P0020047 $9 /*American Indian and Alaska Native; Native Hawaiian and Other Pacific Islander; Some Other Race*/
P0020048 $9 /*Asian; Native Hawaiian and Other Pacific Islander; Some Other Race*/
P0020049 $9 /*Population of four races:*/
P0020050 $9 /*White; Black or African American; American Indian and Alaska Native; Asian*/
P0020051 $9 /*White; Black or African American; American Indian and Alaska Native; Native Hawaiian and Other Pacific Islander*/
P0020052 $9 /*White; Black or African American; American Indian and Alaska Native; Some Other Race*/
P0020053 $9 /*White; Black or African American; Asian; Native Hawaiian and Other Pacific Islander*/
P0020054 $9 /*White; Black or African American; Asian; Some Other Race*/
P0020055 $9 /*White; Black or African American; Native Hawaiian and Other Pacific Islander; Some Other Race*/
P0020056 $9 /*White; American Indian and Alaska Native; Asian; Native Hawaiian and Other Pacific Islander*/
P0020057 $9 /*White; American Indian and Alaska Native; Asian; Some Other Race*/
P0020058 $9 /*White; American Indian and Alaska Native; Native Hawaiian and Other Pacific Islander; Some Other Race*/
P0020059 $9 /*White; Asian; Native Hawaiian and Other Pacific Islander; Some Other Race*/
P0020060 $9 /*Black or African American; American Indian and Alaska Native; Asian; Native Hawaiian and Other Pacific Islander*/
P0020061 $9 /*Black or African American; American Indian and Alaska Native; Asian; Some Other Race*/
P0020062 $9 /*Black or African American; American Indian and Alaska Native; Native Hawaiian and Other Pacific Islander; Some Other Race*/
P0020063 $9 /*Black or African American; Asian; Native Hawaiian and Other Pacific Islander; Some Other Race*/
P0020064 $9 /*American Indian and Alaska Native; Asian; Native Hawaiian and Other Pacific Islander; Some Other Race*/
P0020065 $9 /*Population of five races:*/
P0020066 $9 /*White; Black or African American; American Indian and Alaska Native; Asian; Native Hawaiian and Other Pacific Islander*/
P0020067 $9 /*White; Black or African American; American Indian and Alaska Native; Asian; Some Other Race*/
P0020068 $9 /*White; Black or African American; American Indian and Alaska Native; Native Hawaiian and Other Pacific Islander; Some Other Race*/
P0020069 $9 /*White; Black or African American; Asian; Native Hawaiian and Other Pacific Islander; Some Other Race*/
P0020070 $9 /*White; American Indian and Alaska Native; Asian; Native Hawaiian and Other Pacific Islander; Some Other Race*/
P0020071 $9 /*Black or African American; American Indian and Alaska Native; Asian; Native Hawaiian and Other Pacific Islander; Some Other Race*/
P0020072 $9 /*Population of six races:*/
P0020073 $9 /*White; Black or African American; American Indian and Alaska Native; Asian; Native Hawaiian and Other Pacific Islander; Some Other Race*/
;
INPUT
FILEID   $
STUSAB   $
CHARITER $
CIFSN    $
LOGRECNO $
P0010001 $
P0010002 $
P0010003 $
P0010004 $
P0010005 $
P0010006 $
P0010007 $
P0010008 $
P0010009 $
P0010010 $
P0010011 $
P0010012 $
P0010013 $
P0010014 $
P0010015 $
P0010016 $
P0010017 $
P0010018 $
P0010019 $
P0010020 $
P0010021 $
P0010022 $
P0010023 $
P0010024 $
P0010025 $
P0010026 $
P0010027 $
P0010028 $
P0010029 $
P0010030 $
P0010031 $
P0010032 $
P0010033 $
P0010034 $
P0010035 $
P0010036 $
P0010037 $
P0010038 $
P0010039 $
P0010040 $
P0010041 $
P0010042 $
P0010043 $
P0010044 $
P0010045 $
P0010046 $
P0010047 $
P0010048 $
P0010049 $
P0010050 $
P0010051 $
P0010052 $
P0010053 $
P0010054 $
P0010055 $
P0010056 $
P0010057 $
P0010058 $
P0010059 $
P0010060 $
P0010061 $
P0010062 $
P0010063 $
P0010064 $
P0010065 $
P0010066 $
P0010067 $
P0010068 $
P0010069 $
P0010070 $
P0010071 $
P0020001 $
P0020002 $
P0020003 $
P0020004 $
P0020005 $
P0020006 $
P0020007 $
P0020008 $
P0020009 $
P0020010 $
P0020011 $
P0020012 $
P0020013 $
P0020014 $
P0020015 $
P0020016 $
P0020017 $
P0020018 $
P0020019 $
P0020020 $
P0020021 $
P0020022 $
P0020023 $
P0020024 $
P0020025 $
P0020026 $
P0020027 $
P0020028 $
P0020029 $
P0020030 $
P0020031 $
P0020032 $
P0020033 $
P0020034 $
P0020035 $
P0020036 $
P0020037 $
P0020038 $
P0020039 $
P0020040 $
P0020041 $
P0020042 $
P0020043 $
P0020044 $
P0020045 $
P0020046 $
P0020047 $
P0020048 $
P0020049 $
P0020050 $
P0020051 $
P0020052 $
P0020053 $
P0020054 $
P0020055 $
P0020056 $
P0020057 $
P0020058 $
P0020059 $
P0020060 $
P0020061 $
P0020062 $
P0020063 $
P0020064 $
P0020065 $
P0020066 $
P0020067 $
P0020068 $
P0020069 $
P0020070 $
P0020071 $
P0020072 $
P0020073 $;
run;

data work.part2;
infile 'the location of the files on your computer\ms000022020.pl' lrecl = 20000 dlm='|' dsd missover pad;
LENGTH
FILEID   $6 /*File Identification*/
STUSAB   $2 /*State/US-Abbreviation (USPS)*/
CHARITER $3 /*Characteristic Iteration*/
CIFSN    $2 /*Characteristic Iteration File Sequence Number*/
LOGRECNO $7 /*Logical Record Number*/
P0030001 $9 /*P3-1: Total*/
P0030002 $9 /*P3-2: Population of one race*/
P0030003 $9 /*P3-3: White alone*/
P0030004 $9 /*P3-4: Black or African American alone*/
P0030005 $9 /*P3-5: American Indian and Alaska Native alone*/
P0030006 $9 /*P3-6: Asian alone*/
P0030007 $9 /*P3-7: Native Hawaiian and Other Pacific Islander alone*/
P0030008 $9 /*P3-8: Some other race alone*/
P0030009 $9 /*P3-9: Population of two or more races*/
P0030010 $9 /*P3-10: Population of two races*/
P0030011 $9 /*P3-11: White; Black or African American*/
P0030012 $9 /*P3-12: White; American Indian and Alaska Native*/
P0030013 $9 /*P3-13: White; Asian*/
P0030014 $9 /*P3-14: White; Native Hawaiian and Other Pacific Islander*/
P0030015 $9 /*P3-15: White; Some other race*/
P0030016 $9 /*P3-16: Black or African American; American Indian and Alaska Native*/
P0030017 $9 /*P3-17: Black or African American; Asian*/
P0030018 $9 /*P3-18: Black or African American; Native Hawaiian and Other Pacific Islander*/
P0030019 $9 /*P3-19: Black or African American; Some other race*/
P0030020 $9 /*P3-20: American Indian and Alaska Native; Asian*/
P0030021 $9 /*P3-21: American Indian and Alaska Native; Native Hawaiian and Other Pacific Islander*/
P0030022 $9 /*P3-22: American Indian and Alaska Native; Some other race*/
P0030023 $9 /*P3-23: Asian; Native Hawaiian and Other Pacific Islander*/
P0030024 $9 /*P3-24: Asian; Some other race*/
P0030025 $9 /*P3-25: Native Hawaiian and Other Pacific Islander; Some other race*/
P0030026 $9 /*P3-26: Population of three races*/
P0030027 $9 /*P3-27: White; Black or African American; American Indian and Alaska Native*/
P0030028 $9 /*P3-28: White; Black or African American; Asian*/
P0030029 $9 /*P3-29: White; Black or African American; Native Hawaiian and Other Pacific Islander*/
P0030030 $9 /*P3-30: White; Black or African American; Some other race*/
P0030031 $9 /*P3-31: White; American Indian and Alaska Native; Asian*/
P0030032 $9 /*P3-32: White; American Indian and Alaska Native; Native Hawaiian and Other Pacific Islander*/
P0030033 $9 /*P3-33: White; American Indian and Alaska Native; Some other race*/
P0030034 $9 /*P3-34: White; Asian; Native Hawaiian and Other Pacific Islander*/
P0030035 $9 /*P3-35: White; Asian; Some other race*/
P0030036 $9 /*P3-36: White; Native Hawaiian and Other Pacific Islander; Some other race*/
P0030037 $9 /*P3-37: Black or African American; American Indian and Alaska Native; Asian*/
P0030038 $9 /*P3-38: Black or African American; American Indian and Alaska Native; Native Hawaiian and Other Pacific Islander*/
P0030039 $9 /*P3-39: Black or African American; American Indian and Alaska Native; Some other race*/
P0030040 $9 /*P3-40: Black or African American; Asian; Native Hawaiian and Other Pacific Islander*/
P0030041 $9 /*P3-41: Black or African American; Asian; Some other race*/
P0030042 $9 /*P3-42: Black or African American; Native Hawaiian and Other Pacific Islander; Some other race*/
P0030043 $9 /*P3-43: American Indian and Alaska Native; Asian; Native Hawaiian and Other Pacific Islander*/
P0030044 $9 /*P3-44: American Indian and Alaska Native; Asian; Some other race*/
P0030045 $9 /*P3-45: American Indian and Alaska Native; Native Hawaiian and Other Pacific Islander; Some other race*/
P0030046 $9 /*P3-46: Asian; Native Hawaiian and Other Pacific Islander; Some other race*/
P0030047 $9 /*P3-47: Population of four races*/
P0030048 $9 /*P3-48: White; Black or African American; American Indian and Alaska Native; Asian*/
P0030049 $9 /*P3-49: White; Black or African American; American Indian and Alaska Native; Native Hawaiian and Other Pacific Islander*/
P0030050 $9 /*P3-50: White; Black or African American; American Indian and Alaska Native; Some other race*/
P0030051 $9 /*P3-51: White; Black or African American; Asian; Native Hawaiian and Other Pacific Islander*/
P0030052 $9 /*P3-52: White; Black or African American; Asian; Some other race*/
P0030053 $9 /*P3-53: White; Black or African American; Native Hawaiian and Other Pacific Islander; Some other race*/
P0030054 $9 /*P3-54: White; American Indian and Alaska Native; Asian; Native Hawaiian and Other Pacific Islander*/
P0030055 $9 /*P3-55: White; American Indian and Alaska Native; Asian; Some other race*/
P0030056 $9 /*P3-56: White; American Indian and Alaska Native; Native Hawaiian and Other Pacific Islander; Some other race*/
P0030057 $9 /*P3-57: White; Asian; Native Hawaiian and Other Pacific Islander; Some other race*/
P0030058 $9 /*P3-58: Black or African American; American Indian and Alaska Native; Asian; Native Hawaiian and Other Pacific Islander*/
P0030059 $9 /*P3-59: Black or African American; American Indian and Alaska Native; Asian; Some other race*/
P0030060 $9 /*P3-60: Black or African American; American Indian and Alaska Native; Native Hawaiian and Other Pacific Islander; Some other race*/
P0030061 $9 /*P3-61: Black or African American; Asian; Native Hawaiian and Other Pacific Islander; Some other race*/
P0030062 $9 /*P3-62: American Indian and Alaska Native; Asian; Native Hawaiian and Other Pacific Islander; Some other race*/
P0030063 $9 /*P3-63: Population of five races*/
P0030064 $9 /*P3-64: White; Black or African American; American Indian and Alaska Native; Asian; Native Hawaiian and Other Pacific Islander*/
P0030065 $9 /*P3-65: White; Black or African American; American Indian and Alaska Native; Asian; Some other race*/
P0030066 $9 /*P3-66: White; Black or African American; American Indian and Alaska Native; Native Hawaiian and Other Pacific Islander; Some other race*/
P0030067 $9 /*P3-67: White; Black or African American; Asian; Native Hawaiian and Other Pacific Islander; Some other race*/
P0030068 $9 /*P3-68: White; American Indian and Alaska Native; Asian; Native Hawaiian and Other Pacific Islander; Some other race*/
P0030069 $9 /*P3-69: Black or African American; American Indian and Alaska Native; Asian; Native Hawaiian and Other Pacific Islander; Some other race*/
P0030070 $9 /*P3-70: Population of six races*/
P0030071 $9 /*P3-71: White; Black or African American; American Indian and Alaska Native; Asian; Native Hawaiian and Other Pacific Islander; Some other race*/
P0040001 $9 /*P4-1: Total*/
P0040002 $9 /*P4-2: Hispanic or Latino*/
P0040003 $9 /*P4-3: Not Hispanic or Latino*/
P0040004 $9 /*P4-4: Population of one race*/
P0040005 $9 /*P4-5: White alone*/
P0040006 $9 /*P4-6: Black or African American alone*/
P0040007 $9 /*P4-7: American Indian and Alaska Native alone*/
P0040008 $9 /*P4-8: Asian alone*/
P0040009 $9 /*P4-9: Native Hawaiian and Other Pacific Islander alone*/
P0040010 $9 /*P4-10: Some other race alone*/
P0040011 $9 /*P4-11: Population of two or more races*/
P0040012 $9 /*P4-12: Population of two races*/
P0040013 $9 /*P4-13: White; Black or African American*/
P0040014 $9 /*P4-14: White; American Indian and Alaska Native*/
P0040015 $9 /*P4-15: White; Asian*/
P0040016 $9 /*P4-16: White; Native Hawaiian and Other Pacific Islander*/
P0040017 $9 /*P4-17: White; Some other race*/
P0040018 $9 /*P4-18: Black or African American; American Indian and Alaska Native*/
P0040019 $9 /*P4-19: Black or African American; Asian*/
P0040020 $9 /*P4-20: Black or African American; Native Hawaiian and Other Pacific Islander*/
P0040021 $9 /*P4-21: Black or African American; Some other race*/
P0040022 $9 /*P4-22: American Indian and Alaska Native; Asian*/
P0040023 $9 /*P4-23: American Indian and Alaska Native; Native Hawaiian and Other Pacific Islander*/
P0040024 $9 /*P4-24: American Indian and Alaska Native; Some other race*/
P0040025 $9 /*P4-25: Asian; Native Hawaiian and Other Pacific Islander*/
P0040026 $9 /*P4-26: Asian; Some other race*/
P0040027 $9 /*P4-27: Native Hawaiian and Other Pacific Islander; Some other race*/
P0040028 $9 /*P4-28: Population of three races*/
P0040029 $9 /*P4-29: White; Black or African American; American Indian and Alaska Native*/
P0040030 $9 /*P4-30: White; Black or African American; Asian*/
P0040031 $9 /*P4-31: White; Black or African American; Native Hawaiian and Other Pacific Islander*/
P0040032 $9 /*P4-32: White; Black or African American; Some other race*/
P0040033 $9 /*P4-33: White; American Indian and Alaska Native; Asian*/
P0040034 $9 /*P4-34: White; American Indian and Alaska Native; Native Hawaiian and Other Pacific Islander*/
P0040035 $9 /*P4-35: White; American Indian and Alaska Native; Some other race*/
P0040036 $9 /*P4-36: White; Asian; Native Hawaiian and Other Pacific Islander*/
P0040037 $9 /*P4-37: White; Asian; Some other race*/
P0040038 $9 /*P4-38: White; Native Hawaiian and Other Pacific Islander; Some other race*/
P0040039 $9 /*P4-39: Black or African American; American Indian and Alaska Native; Asian*/
P0040040 $9 /*P4-40: Black or African American; American Indian and Alaska Native; Native Hawaiian and Other Pacific Islander*/
P0040041 $9 /*P4-41: Black or African American; American Indian and Alaska Native; Some other race*/
P0040042 $9 /*P4-42: Black or African American; Asian; Native Hawaiian and Other Pacific Islander*/
P0040043 $9 /*P4-43: Black or African American; Asian; Some other race*/
P0040044 $9 /*P4-44: Black or African American; Native Hawaiian and Other Pacific Islander; Some other race*/
P0040045 $9 /*P4-45: American Indian and Alaska Native; Asian; Native Hawaiian and Other Pacific Islander*/
P0040046 $9 /*P4-46: American Indian and Alaska Native; Asian; Some other race*/
P0040047 $9 /*P4-47: American Indian and Alaska Native; Native Hawaiian and Other Pacific Islander; Some other race*/
P0040048 $9 /*P4-48: Asian; Native Hawaiian and Other Pacific Islander; Some other race*/
P0040049 $9 /*P4-49: Population of four races*/
P0040050 $9 /*P4-50: White; Black or African American; American Indian and Alaska Native; Asian*/
P0040051 $9 /*P4-51: White; Black or African American; American Indian and Alaska Native; Native Hawaiian and Other Pacific Islander*/
P0040052 $9 /*P4-52: White; Black or African American; American Indian and Alaska Native; Some other race*/
P0040053 $9 /*P4-53: White; Black or African American; Asian; Native Hawaiian and Other Pacific Islander*/
P0040054 $9 /*P4-54: White; Black or African American; Asian; Some other race*/
P0040055 $9 /*P4-55: White; Black or African American; Native Hawaiian and Other Pacific Islander; Some other race*/
P0040056 $9 /*P4-56: White; American Indian and Alaska Native; Asian; Native Hawaiian and Other Pacific Islander*/
P0040057 $9 /*P4-57: White; American Indian and Alaska Native; Asian; Some other race*/
P0040058 $9 /*P4-58: White; American Indian and Alaska Native; Native Hawaiian and Other Pacific Islander; Some other race*/
P0040059 $9 /*P4-59: White; Asian; Native Hawaiian and Other Pacific Islander; Some other race*/
P0040060 $9 /*P4-60: Black or African American; American Indian and Alaska Native; Asian; Native Hawaiian and Other Pacific Islander*/
P0040061 $9 /*P4-61: Black or African American; American Indian and Alaska Native; Asian; Some other race*/
P0040062 $9 /*P4-62: Black or African American; American Indian and Alaska Native; Native Hawaiian and Other Pacific Islander; Some other race*/
P0040063 $9 /*P4-63: Black or African American; Asian; Native Hawaiian and Other Pacific Islander; Some other race*/
P0040064 $9 /*P4-64: American Indian and Alaska Native; Asian; Native Hawaiian and Other Pacific Islander; Some other race*/
P0040065 $9 /*P4-65: Population of five races*/
P0040066 $9 /*P4-66: White; Black or African American; American Indian and Alaska Native; Asian; Native Hawaiian and Other Pacific Islander*/
P0040067 $9 /*P4-67: White; Black or African American; American Indian and Alaska Native; Asian; Some other race*/
P0040068 $9 /*P4-68: White; Black or African American; American Indian and Alaska Native; Native Hawaiian and Other Pacific Islander; Some other race*/
P0040069 $9 /*P4-69: White; Black or African American; Asian; Native Hawaiian and Other Pacific Islander; Some other race*/
P0040070 $9 /*P4-70: White; American Indian and Alaska Native; Asian; Native Hawaiian and Other Pacific Islander; Some other race*/
P0040071 $9 /*P4-71: Black or African American; American Indian and Alaska Native; Asian; Native Hawaiian and Other Pacific Islander; Some other race*/
P0040072 $9 /*P4-72: Population of six races*/
P0040073 $9 /*P4-73: White; Black or African American; American Indian and Alaska Native; Asian; Native Hawaiian and Other Pacific Islander; Some other race*/
H0010001 $9 /*H1-1: Total*/
H0010002 $9 /*H1-2: Occupied*/
H0010003 $9 /*H1-3: Vacant*/ ;
INPUT
FILEID   $
STUSAB   $
CHARITER $
CIFSN    $
LOGRECNO $
P0030001 $
P0030002 $
P0030003 $
P0030004 $
P0030005 $
P0030006 $
P0030007 $
P0030008 $
P0030009 $
P0030010 $
P0030011 $
P0030012 $
P0030013 $
P0030014 $
P0030015 $
P0030016 $
P0030017 $
P0030018 $
P0030019 $
P0030020 $
P0030021 $
P0030022 $
P0030023 $
P0030024 $
P0030025 $
P0030026 $
P0030027 $
P0030028 $
P0030029 $
P0030030 $
P0030031 $
P0030032 $
P0030033 $
P0030034 $
P0030035 $
P0030036 $
P0030037 $
P0030038 $
P0030039 $
P0030040 $
P0030041 $
P0030042 $
P0030043 $
P0030044 $
P0030045 $
P0030046 $
P0030047 $
P0030048 $
P0030049 $
P0030050 $
P0030051 $
P0030052 $
P0030053 $
P0030054 $
P0030055 $
P0030056 $
P0030057 $
P0030058 $
P0030059 $
P0030060 $
P0030061 $
P0030062 $
P0030063 $
P0030064 $
P0030065 $
P0030066 $
P0030067 $
P0030068 $
P0030069 $
P0030070 $
P0030071 $
P0040001 $
P0040002 $
P0040003 $
P0040004 $
P0040005 $
P0040006 $
P0040007 $
P0040008 $
P0040009 $
P0040010 $
P0040011 $
P0040012 $
P0040013 $
P0040014 $
P0040015 $
P0040016 $
P0040017 $
P0040018 $
P0040019 $
P0040020 $
P0040021 $
P0040022 $
P0040023 $
P0040024 $
P0040025 $
P0040026 $
P0040027 $
P0040028 $
P0040029 $
P0040030 $
P0040031 $
P0040032 $
P0040033 $
P0040034 $
P0040035 $
P0040036 $
P0040037 $
P0040038 $
P0040039 $
P0040040 $
P0040041 $
P0040042 $
P0040043 $
P0040044 $
P0040045 $
P0040046 $
P0040047 $
P0040048 $
P0040049 $
P0040050 $
P0040051 $
P0040052 $
P0040053 $
P0040054 $
P0040055 $
P0040056 $
P0040057 $
P0040058 $
P0040059 $
P0040060 $
P0040061 $
P0040062 $
P0040063 $
P0040064 $
P0040065 $
P0040066 $
P0040067 $
P0040068 $
P0040069 $
P0040070 $
P0040071 $
P0040072 $
P0040073 $
H0010001 $
H0010002 $
H0010003 $;
run;

data work.part3;
infile 'the location of the files on your computer\ms000032020.pl' lrecl = 20000 dlm='|' dsd missover pad;
LENGTH
FILEID   $6 /*File Identification*/
STUSAB   $2 /*State/US-Abbreviation (USPS)*/
CHARITER $3 /*Characteristic Iteration*/
CIFSN    $2 /*Characteristic Iteration File Sequence Number*/
LOGRECNO $7 /*Logical Record Number*/
P0050001 $9 /*Total:*/
P0050002 $9 /*Institutionalized population:*/
P0050003 $9 /*Correctional facilities for adults*/
P0050004 $9 /*Juvenile facilities*/
P0050005 $9 /*Nursing facilities/Skilled-nursing facilities*/
P0050006 $9 /*Other institutional facilities*/
P0050007 $9 /*Noninstitutionalized population:*/
P0050008 $9 /*College/University student housing*/
P0050009 $9 /*Military quarters*/
P0050010 $9 /*Other noninstitutional facilities*/
;
INPUT
FILEID   $
STUSAB   $
CHARITER $
CIFSN    $
LOGRECNO $
P0050001 $
P0050002 $
P0050003 $
P0050004 $
P0050005 $
P0050006 $
P0050007 $
P0050008 $
P0050009 $
P0050010 $
;
run;

proc sort data=work.header;
  by logrecno;
run;

proc sort data=work.part1;
  by logrecno;
run;

proc sort data=work.part2;
  by logrecno;
run;

proc sort data=work.part3;
  by logrecno;
run;

data xxx.combine;
  merge work.header (in=in1) work.part1 (in=in2) work.part2 (in=in3) work.part3 (in=in4);
  by logrecno;
  if not (in1 and in2 and in3 and in4) then
  do;  
    if not in1 then put 'Logrecno is not in header at line ' _n_;
    if not in2 then put 'Logrecno is not in part1 at line ' _n_;
    if not in3 then put 'Logrecno is not in part2 at line ' _n_;
	if not in4 then put 'Logrecno is not in part2 at line ' _n_;
  end;
run;

