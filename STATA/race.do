clear 

global do = "/Users/shawn/Documents/勞經"
global data = "/Users/shawn/Documents/勞經"
global image = "/Users/shawn/Documents/勞經"
global log = "/Users/shawn/Documents/勞經"
capture log close

log using $log\homework1.txt, replace

set more off
use $data/Descriptive.dta, replace
/**/
ssc install asdoc, replace
ssc install pdslasso
ssc install lassopack

/*迴歸*/







/*
/*考慮相關的變數，但這裡其實都還是category variables*/
/*分開看男女的效果*/
*pdslasso earnings_log Obesity (age marstat famsize racea educ occ1995 ind1995 ///
*classwk2 yearsonjob classwk bmicalc) if sex==1, rob
*pdslasso earnings_log Obesity (age marstat famsize racea educ occ1995 ind1995 ///
*classwk2 yearsonjob classwk bmicalc) if sex==2, rob

/*用機器挑出的變數看一 下迴歸結果*/
reg earnings_log Obesity age marstat educ ///
classwk2 yearsonjob classwk bmicalc if white ==1 & sex==1, rob
reg earnings_log Obesity age marstat educ ///
classwk2 yearsonjob classwk bmicalc if white ==1 & sex==2, rob
reg earnings_log Obesity age marstat educ ///
classwk2 yearsonjob classwk bmicalc if Black ==1 & sex==1, rob
reg earnings_log Obesity age educ ///
ind1995 classwk bmicalc if Black ==1 & sex==2, rob
/*黑人不顯著*/
*/





.
/*
/*將原本的Category variable轉成dummy variable*/
/*再挑一次變數*/
pdslasso earnings_log Obesity (Northeast North_Central_or_Midwest South ///
married divorced never_married ///
white Black high_school college Banchelor Master Professional Doctoral ///
Managerial_Professional Technical_Sales_Administrative ///
Service Operators_Fabricators_Laborers Private Public ///
Self_employed age famsize ///
yearsonjob bmicalc) if white ==1 & sex==1, rob

pdslasso earnings_log Obesity (Northeast North_Central_or_Midwest South ///
married divorced never_married ///
white Black high_school college Banchelor Master Professional Doctoral ///
Managerial_Professional Technical_Sales_Administrative ///
Service Operators_Fabricators_Laborers Private Public ///
Self_employed age famsize ///
yearsonjob bmicalc) if white == 1 & sex==2, rob

pdslasso earnings_log Obesity (Northeast North_Central_or_Midwest South ///
married divorced never_married ///
white Black high_school college Banchelor Master Professional Doctoral ///
Managerial_Professional Technical_Sales_Administrative ///
Service Operators_Fabricators_Laborers Private Public ///
Self_employed age famsize ///
yearsonjob bmicalc) if Black ==1 & sex==1, rob

pdslasso earnings_log Obesity (Northeast North_Central_or_Midwest South ///
married divorced never_married ///
white Black high_school college Banchelor Master Professional Doctoral ///
Managerial_Professional Technical_Sales_Administrative ///
Service Operators_Fabricators_Laborers Private Public ///
Self_employed age famsize ///
yearsonjob bmicalc) if Black == 1 & sex==2, rob
*/

/*迴歸*/
reg earnings_log Obesity Northeast married divorced never_married ///
high_school college Banchelor Master Professional Doctoral ///
Managerial_Professional Technical_Sales_Administrative Service ///
Private Self_employed age famsize yearsonjob bmicalc ///
if white ==1 & sex==1, rob

reg earnings_log Obesity Northeast North_Central_or_Midwest married ///
divorced never_married Banchelor Master Professional Doctoral Managerial_ ///
Professional Technical_Sales_Administrative Operators_Fabricators_Laborers ///
Private Self_employed age famsize yearsonjob bmicalc ///
if white ==1 & sex==2, rob

