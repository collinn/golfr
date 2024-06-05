
df <- data.frame(Name = letters[1:5], Val = rnorm(5))

dosomething <- function(dat, id) {
  names <- dat[[id]]
  print(names)
}

dosomething(df, id = "Name")


# tesat something with function
x <- funciotn()))))
