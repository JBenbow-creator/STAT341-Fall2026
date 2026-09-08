#Author.Jashawn Benbow,Date:9/8/2026,Purpose:ANOVA analysis

#Load package ggplot2
library(ggplot2)

#Load the dataset
PATH <- "https://raw.githubusercontent.com/guru99-edu/R-Programming/master/poisons.csv" 

df <- read.csv(PATH) 

#Create a hypothesis: Alternate hypothesis: There is a significant difference for survival with poison type 1 compared types 2 and 3
# Null hypothesis: There is no significant difference between 1 and other 2 poisons.

#Plot the dataset using library ggplot2