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




gen Sales_occupation = 0
replace Sales_occupation = 1 if occ1995 > 400 & occ1995 < 405 
tab Sales_occupation





/*將原本的Category variable轉成dummy variable*/
/*再挑一次變數*/
pdslasso earnings_log Obesity (Northeast North_Central_or_Midwest South ///
married divorced never_married ///
white Black high_school college Banchelor Master Professional Doctoral ///
Private Public ///
Self_employed age famsize educ yearsonjob bmicalc) if Service==1 & sex==1, rob

pdslasso earnings_log Obesity (Northeast North_Central_or_Midwest South ///
married divorced never_married ///
white Black high_school college Banchelor Master Professional Doctoral ///
Private Public ///
Self_employed age famsize educ yearsonjob bmicalc) if Service==1 & sex==2, rob

pdslasso earnings_log Obesity (Northeast North_Central_or_Midwest South ///
married divorced never_married white Black high_school college Banchelor Master Professional Doctoral ///
Private Public Self_employed age famsize educ yearsonjob bmicalc) if Sales_occupation==1 & sex==1, rob

pdslasso earnings_log Obesity (Northeast North_Central_or_Midwest South ///
married divorced never_married white Black high_school college Banchelor Master Professional Doctoral ///
Private Public Self_employed age famsize educ yearsonjob bmicalc) if Sales_occupation==1 & sex==2, rob

pdslasso earnings_log Obesity (Northeast North_Central_or_Midwest South ///
married divorced never_married ///
white Black high_school college Banchelor Master Professional Doctoral ///
Private Public ///
Self_employed age famsize educ yearsonjob bmicalc) if Service==0 & Sales_occupation ==0 & sex==1, rob

pdslasso earnings_log Obesity (Northeast North_Central_or_Midwest South ///
married divorced never_married ///
white Black high_school college Banchelor Master Professional Doctoral ///
Private Public ///
Self_employed age famsize educ yearsonjob bmicalc) if Service==0 & Sales_occupation ==0 & sex==2, rob





/*將上面dummy variable拿掉教育，教育程度使用原本的連續變數*/
/*再挑一次變數*/
pdslasso earnings_log Obesity (Northeast North_Central_or_Midwest South ///
married divorced never_married white Black Private Public ///
Self_employed age famsize educ yearsonjob bmicalc) if Service ==1 & sex==1, rob

pdslasso earnings_log Obesity (Northeast North_Central_or_Midwest South ///
married divorced never_married white Black Private Public ///
Self_employed age famsize educ yearsonjob bmicalc) if Service ==1 & sex==2, rob

pdslasso earnings_log Obesity (Northeast North_Central_or_Midwest South ///
married divorced never_married white Black Private Public ///
Self_employed age famsize educ yearsonjob bmicalc) if Sales_occupation==1 & sex==1, rob

pdslasso earnings_log Obesity (Northeast North_Central_or_Midwest South ///
married divorced never_married white Black Private Public ///
Self_employed age famsize educ yearsonjob bmicalc) if Sales_occupation==1 & sex==2, rob

pdslasso earnings_log Obesity (Northeast North_Central_or_Midwest South ///
married divorced never_married white Black Private Public ///
Self_employed age famsize educ yearsonjob bmicalc) if Service==0 & Sales_occupation ==0 & sex==1, rob

pdslasso earnings_log Obesity (Northeast North_Central_or_Midwest South ///
married divorced never_married white Black Private Public ///
Self_employed age famsize educ yearsonjob bmicalc) if Service==0 & Sales_occupation ==0 & sex==2, rob








replace edu_degree = . if edu_degree > 50
/**/
reg earnings_log Obesity edu_degree if Service == 1 & sex== 1, rob
outreg2 using $data\reg_male,excel replace ctitle(log_earnings)
reg earnings_log  bmicalc edu_degree if Service == 1 & sex== 1, rob
outreg2 using $data\reg_male,excel append ctitle(log_earnings)
reg earnings_log Obesity  North_Central_or_Midwest married never_married Public age edu_degree yearsonjob if Service == 1 & sex== 1, rob
outreg2 using $data\reg_male,excel append ctitle(log_earnings)
reg earnings_log Obesity  underweight normalweight edu_degree if Service == 1 & sex== 1, rob
outreg2 using $data\reg_male,excel append ctitle(log_earnings)




