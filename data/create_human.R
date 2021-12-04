# Piritta Vesaniemi, 28.11.2021, Rscript file for data wrangling exercise

# Making libraries available
install.packages("openxlsx", "tidyverse", "ggplot2", "readr")
library(tidyverse)
library(openxlsx)
library(ggplot2)
library(readr)


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
# saving the old column names for further reference just in case (not required by the task)
old_names_hd <- colnames(hd)
old_names_gii <- colnames(gii)

# To be  on the safe side, I'll mask the "hd" and "gii" data with another name in order to save them from harm (not required by the task). 
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

# Now I'll revert back to using the original hd and gii names, by replacing the originals with the datasets that have modified column names 
hd <- tryhd
gii <- trygii

# Creating two new variables to the gender equality data, which is the "gii" dataset

# The first new variable is the ratio of Female and Male populations with secondary education in each country. 
gii <- mutate(gii, FM2Rat = F2Ed / M2Ed)

#The second new variable is the ratio of labour force participation of females and males in each country.
gii <- mutate(gii, FMLabourRat = FLabour / MLabour)

# Joining the two datasets by Country
hd_gii <- inner_join(hd, gii, by = "Country", suffix = c(".hd", ".gii"))
str(hd_gii)
# There are 195 observations of 19 variables.

# Saving modified and joined data as "human"
human <- hd_gii
path <- "C:/Users/35840/OneDrive - University of Helsinki/IODS/IODS-project/data"
write.csv(human, file.path(path, "human.csv"), row.names=FALSE)

#
# Week 5 task starts here!
#
# Reading the human data to R
human <- read.csv("C:/Users/35840/OneDrive - University of Helsinki/IODS/IODS-project/data/human.csv")

# Structure and dimensions of "human"
str(human)
dim (human)
# There are 195 observations of 19 variables. The variables are named 
# "HDIR" for HDI rank, "Country" for country, "HDIx" for Human development index, "LifeEx" for Life expectancy at birth,
# "ExEd" for Expected years of education, "MeanEdYears" for Mean years of education,  "GNI" for Gross National Income per capita,
# "GNIRlessHDIR" is GNI minus HDI rank, "GIIR" for GII rank, "GIIx" for Gender inequality index, "MotherDeathR" for Maternal mortality ratio,
# "AdolBirthR" for Adolescent birth rate, "RepInParl" for Percent of Representation in Parliament, 
# "F2Ed" for Female population with secondary education, "M2Ed" Male population with secondary education,
# "FLabour" for Female labour force participation rate, "MLabour" Male labour force participation rate, 
# "FM2Rat" for the new  ratio of Female and Male populations with secondary education in each country
# "FMLabourRat" for the new ratio of Female and Male populations labour force participation in each country. 

# Mutation of data: transform the Gross National Income (GNI) variable to numeric
# saving the non-mutated human data just in case (not required by the task)
savehuman <- human
# doing the actual  mutation, there is a need to change decimal commas to decimal dots for R to understand that it's a number
human$GNI <- as.numeric(gsub(",", ".", human$GNI)) 
# checking that the numeric values match the character values
human$GNI
# checking the structure of the dataframe
str(human)
# The GNI variable shows rounded values  "GNI         : num  65 42.3 56.4 44 45.4 ..." but the check above confirmed that the saved values have 3 decimals

# Excluding unnecessary columns, keeping those that match "Mat.Mor", "Ado.Birth", "Parli.F"
# to make things simpler, I'll rename my to-keep columns first with the task given column names:
oldnameshuman <- colnames(human)
colnames(human)[18] <- "Edu2.FM"
colnames(human)[19] <- "Labo.FM"
colnames(human)[5] <- "Edu.Exp"
colnames(human)[4] <- "Life.Exp"
colnames(human)[11] <- "Mat.Mor"
colnames(human)[12] <- "Ado.Birth"
colnames(human)[13] <- "Parli.F"
colnames(human)
# now let's keep only the columns "Country", "Edu2.FM", "Labo.FM", "Edu.Exp", "Life.Exp", "GNI", "Mat.Mor", "Ado.Birth", "Parli.F"
keep_columns <- c("Country", "Edu2.FM", "Labo.FM", "Edu.Exp", "Life.Exp", "GNI", "Mat.Mor", "Ado.Birth", "Parli.F")
human1 <- select(human, one_of(keep_columns))
colnames(human1)

# Now let's remove all rows with missing values from the new human1 dataset
human1 <- na.omit(human1)

