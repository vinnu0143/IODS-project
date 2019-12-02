# Arun Kumar Tonduru, 25/11/2019.
# Data Wrangling on Human development and Gender inequality data sets

#Read the datasets
hd <- read.csv("http://s3.amazonaws.com/assets.datacamp.com/production/course_2218/datasets/human_development.csv", stringsAsFactors = F)
gii <- read.csv("http://s3.amazonaws.com/assets.datacamp.com/production/course_2218/datasets/gender_inequality.csv", stringsAsFactors = F, na.strings = "..")


#Structure of the datasets
str(hd)
str(gii)

#Dimensions of the dataset
dim(hd)
dim(gii)

#Summary of the datasets
summary(hd)
summary(gii)

#Show Column names of the humnan development dataset
colnames(hd)

#Rename the columns with my own new short cuts

new_hd <- c("HDI.Rank","Country","HDI","Life.Exp","Edu.Exp","Edu.Mean","GNI","GNI.Minus.Rank")
new_gii <- c("GII.Rank", "Country", "GII","Mat.Mor","Ado.Birth","Parli.F","Edu2.F","Edu2.M","Labo.F","Labo.M")

colnames(hd) <-new_hd 
colnames(gii) <-new_gii  
colnames(hd)
colnames(gii)


library(dplyr); library(ggplot2)

gii <- mutate(gii, Edu2.FM = (Edu2.F / Edu2.M))
gii <- mutate(gii, Labo.FM = (Labo.F / Labo.M))

colnames(gii)

human <- inner_join(hd, gii, by = c("Country"), suffix = c(".hd", ".gii"))
colnames(human)
dim(human)

write.csv(human, file="C:/Users/vinnu/Documents/IODS-project/data/human.csv", row.names= FALSE)

human<- read.csv("C:/Users/vinnu/Documents/IODS-project/data/human.csv")
colnames(human)

#The final dataset contains 195 observations and 19 variables.


#Chapter5 

colnames(human)

human <- mutate(human, as.numeric(GNI))
keep <- c("Country", "Edu2.FM", "Labo.FM", "Life.Exp", "Edu.Exp", "GNI", "Mat.Mor", "Ado.Birth", "Parli.F")
human <- select(human, one_of(keep))

complete.cases(human)
human_ <- filter(human, complete.cases(human)== TRUE)


human$Country

last <- nrow(human_) - 7
human_ <- human_[1:last, ]

rownames(human_) <- human_$Country
human_ <- human_[ ,2:ncol(human_)]

dim(human_)
human <- human_

write.csv(human, file="C:/Users/vinnu/Documents/IODS-project/data/human.csv", row.names= TRUE)
human<- read.csv("C:/Users/vinnu/Documents/IODS-project/data/human.csv")
colnames(human)