reg earnings_log Obesity edu_degree if Service == 1 & sex== 2, rob
outreg2 using $data\reg_male,excel append ctitle(log_earnings)
reg earnings_log  bmicalc edu_degree if Service == 1 & sex== 2, rob
outreg2 using $data\reg_male,excel append ctitle(log_earnings)
reg earnings_log Obesity  Northeast North_Central_or_Midwest divorced never_married white Self_employed age edu_degree yearsonjob if Service == 1 & sex== 2, rob
outreg2 using $data\reg_male,excel append ctitle(log_earnings)
reg earnings_log Obesity  underweight normalweight edu_degree if Service == 1 & sex== 2, rob
outreg2 using $data\reg_male,excel append ctitle(log_earnings)






/**/
reg earnings_log Obesity edu_degree if Sales_occupation == 1 & sex== 1, rob
outreg2 using $data\reg_male,excel append ctitle(log_earnings)
reg earnings_log  bmicalc edu_degree if Sales_occupation == 1 & sex== 1, rob
outreg2 using $data\reg_male,excel append ctitle(log_earnings)
reg earnings_log Obesity edu_degree North_Central_or_Midwest married never_married Public age edu_degree yearsonjob if Sales_occupation == 1 & sex== 1, rob
outreg2 using $data\reg_male,excel append ctitle(log_earnings)
reg earnings_log Obesity edu_degree underweight normalweight edu_degree if Sales_occupation == 1 & sex== 1, rob
outreg2 using $data\reg_male,excel append ctitle(log_earnings)




reg earnings_log Obesity edu_degree if Sales_occupation == 1 & sex== 2, rob
outreg2 using $data\reg_male,excel append ctitle(log_earnings)
reg earnings_log  bmicalc edu_degree if Sales_occupation == 1 & sex== 2, rob
outreg2 using $data\reg_male,excel append ctitle(log_earnings)
reg earnings_log Obesity  Northeast North_Central_or_Midwest divorced never_married white Self_employed age edu_degree yearsonjob if Sales_occupation == 1 & sex== 2, rob
outreg2 using $data\reg_male,excel append ctitle(log_earnings)
reg earnings_log Obesity  underweight normalweight edu_degree if Sales_occupation == 1 & sex== 2, rob
outreg2 using $data\reg_male,excel append ctitle(log_earnings)









/**/
reg earnings_log Obesity edu_degree if Service==0 & Sales_occupation ==0 & sex==1, rob
outreg2 using $data\reg_male,excel append ctitle(log_earnings)
reg earnings_log  bmicalc edu_degree if Service==0 & Sales_occupation ==0 & sex==1, rob
outreg2 using $data\reg_male,excel append ctitle(log_earnings)
reg earnings_log Obesity Northeast North_Central_or_Midwest married never_married white ///
Black Private age famsize edu_degree yearsonjob if Service==0 & Sales_occupation ==0 & sex==1, rob
outreg2 using $data\reg_male,excel append ctitle(log_earnings)
reg earnings_log Obesity  underweight normalweight edu_degree if Service==0 & Sales_occupation ==0 & sex==1, rob
outreg2 using $data\reg_male,excel append ctitle(log_earnings)




reg earnings_log Obesity edu_degree if Service==0 & Sales_occupation ==0 & sex==2, rob
outreg2 using $data\reg_male,excel append ctitle(log_earnings)
reg earnings_log bmicalc edu_degree if Service==0 & Sales_occupation ==0 & sex==2, rob
outreg2 using $data\reg_male,excel append ctitle(log_earnings)
reg earnings_log Obesity Northeast North_Central_or_Midwest married divorced never_married ///
Black Private Self_employed age famsize edu_degree yearsonjob  if Service==0 & Sales_occupation ==0 & sex==2, rob
outreg2 using $data\reg_male,excel append ctitle(log_earnings)
reg earnings_log Obesity  underweight normalweight edu_degree if Service==0 & Sales_occupation ==0 & sex==2, rob
outreg2 using $data\reg_male,excel append ctitle(log_earnings)







