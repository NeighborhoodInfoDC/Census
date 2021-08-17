/**************************************************************************
 Program:  pl_all_4_2020_mac.sas
 Library:  Census
 Project:  Urban-Greater DC
 Author:   Rob Pitingolo
 Created:  08/13/21
 Version:  SAS 9.1
 Environment:  Windows
 
 Description:  Autocall macro to read Census 2020 Redistricting data
 files.

 Modifications:
**************************************************************************/

/** Macro pl_all_4_2020_mac - Start Definition **/

%macro pl_all_4_2020_mac( state );

  %local dec_yr in_path;
  
  %let dec_yr = 2020;
  %let in_path = &_dcdata_r_path\Census\Raw\2020\PL94171;

  /* This SAS program will make a SAS DATASET from the three Segment files *.pl */
  /* User will have to modify the libname,data and infile statements to conform to his environment*/
  /* This modification needs to be done in each of the three infile statements */
  /* Also change dataset name in the merge stage at the end of the program to conform the user's dataset name*/
  /* Checks are made on LOCRECNO as the three files are conbined */
  /* User should check SAS log*/
  /* */

	data work.header;
	infile "&in_path\&state.geo&dec_yr..pl" dlm="|" lrecl = 500 dsd missover pad;
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
	label
	FILEID="File Identification"
	STUSAB ="State/US-Abbreviation (USPS)"
	SUMLEV="Summary Level"
	GEOVAR="Geographic Variant"
	GEOCOMP="Geographic Component"
	CHARITER="Characteristic Iteration"
	CIFSN="Characteristic Iteration File Sequence Number"
	LOGRECNO="Logical Record Number"
	GEOID="Geographic Record Identifier"
	GEOCODE="Geographic Code Identifier"
	REGION="Region"
	DIVISION="Division"
	STATE="State (FIPS)"
	STATENS="State (NS)"
	COUNTY="County (FIPS)"
	COUNTYCC="FIPS County Class Code"
	COUNTYNS="County (NS)"
	COUSUB="County Subdivision (FIPS)"
	COUSUBCC="FIPS County Subdivision Class Code"
	COUSUBNS="County Subdivision (NS)"
	SUBMCD="Subminor Civil Division (FIPS)"
	SUBMCDCC="FIPS Subminor Civil Division Class Code"
	SUBMCDNS="Subminor Civil Division (NS)"
	ESTATE="Estate (FIPS)"
	ESTATECC="FIPS Estate Class Code"
	ESTATENS="Estate (NS)"
	CONCIT="Consolidated City (FIPS)"
	CONCITCC="FIPS Consolidated City Class Code"
	CONCITNS="Consolidated City (NS)"
	PLACE="Place (FIPS)"
	PLACECC="FIPS Place Class Code"
	PLACENS="Place (NS)"
	TRACT="Census Tract"
	BLKGRP="Block Group"
	BLOCK="Block"
	AIANHH="American Indian Area/Alaska Native Area/Hawaiian Home Land (Census)"
	AIHHTLI="American Indian Trust Land/Hawaiian Home Land Indicator"
	AIANHHFP="American Indian Area/Alaska Native Area/Hawaiian Home Land (FIPS)"
	AIANHHCC="FIPS American Indian Area/Alaska Native Area/Hawaiian Home Land Class Code"
	AIANHHNS="American Indian Area/Alaska Native Area/Hawaiian Home Land (NS)"
	AITS="American Indian Tribal Subdivision (Census)"
	AITSFP="American Indian Tribal Subdivision (FIPS)"
	AITSCC="FIPS American Indian Tribal Subdivision Class Code"
	AITSNS="American Indian Tribal Subdivision (NS)"
	TTRACT="Tribal Census Tract"
	TBLKGRP="Tribal Block Group"
	ANRC="Alaska Native Regional Corporation (FIPS)"
	ANRCCC="FIPS Alaska Native Regional Corporation Class Code"
	ANRCNS="Alaska Native Regional Corporation (NS)"
	CBSA="Metropolitan Statistical Area/Micropolitan Statistical Area"
	MEMI="Metropolitan/Micropolitan Indicator"
	CSA="Combined Statistical Area"
	METDIV="Metropolitan Division"
	NECTA="New England City and Town Area"
	NMEMI="NECTA Metropolitan/Micropolitan Indicator"
	CNECTA="Combined New England City and Town Area"
	NECTADIV="New England City and Town Area Division"
	CBSAPCI="Metropolitan Statistical Area/Micropolitan Statistical Area Principal City Indicator"
	NECTAPCI="New England City and Town Area Principal City Indicator"
	UA="Urban Area"
	UATYPE="Urban Area Type"
	UR="Urban/Rural"
	CD116="Congressional District (116th)"
	CD118="Congressional District (118th)"
	CD119="Congressional District (119th)"
	CD120="Congressional District (120th)"
	CD121="Congressional District (121st)"
	SLDU18="State Legislative District (Upper Chamber) (2018)"
	SLDU22="State Legislative District (Upper Chamber) (2022)"
	SLDU24="State Legislative District (Upper Chamber) (2024)"
	SLDU26="State Legislative District (Upper Chamber) (2026)"
	SLDU28="State Legislative District (Upper Chamber) (2028)"
	SLDL18="State Legislative District (Lower Chamber) (2018)"
	SLDL22="State Legislative District (Lower Chamber) (2022)"
	SLDL24="State Legislative District (Lower Chamber) (2024)"
	SLDL26="State Legislative District (Lower Chamber) (2026)"
	SLDL28="State Legislative District (Lower Chamber) (2028)"
	VTD="Voting District"
	VTDI="Voting District Indicator"
	ZCTA="ZIP Code Tabulation Area (5-Digit)"
	SDELM="School District (Elementary)"
	SDSEC="School District (Secondary)"
	SDUNI="School District (Unified)"
	PUMA="Public Use Microdata Area"
	AREALAND="Area (Land)"
	AREAWATR="Area (Water)"
	BASENAME="Area Base Name"
	NAME="Area Name-Legal/Statistical Area Description (LSAD) Term-Part Indicator"
	FUNCSTAT="Functional Status Code"
	GCUNI="Geographic Change User Note Indicator"
	POP100="Population Count (100%)"
	HU100="Housing Unit Count (100%)"
	INTPTLAT="Internal Point (Latitude)"
	INTPTLON="Internal Point (Longitude)"
	LSADC="Legal/Statistical Area Description Code"
	PARTFLAG="Part Flag"
	UGA="Urban Growth Area";

	run;

	data work.part1;
	infile "&in_path\&state.00001&dec_yr..pl" lrecl = 20000 dlm="|" dsd missover pad;
	LENGTH
	FILEID   $6 /*File Identification*/
	STUSAB   $2 /*State/US-Abbreviation (USPS)*/
	CHARITER $3 /*Characteristic Iteration*/
	CIFSN    $2 /*Characteristic Iteration File Sequence Number*/
	LOGRECNO $7 /*Logical Record Number*/
	P0010001 8. /*Total:*/
	P0010002 8. /*Population of one race:*/
	P0010003 8. /*White alone*/
	P0010004 8. /*Black or African American alone*/
	P0010005 8. /*American Indian and Alaska Native alone*/
	P0010006 8. /*Asian alone*/
	P0010007 8. /*Native Hawaiian and Other Pacific Islander alone*/
	P0010008 8. /*Some Other Race alone*/
	P0010009 8. /*Population of two or more races:*/
	P0010010 8. /*Population of two races:*/
	P0010011 8. /*White; Black or African American*/
	P0010012 8. /*White; American Indian and Alaska Native*/
	P0010013 8. /*White; Asian*/
	P0010014 8. /*White; Native Hawaiian and Other Pacific Islander*/
	P0010015 8. /*White; Some Other Race*/
	P0010016 8. /*Black or African American; American Indian and Alaska Native*/
	P0010017 8. /*Black or African American; Asian*/
	P0010018 8. /*Black or African American; Native Hawaiian and Other Pacific Islander*/
	P0010019 8. /*Black or African American; Some Other Race*/
	P0010020 8. /*American Indian and Alaska Native; Asian*/
	P0010021 8. /*American Indian and Alaska Native; Native Hawaiian and Other Pacific Islander*/
	P0010022 8. /*American Indian and Alaska Native; Some Other Race*/
	P0010023 8. /*Asian; Native Hawaiian and Other Pacific Islander*/
	P0010024 8. /*Asian; Some Other Race*/
	P0010025 8. /*Native Hawaiian and Other Pacific Islander; Some Other Race*/
	P0010026 8. /*Population of three races:*/
	P0010027 8. /*White; Black or African American; American Indian and Alaska Native*/
	P0010028 8. /*White; Black or African American; Asian*/
	P0010029 8. /*White; Black or African American; Native Hawaiian and Other Pacific Islander*/
	P0010030 8. /*White; Black or African American; Some Other Race*/
	P0010031 8. /*White; American Indian and Alaska Native; Asian*/
	P0010032 8. /*White; American Indian and Alaska Native; Native Hawaiian and Other Pacific Islander*/
	P0010033 8. /*White; American Indian and Alaska Native; Some Other Race*/
	P0010034 8. /*White; Asian; Native Hawaiian and Other Pacific Islander*/
	P0010035 8. /*White; Asian; Some Other Race*/
	P0010036 8. /*White; Native Hawaiian and Other Pacific Islander; Some Other Race*/
	P0010037 8. /*Black or African American; American Indian and Alaska Native; Asian*/
	P0010038 8. /*Black or African American; American Indian and Alaska Native; Native Hawaiian and Other Pacific Islander*/
	P0010039 8. /*Black or African American; American Indian and Alaska Native; Some Other Race*/
	P0010040 8. /*Black or African American; Asian; Native Hawaiian and Other Pacific Islander*/
	P0010041 8. /*Black or African American; Asian; Some Other Race*/
	P0010042 8. /*Black or African American; Native Hawaiian and Other Pacific Islander; Some Other Race*/
	P0010043 8. /*American Indian and Alaska Native; Asian; Native Hawaiian and Other Pacific Islander*/
	P0010044 8. /*American Indian and Alaska Native; Asian; Some Other Race*/
	P0010045 8. /*American Indian and Alaska Native; Native Hawaiian and Other Pacific Islander; Some Other Race*/
	P0010046 8. /*Asian; Native Hawaiian and Other Pacific Islander; Some Other Race*/
	P0010047 8. /*Population of four races:*/
	P0010048 8. /*White; Black or African American; American Indian and Alaska Native; Asian*/
	P0010049 8. /*White; Black or African American; American Indian and Alaska Native; Native Hawaiian and Other Pacific Islander*/
	P0010050 8. /*White; Black or African American; American Indian and Alaska Native; Some Other Race*/
	P0010051 8. /*White; Black or African American; Asian; Native Hawaiian and Other Pacific Islander*/
	P0010052 8. /*White; Black or African American; Asian; Some Other Race*/
	P0010053 8. /*White; Black or African American; Native Hawaiian and Other Pacific Islander; Some Other Race*/
	P0010054 8. /*White; American Indian and Alaska Native; Asian; Native Hawaiian and Other Pacific Islander*/
	P0010055 8. /*White; American Indian and Alaska Native; Asian; Some Other Race*/
	P0010056 8. /*White; American Indian and Alaska Native; Native Hawaiian and Other Pacific Islander; Some Other Race*/
	P0010057 8. /*White; Asian; Native Hawaiian and Other Pacific Islander; Some Other Race*/
	P0010058 8. /*Black or African American; American Indian and Alaska Native; Asian; Native Hawaiian and Other Pacific Islander*/
	P0010059 8. /*Black or African American; American Indian and Alaska Native; Asian; Some Other Race*/
	P0010060 8. /*Black or African American; American Indian and Alaska Native; Native Hawaiian and Other Pacific Islander; Some Other Race*/
	P0010061 8. /*Black or African American; Asian; Native Hawaiian and Other Pacific Islander; Some Other Race*/
	P0010062 8. /*American Indian and Alaska Native; Asian; Native Hawaiian and Other Pacific Islander; Some Other Race*/
	P0010063 8. /*Population of five races:*/
	P0010064 8. /*White; Black or African American; American Indian and Alaska Native; Asian; Native Hawaiian and Other Pacific Islander*/
	P0010065 8. /*White; Black or African American; American Indian and Alaska Native; Asian; Some Other Race*/
	P0010066 8. /*White; Black or African American; American Indian and Alaska Native; Native Hawaiian and Other Pacific Islander; Some Other Race*/
	P0010067 8. /*White; Black or African American; Asian; Native Hawaiian and Other Pacific Islander; Some Other Race*/
	P0010068 8. /*White; American Indian and Alaska Native; Asian; Native Hawaiian and Other Pacific Islander; Some Other Race*/
	P0010069 8. /*Black or African American; American Indian and Alaska Native; Asian; Native Hawaiian and Other Pacific Islander; Some Other Race*/
	P0010070 8. /*Population of six races:*/
	P0010071 8. /*White; Black or African American; American Indian and Alaska Native; Asian; Native Hawaiian and Other Pacific Islander; Some Other Race*/
	P0020001 8. /*Total:*/
	P0020002 8. /*Hispanic or Latino*/
	P0020003 8. /*Not Hispanic or Latino:*/
	P0020004 8. /*Population of one race:*/
	P0020005 8. /*White alone*/
	P0020006 8. /*Black or African American alone*/
	P0020007 8. /*American Indian and Alaska Native alone*/
	P0020008 8. /*Asian alone*/
	P0020009 8. /*Native Hawaiian and Other Pacific Islander alone*/
	P0020010 8. /*Some Other Race alone*/
	P0020011 8. /*Population of two or more races:*/
	P0020012 8. /*Population of two races:*/
	P0020013 8. /*White; Black or African American*/
	P0020014 8. /*White; American Indian and Alaska Native*/
	P0020015 8. /*White; Asian*/
	P0020016 8. /*White; Native Hawaiian and Other Pacific Islander*/
	P0020017 8. /*White; Some Other Race*/
	P0020018 8. /*Black or African American; American Indian and Alaska Native*/
	P0020019 8. /*Black or African American; Asian*/
	P0020020 8. /*Black or African American; Native Hawaiian and Other Pacific Islander*/
	P0020021 8. /*Black or African American; Some Other Race*/
	P0020022 8. /*American Indian and Alaska Native; Asian*/
	P0020023 8. /*American Indian and Alaska Native; Native Hawaiian and Other Pacific Islander*/
	P0020024 8. /*American Indian and Alaska Native; Some Other Race*/
	P0020025 8. /*Asian; Native Hawaiian and Other Pacific Islander*/
	P0020026 8. /*Asian; Some Other Race*/
	P0020027 8. /*Native Hawaiian and Other Pacific Islander; Some Other Race*/
	P0020028 8. /*Population of three races:*/
	P0020029 8. /*White; Black or African American; American Indian and Alaska Native*/
	P0020030 8. /*White; Black or African American; Asian*/
	P0020031 8. /*White; Black or African American; Native Hawaiian and Other Pacific Islander*/
	P0020032 8. /*White; Black or African American; Some Other Race*/
	P0020033 8. /*White; American Indian and Alaska Native; Asian*/
	P0020034 8. /*White; American Indian and Alaska Native; Native Hawaiian and Other Pacific Islander*/
	P0020035 8. /*White; American Indian and Alaska Native; Some Other Race*/
	P0020036 8. /*White; Asian; Native Hawaiian and Other Pacific Islander*/
	P0020037 8. /*White; Asian; Some Other Race*/
	P0020038 8. /*White; Native Hawaiian and Other Pacific Islander; Some Other Race*/
	P0020039 8. /*Black or African American; American Indian and Alaska Native; Asian*/
	P0020040 8. /*Black or African American; American Indian and Alaska Native; Native Hawaiian and Other Pacific Islander*/
	P0020041 8. /*Black or African American; American Indian and Alaska Native; Some Other Race*/
	P0020042 8. /*Black or African American; Asian; Native Hawaiian and Other Pacific Islander*/
	P0020043 8. /*Black or African American; Asian; Some Other Race*/
	P0020044 8. /*Black or African American; Native Hawaiian and Other Pacific Islander; Some Other Race*/
	P0020045 8. /*American Indian and Alaska Native; Asian; Native Hawaiian and Other Pacific Islander*/
	P0020046 8. /*American Indian and Alaska Native; Asian; Some Other Race*/
	P0020047 8. /*American Indian and Alaska Native; Native Hawaiian and Other Pacific Islander; Some Other Race*/
	P0020048 8. /*Asian; Native Hawaiian and Other Pacific Islander; Some Other Race*/
	P0020049 8. /*Population of four races:*/
	P0020050 8. /*White; Black or African American; American Indian and Alaska Native; Asian*/
	P0020051 8. /*White; Black or African American; American Indian and Alaska Native; Native Hawaiian and Other Pacific Islander*/
	P0020052 8. /*White; Black or African American; American Indian and Alaska Native; Some Other Race*/
	P0020053 8. /*White; Black or African American; Asian; Native Hawaiian and Other Pacific Islander*/
	P0020054 8. /*White; Black or African American; Asian; Some Other Race*/
	P0020055 8. /*White; Black or African American; Native Hawaiian and Other Pacific Islander; Some Other Race*/
	P0020056 8. /*White; American Indian and Alaska Native; Asian; Native Hawaiian and Other Pacific Islander*/
	P0020057 8. /*White; American Indian and Alaska Native; Asian; Some Other Race*/
	P0020058 8. /*White; American Indian and Alaska Native; Native Hawaiian and Other Pacific Islander; Some Other Race*/
	P0020059 8. /*White; Asian; Native Hawaiian and Other Pacific Islander; Some Other Race*/
	P0020060 8. /*Black or African American; American Indian and Alaska Native; Asian; Native Hawaiian and Other Pacific Islander*/
	P0020061 8. /*Black or African American; American Indian and Alaska Native; Asian; Some Other Race*/
	P0020062 8. /*Black or African American; American Indian and Alaska Native; Native Hawaiian and Other Pacific Islander; Some Other Race*/
	P0020063 8. /*Black or African American; Asian; Native Hawaiian and Other Pacific Islander; Some Other Race*/
	P0020064 8. /*American Indian and Alaska Native; Asian; Native Hawaiian and Other Pacific Islander; Some Other Race*/
	P0020065 8. /*Population of five races:*/
	P0020066 8. /*White; Black or African American; American Indian and Alaska Native; Asian; Native Hawaiian and Other Pacific Islander*/
	P0020067 8. /*White; Black or African American; American Indian and Alaska Native; Asian; Some Other Race*/
	P0020068 8. /*White; Black or African American; American Indian and Alaska Native; Native Hawaiian and Other Pacific Islander; Some Other Race*/
	P0020069 8. /*White; Black or African American; Asian; Native Hawaiian and Other Pacific Islander; Some Other Race*/
	P0020070 8. /*White; American Indian and Alaska Native; Asian; Native Hawaiian and Other Pacific Islander; Some Other Race*/
	P0020071 8. /*Black or African American; American Indian and Alaska Native; Asian; Native Hawaiian and Other Pacific Islander; Some Other Race*/
	P0020072 8. /*Population of six races:*/
	P0020073 8. /*White; Black or African American; American Indian and Alaska Native; Asian; Native Hawaiian and Other Pacific Islander; Some Other Race*/
	;
	INPUT
	FILEID   $
	STUSAB   $
	CHARITER $
	CIFSN    $
	LOGRECNO $
	P0010001 
	P0010002 
	P0010003 
	P0010004 
	P0010005 
	P0010006 
	P0010007 
	P0010008 
	P0010009 
	P0010010 
	P0010011 
	P0010012 
	P0010013 
	P0010014 
	P0010015 
	P0010016 
	P0010017 
	P0010018 
	P0010019 
	P0010020 
	P0010021 
	P0010022 
	P0010023 
	P0010024 
	P0010025 
	P0010026 
	P0010027 
	P0010028 
	P0010029 
	P0010030 
	P0010031 
	P0010032 
	P0010033 
	P0010034 
	P0010035 
	P0010036 
	P0010037 
	P0010038 
	P0010039 
	P0010040 
	P0010041 
	P0010042 
	P0010043 
	P0010044 
	P0010045 
	P0010046 
	P0010047 
	P0010048 
	P0010049 
	P0010050 
	P0010051 
	P0010052 
	P0010053 
	P0010054 
	P0010055 
	P0010056 
	P0010057 
	P0010058 
	P0010059 
	P0010060 
	P0010061 
	P0010062 
	P0010063 
	P0010064 
	P0010065 
	P0010066 
	P0010067 
	P0010068 
	P0010069 
	P0010070 
	P0010071 
	P0020001 
	P0020002 
	P0020003 
	P0020004 
	P0020005 
	P0020006 
	P0020007 
	P0020008 
	P0020009 
	P0020010 
	P0020011 
	P0020012 
	P0020013 
	P0020014 
	P0020015 
	P0020016 
	P0020017 
	P0020018 
	P0020019 
	P0020020 
	P0020021 
	P0020022 
	P0020023 
	P0020024 
	P0020025 
	P0020026 
	P0020027 
	P0020028 
	P0020029 
	P0020030 
	P0020031 
	P0020032 
	P0020033 
	P0020034 
	P0020035 
	P0020036 
	P0020037 
	P0020038 
	P0020039 
	P0020040 
	P0020041 
	P0020042 
	P0020043 
	P0020044 
	P0020045 
	P0020046 
	P0020047 
	P0020048 
	P0020049 
	P0020050 
	P0020051 
	P0020052 
	P0020053 
	P0020054 
	P0020055 
	P0020056 
	P0020057 
	P0020058 
	P0020059 
	P0020060 
	P0020061 
	P0020062 
	P0020063 
	P0020064 
	P0020065 
	P0020066 
	P0020067 
	P0020068 
	P0020069 
	P0020070 
	P0020071 
	P0020072 
	P0020073 ;
	label
	FILEID="File Identification"
	STUSAB="State/US-Abbreviation (USPS)"
	CHARITER="Characteristic Iteration"
	CIFSN="Characteristic Iteration File Sequence Number"
	LOGRECNO="Logical Record Number"
	P0010001="Total:"
	P0010002="Population of one race:"
	P0010003="White alone"
	P0010004="Black or African American alone"
	P0010005="American Indian and Alaska Native alone"
	P0010006="Asian alone"
	P0010007="Native Hawaiian and Other Pacific Islander alone"
	P0010008="Some Other Race alone"
	P0010009="Population of two or more races:"
	P0010010="Population of two races:"
	P0010011="White; Black or African American"
	P0010012="White; American Indian and Alaska Native"
	P0010013="White; Asian"
	P0010014="White; Native Hawaiian and Other Pacific Islander"
	P0010015="White; Some Other Race"
	P0010016="Black or African American; American Indian and Alaska Native"
	P0010017="Black or African American; Asian"
	P0010018="Black or African American; Native Hawaiian and Other Pacific Islander"
	P0010019="Black or African American; Some Other Race"
	P0010020="American Indian and Alaska Native; Asian"
	P0010021="American Indian and Alaska Native; Native Hawaiian and Other Pacific Islander"
	P0010022="American Indian and Alaska Native; Some Other Race"
	P0010023="Asian; Native Hawaiian and Other Pacific Islander"
	P0010024="Asian; Some Other Race"
	P0010025="Native Hawaiian and Other Pacific Islander; Some Other Race"
	P0010026="Population of three races:"
	P0010027="White; Black or African American; American Indian and Alaska Native"
	P0010028="White; Black or African American; Asian"
	P0010029="White; Black or African American; Native Hawaiian and Other Pacific Islander"
	P0010030="White; Black or African American; Some Other Race"
	P0010031="White; American Indian and Alaska Native; Asian"
	P0010032="White; American Indian and Alaska Native; Native Hawaiian and Other Pacific Islander"
	P0010033="White; American Indian and Alaska Native; Some Other Race"
	P0010034="White; Asian; Native Hawaiian and Other Pacific Islander"
	P0010035="White; Asian; Some Other Race"
	P0010036="White; Native Hawaiian and Other Pacific Islander; Some Other Race"
	P0010037="Black or African American; American Indian and Alaska Native; Asian"
	P0010038="Black or African American; American Indian and Alaska Native; Native Hawaiian and Other Pacific Islander"
	P0010039="Black or African American; American Indian and Alaska Native; Some Other Race"
	P0010040="Black or African American; Asian; Native Hawaiian and Other Pacific Islander"
	P0010041="Black or African American; Asian; Some Other Race"
	P0010042="Black or African American; Native Hawaiian and Other Pacific Islander; Some Other Race"
	P0010043="American Indian and Alaska Native; Asian; Native Hawaiian and Other Pacific Islander"
	P0010044="American Indian and Alaska Native; Asian; Some Other Race"
	P0010045="American Indian and Alaska Native; Native Hawaiian and Other Pacific Islander; Some Other Race"
	P0010046="Asian; Native Hawaiian and Other Pacific Islander; Some Other Race"
	P0010047="Population of four races:"
	P0010048="White; Black or African American; American Indian and Alaska Native; Asian"
	P0010049="White; Black or African American; American Indian and Alaska Native; Native Hawaiian and Other Pacific Islander"
	P0010050="White; Black or African American; American Indian and Alaska Native; Some Other Race"
	P0010051="White; Black or African American; Asian; Native Hawaiian and Other Pacific Islander"
	P0010052="White; Black or African American; Asian; Some Other Race"
	P0010053="White; Black or African American; Native Hawaiian and Other Pacific Islander; Some Other Race"
	P0010054="White; American Indian and Alaska Native; Asian; Native Hawaiian and Other Pacific Islander"
	P0010055="White; American Indian and Alaska Native; Asian; Some Other Race"
	P0010056="White; American Indian and Alaska Native; Native Hawaiian and Other Pacific Islander; Some Other Race"
	P0010057="White; Asian; Native Hawaiian and Other Pacific Islander; Some Other Race"
	P0010058="Black or African American; American Indian and Alaska Native; Asian; Native Hawaiian and Other Pacific Islander"
	P0010059="Black or African American; American Indian and Alaska Native; Asian; Some Other Race"
	P0010060="Black or African American; American Indian and Alaska Native; Native Hawaiian and Other Pacific Islander; Some Other Race"
	P0010061="Black or African American; Asian; Native Hawaiian and Other Pacific Islander; Some Other Race"
	P0010062="American Indian and Alaska Native; Asian; Native Hawaiian and Other Pacific Islander; Some Other Race"
	P0010063="Population of five races:"
	P0010064="White; Black or African American; American Indian and Alaska Native; Asian; Native Hawaiian and Other Pacific Islander"
	P0010065="White; Black or African American; American Indian and Alaska Native; Asian; Some Other Race"
	P0010066="White; Black or African American; American Indian and Alaska Native; Native Hawaiian and Other Pacific Islander; Some Other Race"
	P0010067="White; Black or African American; Asian; Native Hawaiian and Other Pacific Islander; Some Other Race"
	P0010068="White; American Indian and Alaska Native; Asian; Native Hawaiian and Other Pacific Islander; Some Other Race"
	P0010069="Black or African American; American Indian and Alaska Native; Asian; Native Hawaiian and Other Pacific Islander; Some Other Race"
	P0010070="Population of six races:"
	P0010071="White; Black or African American; American Indian and Alaska Native; Asian; Native Hawaiian and Other Pacific Islander; Some Other Race"
	P0020001="Total:"
	P0020002="Hispanic or Latino"
	P0020003="Not Hispanic or Latino:"
	P0020004="Population of one race:"
	P0020005="White alone"
	P0020006="Black or African American alone"
	P0020007="American Indian and Alaska Native alone"
	P0020008="Asian alone"
	P0020009="Native Hawaiian and Other Pacific Islander alone"
	P0020010="Some Other Race alone"
	P0020011="Population of two or more races:"
	P0020012="Population of two races:"
	P0020013="White; Black or African American"
	P0020014="White; American Indian and Alaska Native"
	P0020015="White; Asian"
	P0020016="White; Native Hawaiian and Other Pacific Islander"
	P0020017="White; Some Other Race"
	P0020018="Black or African American; American Indian and Alaska Native"
	P0020019="Black or African American; Asian"
	P0020020="Black or African American; Native Hawaiian and Other Pacific Islander"
	P0020021="Black or African American; Some Other Race"
	P0020022="American Indian and Alaska Native; Asian"
	P0020023="American Indian and Alaska Native; Native Hawaiian and Other Pacific Islander"
	P0020024="American Indian and Alaska Native; Some Other Race"
	P0020025="Asian; Native Hawaiian and Other Pacific Islander"
	P0020026="Asian; Some Other Race"
	P0020027="Native Hawaiian and Other Pacific Islander; Some Other Race"
	P0020028="Population of three races:"
	P0020029="White; Black or African American; American Indian and Alaska Native"
	P0020030="White; Black or African American; Asian"
	P0020031="White; Black or African American; Native Hawaiian and Other Pacific Islander"
	P0020032="White; Black or African American; Some Other Race"
	P0020033="White; American Indian and Alaska Native; Asian"
	P0020034="White; American Indian and Alaska Native; Native Hawaiian and Other Pacific Islander"
	P0020035="White; American Indian and Alaska Native; Some Other Race"
	P0020036="White; Asian; Native Hawaiian and Other Pacific Islander"
	P0020037="White; Asian; Some Other Race"
	P0020038="White; Native Hawaiian and Other Pacific Islander; Some Other Race"
	P0020039="Black or African American; American Indian and Alaska Native; Asian"
	P0020040="Black or African American; American Indian and Alaska Native; Native Hawaiian and Other Pacific Islander"
	P0020041="Black or African American; American Indian and Alaska Native; Some Other Race"
	P0020042="Black or African American; Asian; Native Hawaiian and Other Pacific Islander"
	P0020043="Black or African American; Asian; Some Other Race"
	P0020044="Black or African American; Native Hawaiian and Other Pacific Islander; Some Other Race"
	P0020045="American Indian and Alaska Native; Asian; Native Hawaiian and Other Pacific Islander"
	P0020046="American Indian and Alaska Native; Asian; Some Other Race"
	P0020047="American Indian and Alaska Native; Native Hawaiian and Other Pacific Islander; Some Other Race"
	P0020048="Asian; Native Hawaiian and Other Pacific Islander; Some Other Race"
	P0020049="Population of four races:"
	P0020050="White; Black or African American; American Indian and Alaska Native; Asian"
	P0020051="White; Black or African American; American Indian and Alaska Native; Native Hawaiian and Other Pacific Islander"
	P0020052="White; Black or African American; American Indian and Alaska Native; Some Other Race"
	P0020053="White; Black or African American; Asian; Native Hawaiian and Other Pacific Islander"
	P0020054="White; Black or African American; Asian; Some Other Race"
	P0020055="White; Black or African American; Native Hawaiian and Other Pacific Islander; Some Other Race"
	P0020056="White; American Indian and Alaska Native; Asian; Native Hawaiian and Other Pacific Islander"
	P0020057="White; American Indian and Alaska Native; Asian; Some Other Race"
	P0020058="White; American Indian and Alaska Native; Native Hawaiian and Other Pacific Islander; Some Other Race"
	P0020059="White; Asian; Native Hawaiian and Other Pacific Islander; Some Other Race"
	P0020060="Black or African American; American Indian and Alaska Native; Asian; Native Hawaiian and Other Pacific Islander"
	P0020061="Black or African American; American Indian and Alaska Native; Asian; Some Other Race"
	P0020062="Black or African American; American Indian and Alaska Native; Native Hawaiian and Other Pacific Islander; Some Other Race"
	P0020063="Black or African American; Asian; Native Hawaiian and Other Pacific Islander; Some Other Race"
	P0020064="American Indian and Alaska Native; Asian; Native Hawaiian and Other Pacific Islander; Some Other Race"
	P0020065="Population of five races:"
	P0020066="White; Black or African American; American Indian and Alaska Native; Asian; Native Hawaiian and Other Pacific Islander"
	P0020067="White; Black or African American; American Indian and Alaska Native; Asian; Some Other Race"
	P0020068="White; Black or African American; American Indian and Alaska Native; Native Hawaiian and Other Pacific Islander; Some Other Race"
	P0020069="White; Black or African American; Asian; Native Hawaiian and Other Pacific Islander; Some Other Race"
	P0020070="White; American Indian and Alaska Native; Asian; Native Hawaiian and Other Pacific Islander; Some Other Race"
	P0020071="Black or African American; American Indian and Alaska Native; Asian; Native Hawaiian and Other Pacific Islander; Some Other Race"
	P0020072="Population of six races:"
	P0020073="White; Black or African American; American Indian and Alaska Native; Asian; Native Hawaiian and Other Pacific Islander; Some Other Race";
	run;

	data work.part2;
	infile "&in_path\&state.00002&dec_yr..pl" lrecl = 20000 dlm="|" dsd missover pad;
	LENGTH
	FILEID   $6 /*File Identification*/
	STUSAB   $2 /*State/US-Abbreviation (USPS)*/
	CHARITER $3 /*Characteristic Iteration*/
	CIFSN    $2 /*Characteristic Iteration File Sequence Number*/
	LOGRECNO $7 /*Logical Record Number*/
	P0030001 8. /*P3-1: Total*/
	P0030002 8. /*P3-2: Population of one race*/
	P0030003 8. /*P3-3: White alone*/
	P0030004 8. /*P3-4: Black or African American alone*/
	P0030005 8. /*P3-5: American Indian and Alaska Native alone*/
	P0030006 8. /*P3-6: Asian alone*/
	P0030007 8. /*P3-7: Native Hawaiian and Other Pacific Islander alone*/
	P0030008 8. /*P3-8: Some other race alone*/
	P0030009 8. /*P3-9: Population of two or more races*/
	P0030010 8. /*P3-10: Population of two races*/
	P0030011 8. /*P3-11: White; Black or African American*/
	P0030012 8. /*P3-12: White; American Indian and Alaska Native*/
	P0030013 8. /*P3-13: White; Asian*/
	P0030014 8. /*P3-14: White; Native Hawaiian and Other Pacific Islander*/
	P0030015 8. /*P3-15: White; Some other race*/
	P0030016 8. /*P3-16: Black or African American; American Indian and Alaska Native*/
	P0030017 8. /*P3-17: Black or African American; Asian*/
	P0030018 8. /*P3-18: Black or African American; Native Hawaiian and Other Pacific Islander*/
	P0030019 8. /*P3-19: Black or African American; Some other race*/
	P0030020 8. /*P3-20: American Indian and Alaska Native; Asian*/
	P0030021 8. /*P3-21: American Indian and Alaska Native; Native Hawaiian and Other Pacific Islander*/
	P0030022 8. /*P3-22: American Indian and Alaska Native; Some other race*/
	P0030023 8. /*P3-23: Asian; Native Hawaiian and Other Pacific Islander*/
	P0030024 8. /*P3-24: Asian; Some other race*/
	P0030025 8. /*P3-25: Native Hawaiian and Other Pacific Islander; Some other race*/
	P0030026 8. /*P3-26: Population of three races*/
	P0030027 8. /*P3-27: White; Black or African American; American Indian and Alaska Native*/
	P0030028 8. /*P3-28: White; Black or African American; Asian*/
	P0030029 8. /*P3-29: White; Black or African American; Native Hawaiian and Other Pacific Islander*/
	P0030030 8. /*P3-30: White; Black or African American; Some other race*/
	P0030031 8. /*P3-31: White; American Indian and Alaska Native; Asian*/
	P0030032 8. /*P3-32: White; American Indian and Alaska Native; Native Hawaiian and Other Pacific Islander*/
	P0030033 8. /*P3-33: White; American Indian and Alaska Native; Some other race*/
	P0030034 8. /*P3-34: White; Asian; Native Hawaiian and Other Pacific Islander*/
	P0030035 8. /*P3-35: White; Asian; Some other race*/
	P0030036 8. /*P3-36: White; Native Hawaiian and Other Pacific Islander; Some other race*/
	P0030037 8. /*P3-37: Black or African American; American Indian and Alaska Native; Asian*/
	P0030038 8. /*P3-38: Black or African American; American Indian and Alaska Native; Native Hawaiian and Other Pacific Islander*/
	P0030039 8. /*P3-39: Black or African American; American Indian and Alaska Native; Some other race*/
	P0030040 8. /*P3-40: Black or African American; Asian; Native Hawaiian and Other Pacific Islander*/
	P0030041 8. /*P3-41: Black or African American; Asian; Some other race*/
	P0030042 8. /*P3-42: Black or African American; Native Hawaiian and Other Pacific Islander; Some other race*/
	P0030043 8. /*P3-43: American Indian and Alaska Native; Asian; Native Hawaiian and Other Pacific Islander*/
	P0030044 8. /*P3-44: American Indian and Alaska Native; Asian; Some other race*/
	P0030045 8. /*P3-45: American Indian and Alaska Native; Native Hawaiian and Other Pacific Islander; Some other race*/
	P0030046 8. /*P3-46: Asian; Native Hawaiian and Other Pacific Islander; Some other race*/
	P0030047 8. /*P3-47: Population of four races*/
	P0030048 8. /*P3-48: White; Black or African American; American Indian and Alaska Native; Asian*/
	P0030049 8. /*P3-49: White; Black or African American; American Indian and Alaska Native; Native Hawaiian and Other Pacific Islander*/
	P0030050 8. /*P3-50: White; Black or African American; American Indian and Alaska Native; Some other race*/
	P0030051 8. /*P3-51: White; Black or African American; Asian; Native Hawaiian and Other Pacific Islander*/
	P0030052 8. /*P3-52: White; Black or African American; Asian; Some other race*/
	P0030053 8. /*P3-53: White; Black or African American; Native Hawaiian and Other Pacific Islander; Some other race*/
	P0030054 8. /*P3-54: White; American Indian and Alaska Native; Asian; Native Hawaiian and Other Pacific Islander*/
	P0030055 8. /*P3-55: White; American Indian and Alaska Native; Asian; Some other race*/
	P0030056 8. /*P3-56: White; American Indian and Alaska Native; Native Hawaiian and Other Pacific Islander; Some other race*/
	P0030057 8. /*P3-57: White; Asian; Native Hawaiian and Other Pacific Islander; Some other race*/
	P0030058 8. /*P3-58: Black or African American; American Indian and Alaska Native; Asian; Native Hawaiian and Other Pacific Islander*/
	P0030059 8. /*P3-59: Black or African American; American Indian and Alaska Native; Asian; Some other race*/
	P0030060 8. /*P3-60: Black or African American; American Indian and Alaska Native; Native Hawaiian and Other Pacific Islander; Some other race*/
	P0030061 8. /*P3-61: Black or African American; Asian; Native Hawaiian and Other Pacific Islander; Some other race*/
	P0030062 8. /*P3-62: American Indian and Alaska Native; Asian; Native Hawaiian and Other Pacific Islander; Some other race*/
	P0030063 8. /*P3-63: Population of five races*/
	P0030064 8. /*P3-64: White; Black or African American; American Indian and Alaska Native; Asian; Native Hawaiian and Other Pacific Islander*/
	P0030065 8. /*P3-65: White; Black or African American; American Indian and Alaska Native; Asian; Some other race*/
	P0030066 8. /*P3-66: White; Black or African American; American Indian and Alaska Native; Native Hawaiian and Other Pacific Islander; Some other race*/
	P0030067 8. /*P3-67: White; Black or African American; Asian; Native Hawaiian and Other Pacific Islander; Some other race*/
	P0030068 8. /*P3-68: White; American Indian and Alaska Native; Asian; Native Hawaiian and Other Pacific Islander; Some other race*/
	P0030069 8. /*P3-69: Black or African American; American Indian and Alaska Native; Asian; Native Hawaiian and Other Pacific Islander; Some other race*/
	P0030070 8. /*P3-70: Population of six races*/
	P0030071 8. /*P3-71: White; Black or African American; American Indian and Alaska Native; Asian; Native Hawaiian and Other Pacific Islander; Some other race*/
	P0040001 8. /*P4-1: Total*/
	P0040002 8. /*P4-2: Hispanic or Latino*/
	P0040003 8. /*P4-3: Not Hispanic or Latino*/
	P0040004 8. /*P4-4: Population of one race*/
	P0040005 8. /*P4-5: White alone*/
	P0040006 8. /*P4-6: Black or African American alone*/
	P0040007 8. /*P4-7: American Indian and Alaska Native alone*/
	P0040008 8. /*P4-8: Asian alone*/
	P0040009 8. /*P4-9: Native Hawaiian and Other Pacific Islander alone*/
	P0040010 8. /*P4-10: Some other race alone*/
	P0040011 8. /*P4-11: Population of two or more races*/
	P0040012 8. /*P4-12: Population of two races*/
	P0040013 8. /*P4-13: White; Black or African American*/
	P0040014 8. /*P4-14: White; American Indian and Alaska Native*/
	P0040015 8. /*P4-15: White; Asian*/
	P0040016 8. /*P4-16: White; Native Hawaiian and Other Pacific Islander*/
	P0040017 8. /*P4-17: White; Some other race*/
	P0040018 8. /*P4-18: Black or African American; American Indian and Alaska Native*/
	P0040019 8. /*P4-19: Black or African American; Asian*/
	P0040020 8. /*P4-20: Black or African American; Native Hawaiian and Other Pacific Islander*/
	P0040021 8. /*P4-21: Black or African American; Some other race*/
	P0040022 8. /*P4-22: American Indian and Alaska Native; Asian*/
	P0040023 8. /*P4-23: American Indian and Alaska Native; Native Hawaiian and Other Pacific Islander*/
	P0040024 8. /*P4-24: American Indian and Alaska Native; Some other race*/
	P0040025 8. /*P4-25: Asian; Native Hawaiian and Other Pacific Islander*/
	P0040026 8. /*P4-26: Asian; Some other race*/
	P0040027 8. /*P4-27: Native Hawaiian and Other Pacific Islander; Some other race*/
	P0040028 8. /*P4-28: Population of three races*/
	P0040029 8. /*P4-29: White; Black or African American; American Indian and Alaska Native*/
	P0040030 8. /*P4-30: White; Black or African American; Asian*/
	P0040031 8. /*P4-31: White; Black or African American; Native Hawaiian and Other Pacific Islander*/
	P0040032 8. /*P4-32: White; Black or African American; Some other race*/
	P0040033 8. /*P4-33: White; American Indian and Alaska Native; Asian*/
	P0040034 8. /*P4-34: White; American Indian and Alaska Native; Native Hawaiian and Other Pacific Islander*/
	P0040035 8. /*P4-35: White; American Indian and Alaska Native; Some other race*/
	P0040036 8. /*P4-36: White; Asian; Native Hawaiian and Other Pacific Islander*/
	P0040037 8. /*P4-37: White; Asian; Some other race*/
	P0040038 8. /*P4-38: White; Native Hawaiian and Other Pacific Islander; Some other race*/
	P0040039 8. /*P4-39: Black or African American; American Indian and Alaska Native; Asian*/
	P0040040 8. /*P4-40: Black or African American; American Indian and Alaska Native; Native Hawaiian and Other Pacific Islander*/
	P0040041 8. /*P4-41: Black or African American; American Indian and Alaska Native; Some other race*/
	P0040042 8. /*P4-42: Black or African American; Asian; Native Hawaiian and Other Pacific Islander*/
	P0040043 8. /*P4-43: Black or African American; Asian; Some other race*/
	P0040044 8. /*P4-44: Black or African American; Native Hawaiian and Other Pacific Islander; Some other race*/
	P0040045 8. /*P4-45: American Indian and Alaska Native; Asian; Native Hawaiian and Other Pacific Islander*/
	P0040046 8. /*P4-46: American Indian and Alaska Native; Asian; Some other race*/
	P0040047 8. /*P4-47: American Indian and Alaska Native; Native Hawaiian and Other Pacific Islander; Some other race*/
	P0040048 8. /*P4-48: Asian; Native Hawaiian and Other Pacific Islander; Some other race*/
	P0040049 8. /*P4-49: Population of four races*/
	P0040050 8. /*P4-50: White; Black or African American; American Indian and Alaska Native; Asian*/
	P0040051 8. /*P4-51: White; Black or African American; American Indian and Alaska Native; Native Hawaiian and Other Pacific Islander*/
	P0040052 8. /*P4-52: White; Black or African American; American Indian and Alaska Native; Some other race*/
	P0040053 8. /*P4-53: White; Black or African American; Asian; Native Hawaiian and Other Pacific Islander*/
	P0040054 8. /*P4-54: White; Black or African American; Asian; Some other race*/
	P0040055 8. /*P4-55: White; Black or African American; Native Hawaiian and Other Pacific Islander; Some other race*/
	P0040056 8. /*P4-56: White; American Indian and Alaska Native; Asian; Native Hawaiian and Other Pacific Islander*/
	P0040057 8. /*P4-57: White; American Indian and Alaska Native; Asian; Some other race*/
	P0040058 8. /*P4-58: White; American Indian and Alaska Native; Native Hawaiian and Other Pacific Islander; Some other race*/
	P0040059 8. /*P4-59: White; Asian; Native Hawaiian and Other Pacific Islander; Some other race*/
	P0040060 8. /*P4-60: Black or African American; American Indian and Alaska Native; Asian; Native Hawaiian and Other Pacific Islander*/
	P0040061 8. /*P4-61: Black or African American; American Indian and Alaska Native; Asian; Some other race*/
	P0040062 8. /*P4-62: Black or African American; American Indian and Alaska Native; Native Hawaiian and Other Pacific Islander; Some other race*/
	P0040063 8. /*P4-63: Black or African American; Asian; Native Hawaiian and Other Pacific Islander; Some other race*/
	P0040064 8. /*P4-64: American Indian and Alaska Native; Asian; Native Hawaiian and Other Pacific Islander; Some other race*/
	P0040065 8. /*P4-65: Population of five races*/
	P0040066 8. /*P4-66: White; Black or African American; American Indian and Alaska Native; Asian; Native Hawaiian and Other Pacific Islander*/
	P0040067 8. /*P4-67: White; Black or African American; American Indian and Alaska Native; Asian; Some other race*/
	P0040068 8. /*P4-68: White; Black or African American; American Indian and Alaska Native; Native Hawaiian and Other Pacific Islander; Some other race*/
	P0040069 8. /*P4-69: White; Black or African American; Asian; Native Hawaiian and Other Pacific Islander; Some other race*/
	P0040070 8. /*P4-70: White; American Indian and Alaska Native; Asian; Native Hawaiian and Other Pacific Islander; Some other race*/
	P0040071 8. /*P4-71: Black or African American; American Indian and Alaska Native; Asian; Native Hawaiian and Other Pacific Islander; Some other race*/
	P0040072 8. /*P4-72: Population of six races*/
	P0040073 8. /*P4-73: White; Black or African American; American Indian and Alaska Native; Asian; Native Hawaiian and Other Pacific Islander; Some other race*/
	H0010001 8. /*H1-1: Total*/
	H0010002 8. /*H1-2: Occupied*/
	H0010003 8. /*H1-3: Vacant*/ ;
	INPUT
	FILEID   $
	STUSAB   $
	CHARITER $
	CIFSN    $
	LOGRECNO $
	P0030001 
	P0030002 
	P0030003 
	P0030004 
	P0030005 
	P0030006 
	P0030007 
	P0030008 
	P0030009 
	P0030010 
	P0030011 
	P0030012 
	P0030013 
	P0030014 
	P0030015 
	P0030016 
	P0030017 
	P0030018 
	P0030019 
	P0030020 
	P0030021 
	P0030022 
	P0030023 
	P0030024 
	P0030025 
	P0030026 
	P0030027 
	P0030028 
	P0030029 
	P0030030 
	P0030031 
	P0030032 
	P0030033 
	P0030034 
	P0030035 
	P0030036 
	P0030037 
	P0030038 
	P0030039 
	P0030040 
	P0030041 
	P0030042 
	P0030043 
	P0030044 
	P0030045 
	P0030046 
	P0030047 
	P0030048 
	P0030049 
	P0030050 
	P0030051 
	P0030052 
	P0030053 
	P0030054 
	P0030055 
	P0030056 
	P0030057 
	P0030058 
	P0030059 
	P0030060 
	P0030061 
	P0030062 
	P0030063 
	P0030064 
	P0030065 
	P0030066 
	P0030067 
	P0030068 
	P0030069 
	P0030070 
	P0030071 
	P0040001 
	P0040002 
	P0040003 
	P0040004 
	P0040005 
	P0040006 
	P0040007 
	P0040008 
	P0040009 
	P0040010 
	P0040011 
	P0040012 
	P0040013 
	P0040014 
	P0040015 
	P0040016 
	P0040017 
	P0040018 
	P0040019 
	P0040020 
	P0040021 
	P0040022 
	P0040023 
	P0040024 
	P0040025 
	P0040026 
	P0040027 
	P0040028 
	P0040029 
	P0040030 
	P0040031 
	P0040032 
	P0040033 
	P0040034 
	P0040035 
	P0040036 
	P0040037 
	P0040038 
	P0040039 
	P0040040 
	P0040041 
	P0040042 
	P0040043 
	P0040044 
	P0040045 
	P0040046 
	P0040047 
	P0040048 
	P0040049 
	P0040050 
	P0040051 
	P0040052 
	P0040053 
	P0040054 
	P0040055 
	P0040056 
	P0040057 
	P0040058 
	P0040059 
	P0040060 
	P0040061 
	P0040062 
	P0040063 
	P0040064 
	P0040065 
	P0040066 
	P0040067 
	P0040068 
	P0040069 
	P0040070 
	P0040071 
	P0040072 
	P0040073 
	H0010001 
	H0010002 
	H0010003 ;
	label
	FILEID="File Identification"
	STUSAB="State/US-Abbreviation (USPS)"
	CHARITER="Characteristic Iteration"
	CIFSN="Characteristic Iteration File Sequence Number"
	LOGRECNO="Logical Record Number"
	P0030001="P3-1: Total"
	P0030002="P3-2: Population of one race"
	P0030003="P3-3: White alone"
	P0030004="P3-4: Black or African American alone"
	P0030005="P3-5: American Indian and Alaska Native alone"
	P0030006="P3-6: Asian alone"
	P0030007="P3-7: Native Hawaiian and Other Pacific Islander alone"
	P0030008="P3-8: Some other race alone"
	P0030009="P3-9: Population of two or more races"
	P0030010="P3-10: Population of two races"
	P0030011="P3-11: White; Black or African American"
	P0030012="P3-12: White; American Indian and Alaska Native"
	P0030013="P3-13: White; Asian"
	P0030014="P3-14: White; Native Hawaiian and Other Pacific Islander"
	P0030015="P3-15: White; Some other race"
	P0030016="P3-16: Black or African American; American Indian and Alaska Native"
	P0030017="P3-17: Black or African American; Asian"
	P0030018="P3-18: Black or African American; Native Hawaiian and Other Pacific Islander"
	P0030019="P3-19: Black or African American; Some other race"
	P0030020="P3-20: American Indian and Alaska Native; Asian"
	P0030021="P3-21: American Indian and Alaska Native; Native Hawaiian and Other Pacific Islander"
	P0030022="P3-22: American Indian and Alaska Native; Some other race"
	P0030023="P3-23: Asian; Native Hawaiian and Other Pacific Islander"
	P0030024="P3-24: Asian; Some other race"
	P0030025="P3-25: Native Hawaiian and Other Pacific Islander; Some other race"
	P0030026="P3-26: Population of three races"
	P0030027="P3-27: White; Black or African American; American Indian and Alaska Native"
	P0030028="P3-28: White; Black or African American; Asian"
	P0030029="P3-29: White; Black or African American; Native Hawaiian and Other Pacific Islander"
	P0030030="P3-30: White; Black or African American; Some other race"
	P0030031="P3-31: White; American Indian and Alaska Native; Asian"
	P0030032="P3-32: White; American Indian and Alaska Native; Native Hawaiian and Other Pacific Islander"
	P0030033="P3-33: White; American Indian and Alaska Native; Some other race"
	P0030034="P3-34: White; Asian; Native Hawaiian and Other Pacific Islander"
	P0030035="P3-35: White; Asian; Some other race"
	P0030036="P3-36: White; Native Hawaiian and Other Pacific Islander; Some other race"
	P0030037="P3-37: Black or African American; American Indian and Alaska Native; Asian"
	P0030038="P3-38: Black or African American; American Indian and Alaska Native; Native Hawaiian and Other Pacific Islander"
	P0030039="P3-39: Black or African American; American Indian and Alaska Native; Some other race"
	P0030040="P3-40: Black or African American; Asian; Native Hawaiian and Other Pacific Islander"
	P0030041="P3-41: Black or African American; Asian; Some other race"
	P0030042="P3-42: Black or African American; Native Hawaiian and Other Pacific Islander; Some other race"
	P0030043="P3-43: American Indian and Alaska Native; Asian; Native Hawaiian and Other Pacific Islander"
	P0030044="P3-44: American Indian and Alaska Native; Asian; Some other race"
	P0030045="P3-45: American Indian and Alaska Native; Native Hawaiian and Other Pacific Islander; Some other race"
	P0030046="P3-46: Asian; Native Hawaiian and Other Pacific Islander; Some other race"
	P0030047="P3-47: Population of four races"
	P0030048="P3-48: White; Black or African American; American Indian and Alaska Native; Asian"
	P0030049="P3-49: White; Black or African American; American Indian and Alaska Native; Native Hawaiian and Other Pacific Islander"
	P0030050="P3-50: White; Black or African American; American Indian and Alaska Native; Some other race"
	P0030051="P3-51: White; Black or African American; Asian; Native Hawaiian and Other Pacific Islander"
	P0030052="P3-52: White; Black or African American; Asian; Some other race"
	P0030053="P3-53: White; Black or African American; Native Hawaiian and Other Pacific Islander; Some other race"
	P0030054="P3-54: White; American Indian and Alaska Native; Asian; Native Hawaiian and Other Pacific Islander"
	P0030055="P3-55: White; American Indian and Alaska Native; Asian; Some other race"
	P0030056="P3-56: White; American Indian and Alaska Native; Native Hawaiian and Other Pacific Islander; Some other race"
	P0030057="P3-57: White; Asian; Native Hawaiian and Other Pacific Islander; Some other race"
	P0030058="P3-58: Black or African American; American Indian and Alaska Native; Asian; Native Hawaiian and Other Pacific Islander"
	P0030059="P3-59: Black or African American; American Indian and Alaska Native; Asian; Some other race"
	P0030060="P3-60: Black or African American; American Indian and Alaska Native; Native Hawaiian and Other Pacific Islander; Some other race"
	P0030061="P3-61: Black or African American; Asian; Native Hawaiian and Other Pacific Islander; Some other race"
	P0030062="P3-62: American Indian and Alaska Native; Asian; Native Hawaiian and Other Pacific Islander; Some other race"
	P0030063="P3-63: Population of five races"
	P0030064="P3-64: White; Black or African American; American Indian and Alaska Native; Asian; Native Hawaiian and Other Pacific Islander"
	P0030065="P3-65: White; Black or African American; American Indian and Alaska Native; Asian; Some other race"
	P0030066="P3-66: White; Black or African American; American Indian and Alaska Native; Native Hawaiian and Other Pacific Islander; Some other race"
	P0030067="P3-67: White; Black or African American; Asian; Native Hawaiian and Other Pacific Islander; Some other race"
	P0030068="P3-68: White; American Indian and Alaska Native; Asian; Native Hawaiian and Other Pacific Islander; Some other race"
	P0030069="P3-69: Black or African American; American Indian and Alaska Native; Asian; Native Hawaiian and Other Pacific Islander; Some other race"
	P0030070="P3-70: Population of six races"
	P0030071="P3-71: White; Black or African American; American Indian and Alaska Native; Asian; Native Hawaiian and Other Pacific Islander; Some other race"
	P0040001="P4-1: Total"
	P0040002="P4-2: Hispanic or Latino"
	P0040003="P4-3: Not Hispanic or Latino"
	P0040004="P4-4: Population of one race"
	P0040005="P4-5: White alone"
	P0040006="P4-6: Black or African American alone"
	P0040007="P4-7: American Indian and Alaska Native alone"
	P0040008="P4-8: Asian alone"
	P0040009="P4-9: Native Hawaiian and Other Pacific Islander alone"
	P0040010="P4-10: Some other race alone"
	P0040011="P4-11: Population of two or more races"
	P0040012="P4-12: Population of two races"
	P0040013="P4-13: White; Black or African American"
	P0040014="P4-14: White; American Indian and Alaska Native"
	P0040015="P4-15: White; Asian"
	P0040016="P4-16: White; Native Hawaiian and Other Pacific Islander"
	P0040017="P4-17: White; Some other race"
	P0040018="P4-18: Black or African American; American Indian and Alaska Native"
	P0040019="P4-19: Black or African American; Asian"
	P0040020="P4-20: Black or African American; Native Hawaiian and Other Pacific Islander"
	P0040021="P4-21: Black or African American; Some other race"
	P0040022="P4-22: American Indian and Alaska Native; Asian"
	P0040023="P4-23: American Indian and Alaska Native; Native Hawaiian and Other Pacific Islander"
	P0040024="P4-24: American Indian and Alaska Native; Some other race"
	P0040025="P4-25: Asian; Native Hawaiian and Other Pacific Islander"
	P0040026="P4-26: Asian; Some other race"
	P0040027="P4-27: Native Hawaiian and Other Pacific Islander; Some other race"
	P0040028="P4-28: Population of three races"
	P0040029="P4-29: White; Black or African American; American Indian and Alaska Native"
	P0040030="P4-30: White; Black or African American; Asian"
	P0040031="P4-31: White; Black or African American; Native Hawaiian and Other Pacific Islander"
	P0040032="P4-32: White; Black or African American; Some other race"
	P0040033="P4-33: White; American Indian and Alaska Native; Asian"
	P0040034="P4-34: White; American Indian and Alaska Native; Native Hawaiian and Other Pacific Islander"
	P0040035="P4-35: White; American Indian and Alaska Native; Some other race"
	P0040036="P4-36: White; Asian; Native Hawaiian and Other Pacific Islander"
	P0040037="P4-37: White; Asian; Some other race"
	P0040038="P4-38: White; Native Hawaiian and Other Pacific Islander; Some other race"
	P0040039="P4-39: Black or African American; American Indian and Alaska Native; Asian"
	P0040040="P4-40: Black or African American; American Indian and Alaska Native; Native Hawaiian and Other Pacific Islander"
	P0040041="P4-41: Black or African American; American Indian and Alaska Native; Some other race"
	P0040042="P4-42: Black or African American; Asian; Native Hawaiian and Other Pacific Islander"
	P0040043="P4-43: Black or African American; Asian; Some other race"
	P0040044="P4-44: Black or African American; Native Hawaiian and Other Pacific Islander; Some other race"
	P0040045="P4-45: American Indian and Alaska Native; Asian; Native Hawaiian and Other Pacific Islander"
	P0040046="P4-46: American Indian and Alaska Native; Asian; Some other race"
	P0040047="P4-47: American Indian and Alaska Native; Native Hawaiian and Other Pacific Islander; Some other race"
	P0040048="P4-48: Asian; Native Hawaiian and Other Pacific Islander; Some other race"
	P0040049="P4-49: Population of four races"
	P0040050="P4-50: White; Black or African American; American Indian and Alaska Native; Asian"
	P0040051="P4-51: White; Black or African American; American Indian and Alaska Native; Native Hawaiian and Other Pacific Islander"
	P0040052="P4-52: White; Black or African American; American Indian and Alaska Native; Some other race"
	P0040053="P4-53: White; Black or African American; Asian; Native Hawaiian and Other Pacific Islander"
	P0040054="P4-54: White; Black or African American; Asian; Some other race"
	P0040055="P4-55: White; Black or African American; Native Hawaiian and Other Pacific Islander; Some other race"
	P0040056="P4-56: White; American Indian and Alaska Native; Asian; Native Hawaiian and Other Pacific Islander"
	P0040057="P4-57: White; American Indian and Alaska Native; Asian; Some other race"
	P0040058="P4-58: White; American Indian and Alaska Native; Native Hawaiian and Other Pacific Islander; Some other race"
	P0040059="P4-59: White; Asian; Native Hawaiian and Other Pacific Islander; Some other race"
	P0040060="P4-60: Black or African American; American Indian and Alaska Native; Asian; Native Hawaiian and Other Pacific Islander"
	P0040061="P4-61: Black or African American; American Indian and Alaska Native; Asian; Some other race"
	P0040062="P4-62: Black or African American; American Indian and Alaska Native; Native Hawaiian and Other Pacific Islander; Some other race"
	P0040063="P4-63: Black or African American; Asian; Native Hawaiian and Other Pacific Islander; Some other race"
	P0040064="P4-64: American Indian and Alaska Native; Asian; Native Hawaiian and Other Pacific Islander; Some other race"
	P0040065="P4-65: Population of five races"
	P0040066="P4-66: White; Black or African American; American Indian and Alaska Native; Asian; Native Hawaiian and Other Pacific Islander"
	P0040067="P4-67: White; Black or African American; American Indian and Alaska Native; Asian; Some other race"
	P0040068="P4-68: White; Black or African American; American Indian and Alaska Native; Native Hawaiian and Other Pacific Islander; Some other race"
	P0040069="P4-69: White; Black or African American; Asian; Native Hawaiian and Other Pacific Islander; Some other race"
	P0040070="P4-70: White; American Indian and Alaska Native; Asian; Native Hawaiian and Other Pacific Islander; Some other race"
	P0040071="P4-71: Black or African American; American Indian and Alaska Native; Asian; Native Hawaiian and Other Pacific Islander; Some other race"
	P0040072="P4-72: Population of six races"
	P0040073="P4-73: White; Black or African American; American Indian and Alaska Native; Asian; Native Hawaiian and Other Pacific Islander; Some other race"
	H0010001="H1-1: Total"
	H0010002="H1-2: Occupied"
	H0010003="H1-3: Vacant";
	run;

	data work.part3;
	infile "&in_path\&state.00003&dec_yr..pl" lrecl = 20000 dlm="|" dsd missover pad;
	LENGTH
	FILEID   $6 /*File Identification*/
	STUSAB   $2 /*State/US-Abbreviation (USPS)*/
	CHARITER $3 /*Characteristic Iteration*/
	CIFSN    $2 /*Characteristic Iteration File Sequence Number*/
	LOGRECNO $7 /*Logical Record Number*/
	P0050001 8. /*Total:*/
	P0050002 8. /*Institutionalized population:*/
	P0050003 8. /*Correctional facilities for adults*/
	P0050004 8. /*Juvenile facilities*/
	P0050005 8. /*Nursing facilities/Skilled-nursing facilities*/
	P0050006 8. /*Other institutional facilities*/
	P0050007 8. /*Noninstitutionalized population:*/
	P0050008 8. /*College/University student housing*/
	P0050009 8. /*Military quarters*/
	P0050010 8. /*Other noninstitutional facilities*/
	;
	INPUT
	FILEID   $
	STUSAB   $
	CHARITER $
	CIFSN    $
	LOGRECNO $
	P0050001 
	P0050002 
	P0050003 
	P0050004 
	P0050005 
	P0050006 
	P0050007 
	P0050008 
	P0050009 
	P0050010 
	;
	label
	FILEID="File Identification"
	STUSAB="State/US-Abbreviation (USPS)"
	CHARITER="Characteristic Iteration"
	CIFSN="Characteristic Iteration File Sequence Number"
	LOGRECNO="Logical Record Number"
	P0050001="Total:"
	P0050002="Institutionalized population:"
	P0050003="Correctional facilities for adults"
	P0050004="Juvenile facilities"
	P0050005="Nursing facilities/Skilled-nursing facilities"
	P0050006="Other institutional facilities"
	P0050007="Noninstitutionalized population:"
	P0050008="College/University student housing"
	P0050009="Military quarters"
	P0050010="Other noninstitutional facilities";
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


	data Census_pl_&dec_yr._&state ;
	  merge work.header (in=in1) work.part1 (in=in2) work.part2 (in=in3) work.part3 (in=in4);
	  by logrecno;
	  if not (in1 and in2 and in3 and in4) then
	  do;  
	    if not in1 then put 'Logrecno is not in header at line ' _n_;
	    if not in2 then put 'Logrecno is not in part1 at line ' _n_;
	    if not in3 then put 'Logrecno is not in part2 at line ' _n_;
		if not in4 then put 'Logrecno is not in part3 at line ' _n_;
	  end;
    
    format sumlev $sum20f.;
    
    ** Add standard block and tract variables **;
    
    length GeoBlk2020 $ 15 GeoBg2020 $ 12 Geo2020 $ 11;
    
    if block ~= '' then
      GeoBlk2020 = state || county || tract || block;
    
    if blkgrp ~= '' then
      GeoBg2020 = state || county || tract || blkgrp;
    
    if tract ~= '' then
      Geo2020 = state || county || tract;
    
    label
      GeoBlk2020 = 'Full census block ID (2020): sscccttttttbbbb'
      GeoBg2020 = 'Full census block group ID (2020): sscccttttttb'
      Geo2020 = 'Full census tract ID (2020): ssccctttttt';
    
  run;

  %Finalize_data_set( 
  data=Census_pl_&dec_yr._&state,
  out=Census_pl_&dec_yr._&state,
  outlib=Census,
  label="Census PL94-171 Redistricting File, &dec_yr., %upcase(&state)",
  sortby=GeoBlk2020,
  restrictions=None,
  printobs=0,
  revisions=New File
  )
  

%mend pl_all_4_2020_mac;

/** End Macro Definition **/



