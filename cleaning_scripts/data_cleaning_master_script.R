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

int_students1 <- read.csv("int_students1.csv")
int_students2 <- read.csv("int_students2.csv")
int_students3 <- read.csv("int_students3.csv")

#### step2 
# rename the variables
source("variable_namer.R")


### step3 
## combine all three survey rounds 
source("survey_round_merger.R")


## step4 combines duplicate or typo entries for each question
## eg turns "Taipei Mediculee" and "Tmu" all into "tmu"
## it also fixes the variable class for numbers and dates

source("variable_merger.R")


## this step writes the data.frame to a csv file

write.csv(int_students_total, file = "int_students_total.csv")








