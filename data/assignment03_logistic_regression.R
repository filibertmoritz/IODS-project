# assignment 3 - binomial logistic regression analysis
# written by Filibert Heim, filibert.heim@posteo.de
# date: 20.11.2023
# data source: http://www.archive.ics.uci.edu/dataset/320/student+performance (accessed at the 20th of November in 2023)

# load packages
library(tidyverse)

# load and explore data 
wd <- getwd()
mat <- read.csv(file = paste0(wd, '/data/student-mat.csv'), 
         header = T, sep = ';')
por <- read.csv(file = paste0(wd, '/data/student-por.csv'),  
                header = T, sep = ';')
str(mat) # 395 observations and 33 variables 
dim(mat)
str(por) # 649 obs. of  33 variables
dim(por)
names(mat) == names(por) # the variables seem to be the same, only # of observations varies between data sets

# join two datasets 

col_no_join <- c("failures", "paid", "absences", "G1", "G2", "G3")
vec_join_by <- names(mat)[-c(which(names(mat) %in% col_no_join))]


joined_data <- inner_join(x = mat, y = por, by = vec_join_by, keep = F) # keep = F drops rows that do not match
# View(joined_data)
str(joined_data)
dim(joined_data)

#deal with the duplicated students and their answers if they are different or delete in case they are equal
# first check which rows are equal and remove duplicated rows

#use the distinct function: keeps only unique rows while removing equal rows
test <- joined_data %>% distinct()
dim(test) #still the same dim, so there were no students that filled out the questionnaire and gave the same answers

# somehow I have the impression that I don't really understood the task 5, because it does not change the 
# data.frame dimensions. Thus, I will stop here doing the data preparation








