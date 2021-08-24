# class_converter


####################################################################################
### remove columns 
#####################################################################################

int_students_total <- int_students_total %>%
  dplyr::select(-email,-ip_address)



####################################################################################
### fix numbers 
#####################################################################################


#some variables make more sense as numbers, this step converts them back to numbers
int_students_total[,c("survey_time_secs","age","months_in_taiwan")] <- data.frame(apply(int_students_total[,c("survey_time_secs","age","months_in_taiwan")], 2,as.numeric))


#in case we want to look at response date sometime later,let's convert survey_time to a date-time format
require(lubridate)
int_students_total$survey_time <- ymd_hms(int_students_total$survey_time)



####################################################################################
### make factors
#####################################################################################

#step 1
#convert all the characters into factors
# this turns all character vectors into either ordered or unordered factors
#source: https://gist.github.com/ramhiser/93fe37be439c480dc26c4bed8aab03dd 
int_students_total <- int_students_total %>% mutate(across(where(is.character),factor))

#step 2 
#add levels to the factors where it makes sense to do so

#this helps us look at stuff
#int_students_total%>% dplyr::select(dplyr::contains("opn") & !dplyr::contains("measures") & !dplyr::contains("best") & !dplyr::contains("worst") & !dplyr::contains("country")) %>% summary()


int_students_total%>%
  dplyr::select(dplyr::contains("bvr") | dplyr::contains("hist") & !dplyr::contains("twtravel") & !dplyr::contains("contactw14days") ) %>% summary()

# This is where we actually change the columns into ordered factors
# this is important because otherwise R doesn't know that always is more frequent than never
# unless we tell R otherwise R will treat "always" and "never" the same like colors (yellow isn't more than blue)


#this creates a function that sets the levels we want
f1<- function(x){
  y <- factor(x,levels = c("strongly disagree",
                      "disagree",
                      "neutral",
                      "agree",
                      "strongly agree"))
  y
}


# this applys our function to all the columns containing the key phrases we want
# ! is a way of saying things that don't contain the phrase 
# i.e. !contains("measures) finds columns that don't contain "measures"
# | means or and & means and
# accross selects all the columns where our and/or text match conditions are true
# mutate is the verb that applies the function f1 to the columns we selected 

int_students_total <- int_students_total%>%
  mutate(
    across(contains("opn") & 
         !contains("measures") & 
         !contains("best") & 
         !dplyr::contains("worst") & 
         !contains("country"),
         f1))





# This repeats what we did above with a different set of labels

#first the new function
f2<- function(x){
  y <- factor(x,levels = c("never",
                           "seldom",
                           "sometimes",
                           "often",
                           "always"))
  y
} 

#then we apply the function
int_students_total <- int_students_total%>%
  mutate(
    across(dplyr::contains("bvr") |
             dplyr::contains("hist") & 
             !dplyr::contains("twtravel") & 
             !dplyr::contains("contactw14days") ,
           f2))



