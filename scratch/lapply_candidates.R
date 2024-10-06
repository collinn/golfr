

## Scratch work

weight_matrix <- matrix(0, nrow = n, ncol = n, dimnames = list(students, students))
diag(weight_matrix) <- -99


all_candidate <- lapply(candidates, function(cand) {
  
  ## This goes through all the groups in one candidate round
  ww <- lapply(cand, function(group_members) { 
    # need a value for n
    weight_matrix <- matrix(0, nrow = n, ncol = n, dimnames = list(students, students))
    diag(weight_matrix) <- -99
    for (i in seq_along(group_members)) {
      for (j in (i + 1):length(group_members)) {
        if (j > length(group_members)) break
        weight_matrix[group_members[i], group_members[j]] <- 1
        weight_matrix[group_members[j], group_members[i]] <- 1
      }
    }
    weight_matrix
  })
  
  cummat <- Reduce(`+`, ww)
  cummat
})

round2 <- cummat[[2]]
## Take all candidate weights and add to cumulative for round 2
r3_candidate <- lapply(all_candidate, function(x) {
  round2 + x
})

Final(r3_candidate)
