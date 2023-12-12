# data preparation script for 6th assignment in the course 'Introduction to Open Data Science'
# written by Filibert Heim, filibert.heim@posteo.de on the 11th of December 2023

# load packages and fix some functions that could cause errors
library('tidyverse')
library('corrplot')
library(GGally)
select <- dplyr::select
filter <- dplyr::filter
rename <- dplyr::rename

# load data
RATS <- read.table("https://raw.githubusercontent.com/KimmoVehkalahti/MABS/master/Examples/data/rats.txt", 
           header = TRUE, sep = '\t')
BPRS <- read.table("https://raw.githubusercontent.com/KimmoVehkalahti/MABS/master/Examples/data/BPRS.txt", 
                   sep  =" ", header = T)

# next task - As before, write the wrangled data sets to files in your IODS-project data-folder.
# I'm not sure what to do to fullfill this task

# explore data 
names(RATS)
head(RATS)
str(RATS) # print structure of the data, there could be some issues with ID and Group as int
summary(RATS) # brief summary of the variables 

names(BPRS)
head(BPRS)
str(BPRS) # print structure of the data, there could be some issues with ID and Group as int
summary(BPRS) # brief summary of the variables 

# make some adjustments
RATS <- RATS %>% mutate(ID = as.factor(ID), Group = as.factor(Group))
BPRS <- BPRS %>% mutate(treatment = as.factor(treatment), subject = as.factor(subject))

# convert to long format and add variables 
BPRSL <-  BPRS %>% 
  pivot_longer(cols = -c(treatment, subject),names_to = "weeks", values_to = "bprs") %>%
  arrange(weeks) %>% 
  mutate(week = as.integer(substr(x = weeks, start = 5, stop = 5)))
RATSL <- RATS %>% 
  pivot_longer(cols = -c(ID, Group), names_to = 'WD', values_to = 'Weight') %>% 
  mutate(Time = as.integer(substr(WD, start = 3, stop = 4))) %>%
  arrange(Time)

# take a SEROUS look at the data sets in long format...
names(RATSL) # only 5 variable names, less than in wide format (13)
dim(RATSL)
str(RATSL)
summary(RATSL) # weight with min 225 and max 628, mean of 384, not really balanced for Groups,
hist(RATSL$Weight) # this data looks confusing
names(BPRSL) # only 5 variable names, less than in wide format (11)
dim(BPRSL) # much more observations!
str(BPRSL) # its good to have the data in proper format like factors!
summary(BPRSL) # week 0-8; bprs from 18-95 with mean of 37.66, balanced treatment design
hist(BPRSL$bprs) # this data looks interesting!

# difference between long and wide format: long format contains only one combination of variables in a row - which makes them very practical for plotting; 
# wide format has data of each 'group' or 'week' in an extra column, its much harder to work with these structure in R

# export data
write.csv(BPRSL, file = 'Studium/Semester 7 (Erasmus)/Introduction to Open Data Science/IODS-project/data/bprsl_data.csv')
write.csv(RATSL, file = 'Studium/Semester 7 (Erasmus)/Introduction to Open Data Science/IODS-project/data/ratsl_data.csv')
