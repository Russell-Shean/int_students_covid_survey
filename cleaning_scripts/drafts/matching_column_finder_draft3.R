matching_column_finder3 <- function(outer_df, n_results =50L){
  
  outer_matrix <- outer_df
  
  #Define variables that can stay constant throughout the environemnt
  #this saves memory bc you don't have to remake these variables every time a loop runs
  n_columns= ncol(outer_matrix)
  x <- 0
  n_rows <- nrow(outer_matrix)
  y <- rep(0,n_rows)
  
  
  matrick <- matrix(0, nrow = n_rows, ncol = n_rows)
  
  Howlong <- c(t1=Sys.time())
  
  for (z in 1:n_rows) {
    for (t in 1:n_rows) {
            matrick[t,z] <- length(which(outer_matrix[z,]==outer_matrix[t,]))
          }
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
  
  
  
    for (i in top_matches) {
      if(i > 0){
    
    #vertical match
    matches_df <- rbind(matches_df, outer_df[i%/%n_rows+1,], outer_df[i%%n_rows,])
    #horizontal match
    #matches_df <- rbind(matches_df, outer_df[i%%n_rows,])
    
    match_who <- c(match_who,i%%n_rows,i%/%n_rows+1)  
    n_matches <- c(n_matches, matrick[i],matrick[i])
    }
  }
  
  Howlong <- c(Howlong, t4 = Sys.time())
  
  #matches_df <- cbind(matches_df[-1,],match_who,n_matches) 
  
  listie <- list(matches_df[-1,],Howlong, matrick,matches_df,match_who,n_matches)
  
} 


test3 <- matching_column_finder3(int_students_total)  


length(which(test3[[3]]>0))
