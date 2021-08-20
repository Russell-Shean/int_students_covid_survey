# survey round merger

## step 1 combine all three rounds of surveys

#this adds a column to specify which survey round a response is from
int_students1$survey_round <- "round_1"
int_students2$survey_round <- "round_2"
int_students3$survey_round <- "round_3"

#round 3 has two new questions, this step adds these questions to rounds1 and 2, 
#so that the number of columns match

#this creates a function that theoretically reduces the amount of typing I have to do (tbd if it actually saves time lol)

#functions are useful because they allow us to repeat the same set of code with different variables

column_adder <- function(df){
  df$july_survey <- NA
  df$email <- NA
  df
}

#this uses the function we just created to add the two columns to round 1 and 2
int_students1 <- column_adder(int_students1)
int_students2 <- column_adder(int_students2)

#this removes the function bc we no longer need it
rm(column_adder)

int_students_total <- rbind(int_students1,
                            int_students2,
                            int_students3)


#this removes the individual data.frames for each round
# we don't need them anymore now that we've made an overall data.frame
rm(int_students1,int_students2,int_students3)



#this step  removes the stupid (system generated columns with all NA values) variables we don't need

# this defines a function that looks to see if all the values in a column are NA
all.naas <- function(x){all(is.na(x))}

# this step applies the function we just made to all the columns
apply(int_students_total,2,all.naas)

#this step tells us which of the columns had only nas and only shows those columns
which(apply(int_students_total,2,all.naas))

#this makes a vector with the names of those columns

stupid_columns <- names(which(apply(int_students_total,2,all.naas)))

stupid_columns <- c(stupid_columns, "user_id")


# this removes the stupid columns with all blanks

require(dplyr)

int_students_total <- int_students_total %>%
  dplyr::select(-all_of(stupid_columns))

#this removes the stupid_columns vector now that we no longer need it
rm(stupid_columns)

