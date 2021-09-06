# covid cases
#this imports  covid case counts from the Taiwan CDC website

#and then calculates a previous 14 days field

#Covid JSon 

library(rjson)
library(jsonlite)
library(dplyr)

# this imports covid data directly from Taiwan CDC website
# https://data.cdc.gov.tw/dataset/aagsdctable-day-19cov
# this website is updated daily, so this will automatically download the most recent numbers
covid_cases <- fromJSON("https://od.cdc.gov.tw/eic/Day_Confirmation_Age_County_Gender_19CoV.json", flatten=TRUE)

#rename variables with English names
# because Chinese characters and encoding
# are a huge pains in scripts
# we can Chinese labels back later if needed

colnames(covid_cases) <- c("disease_type",
                           "assigned_onset_date",
                           "city",
                           "district",
                           "sex",
                           "imported",
                           "age_range",         
                           "case_count")

#makes site id column, because there are about 22 zhongzheng
# districts, one for each city/county in Taiwan
covid_cases$site_id <- paste(covid_cases$city, 
                             covid_cases$district, 
                             sep = "")

# convert Taiwan CDC dates into a Date format that R 
# recognizes 

library(lubridate)
covid_cases$assigned_onset_date <- as.Date(covid_cases$assigned_onset_date, format = "%Y/%m/%d")

#changes case count to a number 
covid_cases$case_count <- as.numeric(covid_cases$case_count)

# aggregate cases by date because for this we don't care about district, age, sex, etc
covid_cases_total <- aggregate(case_count~assigned_onset_date, data = covid_cases, FUN = sum)

#aggregate only domestic cases (no idea what "none" means, but I'm assuming it means a domestic case?)
covid_cases_domestic <- aggregate(case_count~assigned_onset_date+imported, data = covid_cases, FUN = sum)
covid_cases_domestic <- covid_cases_domestic %>% filter(imported !="是")





##################################################################################################
###########   This makes a function to calculate cumulative prevalence ##############################
####################################################################################################

prevalator <- function(df= covid_cases_total){
  
  require(lubridate)
  require(dplyr)
  
  #This makes a sequence between the minimum and max dates in the data set
  # this is needed so that we can assign zeros to dates without any covid cases
  date_range <- seq(from= min(df$assigned_onset_date,
                              na.rm = TRUE),
                    to= max(df$assigned_onset_date,
                            na.rm = TRUE),
                    by="days")
  
  firstcase_date <- min(df$assigned_onset_date,
                        na.rm = TRUE)
  
  date_range_df <- data.frame(assigned_onset_date=date_range)


  
  
  df <- df %>%
    dplyr::full_join(date_range_df,
                     by = c("assigned_onset_date"="assigned_onset_date"))
  

  
  df$case_count <- ifelse(is.na(df$case_count), 0, df$case_count)
  
  

  
 df <- df %>% 
   dplyr::arrange(assigned_onset_date)
  
df


  

  
  date_indexes <- list()
  

  
  
  for (i in seq_along(date_range)) {
    n <- df$assigned_onset_date[i]-14
    date_indexes[[i]]<-  seq(from=n, length.out= 14, by="day" )               
  }
  

  
  
  previous_14days <- vector()
  
  

  for (t in 1:585) {
    previous_14days<- c(previous_14days, sum(df[df$assigned_onset_date %in% date_indexes[[t]],]$case_count))
  }
  


df <- cbind(df, previous_14days)
  
}



covid_cases_total <- prevalator(covid_cases_total)

int_students_total$survey_date <- date(int_students_total$survey_time)

balls <- left_join(int_students_total, covid_cases_total, by =c("survey_date"="assigned_onset_date"))
  
 