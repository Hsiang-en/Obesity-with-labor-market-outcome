clear 

global do = "/Users/shawn/Documents/勞經"
global data = "/Users/shawn/Documents/勞經"
global image = "/Users/shawn/Documents/勞經"
global log = "/Users/shawn/Documents/勞經"

capture log close

set more off
use $data/Descriptive.dta, replace


/**/
ssc install asdoc, replace
ssc install pdslasso
ssc install lassopack

/*迴歸*/







/*考慮相關的變數，但這裡其實都還是category variables*/
/*分開看男女的效果*/
pdslasso earnings_log Obesity (age marstat famsize racea educ occ1995 ind1995 ///
classwk2 yearsonjob classwk bmicalc) if Public==1 & sex==1, rob
pdslasso earnings_log Obesity (age marstat famsize racea educ occ1995 ind1995 ///
classwk2 yearsonjob classwk bmicalc) if Public==1 & sex==2, rob
pdslasso earnings_log Obesity (age marstat famsize racea educ occ1995 ind1995 ///
classwk2 yearsonjob classwk bmicalc) if Private==1 & sex==1, rob
pdslasso earnings_log Obesity (age marstat famsize racea educ occ1995 ind1995 ///
classwk2 yearsonjob classwk bmicalc) if Private==1 & sex==2, rob








/*用挑出的變數看一 下迴歸結果*/
reg earnings_log Obesity marstat educ ind1995 classwk2 yearsonjob classwk bmicalc if Public==1 & sex==1, rob
reg earnings_log Obesity educ ind1995 classwk2 yearsonjob classwk bmicalc if Public==1 & sex==2, rob
reg earnings_log Obesity age marstat educ yearsonjob classwk bmicalc if Private==1 & sex==1, rob
reg earnings_log Obesity age marstat educ yearsonjob classwk bmicalc if Private==1 & sex==2, rob








/*將原本的Category variable轉成dummy variable*/
/*再挑一次變數*/
pdslasso earnings_log Obesity (Northeast North_Central_or_Midwest South ///
married divorced never_married ///
white Black high_school college Banchelor Master Professional Doctoral ///
Managerial_Professional Technical_Sales_Administrative ///
Service Operators_Fabricators_Laborers Private Public ///
Self_employed age famsize educ yearsonjob bmicalc) if Public==1 & sex==1, rob

pdslasso earnings_log Obesity (Northeast North_Central_or_Midwest South ///
married divorced never_married ///
white Black high_school college Banchelor Master Professional Doctoral ///
Managerial_Professional Technical_Sales_Administrative ///
Service Operators_Fabricators_Laborers Private Public ///
Self_employed age famsize educ yearsonjob bmicalc) if Public==1 & sex==2, rob

pdslasso earnings_log Obesity (Northeast North_Central_or_Midwest South ///
married divorced never_married ///
white Black high_school college Banchelor Master Professional Doctoral ///
Managerial_Professional Technical_Sales_Administrative ///
Service Operators_Fabricators_Laborers Private Public ///
Self_employed age famsize educ yearsonjob bmicalc) if Private==1 & sex==1, rob

pdslasso earnings_log Obesity (Northeast North_Central_or_Midwest South ///
married divorced never_married ///
white Black high_school college Banchelor Master Professional Doctoral ///
Managerial_Professional Technical_Sales_Administrative ///
Service Operators_Fabricators_Laborers Private Public ///
Self_employed age famsize educ yearsonjob bmicalc) if Private==1 & sex==2, rob









/*迴歸*/
reg  earnings_log Obesity Northeast North_Central_or_Midwest married never_married college Banchelor ///
Professional Managerial_Professional Self_employed age famsize educ yearsonjob ///
bmicalc if Public==1 & sex==1, rob

reg earnings_log Obesity North_Central_or_Midwest married divorced never_married Black college ///
Professional Doctoral Managerial_Professional Technical_Sales_Administrative ///
Self_employed age educ yearsonjob bmicalc if Public==1 & sex==2, rob

reg earnings_log Obesity married never_married white Black high_school Banchelor Master Professional ///
Managerial_Professional Service age educ yearsonjob bmicalc if Private==1 & sex==1, rob

reg earnings_log Obesity North_Central_or_Midwest married divorced never_married college Banchelor /// 
Master Professional Doctoral Managerial_Professional Technical_Sales_Administrative ///
Operators_Fabricators_Laborers age famsize educ yearsonjob bmicalc if Private==1 & sex==2, rob
/**/







/*將上面dummy variable拿掉教育，教育程度使用原本的連續變數*/
/*再挑一次變數*/
pdslasso earnings_log Obesity (Northeast North_Central_or_Midwest South ///
married divorced never_married white Black Managerial_Professional ///
Technical_Sales_Administrative Service Operators_Fabricators_Laborers Private Public ///
Self_employed age famsize educ yearsonjob bmicalc) if Public ==1 & sex==1, rob

pdslasso earnings_log Obesity (Northeast North_Central_or_Midwest South ///
married divorced never_married white Black Managerial_Professional ///
Technical_Sales_Administrative Service Operators_Fabricators_Laborers Private Public ///
Self_employed age famsize educ yearsonjob bmicalc) if Public ==1 & sex==2, rob

