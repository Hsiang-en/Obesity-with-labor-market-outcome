clear 

global do = "C:\Users\user\Desktop\學習\勞經\do"
global data = "C:\Users\user\Desktop\學習\勞經\data"
global image = "C:\Users\user\Desktop\學習\勞經\image"
global log = "C:\Users\user\Desktop\學習\勞經\log"

use $data\treatment.dta, replace

gen Northeast = 0
replace Northeast = 1 if region == 1
gen North_Central_or_Midwest = 0
replace North_Central_or_Midwest = 1 if region == 2
gen South = 0
replace South = 1 if region == 3
*tabstat Northeast North_Central_or_Midwest South West, stat(mean cv)

gen married = 0
replace married = 1 if marstat == 10
gen divorced = 0
replace divorced = 1 if marstat == 30
gen never_married = 0
replace never_married = 1 if marstat == 50
*tabstat married married_spouse_present married_spouse_not_in_household ///
*widowed divorced separated never_married, stat(mean cv) 

gen white = 0
replace white = 1 if racea == 100
gen Black = 0
replace Black = 1 if racea == 200
la var Black "Black/African-American"
**tabstat white Black Native_or_indian Chinese Filipino ///
Asian_Indian Other_Asian Other_race, stat(mean cv) 

gen high_school = 0
replace high_school = 1 if educ_2 > 300 & educ_2 < 400
gen college = 0
replace college = 1 if educ_2 > 400 & educ_2 < 500
la var college "no 4year degree for some college"
gen Banchelor = 0
replace Banchelor = 1 if educ_2 == 500
la var Banchelor "BA,AB,BS,BBA"
gen Master = 0
replace Master = 1 if educ_2 == 601
la var Master "MA,MS,Med,MBA"
gen Professional = 0
replace Professional = 1 if educ_2 == 602
la var Professional "MD,DDS,DVM,JD"
gen Doctoral = 0
replace Doctoral = 1 if educ_2 == 603
la var Doctoral "PhD, EdD"
tabstat high_school ///
college Banchelor Master Professional Doctoral, stat(mean) 

gen Managerial_Professional = 0
replace Managerial_Professional = 1 if occ1995 > 0 & occ1995 < 300
la var Managerial_Professional "Managerial and Professional Specialty Occupations"
gen Technical_Sales_Administrative = 0
replace Technical_Sales_Administrative = 1 if occ1995 > 300 & occ1995 < 600
la var Technical_Sales_Administrative ///
"Technical, Sales and Administrative support Occupations"
gen Service = 0
replace Service = 1 if occ1995 > 600 & occ1995 < 900
gen Operators_Fabricators_Laborers = 0
replace Operators_Fabricators_Laborers = 1 if occ1995 > 1400 & occ1995 < 1600
tabstat Managerial_Professional Technical_Sales_Administrative ///
Service Operators_Fabricators_Laborers, stat(mean)

/*
gen Agriculture_Forestry_Fishing = 0
replace Agriculture_Forestry_Fishing = 1 if ind1995 > 0 & ind1995 < 300
gen Mining = 0
replace Mining = 1 if ind1995 == 300
gen Construction = 0
replace Construction = 1 if ind1995 == 400
gen Manufacturing = 0
replace Manufacturing = 1 if ind1995 > 400 & ind1995 < 700
gen Public_Utilities = 0
replace Public_Utilitles = 1 if ind1995 > 700 & ind1995 < 1000
la var Public_Utilities "Transportation Communication and other Public Utilities"
gen Wholesale_Trade = 0
replace Wholesale_Trade = 1 if ind1995 == 1000 
la var Wholesale_Trade "Wholesale trade - durable and nondurable goods"
gen Retail = 0
replace Retail = 1 if ind1995 > 1000 & ind1995 < 1300
la var Retail "Retail sale"
*/

gen Private= 0
replace Private = 1 if classwk == 20 | classwk2 == 1
la var Private "Employee of private company for wages"
gen Public = 0
replace Public = 1 if classwk == 31 | classwk2 == 2 |classwk == 33 ///
| classwk2 == 3 | classwk == 34 | classwk2 == 4 |classwk == 40 | classwk2 == 5
gen Self_employed = 0
replace Self_employed = 1 if classwk == 40 | classwk2 == 5
tabstat Private Public Self_employed, stat(n mean cv min max)

save $data\Descriptive.dta, replace

tabstat Northeast North_Central_or_Midwest South ///
married divorced never_married ///
white Black high_school college Banchelor Master Professional Doctoral ///
Managerial_Professional Technical_Sales_Administrative ///
Service Operators_Fabricators_Laborers Private Public ///
Self_employed, by (sex) stat(mean sd min max) col(stat) long

save $data\Descriptive.dta, replace
