# initmat
## Takes column of the data frame as input, returns matrix
### Generates initial matrix
initmat <- function(students) {
  n <- length(students)
  initmat <- matrix(0, nrow = n, ncol = n, dimnames = list(students, students))
  diag(initmat) <- -99
  return(initmat)
}
