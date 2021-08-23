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

#these steps are important because R treats capital letters and lower case letters as different characters and also treats white space as a character (of sorts) 

# Therefore, for R, "Tmu", "TMu" "tMU", "TMU", "tmu ", " tmU" are all different, so forcing everything to lower case and removing white space helps us turn all of these things into "tmu" and automatically combine these different posibilities
#this is important when users are allowed to input their own data

####################################################################################
### fix numbers 
#####################################################################################


#some variables make more sense as numbers, this step converts them back to numbers
int_students_total[,c("survey_time_secs","age","months_in_taiwan")] <- data.frame(apply(int_students_total[,c("survey_time_secs","age","months_in_taiwan")], 2,as.numeric))


#in case we want to look at response date sometime later,let's convert survey_time to a date-time format
require(lubridate)
int_students_total$survey_time <- ymd_hms(int_students_total$survey_time)


#####################################################################################
## change "" to NA     ##########################################################
################################################################################
#here's a cool trick from stackoverflow:  https://stackoverflow.com/questions/35610437/using-dplyr-to-conditionally-replace-values-in-a-column
#We're going to use it to replace all the "" values with NA
#Why survey cake thought "" was a useful replacement for NA is beyond me
#It's probably also possible to specify that "" should be read in as NA during the read.csv() step, so if this is really slow, we'll try that



int_students_total <-  int_students_total %>% 
  mutate(across(everything() & !survey_time, ~replace(., . == "", NA)))





#################################################################################
# variable specific fixes 
################################################################################

# 1. university

# Taipei Medical University fixes

#first, lets make a vector of the different variations and then combine them to one name, 
#I chose taipei medical as the standard name

#here's a way of making a frequency table of the different values a variable in our data has
# table(int_students_total$university)

# now we make the index vector

tmu_misspellings <- c("taipeimedicaluniversity",
                      "tmu",
                      "taipei medical universty",
                      "taipei medical universitu",
                      "taipei medial university",
                      "taipei medical univeristy",
                      "tmu taipei",
                      "tmu taiwan",
                      "tmu college of oral medicine, school of dentistry",
                      "taipei medical univesity",
                      "graduated recently from tmu")

# and then we select only those entries that match the misspellings and change the spelling
#in a sinle step: 
int_students_total[int_students_total$university %in% tmu_misspellings,]$university <- "taipei medical university"

# one participant filled out some responses in Chinese, which creates problem with the encoding
# ie R studio doesn't recognize Chinese characters
# this is a problem with how R studio, R, the source function, windows and surevy monkey (I guess)
# save and encode non- english characters
# there is probably a better solution, but for now we're just going memorize this participant's location in the data 
# and manualy change values. It's not a great idea bc if the order of the data ever changes, we all of the sudden will
# change the wrong participant, however for this survey the order shouldn't change bc survey round 1 has already been completed

int_students_total[c(100,353),]$university <- "taipei medical university"



#National Taiwan University fixes

ntu_misspellings <- c("national taiwan university.",
                      "ntu")

int_students_total[int_students_total$university %in% ntu_misspellings,]$university <- "national taiwan university"


#this creates three categories of university TMU, NTU and other
# peanut_butter is just a filler value before we change values
int_students_total$university2 <- "peanut_butter"

int_students_total[int_students_total$university=="national taiwan university",]$university2 <- "NTU"
int_students_total[int_students_total$university=="taipei medical university",]$university2 <- "TMU"
int_students_total[int_students_total$university!="taipei medical university" &
                   int_students_total$university!="national taiwan university",]$university2 <- "Other"





#this makes a frequency table of universities
#table(int_students_total$university2) 


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
int_students_total$ethnicity_other <- ifelse(!is.na(int_students_total$ethnicity_other) & 
                                               int_students_total$ethnicity_other == "western african",
                                             "west african",
                                             int_students_total$ethnicity_other)

#micronesian
int_students_total$ethnicity_other <- ifelse(!is.na(int_students_total$ethnicity_other) & 
                                               int_students_total$ethnicity_other == "micronesia",
                                             "micronesian",
                                             int_students_total$ethnicity_other)


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



#this removes vectors we no longer need 
rm(ntu_misspellings,tmu_misspellings)
