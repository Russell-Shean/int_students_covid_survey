## Data Cleaning script
## Basic descriptive analysis for International students survey
## Author = Russ
## last update: "2021-09-01 15:28:01 CST"
## Sys.time()

##################################################################

#This script contains code to combine the different survey rounds 
# and do initial data cleaning
# It sources other script files that do the actual work

#IMPORTANT: because of problems with computer encoding,  this script only works for me when I set my system language to english

# (windows doesn't really standardize encoding especially for foreign languages and I think there may be Chinese apostrophes in some of the variable names)
# if you are using a mac or linux this will probably be less of a problem
# changing the encoding for the csv files and these scripts may fix the problem, but just changing the system language may be easier lol 

####################################################################


# step 1 
# read in the data
# each separate .csv file is a different survey round
# I didn't include pilot studies for now

#./ sends you to the specific folder below the working directory
# the working directory is the default folder that R reads from and writes to
# you can find/set the working directory with getwd() or setwd()
# I usually keep things organized in a project in R studio with an associated working directory

#Here's an old path that I may use again at some point if 
# we ever change the repository to private

#int_students1 <- read.csv("./data/int_students1.csv")
#int_students2 <- read.csv("./data/int_students2.csv")
#int_students3 <- read.csv("./data/int_students3.csv")

#this file path you're going to have to change yourself to wherever
# you store the files
int_students1 <- read.csv("C:/Users/rshea/Desktop/old computer/int_students_covid_data/int_students1.csv")
int_students2 <- read.csv("C:/Users/rshea/Desktop/old computer/int_students_covid_data/int_students2.csv")
int_students3 <- read.csv("C:/Users/rshea/Desktop/old computer/int_students_covid_data/int_students3.csv")

# work computer
int_students1 <- read.csv("C:/Users/user/King County Restaurant Inspections/int_student_survey_round3/data/int_students1.csv")
int_students2 <- read.csv("C:/Users/user/King County Restaurant Inspections/int_student_survey_round3/data/int_students2.csv")
int_students3 <- read.csv("C:/Users/user/King County Restaurant Inspections/int_student_survey_round3/data/int_students3.csv")


#### step2 
# rename the variables
source("./cleaning_scripts/variable_namer.R")


### step3 
## combine all three survey rounds 
## also removes some stupid blank columns
source("./cleaning_scripts/survey_round_merger.R")


## step 4
## combines duplicate or typo entries for each question
## eg turns "Taipei Mediculee" and "Tmu" all into "tmu"
## it also fixes the variable class for numbers and dates
## and coverts the response "" into NA

source("./cleaning_scripts/variable_merger.R")


## step 5
## separate out into separate yes or no columns 
## all of the check box responses survey monkey combined in a single column

source("./cleaning_scripts/variable_separator.R")

### step 6
## find duplicate emails
## check to see if other rows are duplicated too
source("./cleaning_scripts/repeat_email_finder.R")

# we need to make decisions about these entries
# I will finish make my entry compare function so we can see how many of the 
# values (columns) are exact matches soon
# it's basically done just very slow, so I need to replace loops and stuff with vectors

## step 7
## make numbers numeric
## make characters factors

source("./cleaning_scripts/class_converter.R")

## Step 8
## KAP yes/no conversions 

## Here's where we categorize each KAP response as sufficient, positive, or good
# and then set cutoff criteria for overall sufficient, positive, and good
source("./cleaning_scripts/kap_coder.R")



## this step writes the data.frame to a csv file

write.csv(int_students_total, file = "C:/Users/user/King County Restaurant Inspections/int_student_survey_round3/data/int_students_total.csv")
write.csv(int_students_total, file = "C:/Users/user/King County Restaurant Inspections/int_student_survey_round3/data/int_students_total.csv")

library(xlsx)
write.xlsx(int_students_total, file = "C:/Users/user/King County Restaurant Inspections/int_student_survey_round3/data/int_students_total.xlsx")







