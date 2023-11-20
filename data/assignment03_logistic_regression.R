# assignment 3 - binomial logistic regression analysis
# written by Filibert Heim, filibert.heim@posteo.de
# date: 20.11.2023
# data source: http://www.archive.ics.uci.edu/dataset/320/student+performance (accessed at the 20th of November in 2023)

# load and explore data 
mat <- read.csv(file = 'Studium/Semester 7 (Erasmus)/Introduction to Open Data Science/IODS-project/data/student-mat.csv', 
         header = T, sep = ';')
por <- read.csv(file = 'Studium/Semester 7 (Erasmus)/Introduction to Open Data Science/IODS-project/data/student-por.csv', 
                header = T, sep = ';')
str(mat) # 395 observations and 33 variables 
dim(mat)
str(por) # 649 obs. of  33 variables
dim(por)
names(mat) == names(por) # the variables seem to be the same, only # of observations varies between data sets

# join two datasets 
View(merge(x = mat, y = por, by = names(por)[c(1:14,16:17,19:29)]))

inner_join(x = mat, y = por, by = names(por)[c(1:14,16:17,19:29)], keep = F)

names(por)[c(1:14,16:17,19:29)]

?inner_join()
