# Variable separator
# in this script we separate out into separate yes or no columns all of the check box responses survey monkey combined in a single column

# define variable naming system 
# original variable name + value 
# eg. native_lang_Vietnamese or native_lang_english

# 1. native language
# next time we should make this a "choose best response"

table(int_students_total$native_lang)

#dutch
int_students_total$native_lang_dutch <- ifelse(!is.na(int_students_total$native_lang) & 
                                                          grepl("dutch", int_students_total$native_lang),
                                                        1,
                                                        0)

#english
int_students_total$native_lang_english <- ifelse(!is.na(int_students_total$native_lang) & 
                                                 grepl("english", int_students_total$native_lang),
                                               1,
                                               0)

#vietnamese
int_students_total$native_lang_vietnamese <- ifelse(!is.na(int_students_total$native_lang) & 
                                                   grepl("vietnamese", int_students_total$native_lang),
                                                 1,
                                                 0)

#indonesian
int_students_total$native_lang_indonesian <- ifelse(!is.na(int_students_total$native_lang) & 
                                                      grepl("indonesian", int_students_total$native_lang),
                                                    1,
                                                    0)


#spanish
int_students_total$native_lang_spanish <- ifelse(!is.na(int_students_total$native_lang) & 
                                                      grepl("spanish", int_students_total$native_lang),
                                                    1,
                                                    0)


#thai
int_students_total$native_lang_thai <- ifelse(!is.na(int_students_total$native_lang) & 
                                                   grepl("thai", int_students_total$native_lang),
                                                 1,
                                                 0)

#tagalog
int_students_total$native_lang_tagalog <- ifelse(!is.na(int_students_total$native_lang) & 
                                                grepl("tagalog", int_students_total$native_lang),
                                              1,
                                              0)

#mandarin chinese
int_students_total$native_lang_chinese <- ifelse(!is.na(int_students_total$native_lang) & 
                                                   grepl("mandarin chinese", int_students_total$native_lang),
                                                 1,
                                                 0)


#french
int_students_total$native_lang_french <- ifelse(!is.na(int_students_total$native_lang) & 
                                                   grepl("french", int_students_total$native_lang),
                                                 1,
                                                 0)

#other
int_students_total$native_lang_other <- ifelse(!is.na(int_students_total$native_lang) & 
                                                  grepl("other", int_students_total$native_lang),
                                                1,
                                                0)



#here's how to make sure it worked
#int_students_total %>% select(contains("native_lang")) %>% View()



