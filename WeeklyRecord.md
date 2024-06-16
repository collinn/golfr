## May 28-31, Week 1
- `GenerateData` to generate random data of students with unique ID
- `MakeGroups` to assign students randomly into set number of groups
and students per group with iteration (overlap not considered)
- `testoverlap` to check if there is going to be an overlap of students
in the group who were assigned together before

## June 3-7, Week 2
- MAP Proposal Part A, B completed
- Generated initial matrix `initmat`
- Generated `updatemat`to reflect the group assignment to the matrix
- Moved `GenerateData`, `MakeGroups`, `testoverlap`, `initmat`, and `updatemat`
to separate .R in `functions` file
- `testmat` to check if there is any unpaired students in the matrix
  (maybe for the future use)

## June 10-14, Week 3
- `groupassign` function generated that loops through `MakeGroups` and `updatemat`
- `updatemat` has been adjusted to reflect multiple iterations on the matrix
- Initial matrix has added in the arguments of `MakeGroups`
- `groupassign` now returns the data frame with lists (saved after each iteration) as final output
- 'MakeGroups' is supposed to return all the data frames combined after each round (Issue \# 2)


## June 17-21, Week 4