reg earnings_log Obesity married never_married college Banchelor ///
Master Professional Doctoral Managerial_Professional Service ///
Operators_Fabricators_Laborers age yearsonjob bmicalc ///
if Black ==1 & sex==1, rob

reg earnings_log Obesity Northeast married divorced never_married ///
college Banchelor Master Professional Doctoral Managerial_Professional ///
Technical_Sales_Administrative Operators_Fabricators_Laborers age ///
yearsonjob bmicalc if Black ==1 & sex==2, rob
/*除了黑人女性其他都顯著*/






/*
/*將上面dummy variable拿掉教育，教育程度使用原本的連續變數*/
/*再挑一次變數*/
pdslasso earnings_log Obesity (Northeast North_Central_or_Midwest South ///
married divorced never_married ///
white Black Managerial_Professional Technical_Sales_Administrative ///
Service Operators_Fabricators_Laborers Private Public ///
Self_employed age famsize edu_degree ///
yearsonjob bmicalc) if white ==1 & sex==1, rob

pdslasso earnings_log Obesity (Northeast North_Central_or_Midwest South ///
married divorced never_married ///
white Black Managerial_Professional Technical_Sales_Administrative ///
Service Operators_Fabricators_Laborers Private Public ///
Self_employed age famsize edu_degree ///
yearsonjob bmicalc) if white == 1 & sex==2, rob

pdslasso earnings_log Obesity (Northeast North_Central_or_Midwest South ///
married divorced never_married ///
white Black Managerial_Professional Technical_Sales_Administrative ///
Service Operators_Fabricators_Laborers Private Public ///
Self_employed age famsize edu_degree ///
yearsonjob bmicalc) if Black == 1 & sex==1, rob

pdslasso earnings_log Obesity (Northeast North_Central_or_Midwest South ///
married divorced never_married ///
white Black Managerial_Professional Technical_Sales_Administrative ///
Service Operators_Fabricators_Laborers Private Public ///
Self_employed age famsize edu_degree ///
yearsonjob bmicalc) if Black ==1 & sex==2, rob
*/

/*迴歸*/
reg earnings_log Obesity Northeast North_Central_or_Midwest married ///
divorced never_married Managerial_Professional ///
Technical_Sales_Administrative Service Private ///
Self_employed age yearsonjob bmicalc if white ==1 & sex==1, rob

reg earnings_log Obesity Northeast North_Central_or_Midwest ///
married divorced never_married Managerial_Professional ///
Technical_Sales_Administrative Operators_Fabricators_Laborers ///
Private Self_employed age famsize yearsonjob bmicalc ///
if white ==1 & sex==2, rob

reg earnings_log Obesity married never_married Managerial_Professional ///
Service Operators_Fabricators_Laborers Self_employed age yearsonjob ///
bmicalc if Black ==1 & sex==1, rob

reg earnings_log Obesity Northeast married divorced ///
Managerial_Professional Technical_Sales_Administrative ///
Operators_Fabricators_Laborers Public age yearsonjob bmicalc ///
if Black ==1 & sex==2, rob
/*除了黑人女性其他都顯著*/







/*反璞歸真*/
reg earnings_log Obesity bmicalc if white ==1 &sex==1, rob

reg earnings_log Obesity bmicalc if white ==1 &sex==2, rob

reg earnings_log Obesity bmicalc if Black ==1 &sex==1, rob

reg earnings_log Obesity bmicalc if Black ==1 &sex==2, rob
/*肥胖係數都顯著*/








/*增加教育*/
reg earnings_log Obesity bmicalc edu_degree if white ==1 &sex==1, rob

reg earnings_log Obesity bmicalc edu_degree if white ==1 &sex==2, rob

reg earnings_log Obesity bmicalc edu_degree if Black ==1 &sex==1, rob

reg earnings_log Obesity bmicalc edu_degree if Black ==1 &sex==2, rob
/*肥胖係數都顯著*/






