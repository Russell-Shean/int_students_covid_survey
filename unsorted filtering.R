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
  


  
  
  