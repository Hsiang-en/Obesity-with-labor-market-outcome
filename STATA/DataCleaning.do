clear 

global do = "C:\Users\user\Desktop\學習\勞經\do"
global data = "C:\Users\user\Desktop\學習\勞經\data"
global image = "C:\Users\user\Desktop\學習\勞經\image"
global log = "C:\Users\user\Desktop\學習\勞經\log"

capture log close

log using $log\homework1.txt, replace

set more off

//Import data
/*
use $data\nhis_BMIyear.dta

merge 1:1 nhispid year using $data\nhis_00003.dta
drop _merge
merge 1:1 nhispid year using $data\nhis_00004.dta
drop _merge

save $data\merge.dta, replace
*/

use $data\merge.dta, replace

//Examine data
bysort nhishid: egen double bmi_f = max(bmicalc_pop)
bysort nhishid: egen double bmi_m = max(bmicalc_mom)
bysort nhishid: egen double bmi_s = max(bmicalc_sp)

foreach x in hnispid{
	replace bmi_f = 0 if bmi_f == bmicalc
	replace bmi_m = 0 if bmi_m == bmicalc
	replace bmi_s = 0 if bmi_s == bmicalc
}

gen bmi_family = bmi_f
replace bmi_family = bmi_m if bmi_m > 0 & bmi_m < 60 
replace bmi_family = bmi_s if bmi_s > 0 & bmi_s < 60 
//

/*To observe the age and family composition*/
*summarize age
*summarize famsize

//

/*To check the lower and higher bound of the observation*/
*inspect age
*inspect famsize
*inspect earnings
*inspect bmicalc
/*Age can't be zero*/
drop if age == 0
/*Earnings will be addressed in the later section*/
/*Investigate the case that bmi over 50*/
*browse height weight bmicalc if bmicalc > 50
/*drop the bmi-too-high case since the subject refuse to answer
about the height or weight */
drop if height > 94
drop if weight > 994
//
/*To check the missing value*/
*codebook age
*codebook bmicalc 
/*bmicalc has the missing value*/ 
drop if bmicalc == 0
drop if bmicalc == .
//

drop serial strata hhweight metro perweight sampweight /// 
fweight supp1wt supp2wt sub77wt astatflg cstatflg marryno /// 
marrytimyr wsdtimyr livbrono livsisno livkidno occ ind ftotval /// 
inclm headinc dietchang wtprognow wtlos wtchange bmi /// 
wtpercept wtdieting wthowover wtovercare wtundercare wtmethodnow 

drop higrade1 higrade2 fmx px marst marstcohab ///
momed daded relsib hispeth racesr jobsecincorp workev ///
mainlong incfam97on2 incfam07on cpi2009 incindiv

drop if earnings ==.
drop if earnings ==0
drop if earnings > 11

//
save $data\drop_var.dta, replace

//Create sample

gen incfam = incfam6881 if year < 1982
replace incfam = incfam8296 if (year < 1997 & year>1981) 
replace incfam = incfam9706 if year >1996  
drop incfam6881 incfam8296 incfam9706

//

//
/*generate the interval for different bmi state*/
gen BMI_standard = 0 if bmicalc < 15
replace BMI_standard = 1 if bmicalc < 16 & (bmicalc > 15 | bmicalc == 15)
replace BMI_standard = 2 if bmicalc < 18.5 & (bmicalc > 16 | bmicalc == 16)
replace BMI_standard = 3 if bmicalc < 25 & (bmicalc > 18.5 | bmicalc == 18.5)
replace BMI_standard = 4 if bmicalc < 30 & (bmicalc > 25 | bmicalc == 25)
replace BMI_standard = 5 if bmicalc < 35 & (bmicalc > 30 | bmicalc == 30)
replace BMI_standard = 6 if bmicalc < 40 & (bmicalc > 35 | bmicalc == 35)
replace BMI_standard = 7 if bmicalc > 40

gen BMI_interval = BMI_standard

/*generate the lower bound for the different groups of earnings*/
replace earnings = 1 if earnings == 1
replace earnings = 5000 if earnings == 2
replace earnings = 10000 if earnings == 3
replace earnings = 15000 if earnings == 4
replace earnings = 20000 if earnings == 5
replace earnings = 25000 if earnings == 6
replace earnings = 35000 if earnings == 7
replace earnings = 45000 if earnings == 8
replace earnings = 55000 if earnings == 9
replace earnings = 65000 if earnings == 10
replace earnings = 75000 if earnings == 11


