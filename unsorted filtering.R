summary(int_students_total)

natabler <- function(x){table(x,useNA = "ifany")}


require(purrr)
require(lubridate)

int_students <- int_students_total %>% 
  dplyr::select(-all_of(c("email","ip_address")))%>%
  select_if(negate(is.numeric))%>%
  select_if(negate(is.Date))%>%
  select_if(negate(is.POSIXct))

  
  
  
  
  apply(int_students,2, natabler)

  


  table(int_students$hist_contactw14days_type,useNA = "ifany") %>% View()

  
  head(int_students$hist_contactw14days_type)  
  
  
  
  #here's a cool trick from stackoverflow:  https://stackoverflow.com/questions/35610437/using-dplyr-to-conditionally-replace-values-in-a-column
  #We're going to use it to replace all the "" values with NA
  #Why survey cake thought "" was a useful replacement for NA is beyond me
  #It's probably also possible to specify that "" should be read in as NA during the read.csv() step, so if this is really slow, we'll try that
  
  
  ubt <- int_students_total %>% 
    mutate(hist_contactw14days_type = replace(hist_contactw14days_type, hist_contactw14days_type == "", NA)))


ubt <- int_students_total[ int_students_total == "" ] <- "Peanut butter"
  
  
  
  
  
ubt <-  int_students_total %>% 
  mutate(across(everything() & !survey_time, ~replace(., . == "", NA)))
  
  #that worked on one columns so now let's make a function out of it and apply it to all the columns
  
  blank_toNA_converter <- function(x){
    require(dplyr)
    
    
    
  }
  
  
  
  