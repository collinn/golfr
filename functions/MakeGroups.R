# MakeGroups
## Takes data frame and two integers as inputs, returns data frame
### Assign every student into groups with set number of students per group,
### with set number of iterations (overlap not considered)

MakeGroups <- function(data, students_per_group, iterations, initial_matrix) {
  num_students <- nrow(data)
  # ceiling or floor?
  num_groups <- ceiling(num_students / students_per_group)
  # Initialize a list to store group assignments for each iteration
  group_assignments_list <- list()
  group_assignments_list <- vector("list", length = iterations)
  
  for (i in seq_len(iterations)) {
    shuffled_students <- sample(data$Student)
    
    # Create initial group assignments
    group_assignments <- rep(seq_len(num_groups), 
                             each = students_per_group, 
                             length.out = num_students)
    
    ## This will always put extra students in existing groups
    ## Maybe want to create a new group if rem_stud/n_group > 1/2
    # Distribute any remaining students among the existing groups
    remaining_students <- num_students %% students_per_group
    if (remaining_students != 0) {
      extra_indices <- (num_students - remaining_students + 1):num_students
      extra_groups <- sample(seq_len(num_groups-1), remaining_students)
      group_assignments[extra_indices] <- extra_groups
    }

    # Combine students with their groups
    iteration_groups <- data.frame(Student = shuffled_students, Group = group_assignments)

    # Order by original student order
    iteration_groups <- iteration_groups[order(match(iteration_groups$Student, data$Student)), ]

    # Add group assignments to the list with the appropriate column name
    group_assignments_list[[paste0("Round_", i)]] <- iteration_groups$Group
  }

  # Combine the original data with the group assignments
  combined_data <- cbind(data, do.call(cbind, group_assignments_list))

  return(combined_data)
}