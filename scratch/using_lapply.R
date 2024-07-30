
m <- vector("list", 4)
for (i in 1:4) {
  m[[i]] <- round(matrix(i, nrow = 2, ncol = 2))
}

## Taking a list of matrices and adding together
tt <- Reduce(`+`, m, accumulate = TRUE)

cs <- function(x) sum(x)

lapply(tt, cs)

x <- as.list(1:4)

lapply(x, sqrt)

## Example of using data.frame with lapply (as a list)
df <- read.csv("~/projects/golfer_solution.csv")

ff <- function(x) {
  length(unique(x))
}

lapply(df, code from that loop that computes weight at each round)

# step 1
# get weight from each round using lapply
wm <- lapply(df, my loop code)

## step 2 get cumulative weight matrix from each round
Reduce(`+`, wm, accumulate = TRUE)

## step 3, compute cs on each element of list
lapply(wm, conflict)