/*不同體態*/
reg earnings_log Obesity bmicalc edu_degree ///
normalweight overweight if white ==1 &sex==1, rob

reg earnings_log Obesity bmicalc edu_degree ///
normalweight overweight if white ==1 &sex==2, rob

reg earnings_log Obesity bmicalc edu_degree ///
normalweight overweight if Black ==1 &sex==1, rob

reg earnings_log Obesity bmicalc edu_degree ///
normalweight overweight if Black ==1 &sex==2, rob









replace edu_degree = . if edu_degree > 50
/*白人男性*/
reg earnings_log Obesity edu_degree if white ==1 &sex==1, rob
outreg2 using $data\reg_male,excel replace ctitle(log_earnings)
reg earnings_log bmicalc edu_degree if white ==1 &sex==1, rob
outreg2 using $data\reg_male,excel append ctitle(log_earnings)
reg earnings_log Obesity Northeast North_Central_or_Midwest married ///
divorced never_married Managerial_Professional ///
Technical_Sales_Administrative Service Private ///
Self_employed age yearsonjob  edu_degree if white ==1 & sex==1, rob
outreg2 using $data\reg_male,excel append ctitle(log_earnings)
reg earnings_log Obesity  edu_degree ///
underweight normalweight if white ==1 &sex==1, rob 
outreg2 using $data\reg_male,excel append ctitle(log_earnings)

/*白人女性*/
reg earnings_log Obesity edu_degree if white ==1 &sex==2, rob
outreg2 using $data\reg_male,excel append ctitle(log_earnings)
reg earnings_log  bmicalc edu_degree if white ==1 &sex==2, rob
outreg2 using $data\reg_male,excel append ctitle(log_earnings)
reg earnings_log Obesity Northeast North_Central_or_Midwest ///
married divorced never_married Managerial_Professional ///
Technical_Sales_Administrative Operators_Fabricators_Laborers ///
Private Self_employed age famsize yearsonjob  edu_degree if white ==1 & sex==2, rob
outreg2 using $data\reg_male,excel append ctitle(log_earnings)
reg earnings_log Obesity  edu_degree underweight normalweight if white ==1 &sex==2, rob 
outreg2 using $data\reg_male,excel append ctitle(log_earnings)

/*黑人男性*/
reg earnings_log Obesity edu_degree if Black ==1 &sex==1, rob  
outreg2 using $data\reg_male,excel append ctitle(log_earnings)
reg earnings_log  bmicalc edu_degree if Black ==1 &sex==1, rob
outreg2 using $data\reg_male,excel append ctitle(log_earnings)
reg earnings_log Obesity married never_married Managerial_Professional ///
Service Operators_Fabricators_Laborers Self_employed age yearsonjob ///
 edu_degree if Black ==1 & sex==1, rob 
outreg2 using $data\reg_male,excel append ctitle(log_earnings)
reg earnings_log Obesity  edu_degree ///
underweight normalweight if Black ==1 &sex==1, rob
outreg2 using $data\reg_male,excel append ctitle(log_earnings) 

/*黑人女性*/
reg earnings_log Obesity edu_degree if Black ==1 &sex==2, rob
outreg2 using $data\reg_male,excel append ctitle(log_earnings)
reg earnings_log  bmicalc edu_degree if Black ==1 &sex==2, rob
outreg2 using $data\reg_male,excel append ctitle(log_earnings)
reg earnings_log Obesity Northeast married divorced ///
Managerial_Professional Technical_Sales_Administrative ///
Operators_Fabricators_Laborers age yearsonjob  edu_degree ///
if Black ==1 & sex==2, rob
outreg2 using $data\reg_male,excel append ctitle(log_earnings)
reg earnings_log Obesity  edu_degree ///
underweight normalweight if Black ==1 &sex==2, rob
outreg2 using $data\reg_male,excel append ctitle(log_earnings)

log close