pdslasso earnings_log Obesity (Northeast North_Central_or_Midwest South ///
married divorced never_married white Black Managerial_Professional ///
Technical_Sales_Administrative Service Operators_Fabricators_Laborers Private Public ///
Self_employed age famsize educ yearsonjob bmicalc) if Private ==1 & sex==1, rob

pdslasso earnings_log Obesity (Northeast North_Central_or_Midwest South ///
married divorced never_married white Black Managerial_Professional ///
Technical_Sales_Administrative Service Operators_Fabricators_Laborers Private Public ///
Self_employed age famsize educ yearsonjob bmicalc) if Private ==1 & sex==2, rob










/*迴歸*/
reg earnings_log Obesity Northeast North_Central_or_Midwest married never_married Managerial_Professional age famsize educ yearsonjob bmicalc if Public==1 & sex==1, rob

reg earnings_log Obesity North_Central_or_Midwest married divorced never_married Black Managerial_Professional Technical_Sales_Administrative Self_employed age educ ///
yearsonjob bmicalc if Public==1 & sex==2, rob

reg earnings_log Obesity North_Central_or_Midwest married never_married white Black Managerial_Professional Service age educ yearsonjob bmicalc if Private==1 & sex==1, rob

reg earnings_log Obesity Northeast North_Central_or_Midwest married divorced never_married Managerial_Professional Technical_Sales_Administrative ///
Operators_Fabricators_Laborers age famsize educ yearsonjob bmicalc if Private==1 & sex==2, rob
/* */







/*反璞歸真*/
reg earnings_log Obesity bmicalc if Public==1 &sex==1, rob

reg earnings_log Obesity bmicalc if Public==1 &sex==2, rob

reg earnings_log Obesity bmicalc if Private==1 &sex==1, rob

reg earnings_log Obesity bmicalc if Private==1 &sex==2, rob
/*肥胖係數都顯著*/








/*增加教育*/
reg earnings_log Obesity bmicalc educ if Public==1 &sex==1, rob

reg earnings_log Obesity bmicalc educ if Public==1 &sex==2, rob

reg earnings_log Obesity bmicalc educ if Private==1 &sex==1, rob

reg earnings_log Obesity bmicalc educ if Private==1 &sex==2, rob
/*肥胖係數都顯著*/








replace edu_degree = . if edu_degree > 50
/**/
reg earnings_log Obesity edu_degree if Public==1 &sex==1, rob
outreg2 using $data\reg_male,excel replace ctitle(log_earnings)
reg earnings_log  bmicalc edu_degree if Public==1 &sex==1, rob
outreg2 using $data\reg_male,excel append ctitle(log_earnings)
reg earnings_log Obesity Northeast North_Central_or_Midwest married never_married Managerial_Professional age famsize educ yearsonjob  edu_degree if Public==1 & sex==1, rob
outreg2 using $data\reg_male,excel append ctitle(log_earnings)
reg earnings_log Obesity  underweight normalweight edu_degree if Public==1 &sex==1, rob
outreg2 using $data\reg_male,excel append ctitle(log_earnings)

reg earnings_log Obesity edu_degree if Public==1 &sex==2, rob
outreg2 using $data\reg_male,excel append ctitle(log_earnings)
reg earnings_log  bmicalc edu_degree if Public==1 &sex==2, rob
outreg2 using $data\reg_male,excel append ctitle(log_earnings)
reg earnings_log Obesity North_Central_or_Midwest married divorced never_married Black Managerial_Professional Technical_Sales_Administrative Self_employed age edu_degree ///
yearsonjob  if Public==1 & sex==2, rob
outreg2 using $data\reg_male,excel append ctitle(log_earnings)
reg earnings_log Obesity  underweight normalweight edu_degree if Public==1 &sex==2, rob
outreg2 using $data\reg_male,excel append ctitle(log_earnings)






/**/
reg earnings_log Obesity edu_degree if Private==1 &sex==1, rob
outreg2 using $data\reg_male,excel append ctitle(log_earnings)
reg earnings_log  bmicalc edu_degree if Private==1 &sex==1, rob
outreg2 using $data\reg_male,excel append ctitle(log_earnings)
reg earnings_log Obesity North_Central_or_Midwest married never_married white Managerial_Professional Service age educ yearsonjob  edu_degree if Private==1 & sex==1, rob
outreg2 using $data\reg_male,excel append ctitle(log_earnings)
reg earnings_log Obesity  underweight normalweight edu_degree if Private==1 &sex==1, rob
outreg2 using $data\reg_male,excel append ctitle(log_earnings)




reg earnings_log Obesity edu_degree if Private==1 &sex==2, rob
outreg2 using $data\reg_male,excel append ctitle(log_earnings)
reg earnings_log  bmicalc edu_degree if Private==1 &sex==2, rob
outreg2 using $data\reg_male,excel append ctitle(log_earnings)
reg earnings_log Obesity Northeast North_Central_or_Midwest married divorced never_married Managerial_Professional Technical_Sales_Administrative ///
Operators_Fabricators_Laborers age famsize educ yearsonjob  edu_degree if Private==1 & sex==2, rob
outreg2 using $data\reg_male,excel append ctitle(log_earnings)
reg earnings_log Obesity  underweight normalweight edu_degree if Private==1 &sex==2, rob
outreg2 using $data\reg_male,excel append ctitle(log_earnings)

















log close