gen bmi2 = bmicalc * bmicalc
gen bmi3= bmi2 * bmicalc
//

//*http://usacademic.hk/zh/resources/useducation*//

//

//
/*Define the value label for the bmi, and it will be
used in the histogram*/
/*
label define BMI_rule 0 "Very severely underweight" 
label define BMI_rule 1 "Severely underweight" ,add
label define BMI_rule 2 "Underweight" ,add
label define BMI_rule 3 "Normal" ,add
label define BMI_rule 4 "Overweight" ,add
label define BMI_rule 5 "Moderately obese" ,add
label define BMI_rule 6 "Severely obese" ,add
label define BMI_rule 7 "Very severely obese",add
la val BMI_interval BMI_rule
*/
label define BMI_rule 0 "-15"
label define BMI_rule 1 "15-16" ,add
label define BMI_rule 2 "16-18.5" ,add
label define BMI_rule 3 "18.5-25" ,add
label define BMI_rule 4 "25-30" ,add
label define BMI_rule 5 "30-35" ,add
label define BMI_rule 6 "35-40" ,add
label define BMI_rule 7 "40-",add
la val BMI_interval BMI_rule
/*give the discription to the new variable*/
la var incfam "total combined family income"
la var BMI_interval "Bmi state"
la var earnings "Lower bound for different earnings' group"

//
/*Use the recode to generate educational degree,
which will better interpret how many years the 
observation spent on the education*/
gen educ_2 = educ
recode educ (101=0)(102=1)(103=2)(104=3)(105=4) ///
(106=5)(107=6)(108=7)(109=8)(201=9)(202=10)(203=10) ///
(204=12)(300=12)(301=12)(302=12)(401=12)(402=14) ///
(403=14)(500=16)(601=18)(602=20)(603=22),gen (edu_degree)

//
/*Generate dummy for bmi in normal range or not*/
gen normalweight = 0 
replace normalweight = 1 if bmicalc < 25 & (bmicalc > 18.5 | bmicalc == 18.5)

gen Obesity = 0
replace Obesity = 1 if bmicalc > 30
//

bysort year: egen total_earnings = mean(earnings)
bysort year: egen normalweight_earnings = mean(earnings) ///
if normalweight == 1 
bysort year: egen underweight_earnings = mean(earnings) ///
if bmicalc < 18.5 
bysort year: egen overweight_earnings = mean(earnings) ///
if bmicalc > 25 
bysort year: egen obesity_earnings = mean(earnings) ///
if bmicalc > 30
bysort year: egen unnormalweight_earnings = mean(earnings) ///
if normalweight == 0 
bysort year: egen male_earnings = mean(earnings) ///
if sex == 1 
bysort year: egen female_earnings = mean(earnings) ///
if sex == 2 
bysort year: egen male_normalweight_earnings = mean(earnings) ///
if sex == 1 & normalweight == 1 
bysort year: egen female_normalweight_earnings = mean(earnings) ///
if sex == 2 & normalweight == 1 
bysort year: egen male_unnormalweight_earnings = mean(earnings) ///
if sex == 1 & normalweight == 0 
bysort year: egen female_unnormalweight_earnings = mean(earnings) ///
if sex == 2 & normalweight == 0 
bysort year: egen male_underweight_earnings = mean(earnings) ///
if sex == 1 & bmicalc < 18.5 
bysort year: egen female_underweight_earnings = mean(earnings) ///
if sex == 2 & bmicalc < 18.5 
bysort year: egen male_overweight_earnings = mean(earnings) ///
if sex == 1 & bmicalc > 25 
bysort year: egen female_overweight_earnings = mean(earnings) ///
if sex == 2 & bmicalc > 25 
bysort year: egen male_obesity_earnings = mean(earnings) ///
if sex == 1 & bmicalc > 30 
bysort year: egen female_obesity_earnings = mean(earnings) ///
if sex == 2 & bmicalc > 30 
*gen male_penalty = male_normalweight_earnings - male_obesity_earnings
*gen female_penalty = female_normalweight_earnings - female_obesity_earnings
//

