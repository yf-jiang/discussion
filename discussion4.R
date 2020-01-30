library(rlang)
library(microbenchmark)

## Lazy eval
f <- function(a, b){
  a * 10
}
### will the following code return error?
f(4)
### We will not check b until b is called
f(4,whatever)

### A example from R-bloggers
mean_of_that <- function(x, M = mean(x)){
  print(mean(x))
  x <- x[!is.na(x)]
  print(x)
  cat("The mean of x is", M)
}
mean_of_that(c(1,2,3,4,NA))

### on.exit function
f <- function(a, b){
  a * 10
  on.exit(print("return!"))
  on.exit(print("goodbye!"))
}
f(3)




### trycatch example
log_calculator <- function(x){
  tryCatch(
    expr = {
      message(log(x))
      message("Successfully executed the log(x) call.")
    },
    error = function(e){
      message('Caught an error!')
      print(e)
    },
    warning = function(w){
      message('Caught an warning!')
      print(w)
    },
    finally = {
      message('All done, quitting.')
    }
  )    
}
log_calculator(1)
log_calculator(-1)
log_calculator('a')

#Author DataFlair
f<-function(x) {
  r<-x-g(x)
  r
}
g<-function(y) {
  r<-y*h(y)
  r
}
h<-function(z) {
  r<-log(z)
  if(r<10)
    r^2
  else
    r^3
}

f(-1)
##  play with traceback
traceback()
## play with debugonce()
debugonce(f)
f(1)
## another example of debugonce()
SquareSum <- function(mu,val){
  sub <- val - mu
  sqr <- sub^2
  get <- sum(sqr)
  get
}
set.seed(100)
val <- rnorm(100)
SquareSum(1,val)

debugonce(SquareSum)
SquareSum(1,val)


#Author DataFlair
h<-function(z) {
  browser() ## a break point inserted here
  r<-log(z)
  if(r<10)
    r^2
  else
    r^3
}
h(3)


### profiling example http://adv-r.had.co.nz/Profiling.html
rowSums2 <- function(df) {
  out <- df[[1L]]
  if (ncol(df) == 1) return(out)
  
  for (i in 2:ncol(df)) {
    out <- out + df[[i]]
  }
  out
}

## system.time()
df <- as.data.frame(
  replicate(1e3, sample(100, 1e4, replace = TRUE))
)
system.time(rowSums(df))
system.time(rowSums2(df))




## profiling with microbenchmark
random_string <- function() {
  paste(sample(letters, 50, replace = TRUE), collapse = "")
}
strings10 <- replicate(10, random_string())
strings100 <- replicate(100, random_string())

collapse <- function(xs) {
  out <- ""
  for (x in xs) {
    out <- paste0(out, x)
  }
  out
}

microbenchmark(
  loop10  = collapse(strings10),
  loop100 = collapse(strings100),
  vec10   = paste(strings10, collapse = ""),
  vec100  = paste(strings100, collapse = "")
)
