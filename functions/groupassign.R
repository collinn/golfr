# groupassign
## Takes data frame and two integers as inputs, returns matrix
### Assigns groups and updates matrix (`MakeGroups`+ `updatemat`)

groupassign <- function(student_data, students_per_group, iterations) {
  # Initialize the interaction matrix
  initial_matrix <- initmat(student_data$Student)
  
  # Loop through iterations
  for (r in seq_len(iterations)) {
    # Assign groups
    grouped_data <- MakeGroups(student_data, students_per_group, 1, initial_matrix)
    
    # Update the interaction matrix
    initial_matrix <- updatemat(initial_matrix, grouped_data$Round_1, student_data$Student)
  }
  
  return(initial_matrix)
}
# 
# n_students <- 4
# student_data <- GenerateData(n_students)
# students_per_group <- 2
# iterations <- 3
# 
# matrices_df <- groupassign(student_data, students_per_group, iterations)
# matrices_df
