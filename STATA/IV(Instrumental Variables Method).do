clear 

global do = "/Users/shawn/Documents/勞經"
global data = "/Users/shawn/Documents/勞經"
global image = "/Users/shawn/Documents/勞經"
global log = "/Users/shawn/Documents/勞經"

capture log close

set more off
use $data/Descriptive.dta, replace


gen Obesity_family = 0 if bmi_family < 30
replace Obesity_family = 1 if bmi_family > 30 | bmi_family == 30


/*男生*/

*(1)
ivregress 2sls earnings_log edu_degree (Obesity = bmi_family)if sex ==1, vce(robust)
estat endogenous 
*reject the null hypothesis: variables are exogenous
estat firststage, all forcenonrobust
*cannot reject the null hypothesis of weak instruments


ivregress 2sls earnings_log edu_degree (bmicalc = bmi_family)if sex ==1, vce(robust)
estat endogenous 
*reject the null hypothesis: variables are exogenous
estat firststage, all forcenonrobust
*cannot reject the null hypothesis of weak instruments


*(2)
ivregress 2sls earnings_log edu_degree Northeast North_Central_or_Midwest South ///
married never_married white Managerial_Professional Technical_Sales_Administrative ///
Service Operators_Fabricators_Laborers Private  ///
Self_employed age famsize yearsonjob (Obesity = bmi_family) if sex ==1, vce(robust)
estat endogenous 
*endogenous
estat firststage, all forcenonrobust
*cannot reject the null hypothesis of weak instruments


ivregress 2sls earnings_log edu_degree Northeast North_Central_or_Midwest South ///
married never_married white Managerial_Professional Technical_Sales_Administrative ///
Service Operators_Fabricators_Laborers Private  ///
Self_employed age famsize yearsonjob (bmicalc = bmi_family) if sex ==1, vce(robust)
estat endogenous 
*endogenous
estat firststage, all forcenonrobust
*cannot reject the null hypothesis of weak instruments



*(4)
ivregress 2sls earnings_log underweight normalweight edu_degree (Obesity = bmi_family) if sex ==1 , vce(robust)
estat endogenous 
*endogenous
estat firststage, all forcenonrobust
*cannot reject the null hypothesis of weak instruments

ivregress 2sls earnings_log underweight normalweight edu_degree (bmicalc = bmi_family) if sex ==1, vce(robust)
estat endogenous 
*endogenous
estat firststage, all forcenonrobust
*cannot reject the null hypothesis of weak instruments























*(1)
ivregress 2sls earnings_log edu_degree (Obesity = Obesity_family)if sex ==1, vce(robust)
estat endogenous 
*reject the null hypothesis: variables are exogenous
estat firststage, all forcenonrobust
*cannot reject the null hypothesis of weak instruments


ivregress 2sls earnings_log edu_degree (bmicalc = Obesity_family)if sex ==1, vce(robust)
estat endogenous 
*reject the null hypothesis: variables are exogenous
estat firststage, all forcenonrobust
*cannot reject the null hypothesis of weak instruments


*(2)
ivregress 2sls earnings_log edu_degree Northeast North_Central_or_Midwest South ///
married never_married white Managerial_Professional Technical_Sales_Administrative ///
Service Operators_Fabricators_Laborers Private  ///
Self_employed age famsize yearsonjob (Obesity = Obesity_family) if sex ==1, vce(robust)
estat endogenous 
*endogenous
estat firststage, all forcenonrobust
*cannot reject the null hypothesis of weak instruments


ivregress 2sls earnings_log edu_degree Northeast North_Central_or_Midwest South ///
married never_married white Managerial_Professional Technical_Sales_Administrative ///
Service Operators_Fabricators_Laborers Private  ///
Self_employed age famsize yearsonjob (bmicalc = Obesity_family) if sex ==1, vce(robust)
estat endogenous 
*endogenous
estat firststage, all forcenonrobust
*cannot reject the null hypothesis of weak instruments



