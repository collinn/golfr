# testoverlap
## Takes three integers, returns boolean
### Determines if there will be overlap in assignment

testoverlap <- function(num_students, students_per_group, iterations) {
  # Calculate the total number of groups needed per iteration
  num_groups <- ceiling(num_students / students_per_group)
  # Calculate the number of unique possible groups
  unique_combinations <- choose(num_students, students_per_group)
  # Check for overlap conditions
  if (unique_combinations <= num_groups * (iterations - 1)) {
    return(TRUE)
  } else {
    return(FALSE)
  }
}
