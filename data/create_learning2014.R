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
