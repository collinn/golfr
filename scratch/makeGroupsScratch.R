

updateGroups <- function(M) {
  # defensive programming
  message <- paste0("M is not a matrix, it is a: ", class(M))
  stop(message)
  stop("M not matrix")
  stop("M not matrix")

  
  for (i in blah) {
    M[i, j] <- stuff
    stop("Error: incorrect dimensions subset object lbha blah blah idk what this is")
  }
  
}
M <- 1:6
updateGroups(M)
M <- data.frame(x = 1:5)


## First round
M <- matrix(c(-99, 0, 0, 0,
              0, -99, 0, 0,
              0, 0, -99, 0,
              0, 0, 0 ,-99), nrow = 4, byrow = TRUE)
colnames(M) <- rownames(M) <- LETTERS[1:4]


M

## first iteration
i <- 1
alreadyAssigned <- numeric()
for (i in seq_len(nrow(M)-1)) {
  validChoices <- which(M[i, (i+1):ncol(M)] == 0) + i  # problem when i = 3, should know A/B not valid
  validChoices <- setdiff(validChoices, alreadyAssigned)
  if (length(validChoices) != 4 - i) next()
  newpart <- sample(validChoices, 1) # group size of 2 - 1
  M[i, newpart] <- 1
  M[newpart, i] <- 1
  alreadyAssigned <- c(alreadyAssigned, newpart)
}

## WATCH OUT FOR MAGIC NUMBERS!!!!!
makeGroups <- function(..., M) {
  ## for whatever iteration iteration
  for (i in seq_len(nrow(M))) {
    validChoices <- which(M[i, ] == 0)
    if (length(validChoices) != 2) next()
    newpart <- sample(validChoices, 1) # group size of n - 1
    M[i, newpart] <- M[i, newpart] + 1
    M[newpart, i] <- M[newpart, i] + 1
  }
  
}

bigMainfunction <- function() {
  
  M <- initMat()
  ## Looping through each round
  for (i in numRounds) {
    gp <- makeGroups
    M <- updateMat()
  }
  
  return(gp)
}

M

## This for loop (immediately below) is looping through each student/obs to be assigned
## second iteration  (within makeGroup)
for (i in seq_len(nrow(M))) {
  validChoices <- which(M[i, ] == 0)
  if (length(validChoices) != 2) next()
  newpart <- sample(validChoices, 1) # group size of 2 - 1
  M[i, newpart] <- 1
  M[newpart, i] <- 1
}

M

## third iteration (within makeGroup)
i <- 2
for (i in seq_len(nrow(M))) {
  validChoices <- which(M[i, ] == 0)
  if (length(validChoices) != 1) next()
  newpart <- sample(validChoices, 1) # group size of 2 - 1
  M[i, newpart] <- 1
  M[newpart, i] <- 1
}


M

x <- 11:20


## Discussion
# for each ROUND for assignment, should loop through and make new groups
# after assigning groups in a round, update M (matrix)
# on next loop iteration (i.e., Round 2), use M from ROUND 1 and 
# create next set of groups

## ALSO
# witin makeGroups, will need to loop through each students
# Always start with A, then move to B, if B not assigned with A, assign B
# otherwise skip to C, etc., 

## For now
# this involves two sets of for loops
# one for loop for each round of assignment
# Within each round, also loop through all students to determine their group pairs
# examples of the subject loops are given above



