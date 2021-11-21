# Piritta Vesaniemi, 21.11.2021, Rscript file for data wrangling exercise

# making libraries available
install.packages("openxlsx", "dplyr")
library(dplyr)
library(openxlsx)

# Reading the datasets student-mat and student-por
math <- read.table("C:/Users/35840/OneDrive - University of Helsinki/IODS/IODS-project/data/student-mat.csv", sep = ";" , header=TRUE)
por <- read.table("C:/Users/35840/OneDrive - University of Helsinki/IODS/IODS-project/data/student-por.csv", sep = ";" , header=TRUE)

# joining the datasets following https://raw.githubusercontent.com/rsund/IODS-project/master/data/create_alc.R

# Define own id for both datasets
por_id <- por %>% mutate(id=1000+row_number()) 
math_id <- math %>% mutate(id=2000+row_number())

# Which columns vary in datasets
free_cols <- c("id","failures","paid","absences","G1","G2","G3")

# The rest of the columns are common identifiers used for joining the datasets
join_cols <- setdiff(colnames(por),free_cols)

pormath_free <- por_id %>% bind_rows(math_id) %>% select(one_of(free_cols))

# Combine datasets to one long data
#There are NO 382 but 370 students that belong to both datasets
pormath <- por_id %>% 
  bind_rows(math_id) %>%
  # Aggregate data (more joining variables than in the example)  
  group_by(.dots=join_cols) %>%  
  # Calculating required variables from two obs  
  summarise(                                                           
    n=n(),
    id.p=min(id),
    id.m=max(id),
    failures=round(mean(failures)),     #  Rounded mean for numerical
    paid=first(paid),                   #    and first for chars
    absences=round(mean(absences)),
    G1=round(mean(G1)),
    G2=round(mean(G2)),
    G3=round(mean(G3))    
  ) %>%
  # Remove lines that do not have exactly one obs from both datasets
  #   There must be exactly 2 observations found in order to joining be succesful
  #   In addition, 2 obs to be joined must be 1 from por and 1 from math
  #     (id:s differ more than max within one dataset (649 here))
  filter(n==2, id.m-id.p>650) %>%  
  # Join original free fields, because rounded means or first values may not be relevant
  inner_join(pormath_free,by=c("id.p"="id"),suffix=c("",".p")) %>%
  inner_join(pormath_free,by=c("id.m"="id"),suffix=c("",".m")) %>%
  # Calculate other required variables  
  ungroup %>% mutate(
    alc_use = (Dalc + Walc) / 2,
    high_use = alc_use > 2,
    cid=3000+row_number()
  )

# Save created data to folder 'data' as an Excel worksheet
write.xlsx(pormath, file="C:/Users/35840/OneDrive - University of Helsinki/IODS/IODS-project/datapormath.xlsx")
