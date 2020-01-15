
iris %>% head
## select first 3 column
select(iris,1:3) %>% head
?select
## Select all the columns of the iris dataset except “Petal Width”.
select(iris,-'Petal.Width') %>% head
## Select all columns of the iris dataset that start with the
## character string “P”.
select(iris,starts_with('P')) %>% head
select(iris,matches('^P.*')) %>% head
## Filter the rows of the iris dataset for Sepal.Length >= 4.6 
## and Petal.Width >= 0.5.
filter(iris, Sepal.Length >= 4.6 & Petal.Width >= 0.5) %>% head
## Arrange rows by a particular column, such as the Sepal.Width
arrange(iris,Sepal.Width) %>% head
iris %>% head
## Select three columns from iris, arrange the rows by Sepal.Length,
## then arrange the rows by Sepal.Width
iris %>% select(1:3) %>% arrange(Sepal.Length,Sepal.Width) %>% head

## Create a new column called proportion, 
## which is the ratio of Sepal.Length to Sepal.Width
iris_with_proportion <- mutate(iris,proportion = Sepal.Length/Sepal.Width) %>% head
iris_with_proportion %>% head
## Compute the average number of Sepal.Length, 
## apply the mean() function
## to the column Sepal.Length, and call the summary value 
## “avg_slength”.
summarise(iris,avg_slength = mean(Sepal.Length))

## Split the iris data frame by the Species, then ask for the same 
## summary statistics as above
iris %>% head
iris %>% group_by(Species) %>% summarise(avg_slength =mean(Sepal.Length))




mtcars %>% head
## group by does not change how it looks like
mtcars %>% group_by(carb) %>% head
## only when you manipulate it shows different
mtcars %>% group_by(carb) %>% summarise(cnt = n(),
                                        disp = mean(disp),
                                        Qt = quantile(mpg,0.50))


### table join

tb1 = tibble(id = 1:8,rate = abs(rnorm(8)))
tb1
tb2 = tibble(id = 1:5,attend = rep(TRUE,5))
tb2
tb2_1 = tibble(id = 6:10,attend = rep(FALSE,5))
tb2_1
tb3 = rbind(tb2,tb2_1)
tb3
tb3 %>% left_join(tb1)
tb1 %>% left_join(tb3)

tb3 %>% right_join(tb2)
tb3 %>% inner_join(tb1)
full_join()








### Sample code for iris
iris %>%
  select(1:3)

select(iris,-'Petal.Width')

select(iris,starts_with('P'))
select(iris,matches('^P.*'))

filter(iris, Sepal.Length >= 4.6 & Petal.Width >= 0.5)

arrange(iris,Sepal.Width) %>% head

iris %>% 
  select(1:3) %>% 
  arrange(Sepal.Length,Sepal.Width)%>% head  

iris %>% mutate(proportion = Sepal.Length/Sepal.Width ) %>% head

iris %>% summarise(avg_slength = mean(Sepal.Length))

iris %>% group_by(Species) %>% 
  summarise(avg_slength = mean(Sepal.Length),
            total = n())