/*earnings取log*/
gen earnings_log = log(earnings)

gen underweight = 0
replace underweight = 1
gen overweight = 0
replace overweight = 1 

drop height_mom height_mom2 height_pop height_pop2 height_sp ///
weight_mom weight_mom2 weight_pop weight_pop2 weight_sp ///
bmicalc_mom bmicalc_mom2 bmicalc_pop bmicalc_pop2 bmicalc_sp 
//

save $data\treatment.dta, replace

//

//
/*
/*An overviw to observe the distribution of BMI*/
histogram bmicalc, discrete percent ytitle(percent) /// 
xtitle(Bmi) title("Bmi distribution")
graph export $image\Bmi_distribution.png, as(png) replace
/*Observe the distribution of BMI by interval*/
histogram BMI_interval, discrete percent ytitle(percent) ///
xtitle(Bmi) xlabel(0(1)7, angle(vertical) valuelabel) ///
title("Bmi distribution on interval")
graph export $image\Bmi_distribution_on_interval.png, as(png) replace

//
/*use the fit plot to find the best interpretation of the distribution.
Since the curve might be U-shape, adopting the quadratic regression*/
twoway (qfitci earnings bmicalc), ytitle(earnings) ///
xtitle(Bmi) title("predicion for earnings and Bmi") ///
subtitle("Quadratic regression") 
graph export $image\predicion_for_earnings_and_Bmi.png, as(png) replace

/*Take a look on the trend of the total earnings on BMI*/
twoway (line total_earnings year) ///
(line normalweight_earnings year) (line underweight_earnings year) ///
(line overweight_earnings year), ytitle(earnings) ///
xtitle(survey year) title("Earnings on BMI")
graph export $image\earnings_on_Bmi.png, as(png) replace

/*Total earnings on BMI and gender*/
twoway (line male_normalweight_earnings year) ///
(line male_underweight_earnings year) (line male_overweight_earnings year) ///
, ytitle(earnings) xtitle(survey year) title("Male's earnings on BMI")
graph export $image\male_earnings_on_Bmi.png, as(png) replace

twoway (line female_normalweight_earnings year) ///
(line female_underweight_earnings year) (line female_overweight_earnings year) ///
, ytitle(earnings) xtitle(survey year) title("Female's earnings on BMI")
graph export $image\female_earnings_on_Bmi.png, as(png) replace

*twoway (line male_penalty year) (line female_penalty year)
*graph export $image\penalty_on_gender.png, as(png) replace
//

/**/
ssc install asdoc, replace

/*regress the wages on educational degree and BMI only*/
reg earnings edu_degree bmicalc if bmicalc < 18.5
reg earnings edu_degree bmicalc if bmicalc > 25
reg earnings edu_degree bmicalc if bmicalc > 30

asdoc reg earnings edu_degree bmicalc if bmicalc < 18.5, nest replace
asdoc reg earnings edu_degree bmicalc if bmicalc > 25, nest append
asdoc reg earnings edu_degree bmicalc if bmicalc > 30, nest append
//
/*regress the wages on educational degree and BMI*/
reg earnings edu_degree bmicalc, vce(robust)
reg earnings edu_degree bmicalc if bmicalc < 18.5, vce(robust)
reg earnings edu_degree bmicalc if bmicalc > 25, vce(robust)
reg earnings edu_degree bmicalc if bmicalc > 30, vce(robust)

/*Discuss the wages on educational degree, BMI and sex*/
reg earnings edu_degree bmicalc if bmicalc < 18.5 & sex ==1, vce(robust)
reg earnings edu_degree bmicalc if bmicalc > 25 & sex==1 , vce(robust)
reg earnings edu_degree bmicalc if bmicalc > 30 & sex==1 , vce(robust)

reg earnings edu_degree bmicalc if bmicalc < 18.5 & sex ==2, vce(robust)
reg earnings edu_degree bmicalc if bmicalc > 25 & sex==2 , vce(robust)
reg earnings edu_degree bmicalc if bmicalc > 30 & sex==2 , vce(robust)
//
*reg Learn region marstat famsize racea educ ///
*occ1995 ind1995 classwk bmicalc,vce (robust)

//

reg earnings edu_degree bmicalc age sex famsize racea occ1995 ///
ind1995 classwk2 yearsonjob

