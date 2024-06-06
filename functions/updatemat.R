# updatemat
## Takes matrix, vector and integer as inputs, returns matrix
### Updates the results of first round to the initial matrix

updatemat <- function(initmat, groupAssignments, students) {
  numGroups <- length(unique(groupAssignments))
  
  for (g in seq_len(numGroups)) {
    groupMembers <- students[groupAssignments == g,]
    for (j in seq_along(groupMembers)) {
      for (k in seq_along(groupMembers)) {
        if (j != k) {
          initmat[groupMembers[j], groupMembers[k]] <- 1
        }
      }
    }
  }
  
  return(initmat)
}