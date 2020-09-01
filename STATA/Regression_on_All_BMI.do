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






replace edu_degree = . if edu_degree > 50
.

/*將原本的Category variable轉成dummy variable*/
/*再挑一次變數*/
pdslasso earnings_log Obesity (Northeast North_Central_or_Midwest South ///
married divorced never_married ///
white Black high_school college Banchelor Master Professional Doctoral ///
Managerial_Professional Technical_Sales_Administrative ///
Service Operators_Fabricators_Laborers Private Public ///
Self_employed age famsize ///
yearsonjob bmicalc) if sex==1, rob
//*26取21*//
pdslasso earnings_log Obesity (Northeast North_Central_or_Midwest South ///
married divorced never_married ///
white Black high_school college Banchelor Master Professional Doctoral ///
Managerial_Professional Technical_Sales_Administrative ///
Service Operators_Fabricators_Laborers Private Public ///
Self_employed age famsize ///
yearsonjob bmicalc) if sex==2, rob
//*26取24*//

/*迴歸*/
reg earnings_log Obesity Northeast North_Central_or_Midwest South ///
married never_married white Black high_school ///
South married never_married white Black high_school ///
college Banchelor Master Professional Doctoral Managerial_Professional ///
Service Private Self_employed age yearsonjob bmicalc if sex==1, rob

reg earnings_log Obesity Northeast North_Central_or_Midwest married ///
divorced never_married white Black college Banchelor Master Professional ///
Doctoral Managerial_Professional Technical_Sales_Administrative ///
Operators_Fabricators_Laborers Private Self_employed age famsize ///
yearsonjob bmicalc if sex==2, rob
/*肥胖是顯著負相關*/
/*BMI的係數都顯著，但都是正相關*/







/*將上面dummy variable拿掉教育，教育程度使用原本的連續變數*/
/*再挑一次變數*/
pdslasso earnings_log Obesity (Northeast North_Central_or_Midwest South ///
married divorced never_married ///
white Black Managerial_Professional Technical_Sales_Administrative ///
Service Operators_Fabricators_Laborers Private Public ///
Self_employed age famsize yearsonjob) if sex==1, rob
//*26取21*//
pdslasso earnings_log Obesity (Northeast North_Central_or_Midwest South ///
married divorced never_married ///
white Black Managerial_Professional Technical_Sales_Administrative ///
Service Operators_Fabricators_Laborers Private Public ///
Self_employed age famsize yearsonjob)if sex==2, rob
//*26取24*//


/*迴歸*/
reg earnings_log Obesity bmicalc edu_degree Northeast North_Central_or_Midwest South ///
married never_married white Black Managerial_Professional Technical_Sales_Administrative ///
Service Operators_Fabricators_Laborers Private Public ///
Self_employed age famsize yearsonjob if sex==1, rob

reg earnings_log Obesity bmicalc edu_degree Northeast North_Central_or_Midwest South ///
married divorced never_married white Black Managerial_Professional Technical_Sales_Administrative ///
Service Operators_Fabricators_Laborers Private Public ///
Self_employed age famsize yearsonjob if sex==2, rob
/*肥胖是顯著負相關*/
/*BMI的係數都顯著，但都是正相關*/







/**/
reg earnings_log Obesity bmicalc if sex==1, rob

reg earnings_log Obesity bmicalc if sex==2, rob
/*肥胖是顯著負相關*/
/*BMI的係數都顯著，但都是正相關*/








/*增加教育*/
reg earnings_log Obesity bmicalc edu_degree if sex==1, rob

reg earnings_log Obesity bmicalc edu_degree if sex==2, rob
/*肥胖是顯著負相關*/
/*BMI的係數都顯著，但都是正相關*/







/*考慮不同interval的BMI*/
reg earnings_log underweight normalweight Obesity ///
bmicalc edu_degree if sex==1, rob

reg earnings_log underweight normalweight Obesity ///
bmicalc edu_degree if sex==2, rob
/*效果顯著，但係數為正*/




/*做表格*/
/*男生*/
reg earnings_log Obesity edu_degree if sex==1, rob
outreg2 using $data\reg_male,excel replace ctitle(log_earnings)
reg earnings_log bmicalc edu_degree if sex==1, rob
outreg2 using $data\reg_male,excel append ctitle(log_earnings)
reg earnings_log Obesity edu_degree Northeast North_Central_or_Midwest South ///
married never_married white Managerial_Professional Technical_Sales_Administrative ///
Service Operators_Fabricators_Laborers Private  ///
Self_employed age famsize yearsonjob if sex==1, rob
outreg2 using $data\reg_male,excel append ctitle(log_earnings)
reg earnings_log underweight normalweight Obesity edu_degree if sex==1, rob 
outreg2 using $data\reg_male,excel append ctitle(log_earnings)

/*女生*/
reg earnings_log Obesity edu_degree if sex==2, rob
outreg2 using $data\reg_male,excel append ctitle(log_earnings)
reg earnings_log bmicalc edu_degree if sex==2
outreg2 using $data\reg_male,excel append ctitle(log_earnings)
reg earnings_log Obesity edu_degree Northeast North_Central_or_Midwest South ///
married divorced never_married white Managerial_Professional Technical_Sales_Administrative ///
Service Operators_Fabricators_Laborers Private  ///
Self_employed age famsize yearsonjob if sex==2, rob
outreg2 using $data\reg_male,excel append ctitle(log_earnings)
reg earnings_log underweight normalweight Obesity edu_degree if sex==2, rob
outreg2 using $data\reg_male,excel append ctitle(log_earnings)

ivregress 2sls earnings_log Obesity edu_degree Northeast North_Central_or_Midwest South ///
married never_married white Black Managerial_Professional Technical_Sales_Administrative ///
Service Operators_Fabricators_Laborers Private Public ///
Self_employed age famsize yearsonjob (bmicalc = bmi_family) if sex==1, vce(robust)




log close
