# variable merger



######################################################################################################
# step 1 force everything to lower case and remove white space
# for all user typed responses
# we can run the response back through python or something to change capitalization later
#########################################################################################

# First we're going to use an apply statement to apply a function to a bunch of different columns at the same time
# i.e. do the same thing to multiple columns at the same time

#this step converts everything to lowercase text
int_students_total <- data.frame(apply(int_students_total, 2,tolower))


#this step removes white space at beginning and end of string
#and reduces white space between words to one space
require(stringr)
int_students_total <- data.frame(apply(int_students_total, 2,str_squish))

####################################################################################
### fix numbers 
#####################################################################################


#some variables make more sense as numbers, this step converts them back to numbers
int_students_total[,c("survey_time_secs","age","months_in_taiwan")] <- data.frame(apply(int_students_total[,c("survey_time_secs","age","months_in_taiwan")], 2,as.numeric))


#in case we want to look at response date sometime later, let's convert survey_time to a date-time format
require(lubridate)
int_students_total$survey_time <- ymd_hms(int_students_total$survey_time)

#################################################################################
# variable specific fixes 
################################################################################

# 1. university

# Taipei Medical University fixes
int_students_total[int_students_total$university=="taipeimedicaluniversity",]$university <- "taipei medical university"
int_students_total[int_students_total$university=="tmu",]$university <- "taipei medical university"
int_students_total[int_students_total$university=="taipei medical universty",]$university <- "taipei medical university"
int_students_total[int_students_total$university=="taipei medical universitu",]$university <- "taipei medical university"
int_students_total[int_students_total$university=="taipei medial university",]$university <- "taipei medical university"
int_students_total[int_students_total$university=="taipei medical univeristy",]$university <- "taipei medical university"
int_students_total[int_students_total$university=="tmu taipei",]$university <- "taipei medical university"
int_students_total[int_students_total$university=="tmu taiwan",]$university <- "taipei medical university"
int_students_total[int_students_total$university=="tmu college of oral medicine, school of dentistry",]$university <- "taipei medical university"

## This is an absolutely terrible terrible terrible way to get around encoding issues I'm having
## the real solution is to take the time to figure out my encoding setting in windows, excel, survey cake, rstudio and rstudio's source() function
## and then make sure all the files are saved with consistant encoding
## or switch to linux lol

#anywho, my terrible terrible hack is to match as many other variables as possible and rename the chinese version of 
#taipei medical as taipei medical university using the respondent's other info
# this is a terrible way to do it because it requires the order of respondents in the first survey round to never change
int_students_total[100,]$university <- "taipei medical university"



#National Taiwan University fixes
int_students_total[int_students_total$university=="national taiwan university.",]$university <- "national taiwan university"
int_students_total[int_students_total$university=="ntu",]$university <- "national taiwan university"

#this creates three categories of university TMU, NTU and other
int_students_total$university2 <- "peanut_butter"

int_students_total[int_students_total$university=="national taiwan university",]$university2 <- "NTU"
int_students_total[int_students_total$university=="taipei medical university",]$university2 <- "TMU"
int_students_total[int_students_total$university!="taipei medical university" &
                   int_students_total$university!="national taiwan university",]$university2 <- "Other"





#this makes a frequency table of universities
table(int_students_total$university2) 


# 2. Country of origin 
# Not all issues are resolved here
# for example, I don't know where ut is (probably the US mistyped but hard to say for sure)
# likewise I'm not going to guess that vn = vietnam

#united states
int_students_total[int_students_total$country_origin=="the united states",]$country_origin <- "united states"
int_students_total[int_students_total$country_origin=="usa",]$country_origin <- "united states"
int_students_total[int_students_total$country_origin=="us.",]$country_origin <- "united states"
int_students_total[int_students_total$country_origin=="the united states.",]$country_origin <- "united states"
int_students_total[int_students_total$country_origin=="us",]$country_origin <- "united states"

#thailand
int_students_total[int_students_total$country_origin=="thai",]$country_origin <- "thailand"

#vietnam
int_students_total[int_students_total$country_origin=="vietnamese",]$country_origin <- "vietnam"
int_students_total[int_students_total$country_origin=="viet nam",]$country_origin <- "vietnam"
#repeat of bad hack from above: 
int_students_total[100,]$country_origin <- "vietnam"


#united kingdom
int_students_total[int_students_total$country_origin=="uk",]$country_origin <- "united kingdom"
int_students_total[int_students_total$country_origin=="britain",]$country_origin <- "united kingdom"



#india
int_students_total[int_students_total$country_origin=="indian",]$country_origin <- "india"

#philippines
int_students_total[int_students_total$country_origin=="pilippines",]$country_origin <- "philippines"

#eswatini
int_students_total[int_students_total$country_origin=="swaziland",]$country_origin <- "eswatini"



# 3. Other race or ethnicity
# here we're going to be pretty conservative about combining categories

#west african
int_students_total[int_students_total$ethnicity_other=="western african",]$ethnicity_other <- "west african"

#micronesian
int_students_total[int_students_total$ethnicity_other=="micronesia",]$ethnicity_other <- "micronesian"


# 4. Health background

# There are a lot of different ways of saying you're a doctor
# we'll need to figure out how best to combine all these

table(int_students_total$health_background_type, useNA = "ifany")

# 5. Chronic comorbidities

# this also needs a decision about how best to combine
# Are chronic kidney disease, chronic renal insufficiency and kidney disease similiar enough to combine
# in one category?

table(int_students_total$comordidities_type, useNA = "ifany")


# 6 

