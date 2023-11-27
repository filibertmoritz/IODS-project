# assignment 4 - data preparation for week 5 
# Filibert Heim, filibert.heim@posteo.de
# written on the 27th of November in 2023

# NB: I saved the file with another name to fit better in my folder structure

# load packages
library(readr)
library('tidyverse')
select <- dplyr::select
rename <- dplyr::rename
filter <- dplyr::filter
library('MASS')
library('finalfit')

# load data
hd <- read_csv("https://raw.githubusercontent.com/KimmoVehkalahti/Helsinki-Open-Data-Science/master/datasets/human_development.csv")
gii <- read_csv("https://raw.githubusercontent.com/KimmoVehkalahti/Helsinki-Open-Data-Science/master/datasets/gender_inequality.csv", na = "..")

# explore data first hd, afterwards gii
dim(hd)
head(hd)
str(hd)
summary(hd)
dim(gii)
head(gii)
str(gii)
summary(gii)

# rename variables - its possible with names() or rename()
names(hd) # check names 
hd <- hd %>% rename(HDI_rank = `HDI Rank`, HDI = `Human Development Index (HDI)`,
              Life.Exp = `Life Expectancy at Birth`, Edu.Exp = `Expected Years of Education`, 
              edu_mean = `Mean Years of Education`, GNI = `Gross National Income (GNI) per Capita`, 
              GNU_HDI_rank = `GNI per Capita Rank Minus HDI Rank`) # the task is not clear: should I rename all or only the varibles mentioned at the git page?
names(gii)
gii <- gii %>% rename(GII.Rank = `GII Rank`, GII = `Gender Inequality Index (GII)`, Mat.Mor = `Maternal Mortality Ratio`,
               Adol.Birth = `Adolescent Birth Rate`, Parli = `Percent Representation in Parliament`, 
               Edu2.F = `Population with Secondary Education (Female)`, Edu2.M = `Population with Secondary Education (Male)`, 
               Labo2.F = `Labour Force Participation Rate (Female)`, Labo2.M = `Labour Force Participation Rate (Male)`) 

# compute new variables 
gii <- gii %>% mutate(Edu2.FM = Edu2.F / Edu2.M, 
                      Labo.FM = Labo2.F / Labo2.M)

# join datasets
human <- inner_join(x = hd, y = gii, by = 'Country') # looks like everything worked
dim(human)
head(human)
