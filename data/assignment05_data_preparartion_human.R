# assignment 5 - data preparation 
# Filibert Heim, filibert.heim@posteo.de
# written on the 3rd of December in 2023

# load packages
library(readr)
library('tidyverse')
select <- dplyr::select
rename <- dplyr::rename
filter <- dplyr::filter
library('MASS')
library('finalfit')

# load data 
human <- read_csv("https://raw.githubusercontent.com/KimmoVehkalahti/Helsinki-Open-Data-Science/master/datasets/human1.csv")

# explore str and dim of human dataset
str(human)
dim(human)

# explain dataset briefly: The 'human' dataset is provided by United Nations Development Program and gives an overview of all the measurements and indices dealing with 'development' of countries worldwide. Therefor, the 'human' dataset contains HDI and connected variables for (nearly) all countries of the world. Generally, the HDI is computed fro 3 dimensions: life expectancy at birth, expected years of schooling/mean years of schooling and GNI per capita. 
# In detail, the dataset contains the following variables: 
## 'HDI.Rank' - Rank of HDI worlwide
## 'Country' - Country name
## 'HDI' - Human development index
## 'Life.Exp' - Life expectancy at birth
## 'Edu.Exp' - Expected years of schooling 
## 'Edu.Mean' - Mean years of schooling 
## 'GNI' - Gross National Income per capita
## 'GNI.Minus.Rank' - 
## 'GII.Rank' - Rank of GII worlwide
## 'GII' - Gender Inequality Index 
## 'Mat.Mor' - Maternal mortality ratio
## 'Ado.Birth' - Adolescent birth rate
## 'Parli.F' - Percetange of female representatives in parliament
## 'Edu2.F' - Proportion of females with at least secondary education
## 'Edu2.M' - Proportion of males with at least secondary education
## 'Labo.F' - Proportion of females in the labour force
## 'Labo.M' - Proportion of males in the labour force
## 'Edu2.FM' - Edu2.F / Edu2.M
## 'Labo.FM' - Labo2.F / Labo2.M

# for more information see also: https://hdr.undp.org/system/files/documents/technical-notes-calculating-human-development-indices.pdf

# exclude unneeded variables 
keep_var <- c("Country", "Edu2.FM", "Labo.FM", "Edu.Exp", "Life.Exp", "GNI", "Mat.Mor", "Ado.Birth", "Parli.F") # define variables we need
human <- human %>% select(all_of(keep_var)) # select variables we need

# remove all columns with missing values
remove <- complete.cases(human) # vector containing information about missing values in rows
human <- human %>% mutate(rem = remove) %>% 
  filter(rem == T) %>% 
  select(-rem)

# search for regions which are no countries and exclude them
human$Country # "Arab States", "East Asia and the Pacific", "Europe and Central Asia", "Latin America and the Caribbean", "South Asia", "Sub-Saharan Africa""World"
region <- c("Arab States","East Asia and the Pacific","Europe and Central Asia","Latin America and the Caribbean","South Asia","Sub-Saharan Africa","World") # define regions
human <- human %>% filter(!Country %in% region) # exclude regions

# check dim
dim(human)

# export data 
write_csv(human, file = 'data/human_dataset.csv')
