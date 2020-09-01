#設定檔案位置
setwd("/Users/shawn/Documents/勞經")

#讀取資料
install.packages("haven")
yes
library(haven)
data_dta <- read_dta("/Users/shawn/Documents/勞經/drive-download-20200604T124241Z-001/Descriptive.dta")
#View(data_dta)

#生成不同性別的組別
male <- summarise(data_dta, male = ifelse(sex == 1, 1, 0), bmi = BMI_interval)
male <- mutate(female = ifelse(sex == 2, 1, 0))
male <- filter(male, male == 1)
female <- summarise(data_dta, female = ifelse(sex == 2, 1, 0), bmi = BMI_interval)
female <- mutate(male = ifelse(sex == 1, 1, 0))
female <- filter(female, female == 1)

#生成percentage
male <- mutate(male, n=n())
female <- mutate(female, n=n())

male_2 <- summarise(male, bmi = ifelse(bmi == 2, bmi, 0))
male_2 <- filter(male, bmi ==2)
male_2 <- mutate(male_2, nn = n())

male_3 <- summarise(male, bmi = ifelse(bmi == 3, bmi, 0))
male_3 <- filter(male, bmi ==3)
male_3 <- mutate(male_3, nn = n())

male_4 <- summarise(male, bmi = ifelse(bmi == 4, bmi, 0))
male_4 <- filter(male, bmi ==4)
male_4 <- mutate(male_4, nn = n())

male_5 <- summarise(male, bmi = ifelse(bmi == 5, bmi, 0))
male_5 <- filter(male, bmi ==5)
male_5 <- mutate(male_5, nn = n())

male_6 <- summarise(male, bmi = ifelse(bmi == 6, bmi, 0))
male_6 <- filter(male, bmi ==6)
male_6 <- mutate(male_6, nn = n())

male_7 <- summarise(male, bmi = ifelse(bmi == 7, bmi, 0))
male_7 <- filter(male, bmi ==7)
male_7 <- mutate(male_7, nn = n())

male_1 <- summarise(male, bmi = ifelse(bmi == 1, bmi, 0))
male_1 <- filter(male, bmi ==1)
male_1 <- mutate(male_1, nn = n())

male <- bind_rows(male_1, male_2, male_3, male_4, male_5, male_6, male_7)





female_2 <- summarise(female, bmi = ifelse(bmi == 2, bmi, 0))
female_2 <- filter(female, bmi ==2)
female_2 <- mutate(female_2, nn = n())

female_3 <- summarise(female, bmi = ifelse(bmi == 3, bmi, 0))
female_3 <- filter(female, bmi ==3)
female_3 <- mutate(female_3, nn = n())

female_4 <- summarise(female, bmi = ifelse(bmi == 4, bmi, 0))
female_4 <- filter(female, bmi ==4)
female_4 <- mutate(female_4, nn = n())

female_5 <- summarise(female, bmi = ifelse(bmi == 5, bmi, 0))
female_5 <- filter(female, bmi ==5)
female_5 <- mutate(female_5, nn = n())

female_6 <- summarise(female, bmi = ifelse(bmi == 6, bmi, 0))
female_6 <- filter(female, bmi ==6)
female_6 <- mutate(female_6, nn = n())

female_7 <- summarise(female, bmi = ifelse(bmi == 7, bmi, 0))
female_7 <- filter(female, bmi ==7)
female_7 <- mutate(female_7, nn = n())

female_1 <- summarise(female, bmi = ifelse(bmi == 1, bmi, 0))
female_1 <- filter(female, bmi ==1)
female_1 <- mutate(female_1, nn = n())

female <- bind_rows(female_1, female_2, female_3, female_4, female_5, female_6, female_7)

male <- mutate(male, percentage = nn / n)
female <- mutate(female, percentage = nn / n)
male <- mutate(male, sex = 1)
female <- mutate(female, sex =2)

data_dta <- bind_rows(male, female)

print(percentage)

plot1 <- ggplot(data_dta, aes(x=bmi, y=percentage)) + geom_col(fill="lightskyblue1") + facet_wrap(~sex) 
plot1



