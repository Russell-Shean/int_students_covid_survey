library(ggplot2)

ggplot(data = int_students_total)+
  geom_bar(aes(x=date(survey_time),
           fill=university2))+
  theme_bw()+
  ggtitle("Survey Responses by Day")+
  xlab("Date of Response")+
  ylab("Number of Responses")+ 
  guides(fill=guide_legend(title="University"))


plot2 <- int_students_total %>%
  filter(survey_time > "2021-06-01")%>%
ggplot()+
  geom_bar(aes(x=date(survey_time),
               fill=university2))+
  theme_bw()+
  #ggtitle("Survey Responses by Day")+
  xlab("Date of Response")+
  ylab("Number of Responses")+ 
  guides(fill=guide_legend(title="University")) +
  theme(legend.direction='horizontal',
        legend.position = "top")

plot1 <- int_students_total %>%
  filter(survey_time > "2021-06-01")%>%
  ggplot()+
  geom_bar(aes(x=date(survey_time),
               fill=july_survey))+
  theme_bw()+
  #ggtitle("Survey Responses by Day")+
  xlab("Date of Response")+
  ylab("Number of Responses")+ 
  guides(fill=guide_legend(title="Did you fill out the July survey?"))+
  theme(legend.direction='horizontal',
        legend.position = "top")


library(ggpubr)


ggarrange(plotlist = list(plot1,plot2),nrow = 2)


#step 4 
## make a frequency chart


schools.chart <- schools %>% 
  filter(university == "tmu") %>%
  ggplot(aes(x= university, fill= july_survey))+
  geom_bar()+
  geom_text(stat='count', aes(label = ..count..), vjust= 1.5)+
  ggtitle("Number of respondents from TMU who filled out the international students COVID-19 survey round 3", subtitle = "Stratified by if they already responded to the July Survey")

#this displays the chart
schools.chart