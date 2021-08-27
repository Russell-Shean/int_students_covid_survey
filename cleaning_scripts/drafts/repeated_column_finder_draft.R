




row1_v2 <- function(inner_df, p=1,t=2){
  
  n_columns= ncol(inner_df)
  x <- 0
 
   for (i in 1:n_columns) {
     if(!is.na(inner_df[p,i])&!is.na(inner_df[t,i])){
    if(inner_df[p,i]==inner_df[t,i]){
      x <- x +1
    }
  }}
  x
}






row1_vall <- function(middle_df, p=1){
  

  

  n_rows <- nrow(middle_df)
  y <- rep(0,n_rows)
  
  for (t in 1:(nrow(middle_df))) {
    y[t] <- row1_v2(inner_df=middle_df, t=t,p = p)
  }
  y
}




matching_column_finder <- function(outer_df, n_results =50L){
  
  outer_matrix <- outer_df
  
  #Define variables that can stay constant throughout the environemnt
  #this saves memory bc you don't have to remake these variables every time a loop runs
  n_columns= ncol(outer_matrix)
  x <- 0
  n_rows <- nrow(outer_matrix)
  y <- rep(0,n_rows)
  
  
  
  
  inner_function <- function(inner_df, p=1,t=2){
    for (i in 1:n_columns) {
      if(!is.na(inner_df[p,i])&!is.na(inner_df[t,i])){
        if(inner_df[p,i]==inner_df[t,i]){
          x <- x +1
        }
      }}
    x
  }
  
  
  middle_function <- function(middle_df, p=1){
    
    for (t in 1:n_rows) {
      y[t] <- inner_function(inner_df=middle_df, t=t,p = p)
    }
    y
  }
  
  
  
  
  
  matrick <- matrix(0, nrow = n_rows, ncol = n_rows)
  
   Howlong <- c(t1=Sys.time())
  
   for (z in 1:n_rows) {
    
    matrick[,z] <- middle_function(middle_df = outer_matrix, p=z)
    
  }
  
   Howlong <- c(Howlong, t2 = Sys.time())
  
  for(i in 1:n_rows){
    
    matrick[i,i:n_rows] <- 0
  }
  
  top_matches <- order(matrick, decreasing = TRUE)
  
  
  matches_df <- outer_df[1,]
  
  match_who <- vector(mode = "numeric")
  n_matches <- vector(mode = "numeric")
  
  Howlong <- c(Howlong, t3 = Sys.time())
  
  for (i in head(top_matches, n = n_results)) {

    #vertical match
    matches_df <- rbind(matches_df, outer_df[i%/%n_rows+1,])
    #horizontal match
    matches_df <- rbind(matches_df, outer_df[i%%n_rows,])
    
    match_who <- c(match_who,i%%n_rows,i%/%n_rows+1)  
    n_matches <- c(n_matches, matrick[i],matrick[i])
  }
  
  Howlong <- c(Howlong, t4 = Sys.time())
 
  matches_df <- cbind(matches_df[-1,],match_who,n_matches) 
  
  listie <- list(matches_df[-1,],Howlong, matrick,matches_df,match_who,n_matches)

}





freeze2 <- matching_column_finder2(int_students_total)


test1 <- matching_column_finder(iris)


library(dplyr)
library(nycflights13)

flights <- flights


check_check <- matching_column_finder(int_students_total)





inner_function2 <- function(inner_df, p=1,t=2){
  
  n_columns= ncol(inner_df)
  
  x <- vector("numeric", length = n_columns)
  
  for (i in 1:n_columns) {
    x[i] <-  sum(ifelse(!is.na(inner_df[p,i])& !is.na(inner_df[t,i]) & inner_df[p,i]==inner_df[t,i],1,0))
      }
    
  sum(x)
}


inner_function2(cars)
