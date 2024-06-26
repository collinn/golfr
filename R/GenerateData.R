# GenerateData
## Takes integer as input, returns data frame
### Generates test data frame of the students with unique ID (uppercase letters)

GenerateData <- function(num_students) {
  
  Names <- c(LETTERS, paste(LETTERS))[seq_len(num_students)]
  student_df <- data.frame(Student = Names, stringsAsFactors = FALSE)
  
  return(student_df)
}