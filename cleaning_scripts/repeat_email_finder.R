email.repeats  <- int_students_total %>% count(email, sort = TRUE) %>% filter(!is.na(email),n > 1, email != "yes")

email.repeats


repeats <- int_students_total %>% 
  filter(email %in% email.repeats$email) %>% 
  arrange(email) %>% relocate(survey_time:university2, .before = everything()) %>% 
  select(-gender_other,-gender_other_type) 
