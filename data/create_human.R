# Piritta Vesaniemi, 28.11.2021, Rscript file for data wrangling exercise

# Making libraries available
install.packages("openxlsx", "tidyverse", "ggplot2")
library(tidyverse)
library(openxlsx)
library(ggplot2)


# Read the data into RStudio
hd <- read.csv("http://s3.amazonaws.com/assets.datacamp.com/production/course_2218/datasets/human_development.csv", stringsAsFactors = F)
gii <- read.csv("http://s3.amazonaws.com/assets.datacamp.com/production/course_2218/datasets/gender_inequality.csv", stringsAsFactors = F, na.strings = "..")

# Looking at dimensions and structure
dim(hd)
str(hd)
dim(gii)
str(gii)
# There are 195 observations of 8 variables in "hd" and 195 observations of 10 variables in "gii"

#taking a go at renaming columns
# saving the old column names for further reference just in case
old_names_hd <- colnames(hd)
old_names_gii <- colnames(gii)

# To be  on the safe side, I'll mask the "hd" and "gii" data with another name in order to save them from harm. 
# The data will be essentially the same, but all operations are performed on a doppelgänger.
# This operation does not affect the end result of the wrangling.
tryhd <- hd
trygii <- gii

# checking current column names
colnames(tryhd)
colnames(trygii)

# creating a string vector for new names
new_names_hd <- c("HDIR", "Country", "HDIx", "LifeEx", "ExEd", "MeanEdYears", "GNI", "GNIRlessHDIR")
new_names_gii <- c("GIIR", "Country", "GIIx", "MotherDeathR", "AdolBirthR", "RepInParl", "F2Ed", "M2Ed", "FLabour", "MLabour")

# Finally, renaming columns
colnames(tryhd) = new_names_hd
colnames(trygii) = new_names_gii

# Here we can see that it worked and that the data frame structure is intact
str(tryhd)
str(trygii)


