#設定檔案位置
setwd("/Users/shawn/Documents/勞經")

#讀取資料
#install.packages("haven")
library(haven)
data_dta <- read_dta("/Users/shawn/Documents/勞經/drive-download-20200604T124241Z-001/Descriptive.dta")
#View(data_dta)

#同STATA summary
#summary(data_dta)

#安裝dplyr檔
#install.packages("dplyr")
library(dplyr)

#分辨公私部門的條件變數
data_dta <- mutate(data_dta, male_private = ifelse(sex ==1 & Private == 1, 1, 0 ))
data_dta <- mutate(data_dta, male_nonprivate = ifelse(sex ==1 & Private == 0, 1, 0 ))
data_dta <- mutate(data_dta, female_private = ifelse(sex ==2 & Private == 1, 1, 0 ))
data_dta <- mutate(data_dta, female_nonprivate = ifelse(sex ==2 & Private == 0, 1, 0 ))
savehistory("sector.R")
save(data_dta, file="sector.Rdata")

#性別的dummy
data_dta <- mutate(data_dta, male = ifelse(sex==1, 1, 0))

#生成一個較小的dataframe 
sum1 <- summarise(data_dta, id=ifelse(male_private ==1, nhishid, 0), earnings = ifelse(male_private ==1, earnings, 0))
sum1 <- mutate(sum1, class=1)
sum1 <- filter(sum1, id >0)
View(sum1)
sum2<- summarise(data_dta, id=ifelse(male_nonprivate ==1, nhishid, 0), earnings = ifelse(male_nonprivate==1, earnings, 0))
sum2 <- mutate(sum2, class=2)
sum2 <- filter(sum2, id>0)
View(sum2)
sum3<- summarise(data_dta, id=ifelse(female_private ==1, nhishid, 0), earnings = ifelse(female_private ==1, earnings, 0))
sum3 <- mutate(sum3, class=3)
sum3 <- filter(sum3, id> 0)
View(sum3)
sum4<- summarise(data_dta, id=ifelse(female_nonprivate ==1, nhishid, 0), earnings= ifelse(female_nonprivate ==1, earnings, 0))
sum4 <- mutate(sum4, class=4)
sum4 <- filter(sum4, id>0)
View(sum4)


#合併summary檔案
summary <- bind_rows(sum1, sum2, sum3, sum4)
summary <- arrange(summary, id)
View(summary)

#加上value labels
summary$class <- factor(summary$class, levels=c(1, 2, 3, 4), labels=c("male in private sector", "male not in private sector", "female in private sector", "female not in private sector"))

#作圖
#install.packages("ggplot2")
library(ggplot2)
#看分組的情況
plot1 <- ggplot(summary, aes(x=earnings), groupNames="class") + geom_histogram(fill="lightskyblue1",colour="black") + facet_wrap(~class)
plot1

# kernal density plot
plot2 <- ggplot(summary, aes(x=earnings), groupNames="class") + geom_density(fill="lightskyblue1",colour="darkblue") + geom_vline(xintercept= c(1,5000, 10000, 15000, 20000, 25000, 35000, 45000, 55000, 65000, 75000) ,color="gray", linetype="dashed") + facet_wrap(~class)
plot2

#增加要放進迴歸的控制變數
summary_m <- summarise(data_dta, id=nhishid, bmi=bmicalc, famsize= famsize, yearsonjob= yearsonjob, edu= edu_degree, Normalweight = normalweight, Obesity= Obesity, earnings_log = earnings_log, underweight= underweight, overweight= overweight, Northeast= Northeast, North_Central_or_Midwest = North_Central_or_Midwest, South = South, married = married, divorced = divorced, never_married = never_married, white=white, black=Black, high_school= high_school, college= college, banchelor= Banchelor, master= Master, professional = Professional, doctoral = Doctoral, Managerial_Professional = Managerial_Professional, Technical_Sales_Administrative = Technical_Sales_Administrative, Service= Service, Operators_Fabricators_Laborers= Operators_Fabricators_Laborers, Private = Private, Public = Public, Self_employed = Self_employed, age = age, educ=educ)
summary_mn = full_join(summary, summary_m, by = ("id"))

#scenario
plot3 <- ggplot(summary_mn, aes(x=bmi, y=earnings), groupNames="class") + ggtitle("Earnings on body size by gender and sector") + geom_smooth(se= FALSE, colour="lightskyblue1") + facet_wrap(~class)
plot3

#分組迴歸，抽出原本的dataset
group1 <- filter(summary_mn, class == "male in private sector")
group2 <- filter(summary_mn, class == "male not in private sector")
group3 <- filter(summary_mn, class == "female in private sector")
group4 <- filter(summary_mn, class == "female not in private sector")