*(4)
ivregress 2sls earnings_log underweight normalweight edu_degree (Obesity = Obesity_family) if sex ==1, vce(robust)
estat endogenous 
*endogenous
estat firststage, all forcenonrobust
*cannot reject the null hypothesis of weak instruments

ivregress 2sls earnings_log underweight normalweight edu_degree (bmicalc = Obesity_family)if sex ==1, vce(robust)
estat endogenous 
*endogenous
estat firststage, all forcenonrobust
*cannot reject the null hypothesis of weak instruments













/*女生*/

*(1)
ivregress 2sls earnings_log edu_degree (Obesity = bmi_family)if sex ==2, vce(robust)
estat endogenous 
*reject the null hypothesis: variables are exogenous
estat firststage, all forcenonrobust
*cannot reject the null hypothesis of weak instruments


ivregress 2sls earnings_log edu_degree (bmicalc = bmi_family)if sex ==2, vce(robust)
estat endogenous 
*reject the null hypothesis: variables are exogenous
estat firststage, all forcenonrobust
*cannot reject the null hypothesis of weak instruments


*(2)
ivregress 2sls earnings_log edu_degree Northeast North_Central_or_Midwest South ///
married divorced never_married white Managerial_Professional Technical_Sales_Administrative ///
Service Operators_Fabricators_Laborers Private (Obesity = bmi_family) if sex ==2, vce(robust)
estat endogenous 
*endogenous
estat firststage, all forcenonrobust
*cannot reject the null hypothesis of weak instruments


ivregress 2sls earnings_log edu_degree Northeast North_Central_or_Midwest South ///
married divorced never_married white Managerial_Professional Technical_Sales_Administrative ///
Service Operators_Fabricators_Laborers Private (bmicalc = bmi_family) if sex ==2, vce(robust)
estat endogenous 
*endogenous
estat firststage, all forcenonrobust
*cannot reject the null hypothesis of weak instruments



*(4)
ivregress 2sls earnings_log underweight normalweight edu_degree (Obesity = bmi_family) if sex ==2, vce(robust)
estat endogenous 
*endogenous
estat firststage, all forcenonrobust
*cannot reject the null hypothesis of weak instruments

ivregress 2sls earnings_log underweight normalweight edu_degree (bmicalc = bmi_family) if sex ==2, vce(robust)
estat endogenous 
*endogenous
estat firststage, all forcenonrobust
*cannot reject the null hypothesis of weak instruments












*(1)
ivregress 2sls earnings_log edu_degree (Obesity = Obesity_family)if sex ==2, vce(robust)
estat endogenous 
*reject the null hypothesis: variables are exogenous
estat firststage, all forcenonrobust
*cannot reject the null hypothesis of weak instruments


ivregress 2sls earnings_log edu_degree (bmicalc = Obesity_family)if sex ==2, vce(robust)
estat endogenous 
*reject the null hypothesis: variables are exogenous
estat firststage, all forcenonrobust
*cannot reject the null hypothesis of weak instruments


*(2)
ivregress 2sls earnings_log edu_degree Northeast North_Central_or_Midwest South ///
married divorced never_married white Managerial_Professional Technical_Sales_Administrative ///
Service Operators_Fabricators_Laborers Private (Obesity = Obesity_family) if sex ==2, vce(robust)
estat endogenous 
*endogenous
estat firststage, all forcenonrobust
*cannot reject the null hypothesis of weak instruments


ivregress 2sls earnings_log edu_degree Northeast North_Central_or_Midwest South ///
married divorced never_married white Managerial_Professional Technical_Sales_Administrative ///
Service Operators_Fabricators_Laborers Private (bmicalc = Obesity_family) if sex ==2, vce(robust)
estat endogenous 
*endogenous
estat firststage, all forcenonrobust
*cannot reject the null hypothesis of weak instruments



