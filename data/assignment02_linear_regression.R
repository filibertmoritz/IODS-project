# script written by Filibert Heim, filibert.heim@posteo.de
# date: 10.11.2023
# this script is part of the course 'open data science', assignment 2
# topic: linear regression 

##### 1.1. get started: load packages, data etc #####

library('tidyverse') # load tidyverse packeges 
rename <- dplyr::rename # avoid struggles with function name conflicts
select <- dplyr::select
filter <- dplyr::filter
# install.packages('data.table')
library('data.table')
library('finalfit')

##### 1.2. load data: that refers to task 2 ####

# load data
data1 <- read_table(file = url('https://www.mv.helsinki.fi/home/kvehkala/JYTmooc/JYTOPKYS3-data.txt'))
data2 <- read.table(file = 'Studium/Semester 7 (Erasmus)/Introduction to Open Data Science/IODS-project/data/JYTOPKYS3-data.txt', sep = '\t', header = T)
data1 == data2 # hm, something went wrong with the direct load from the website, cant find the problem with this function, will go on with the 'classical' approach by loading from a file 
data3 <- fread('https://www.mv.helsinki.fi/home/kvehkala/JYTmooc/JYTOPKYS3-data.txt') # load directly with another function from data.table package
str(data2)
str(data3) # now it seems to work properly 
data <- data2 # create data.frame 'data' for further data wrangling and analysis
rm(list = c('data1', 'data2', 'data3')) # remove 'old' objects from global environment

# explore data 
dim(data) # there are 183 observations of 60 variables in this dataset
head(data) # ohhhh, most values are seem to be integer and somehow the column names seem to be a bit cryptic to me
str(data) # gender: chr data type (would be good to have this as factors), all other values are integer
summary(data) # phuuu, there is a lot:D

# change data type from gender
data$gender <- as.factor(data$gender)

##### 1.3. create analysis dataset: refers to task 3 ####

# create new dataset, works only one time!
data <- data %>% # select nessecarry variables and compute missing ones
  mutate(Stra = ((ST01+ST09+ST17+ST25)+(ST04+ST12+ST20+ST28)) %>% ff_label('Strategic approach'), 
         Deep = ((D03+D11+D19+D27)+(D07+D14+D22+D30)+(D06+D15+D23+D31)) %>% ff_label('Deep approach'), 
         Surf = ((SU02+SU10+SU18+SU26)+(SU05+SU13+SU21+SU29)+(SU08+SU16+SU24+SU32)) %>% ff_label('Surface approach')) %>% 
  rename(Gender = gender) %>%
  select(Gender, Age, Attitude, Deep, Stra, Surf, Points)
data <- data %>% filter(!Points == 0) # filter for points = 0
data <- data %>% 
  mutate(Stra = Stra/8, Deep = Deep/12, Surf = Surf/12) # I really have no 
# clue to what the task refers by scale to iriginal scale, normally this is done 
# by scale, but here it says that it should be done by taking the mean, using mean() 
# makes no sense, so I computed the mean by dividing with the number columns that were 
# used to compute the values... 
dim(data) # dimensions fit the data provided in the task

##### 1.4. some more preperations: refers to task 4 #####

# set working directory 
getwd() # get current working directory
setwd('Studium/Semester 7 (Erasmus)/Introduction to Open Data Science/IODS-project/')

# save data set in data folder with baseR
write.csv2(data, file = 'data/assignment02_data.csv')
base <- read.csv(file = 'data/assignment02_data.csv', sep = ';', dec = ',', header = T)
head(base)
str(base)

# save data set using readr (from tidyverse)
write_csv(data, file = 'data/assignment02_data2.csv')
read <- read_csv(file = 'data/assignment02_data2.csv') # dont know how to deal with this warning message, but I guess the column specifications aren't that important
head(read)
str(read)

# everything went right! - remove objects again from global environment
rm(list = c('base', 'read'))

