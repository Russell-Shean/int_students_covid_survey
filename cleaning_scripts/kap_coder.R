# Kap coder

# Here's a function that we'll use to diachatomize each knowledge, attitude and practice response as correct/incorrect
# Knowledge: suffecient/insufficient, attitude: positive/not positive, practice: good/bad
# this function also sums the total of scores for each participant
# and then dichotomizes into all right/ some to all wrong


kap_coder <- function(df,start_var, end_var, label= "knowledge",match_vector){
  

  
  
  #in case someone uses capital letters
  match_vector <- tolower(match_vector)
  
  # this creates a column label for the sum of KAP scores
  label2 <- paste(label,"total",sep="_")
  
  # this creates a column label for dichotomized KAP scores
  label3 <- paste(label,"present",sep="_")
  
  
  #this selects the variables we're looking at
  df_temp <- df %>% dplyr::select(.,{{start_var}}:{{end_var}}) 
  
  
  #new labels for the new columns
  labels4 <- paste(colnames(df_temp),"yesno",sep = "_")
  
  colnames(df_temp) <- labels4
  
  #this counts the number of columns
  howmany_columns <- ncol(df_temp)
  
  #if they provide only a single word, we assume that means that the one entry should be repeated
  if(length(match_vector)==1){
    match_vector <- rep(match_vector, times= howmany_columns)
  } 
  
  #this checks that the length of the match vector is correct
  if(length(match_vector)!=howmany_columns){
    stop("Please confirm the length of the match vector and the starting and ending columns. A aggree/disagree key must be provided for each variable")
  }

 
  for (i in 1:howmany_columns) {
    if(match_vector[i]=="agree"|match_vector[i]=="often"){
      df_temp[,i] <- as.numeric(df_temp[,i]) > 3
    }else if(match_vector[i]=="disagree"|match_vector[i]=="seldom"){
      df_temp[,i] <- as.numeric(df_temp[,i]) < 3
    }else stop("match_vector can only use the terms c('agree','often','disagree','seldom'), please try again'")
      
    
  }
  df_temp[,label2] <- rowSums(df_temp)
  
  df_temp[,label3] <- ifelse(df_temp[,label2]==howmany_columns,1,0)
                       
df_temp
 
df <- cbind(df,df_temp)
 

df
}  



#and now we apply the function

## Knowledge
int_students_total <- kap_coder(int_students_total, 
                                start_var = "opn_feverless_transm",
                                end_var = "opn_elderly_hrisk",
                                match_vector = c("disagree","disagree", rep("agree",times=5)))

## attitudes
int_students_total <- kap_coder(int_students_total, 
                                start_var = "opn_socialdist_protectme",
                                end_var = "opn_covdcontrol_oneyear", 
                                label = "attitude",
                                match_vector = c("agree"))


## practice
int_students_total <- kap_coder(int_students_total, 
                                start_var = "hist_socialdist",
                                end_var = "hist_followregs_twgvt", 
                                label = "practice",
                                match_vector = c(rep("often",times=4),rep("seldom",times=3),rep("often",times=5)))


  
  