reg earnings edu_degree bmicalc age sex famsize racea occ1995 ///
ind1995 classwk2 yearsonjob, vce(robust)

//
ssc install pdslasso
ssc install lassopack
pdslasso male_obesity_earnings Obesity (edu_degree age ///
famsize occ1995 ind1995 classwk2 yearsonjob), rob
pdslasso female_obesity_earnings Obesity (edu_degree age ///
famsize occ1995 ind1995 classwk2 yearsonjob), rob
//

/*Re-discuss the wages on educational degree, BMI and sex*/
reg earnings bmicalc age occ1995 ///
ind1995 classwk2 if bmicalc < 18.5 & sex ==1, vce(robust)
reg earnings bmicalc age occ1995 ///
ind1995 classwk2 if bmicalc > 25 & sex==1 , vce(robust)
reg earnings bmicalc age occ1995 ///
ind1995 classwk2 if bmicalc > 30 & sex==1 , vce(robust)

asdoc reg earnings bmicalc age occ1995 ///
ind1995 classwk2 if bmicalc < 18.5 & sex ==1, vce(robust), nest replace
asdoc reg earnings bmicalc age occ1995 ///
ind1995 classwk2 if bmicalc > 25 & sex==1 , vce(robust), nest append
asdoc reg earnings bmicalc age occ1995 ///
ind1995 classwk2 if bmicalc > 30 & sex==1 , vce(robust), nest append

reg earnings bmicalc age famsize occ1995 ///
ind1995 classwk2 if bmicalc < 18.5 & sex ==2, vce(robust)
reg earnings bmicalc age famsize occ1995 ///
ind1995 classwk2 if bmicalc > 25 & sex==2 , vce(robust)
reg earnings  bmicalc age famsize occ1995 ///
ind1995 classwk2 if bmicalc > 30 & sex==2 , vce(robust)



/*Re-discuss the case for white or not*/
reg earnings bmicalc age occ1995 ///
ind1995 classwk2 if bmicalc < 18.5 & sex ==1 & white == 1, vce(robust)//*//
reg earnings bmicalc age occ1995 ///
ind1995 classwk2 if bmicalc > 25 & sex==1 & white == 1, vce(robust)//***//
reg earnings bmicalc age occ1995 ///
ind1995 classwk2 if bmicalc > 30 & sex==1 & white == 1, vce(robust)//***//

reg earnings bmicalc age occ1995 ///
ind1995 classwk2 if bmicalc < 18.5 & sex ==1 & Black == 1, vce(robust)
reg earnings bmicalc age occ1995 ///
ind1995 classwk2 if bmicalc > 25 & sex==1 & Black == 1, vce(robust)
reg earnings bmicalc age occ1995 ///
ind1995 classwk2 if bmicalc > 30 & sex==1 & Black == 1, vce(robust)

reg earnings bmicalc age famsize occ1995 ///
ind1995 classwk2 if bmicalc < 18.5 & sex ==2 & white == 0 & Black == 0, vce(robust)
reg earnings bmicalc age famsize occ1995 ///
ind1995 classwk2 if bmicalc > 25 & sex==2 & white == 0 & Black == 0, vce(robust)//***//
reg earnings  bmicalc age famsize occ1995 ///
ind1995 classwk2 if bmicalc > 30 & sex==2 & white == 0 & Black == 0, vce(robust)//**//

/*Re-discuss the case for private or public*/
reg earnings bmicalc age occ1995 ///
ind1995 if bmicalc < 18.5 & sex ==1 & Private == 1, vce(robust)
reg earnings bmicalc age occ1995 ///
ind1995 if bmicalc > 25 & sex==1 & Private == 1, vce(robust)//***//
reg earnings bmicalc age occ1995 ///
ind1995 if bmicalc > 30 & sex==1 & Private == 1, vce(robust)//***//

reg earnings bmicalc age occ1995 ///
ind1995 if bmicalc < 18.5 & sex ==1 & Public == 1, vce(robust)
reg earnings bmicalc age occ1995 ///
ind1995 if bmicalc > 25 & sex==1 & Public == 1, vce(robust)//***//
reg earnings bmicalc age occ1995 ///
ind1995 if bmicalc > 30 & sex==1 & Public == 1, vce(robust)//***//
*/


log close
