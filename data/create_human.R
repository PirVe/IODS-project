# Piritta Vesaniemi, 28.11.2021, Rscript file for data wrangling exercise

# Read the data into RStudio
hd <- read.csv("http://s3.amazonaws.com/assets.datacamp.com/production/course_2218/datasets/human_development.csv", stringsAsFactors = F)
gii <- read.csv("http://s3.amazonaws.com/assets.datacamp.com/production/course_2218/datasets/gender_inequality.csv", stringsAsFactors = F, na.strings = "..")

# Looking at dimensions and structure
dim(hd)
str(hd)
dim(gii)
str(gii)
# There are 195 observations of 8 variables in "hd" and 195 observations of 10 variables in "gii"
