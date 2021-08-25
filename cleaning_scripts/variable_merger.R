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


#####################################################################################
## change "" to NA     ##########################################################
################################################################################
#here's a cool trick from stackoverflow:  https://stackoverflow.com/questions/35610437/using-dplyr-to-conditionally-replace-values-in-a-column
#We're going to use it to replace all the "" values with NA
#Why survey cake thought "" was a useful replacement for NA is beyond me
#It's probably also possible to specify that "" should be read in as NA during the read.csv() step, so if this is really slow, we'll try that



int_students_total <-  int_students_total %>% 
  mutate(across(everything() & !survey_time, ~replace(., . == "", NA)))


### Univerisal fixes
#using the same method we're going to replace misspellings throughout the dataframe

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
#in a single step: 

#just in case there are other entries in other columns, we're going to do this across the whole dataframe

int_students_total <-  int_students_total %>% 
  mutate(across(everything() & !survey_time, ~replace(., . %in% tmu_misspellings, "taipei medical university")))


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

int_students_total <-  int_students_total %>% 
  mutate(across(everything() & !survey_time, ~replace(., . %in% ntu_misspellings, "national taiwan university")))


#this creates three categories of university TMU, NTU and other
# peanut_butter is just a filler value before we change values
int_students_total$university2 <- "peanut_butter"

int_students_total[int_students_total$university=="national taiwan university",]$university2 <- "NTU"
int_students_total[int_students_total$university=="taipei medical university",]$university2 <- "TMU"
int_students_total[int_students_total$university!="taipei medical university" &
                   int_students_total$university!="national taiwan university",]$university2 <- "Other"





#this makes a frequency table of universities
#table(int_students_total$university2) 
#in case you want to confirm everything worked

# 2. Country of origin 
# Not all issues are resolved here
# for example, I don't know where ut is (probably the US mistyped but hard to say for sure)
# likewise I'm not going to guess that vn = vietnam

#united states
usa_misspellings <- c("the united states","usa","us.","the united states.","us")

int_students_total <-  int_students_total %>% 
  mutate(across(everything() & !survey_time, ~replace(., . %in% usa_misspellings, "united states")))




#thailand
int_students_total[int_students_total$country_origin=="thai",]$country_origin <- "thailand"

#vietnam

#this we'll fix only at the country column b/c vietnamese is a legit response for language
int_students_total[int_students_total$country_origin=="vietnamese",]$country_origin <- "vietnam"

#this we're going to fix accross all the columns
int_students_total <-  int_students_total %>% 
  mutate(across(everything() & !survey_time, ~replace(., . == "viet nam", "vietnam")))



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

#new zealand
nz_misspellings <- c("newzealand","new zaeland")

int_students_total <-  int_students_total %>% 
  mutate(across(everything() & !survey_time, ~replace(., . %in% nz_misspellings, "new zealand")))



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




# 4. I don't know + no country safe
# There are a lot of ways to say I don't know, so we're going to 
# change them all to "i don't know", but because "'" doesn't always encode
# well, we're going to use "not sure"

dunno_misspellings <- c("i don't know","no idea","no idea for now")

int_students_total <-  int_students_total %>% 
  mutate(across(everything() & !survey_time, ~replace(., . %in% dunno_misspellings, "not sure")))


#not competent to answer (country low risk other)
#b/c of encoding problems we're going to use a partial match instead of a full match
int_students_total$opn_country_lowrisk_other[grepl("not competent to answer", int_students_total$opn_country_lowrisk_other)] <- "not sure"


#no country is safe
no_country_misspellings <- c("no country",
                             "everyone is exposed",
                             "no country or region is free of risk at this moment, thus cannot be compared.",
                             "none, this question is political and is sad to see it",
                             "again, very sad misleading people to believe they are safer in one border or another. plus, taiwan is not easily recognisable as a full country still. keep fighting, but not this way",
                             "anywhere",
                             "do not go abroad at this time",
                             "everywhere",
                             "i highly recommend that you should postpone any going abroad plan",
                             "i will advice to cancel all travel plan until further notice",
                             "just don't",
                             "nowhere is safe",
                             "stay where you are.",
                             "the risk is there in most countries",
                             "there is no safe place right now")



int_students_total <-  int_students_total %>% 
  mutate(across(everything() & !survey_time, ~replace(., . %in% no_country_misspellings, "no country is safe")))



# none
#this word may have been used in other contexts in other columns in a way that we want to keep
# so we'll replace for this column only (opn_country_highrisk_other)

