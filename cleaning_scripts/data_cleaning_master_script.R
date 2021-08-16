## Basic descriptive analysis for International students survey
## Author = Russ
## last update: "2021-08-13 16:37:44 CST"
#Sys.time()

##################################################################

#This script contains code to combine the different survey rounds 
# and do initial data cleaning
# It sources other script files that do the actual work


####################################################################


# step 1 
# read in the data
# each separate .csv file is a different survey round
# I didn't include pilot studies for now

#./ sends you to the specific folder below the working directory
# the working directory is the default folder that R reads from and writes to
# you can find/set the working directory with getwd() or setwd()
# I usually keep things organized in a project in R studio with an associated working directory

int_students1 <- read.csv("./data/int_students1.csv")
int_students2 <- read.csv("./data/int_students2.csv")
int_students3 <- read.csv("./data/int_students3.csv")

#### step2 
# rename the variables
source("./cleaning_scripts/variable_namer.R")


### step3 
## combine all three survey rounds 
source("./cleaning_scripts/survey_round_merger.R")


## step4 combines duplicate or typo entries for each question
## eg turns "Taipei Mediculee" and "Tmu" all into "tmu"
## it also fixes the variable class for numbers and dates

source("./cleaning_scripts/variable_merger.R")


## this step writes the data.frame to a csv file

write.csv(int_students_total, file = "./data/int_students_total.csv")










