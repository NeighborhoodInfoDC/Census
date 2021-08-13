/* This SAS program will make a SAS DATASET from the GEO Header Segment */
/* User will have to modify the libname,data and infile statements to conform to his environment*/
/* */
libname xxx 'the location of the files on your computer';
data xxx.mheader;
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
