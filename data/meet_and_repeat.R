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
write.csv(rats, file.path(path, "rats.csv"), row.names=TRUE)

bprs <- BPRS
write.csv(bprs, file.path(path, "bprs.csv"), row.names=TRUE)

# Look at the (column) names of BPRS
names(BPRS)

# Look at the structure of BPRS
str(BPRS)

# Print out summaries of the variables
summary(BPRS)

# Look at the (column) names of RATS
names(RATS)

# Look at the structure of BPRS
str(RATS)

# Print out summaries of the variables
summary(RATS)
