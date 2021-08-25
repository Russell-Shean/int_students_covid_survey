#################################3
####   function  #################
##################################

# first we'll build a function to semi automate the process of seperating values
# that survey cake combined

value_seperator <- function(df=NULL, column=NULL, search_terms, var_labels=NULL){
  #this makes sure everything is lower case
  search_terms <- tolower(search_terms)
  var_labels <- tolower(var_labels)
  
  #this makes sure that everything is the same length and stops the function if
  #there are more variables in one of the two vectors
  if(length(search_terms)!=length(var_labels)){
    stop("search_terms and var_lavels must be the same length")
  }

  
  column_labels <- paste(column, var_labels,sep = "_")
 
  for (i in seq_along(search_terms)) {
    df[,column_labels[i]] <- ifelse(!is.na(df[,column]) & 
                                      grepl(search_terms[i], df[,column]),
                                    1,
                                    0)
  }
  
  df
  
}


########################33
##  Native language   ####
############################3


native_languages <- c("dutch","english","vietnamese","indonesian", "spanish","thai","tagalog",
                      "mandarin chinese","french","other")

int_students_total <- value_seperator(df=int_students_total,
                column = "native_lang", 
                search_terms = native_languages,
                var_labels = native_languages)

# add some of the more common others
native_languages_others <- c("hindi","mongolian","chichewa")

int_students_total <- value_seperator(df=int_students_total,
                                      column = "native_lang_other_type", 
                                      search_terms = native_languages_others,
                                      var_labels = native_languages_others)

#here's how to make sure it worked
#int_students_total %>% select(contains("native_lang")) %>% View()

#################
## info sources
##################

#2. most commonly used info sources
#table(int_students_total$info_source) %>% View()

info_sources <- c("social media","friends","newspaper","electronic news")
  
infor_source_labels <- c("socialmedia","friends","newspaper","online")


int_students_total <- value_seperator(df=int_students_total,
                                      column = "info_source", 
                                      search_terms = info_sources,
                                      var_labels = infor_source_labels)



######################3
###   opn_school_favmeasures
# What are your favorite measures adopted by your school during the epidemic of COVID-19? (Select all that apply).
###############################################


measures_search_terms <- c("dining restrictions","wearing a mask","long distance learning",
                           "keeping social distance","entrance restriction and access control in campus","none")

measures_labels <- c("dining","masks","elearning","socdist","noenter","nofav")


int_students_total <- value_seperator(df=int_students_total,
                                      column = "opn_school_favmeasures", 
                                      search_terms = measures_search_terms,
                                      var_labels = measures_labels)

####################################################################################
# opn_school_dislikemeasures
# What are your favorite measures adopted by your school during the epidemic of COVID-19? (Select all that apply).
###########################################################################################

int_students_total <- value_seperator(df=int_students_total,
                                      column = "opn_school_dislikemeasures", 
                                      search_terms = measures_search_terms,
                                      var_labels = measures_labels)

################################################################
# opn_twgvt_favmeasures

# What are your favorite measures adopted by your school during the epidemic of COVID-19? (Select all that apply).
####################################################################
gvt_measures_search_terms <- c("dining restrictions","wearing a mask","quarantine for 14 days",
                           "keeping social distance","border control","none")

gvt_measures_labels <- c("dining","masks","quar14days","socdist","border","nofav")

int_students_total <- value_seperator(df=int_students_total,
                                      column = "opn_twgvt_favmeasures", 
                                      search_terms = gvt_measures_search_terms,
                                      var_labels = gvt_measures_labels)





#####################################################3
#12. opn_twgvt_dislikemeasures
# What are the measures adopted by government of Taiwan you dislike the most during the epidemic of COVID-19?
###########################################################3

int_students_total <- value_seperator(df=int_students_total,
                                      column = "opn_twgvt_dislikemeasures", 
                                      search_terms = gvt_measures_search_terms,
                                      var_labels = gvt_measures_labels)




###############
#symptoms
################3


symptoms <- c("None of the above",
              "Fatigue",
              "Muscle soreness",
              "Sore throat",
              "Fever",
              "Nasal Congestion / Runny Nose",
              "Diarrhea",
              "Joint pain",
              "Cough",
              "Nausea or Vomiting",
              "Shortness of breath",
              "Chest pain",
              "Foot, leg or ankle swelling",
              "Decrease output of urine",
              "Blood in urine",
              "Pneumonia by Roentgenerographic study")


symptoms_labels <- c("none","fatigue","musclsore","sorethroat","fever","runnynose","diarrhea",
                     "jointpain","cough","nausea","shortbreath","chestpain","footswell","nopee","bloodypee","pneumonia")


value_seperator(df=int_students_total,
                column = "symptoms", 
                search_terms = symptoms,
                var_labels = symptoms_labels)



#this removes all those extra label vectors that we created
rm(gvt_measures_labels,
gvt_measures_search_terms,
info_sources,infor_source_labels,
measures_labels,
measures_search_terms,
native_languages,
native_languages_others,
symptoms,
symptoms_labels,
value_seperator)

