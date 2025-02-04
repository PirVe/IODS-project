# Piritta Vesaniemi, 12.12.2021, Rscript file for data wrangling exercise

# making libraries available
install.packages("openxlsx", "dplyr", "ggplot2", "tidyr")
library(dplyr)
library(openxlsx)
library(ggplot2)
library(tidyr)

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

# Converting categorical variables to factor
BPRS$treatment <- factor(BPRS$treatment)
BPRS$subject <- factor(BPRS$subject)
RATS$ID <- factor(RATS$ID)
RATS$Group <- factor(RATS$Group)

# Converting both datasets to long form
BPRSL <-  BPRS %>% gather(key = weeks, value = bprs, -treatment, -subject)
RATSL <- RATS %>% gather(key = WD, value = Weight, -ID, -Group)
  
# Add the week column to BPRSL
BPRSL <-  BPRSL %>% mutate(week = as.integer(substr(weeks,5,5)))

# Add the time column to RATSL
RATSL <- RATSL %>% mutate(Time = as.integer(substr(WD,3,4))) 

# Glimpse the data to check variable names and data contents
glimpse(RATSL)
glimpse(BPRSL)

# Check the structure of the data
str(RATSL)
str(BPRSL)
# Now the first variables of both datasets are factors. RATSL includes the variable Time and BPRSL includes the variable Week.
# In this long form, it is possible to track the observations per subject as the time goes on.

# Saving the modified long form datasets
ratsl <- RATSL
path <- "C:/Users/35840/OneDrive - University of Helsinki/IODS/IODS-project/data"
write.csv(ratsl, file.path(path, "ratsl.csv"))

bprsl <- BPRSL
write.csv(bprsl, file.path(path, "bprsl.csv"))

