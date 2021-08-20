## Exclusion criteria

library(dplyr)

# This filters to just round 3 sumbmissions from TMU
# and removes blank email or answer of yes

round_3 <- int_students_total %>%
  filter(survey_round=="round_3",  
         university2=="TMU",
         email != "yes",
         email != "") %>%  
  arrange(survey_time) %>%
  slice(1:51)
  

#This looks for repeat IP and email address

table(round_3$email) %>% View()


winners <- round_3 %>% 
  select(email, survey_time)%>%
  arrange(survey_time) %>%
  distinct(email, .keep_all = TRUE)

write.csv(winners, file = "winners.csv")


# one repeated email, let's see if responses are similiar

write.csv(round_3[round_3$email=="m850109005@tmu.edu.tw",], file = "./data/repeat_email.csv")

# repeat response 

# ip address

table(round_3$ip_address) %>% View(
)






range(round_3$survey_time)


table(round_3$university)


check_check <- rowall_row_all(round_3)


