library(readxl)
hi <- read_excel("hi.xlsx", 
                 col_types = c("text", "numeric", "numeric", 
                               "numeric"))
#View(Descriptive)

hi <- mutate(hi, female=ifelse(sex=="female",1,0))

hi$female <- factor(hi$female, levels=c(0, 1), labels=c("male","female"))
hi$standard <- factor(hi$standard, levels=c(1, 2, 3, 4, 5, 6, 7), labels=c("15-16","16-18.5","18.5-25","25-30","30-35","35-40","40-"))


plot1 <- ggplot(hi, aes(x=standard, y=per)) + geom_col(fill="darkgray") + theme(axis.text.x = element_text(angle = 30, hjust = 1)) + facet_wrap(~female)+xlab("BMI at interval") + ylab("density")
plot1

library(openxlsx)

# for writing a data.frame or list of data.frames to an xlsx file
write.xlsx(forplot, "Documents/勞經/forplot.xlsx")
