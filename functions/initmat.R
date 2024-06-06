# initmat
## Takes integer as input, returns matrix
### Generates initial matrix
initMat <- function(num_students) {
  n <- length(num_students)
  initMat <- matrix(0, nrow = n, ncol = n, dimnames = list(students, students))
  diag(initMat) <- -99
  # -99 can be replaced with -(n-1) when n = number of rows (students)
  return(InitMat)
}