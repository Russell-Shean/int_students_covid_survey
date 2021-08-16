# date spliter

date.spliter <- function(df,var){
  
  #this creates two new variables where we'll store the response date and time
  #for now we fill it with a random filler variable
  df$response_date <- "peanut_butter"
  df$response_time <- "peanut_butter"
  
  #this splits all the dates at the space between the date and the number and puts them in a list
  require(stringr)
  responses <- str_split(df[,var]," ")
  
  #this builds a loop to put the date for each entry into the df$response_date column (replacing "peanut butter")
  for(i in 1:nrow(df)){
    df$response_date[i] <- responses[[i]][1]
  }
  
  #this builds a loop to do the same thing for time
  for(i in 1:nrow(df)){
    df$response_time[i] <- responses[[i]][2]
  }
}

date.spliter(int_students_total,"survey_time")