*(4)
ivregress 2sls earnings_log underweight normalweight edu_degree (Obesity = Obesity_family) if sex ==2, vce(robust)
estat endogenous 
*endogenous
estat firststage, all forcenonrobust
*cannot reject the null hypothesis of weak instruments

ivregress 2sls earnings_log underweight normalweight edu_degree (bmicalc = Obesity_family) if sex ==2, vce(robust)
estat endogenous 
*endogenous
estat firststage, all forcenonrobust











*(1)
ivregress 2sls earnings_log edu_degree (Obesity = bmi_family), vce(robust)
estat endogenous 
*reject the null hypothesis: variables are exogenous
estat firststage, all forcenonrobust
*cannot reject the null hypothesis of weak instruments


ivregress 2sls earnings_log edu_degree (bmicalc = bmi_family), vce(robust)
estat endogenous 
*reject the null hypothesis: variables are exogenous
estat firststage, all forcenonrobust
*cannot reject the null hypothesis of weak instruments


*(2)
ivregress 2sls earnings_log edu_degree Northeast North_Central_or_Midwest South ///
married divorced never_married white Managerial_Professional Technical_Sales_Administrative ///
Service Operators_Fabricators_Laborers Private (Obesity = bmi_family), vce(robust)
estat endogenous 
*endogenous
estat firststage, all forcenonrobust
*cannot reject the null hypothesis of weak instruments


ivregress 2sls earnings_log edu_degree Northeast North_Central_or_Midwest South ///
married divorced never_married white Managerial_Professional Technical_Sales_Administrative ///
Service Operators_Fabricators_Laborers Private (bmicalc = bmi_family), vce(robust)
estat endogenous 
*endogenous
estat firststage, all forcenonrobust
*cannot reject the null hypothesis of weak instruments



*(4)
ivregress 2sls earnings_log underweight normalweight edu_degree (Obesity = bmi_family), vce(robust)
estat endogenous 
*endogenous
estat firststage, all forcenonrobust
*cannot reject the null hypothesis of weak instruments

ivregress 2sls earnings_log underweight normalweight edu_degree (bmicalc = bmi_family), vce(robust)
estat endogenous 
*endogenous
estat firststage, all forcenonrobust
*cannot reject the null hypothesis of weak instruments













*(1)
ivregress 2sls earnings_log edu_degree (Obesity = Obesity_family), vce(robust)
estat endogenous 
*reject the null hypothesis: variables are exogenous
estat firststage, all forcenonrobust
*cannot reject the null hypothesis of weak instruments


ivregress 2sls earnings_log edu_degree (bmicalc = Obesity_family), vce(robust)
estat endogenous 
*reject the null hypothesis: variables are exogenous
estat firststage, all forcenonrobust
*cannot reject the null hypothesis of weak instruments


*(2)
ivregress 2sls earnings_log edu_degree Northeast North_Central_or_Midwest South ///
married divorced never_married white Managerial_Professional Technical_Sales_Administrative ///
Service Operators_Fabricators_Laborers Private (Obesity = Obesity_family), vce(robust)
estat endogenous 
*endogenous
estat firststage, all forcenonrobust
*cannot reject the null hypothesis of weak instruments


ivregress 2sls earnings_log edu_degree Northeast North_Central_or_Midwest South ///
married divorced never_married white Managerial_Professional Technical_Sales_Administrative ///
Service Operators_Fabricators_Laborers Private (bmicalc = Obesity_family), vce(robust)
estat endogenous 
*endogenous
estat firststage, all forcenonrobust
*cannot reject the null hypothesis of weak instruments



*(4)
ivregress 2sls earnings_log underweight normalweight edu_degree (Obesity = Obesity_family), vce(robust)
estat endogenous 
*endogenous
estat firststage, all forcenonrobust
*cannot reject the null hypothesis of weak instruments

ivregress 2sls earnings_log underweight normalweight edu_degree (bmicalc = Obesity_family), vce(robust)
estat endogenous 
*endogenous
estat firststage, all forcenonrobust
*cannot reject the null hypothesis of weak instruments


