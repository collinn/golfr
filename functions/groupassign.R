# groupassign
## Takes data frame and two integers as inputs, returns matrix
### Assigns groups and updates matrix (`MakeGroups`+ `updatemat`)

groupassign <- function(student_data, students_per_group, iterations) {
  # Initialize the interaction matrix
  initial_matrix <- initmat(student_data$Student)
  
  # Initialize a list to store the matrix after each iteration
  matrices_list <- vector("list", length = iterations)
  
  # Loop through iterations
  for (r in seq_len(iterations)) {
    # Assign groups and update the interaction matrix
    final_matrix <- MakeGroups(student_data, students_per_group, 1, initial_matrix)
    
    # Save the final_matrix after each iteration to the list
    matrices_list[[r]] <- final_matrix
    
    # Update the initial matrix for the next iteration
    initial_matrix <- final_matrix
  }
  
  # Combine the list into a data frame of lists
  matrices_df <- data.frame(iteration = seq_len(iterations), matrix = I(matrices_list))
  
  return(matrices_df)
}

n_students <- 4
student_data <- GenerateData(n_students)
students_per_group <- 2
iterations <- 3

matrices_df <- groupassign(student_data, students_per_group, iterations)
matrices_df
