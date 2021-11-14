# Piritta Vesaniemi, 14.11.2021, Rscript file for data wrangling exercise
# step 1 completed

# Reading the data from http://www.helsinki.fi/~kvehkala/JYTmooc/JYTOPKYS3-data.txt
learning2014 <- read.table("http://www.helsinki.fi/~kvehkala/JYTmooc/JYTOPKYS3-data.txt", sep="\t", header=TRUE)

# Exploring dimensions of learning2014
dim(learning2014)
# Output: 183 rows, 60 columns

# Exploring structure of learning2014
str(learning2014)
# Output: a few rows and a few columns with values and value types
# step 2 completed 

# Creating an analysis dataset

# Accessing the dplyr library
install.packages("dplyr")
library(dplyr)

# combining questions for deep, surface and strategic learning
deep_questions <- c("D03", "D11", "D19", "D27", "D07", "D14", "D22", "D30","D06",  "D15", "D23", "D31")
surface_questions <- c("SU02","SU10","SU18","SU26", "SU05","SU13","SU21","SU29","SU08","SU16","SU24","SU32")
strategic_questions <- c("ST01","ST09","ST17","ST25","ST04","ST12","ST20","ST28")

# Selecting the columns from learning2014 and scaling them by taking the mean
deep_columns <- select(learning2014, one_of(deep_questions))
learning2014$deep <- rowMeans(deep_columns)

surface_columns <- select(learning2014, one_of(surface_questions))
learning2014$surf <- rowMeans(surface_columns)

strategic_columns <- select(learning2014, one_of(strategic_questions))
learning2014$stra <- rowMeans(strategic_columns)

# Scaling the column "Attitude" to mean by dividing it by the sum of 10 questions to get it back to Likert scale 1-5
learning2014$attitude <- learning2014$Attitude / 10

# Checking current column names in learning2014
colnames(learning2014)

# choosing the columns to keep and creating a new dataset with them
keep_columns <- c("gender","Age","attitude", "deep", "stra", "surf", "Points")
lrn2014 <- select(learning2014, one_of(keep_columns))

# checking the stucture of the new dataset lrn2014
str(lrn2014)

# renaming columns Age and Points
colnames(lrn2014)[2] <- "age"
colnames(lrn2014)[7] <- "points"

# Excluding observations where the exam points variable is zero by filtering for greater than 0 values
lrn2014 <- filter(lrn2014, points > 0)
#Output: 166 observations of 7 variables
# step 3 completed

# Setting the project folder to IODS-project
setwd("C:/Users/35840/OneDrive - University of Helsinki/IODS/IODS-project")
getwd()

# Saving analysis dataset lrn2014 to csv file
write.csv(lrn2014, file = "lrn2014.csv")

# Checking readability and structure of lrn2014.csv
read.csv("lrn2014.csv")
str(lrn2014)
head(lrn2014)
