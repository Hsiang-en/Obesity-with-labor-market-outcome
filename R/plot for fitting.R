library(haven)
treatment <- read_dta("treatment.dta")


treatment <- mutate(treatment, bmi=bmicalc)

treatment <- mutate(treatment, Sex=ifelse(sex==2,1,0))

treatment$Sex <- factor(treatment$Sex, levels=c(0, 1), labels=c("male","female"))


plot1 <- ggplot(treatment, aes(x=bmi, y=earnings_log, linetype=Sex)) + geom_smooth(color="darkgray",se=FALSE) + theme(axis.text.x = element_text(angle = 45),legend.position="bottom")+xlab("BMI") + scale_x_continuous(limits =c(13,55),breaks = c(15,20,25,30,35,40,45,50,55)) 
plot1

fit <- glm(treatment$earnings_log ~ treatment$bmi, family=quasi(link="identity",variance="mu"))

plot2 <- ggplot(treatment, aes(linetype=female)) + geom_smooth(aes(y=earnings_log, x=fit$fitted.values),se=FALSE)
plot2

library(openxlsx)

# for writing a data.frame or list of data.frames to an xlsx file
write.xlsx(forplot, "Documents/勞經/forplot.xlsx")