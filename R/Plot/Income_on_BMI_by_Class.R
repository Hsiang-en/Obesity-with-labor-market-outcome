library(haven)
Descriptive <- read_dta("Documents/勞經/Descriptive.dta")

#View(Descriptive)
Descriptive$sex <- factor(Descriptive$sex, levels=c(1, 2), labels=c("male", "female"))

male <- filter(Descriptive, sex=="male")
female <- filter(Descriptive, sex=="female")

male1<- filter(male, BMI_standard==1)
male1<- mutate(male1,amount=n())
male2<- filter(male, BMI_standard==2)
male2<- mutate(male2,amount=n())
male3<- filter(male, BMI_standard==3)
male3<- mutate(male3,amount=n())
male4<- filter(male, BMI_standard==4)
male4<- mutate(male4,amount=n())
male5<- filter(male, BMI_standard==5)
male5<- mutate(male5,amount=n())
male6<- filter(male, BMI_standard==6)
male6<- mutate(male6,amount=n())
male7<- filter(male, BMI_standard==7)
male7<- mutate(male7,amount=n())

female1<- filter(female, BMI_standard==1)
female1<- mutate(female1,amount=n())
female2<- filter(female, BMI_standard==2)
female2<- mutate(female2,amount=n())
female3<- filter(female, BMI_standard==3)
female3<- mutate(female3,amount=n())
female4<- filter(female, BMI_standard==4)
female4<- mutate(female4,amount=n())
female5<- filter(female, BMI_standard==5)
female5<- mutate(female5,amount=n())
female6<- filter(female, BMI_standard==6)
female6<- mutate(female6,amount=n())
female7<- filter(female, BMI_standard==7)
female7<- mutate(female7,amount=n())

male=bind_rows(male1, male2, male3, male4, male5, male6, male7)
male<- mutate(male, count=n())
female=bind_rows(female1, female2, female3, female4, female5, female6, female7)
female<- mutate(female, count=n())
df=bind_rows(male, female)
df<-mutate(df, per=amount/count)

df$BMI_standard <- factor(df$BMI_standard, levels=c(1, 2, 3, 4, 5, 6, 7), labels=c("15-16","16-18.5","18.5-25","25-30","30-35","35-40","40-"))


plot1 <- ggplot(df, aes(x=BMI_standard, y=per), groupNames="class") + geom_col(fill="darkblue",colour="lightskyblue1") + facet_wrap(~sex)
plot1

plot2 <- ggplot(Descriptive, aes(x=BMI_standard), groupNames="class") + geom_histogram(fill="darkblue",colour="lightskyblue1") + scale_y_continuous(labels = scales::percent) + facet_wrap(~sex)
plot2


