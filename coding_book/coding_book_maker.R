## coding book 

#this reads in the data
int_students3 <- read.csv("int_students3.csv")

#this creates a vector of the questions
int_students3_names <- colnames(int_students3) 

#this runs the script file that renames all the variables
source("variable_namer.R")

#this creates a vector of the variable names
int_students3_colnames <- colnames(int_students3) 


#this creates a data.frame with the variable names and questions
coding_book <- data.frame(var_name= int_students3_colnames,
                          question_text = int_students3_names)




#this replaces all the dots with spaces, \\ is needed before the period because 
#periods are special charachters in regular expresssions
library(stringr)
coding_book$question_text <- str_replace_all(coding_book$question_text,"\\."," ")

#this writes the coding book to a csv file
# IMPORTANT: this step will overwrite any files with the same name in the current directory
# IMPORTANT: this means any manual changes you made to the coding book file will be lost if you
# didn't change the name or file location when saving your manual changes
write.csv(coding_book, file = "int_students_coding_book.csv")


# if you see this error: 
#      Error in file(file, ifelse(append, "a", "w")) : 
#         cannot open the connection
#    In addition: Warning message:
#  In file(file, ifelse(append, "a", "w")) :
#  cannot open file 'int_students_coding_book.csv': Permission denied

#it means you have to close the coding book file first before overwriting the file again

#this removes the intermediate files

rm(int_students3_colnames,int_students3_names)