int_students_total$opn_country_highrisk_other <- ifelse(!is.na(int_students_total$opn_country_highrisk_other) & 
                                               int_students_total$opn_country_highrisk_other=="none",
                                             "no country is safe",
                                             int_students_total$opn_country_highrisk_other)

# 4. Health background

# In the future it might be better to only provide a few categories, that would lead to more precise answers that more precisely match the 
#categories we care about. It would also save a lot of time, confusion and guessing par moi

# There are a lot of different ways of saying you're a doctor
# we'll need to figure out how best to combine all these

table(int_students_total$health_background_type, useNA = "ifany")

#categories I'm going to use: Doctor, nurse, dentist, allied health sciences (this will include biology and all research jobs), vet, pharmacy, psychology
# for people that provided more than one type of health background, we need a way to break ties
# I decided that medical licenses and rank/years of education should take precedence, so 
# doctor or vet or dentist > pharmacy > nurse > public health etc




# doctors
# specializations such as ent or surgery were all combined under "doctor"
# I assumed that bachelors of medicine means that someone is a licensed medical doctor 
#(even if they may have not passed board exams/done residency yet or may have been educated in a country where medicine is a post-graduate degree)
# homeopathic medicine was assumed to be equivalent to a DO license in the US and was included in the medical doctor category
#medicine or medical was assumed to mean they are a doctor or had gone through medical school
# medical science and medical technology was not

doctor_misspellings <- c("doctor",
                         "general medicine",
                         "general doctor",
                         "ent doctor",
                         "i am a medical doctor",
                         "i am medical doctor",
                         "md",
                         "md degree",
                         "md programme",
                         "medical degree",
                         "medical doctor",
                         "medicine doctor",
                         "preventive medicine doctor",
                         "medical doctor, master of public health",
                         "medical doctor degree",
                         "bachelor of medicine, medical doctor, master of public health",
                         "bachelor in homoeopathic medice(bhms), and public health",
                         "bachelor in homeopathic medicine",
                         "orthopedic surgeon",
                         "orthopedics and trauma surgeon",
                         "surgery",
                         "medicine and public health",
                         "medicine, public health",
                         "general surgeon",
                         "pharmacy, pharmacology and medicine",
                         "nephrologist")

int_students_total <-  int_students_total %>% 
  mutate(across(everything() & !survey_time, ~replace(., . %in% doctor_misspellings, "medicine")))

# Dentists 

dentist_misspellings <- c("dentistry","dds")

int_students_total <-  int_students_total %>% 
  mutate(across(everything() & !survey_time, ~replace(., . %in% dentist_misspellings, "dentist")))


# nurses
#we'll start with replacing partial matches for "nurse" and "nursing" and then see if we need to do anything else
# | means or, so we're looking for nurse or nursing and replacing it with nurse

int_students_total$health_background_type[grepl("nurse|nursing", int_students_total$health_background_type)] <- "nursing"

# 


# 5. Chronic comorbidities

# this also needs a decision about how best to combine
# Are chronic kidney disease, chronic renal insufficiency and kidney disease similiar enough to combine
# in one category?

table(int_students_total$comordidities_type, useNA = "ifany")


# 6 worst information source

table(int_students_total$opn_infosource_worst_other)
table(int_students_total$opn_infosource_worst)

# 7 Taiwan travel history

table(int_students_total$hist_twtravel_locations)

# 8 other types of information sources

# this combines all the entries containing the phrase "journal"
# and renames them as "scientific journal"
int_students_total$info_source_other[grepl("journal", int_students_total$info_source_other)] <- "scientific journal"

#this combines a variety of variations of scientific journal
# we could have done the same thing with a search for "article"
# but I want to keep it more narrow in case someone who fills out
# this survey in the future puts "newspaper article" or something in this field

int_students_total$info_source_other[grepl("scientific articles|research articles|pubmed|scientist papers", int_students_total$info_source_other)] <- "scientific journal"



# this combines all the entries containing the phrase "school" or university
int_students_total$info_source_other[grepl("school|university", int_students_total$info_source_other)] <- "school"



# native languages other

#mongolian
int_students_total$native_lang_other_type <- ifelse(!is.na(int_students_total$native_lang_other_type) & 
                                               int_students_total$native_lang_other_type == "mongolia",
                                             "mongolian",
                                             int_students_total$native_lang_other_type)




#this removes vectors we no longer need 
rm(ntu_misspellings,tmu_misspellings, dentist_misspellings,doctor_misspellings,dunno_misspellings,no_country_misspellings,nz_misspellings,usa_misspellings)
