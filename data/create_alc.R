# Arun Kumar Tonduru 15.11.2019 - RStudio exercise #3 for the IODS course

# Data source: Paulo Cortez, University of Minho, GuimarÃ£es, Portugal, http://www3.dsi.uminho.pt/pcortez. 

#Read math csv into memory
math <- read.table(file = "C:/Users/vinnu/Documents/IODS-project/data/student-mat.csv",  header=TRUE, sep=";")

#Explore column names in math
colnames(math)

#Check the structure of the math 
str(math)

#Read por csv into memory
por <- read.csv(file = "C:/Users/vinnu/Documents/IODS-project/data/student-por.csv",  header=TRUE, sep=";")

#Explore column namesin por
colnames(por)

#Check the structure of the por 
str(por)

#Check dimensions of the both math and por
dim(math)
dim(por)

#load library diplyr for use
library(dplyr)

# common columns to use as identifiers
join_by <- c("school","sex","age","address","famsize","Pstatus","Medu","Fedu","Mjob","Fjob","reason","nursery","internet")  

# Merge the two datasets by the selected identifiers
math_por <- inner_join(math, por, by = join_by, suffix = c(".math", ".por"))

#Explore the column names in merged dataset
colnames(math_por)

#Explore the structure and dimensions of merged dataset
glimpse(math_por)

#After merge there are around 382 observations and 53 variables


# create a new data frame with only the joined columns
alc <- select(math_por, one_of(join_by))

# columns that were not used for joining the data
notjoined_columns <- colnames(math)[!colnames(math) %in% join_by]

# print out the columns not used for joining
notjoined_columns

# for every column name not used for joining...
for(column_name in notjoined_columns) {
  # select two columns from 'math_por' with the same original name
  two_columns <- select(math_por, starts_with(column_name))
  # select the first column vector of those two columns
  first_column <- select(two_columns, 1)[[1]]
  
  # if that first column  vector is numeric...
  if(is.numeric(first_column)) {
    # take a rounded average of each row of the two columns and
    # add the resulting vector to the alc data frame
    alc[column_name] <- round(rowMeans(two_columns))
  } else { # else if it's not numeric...
    # add the first column vector to the alc data frame
    alc[column_name] <- first_column
  }
}

# glimpse at the new combined data
glimpse(alc)

# access the 'tidyverse' packages dplyr and ggplot2
library(dplyr); library(ggplot2)

# define a new column alc_use by combining weekday and weekend alcohol use
alc <- mutate(alc, alc_use = (Dalc + Walc) / 2)

# initialize a plot of alcohol use
g1 <- ggplot(data = alc, aes(x = alc_use, fill = sex))

# define the plot as a bar plot and draw it
g1 + geom_bar()

# define a new logical column 'high_use'
alc <- mutate(alc, high_use = alc_use > 2)

# initialize a plot of 'high_use'
g2 <- ggplot(alc, aes(high_use))

# draw a bar plot of high_use by sex
g2 + facet_wrap("sex") + geom_bar()

#view the structure and dimensions of alc
glimpse(alc)

#write the final output to csv file
write.csv(alc, file = "C:/Users/vinnu/Documents/IODS-project/data/Merged_alc.csv", quote = TRUE, row.names = F)