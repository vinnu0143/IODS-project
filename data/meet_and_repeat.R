# Arun Kumar Tonduru 
# Data wrangling for logitudinal data

library(dplyr); 
library(tidyr)
# Reading data

BPRS <- read.table("https://raw.githubusercontent.com/KimmoVehkalahti/MABS/master/Examples/data/BPRS.txt",
                   sep = " ", header = TRUE)

str(BPRS)
colnames(BPRS)
summary(BPRS)

RATS <- read.table("https://raw.githubusercontent.com/KimmoVehkalahti/MABS/master/Examples/data/rats.txt", 
                   sep = "\t", header = TRUE)

str(RATS)
colnames(RATS)
summary(RATS)


# convert to factors

BPRS$treatment <- factor(BPRS$treatment)
BPRS$subject <- factor(BPRS$subject)

RATS$ID <- factor(RATS$ID)
RATS$Group <- factor(RATS$Group)

# convert to long form

BPRSL <- BPRS %>% gather(key = weeks, value = bprs, -treatment, -subject)
BPRSL <- BPRSL %>% mutate(week = as.integer(substr(BPRSL$weeks, 5,5)))


RATSL <- RATS %>% gather(key = WD, value = weight, -ID, -Group)
RATSL <- RATSL %>% mutate(Time = as.integer(substr(RATSL$WD, 3, 4)))
glimpse(RATSL)

#glimpse and summary
colnames(BPRSL)
str(BPRSL)
summary(BPRSL)

colnames(RATSL)
str(RATSL)
summary(RATSL)
#summary
#write files
write.csv(RATSL, file ="data/RATSL.csv", row.names = FALSE)
write.csv(BPRSL, file ="data/BPRSL.csv", row.names = FALSE)