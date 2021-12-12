# Piritta Vesaniemi, 12.12.2021, Rscript file for data wrangling exercise

# making libraries available
install.packages("openxlsx", "dplyr", "ggplot2")
library(dplyr)
library(openxlsx)
library(ggplot2)

# Reading the datasets BPRS and RATS, noting that the separator is different in both
BPRS <- read.table("https://raw.githubusercontent.com/KimmoVehkalahti/MABS/master/Examples/data/BPRS.txt", sep  =" ", header = T)
RATS <- read.table("https://raw.githubusercontent.com/KimmoVehkalahti/MABS/master/Examples/data/rats.txt", sep  ="\t", header = T)

# Saving the datasets as files to my project:
rats <- RATS
path <- "C:/Users/35840/OneDrive - University of Helsinki/IODS/IODS-project/data"
write.csv(rats, file.path(path, "rats.csv"))

bprs <- BPRS
write.csv(bprs, file.path(path, "bprs.csv"))

# Look at the (column) names of BPRS
names(BPRS)
# The column names are treatment, subject, week0-8

# Look at the structure of BPRS
str(BPRS)
# there are 40 observations of 11 variables, all type "int"

# Print out summaries of the variables
summary(BPRS)
# The mean each week goes down, starting from 48 and ending with 31.43. 

# Look at the (column) names of RATS
names(RATS)
# The names are ID, Group,  WD1,  WD8, WD15, WD2, WD29, WD36, WD43, WD44, WD50, WD57, WD64 

# Look at the structure of BPRS
str(RATS)
# There are 16 observations of 13 variables

# Print out summaries of the variables
summary(RATS)
# Just as with the BPRS dataset, the summaries of the first two variables do not really tell anything, because they signify the individual rat and group.