#regression
#install.packages("hdm")
library(hdm)

#regression
#model 1: Only consider BMI
#model 2: Consider BMI and educational degree
#model 3 & 4: Consider several personal characteristic 
#model5: Consider different BMI-interval

#regression for group 1
reg11 <- lm(earnings_log~bmi, data=group1)
summary(reg11)
reg12 <- lm(earnings_log~bmi+edu, data=group1)
summary(reg12)
reg13 <- lm(earnings_log~bmi+famsize+yearsonjob+Obesity+Northeast+North_Central_or_Midwest+South+married+divorced+never_married+white+black+high_school+college+banchelor+master+professional+doctoral+Managerial_Professional+Technical_Sales_Administrative+Service+Operators_Fabricators_Laborers+Private+Public+Self_employed+age, data=group1)
summary(reg13)
reg14 <- lm(earnings_log~bmi+famsize+yearsonjob+edu+Obesity+Northeast+North_Central_or_Midwest+South+married+divorced+never_married+white+black+Managerial_Professional+Technical_Sales_Administrative+Service+Operators_Fabricators_Laborers+Private+Public+Self_employed+age, data=group1)
summary(reg14)
reg15 <- lm(earnings_log~bmi+Obesity+underweight+Normalweight, data=group1)
summary(reg15)

#regression for group 2
reg21 <- lm(earnings_log~bmi, data=group2)
summary(reg21)
reg22 <- lm(earnings_log~bmi+edu, data=group2)
summary(reg22)
reg23 <- lm(earnings_log~bmi+famsize+yearsonjob+Obesity+Northeast+North_Central_or_Midwest+South+married+divorced+never_married+white+black+high_school+college+banchelor+master+professional+doctoral+Managerial_Professional+Technical_Sales_Administrative+Service+Operators_Fabricators_Laborers+Private+Public+Self_employed+age, data=group2)
summary(reg23)
reg24 <- lm(earnings_log~bmi+famsize+yearsonjob+edu+Obesity+Northeast+North_Central_or_Midwest+South+married+divorced+never_married+white+black+Managerial_Professional+Technical_Sales_Administrative+Service+Operators_Fabricators_Laborers+Private+Public+Self_employed+age, data=group2)
summary(reg24)
reg25 <- lm(earnings_log~bmi+Obesity+underweight+Normalweight, data=group2)
summary(reg25)

#regression for group 3
reg31 <- lm(earnings_log~bmi, data=group3)
summary(reg31)
reg32 <- lm(earnings_log~bmi+edu, data=group3)
summary(reg32)
reg33 <- lm(earnings_log~bmi+famsize+yearsonjob+Obesity+Northeast+North_Central_or_Midwest+South+married+divorced+never_married+white+black+high_school+college+banchelor+master+professional+doctoral+Managerial_Professional+Technical_Sales_Administrative+Service+Operators_Fabricators_Laborers+Private+Public+Self_employed+age, data=group3)
summary(reg33)
reg34 <- lm(earnings_log~bmi+famsize+yearsonjob+edu+Obesity+Northeast+North_Central_or_Midwest+South+married+divorced+never_married+white+black+Managerial_Professional+Technical_Sales_Administrative+Service+Operators_Fabricators_Laborers+Private+Public+Self_employed+age, data=group3)
summary(reg34)
reg35 <- lm(earnings_log~bmi+Obesity+underweight+Normalweight, data=group3)
summary(reg35)

#regression for group 4
reg41 <- lm(earnings_log~bmi, data=group4)
summary(reg41)
reg42 <- lm(earnings_log~bmi+edu, data=group4)
summary(reg42)
reg43 <- lm(earnings_log~bmi+famsize+yearsonjob+Obesity+Northeast+North_Central_or_Midwest+South+married+divorced+never_married+white+black+high_school+college+banchelor+master+professional+doctoral+Managerial_Professional+Technical_Sales_Administrative+Service+Operators_Fabricators_Laborers+Private+Public+Self_employed+age, data=group4)
summary(reg43)
reg44 <- lm(earnings_log~bmi+famsize+yearsonjob+edu+Obesity+Northeast+North_Central_or_Midwest+South+married+divorced+never_married+white+black+Managerial_Professional+Technical_Sales_Administrative+Service+Operators_Fabricators_Laborers+Private+Public+Self_employed+age, data=group4)
summary(reg44)
reg45 <- lm(earnings_log~bmi+Obesity+underweight+Normalweight, data=group4)
summary(reg45)


