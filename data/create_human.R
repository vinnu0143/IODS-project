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

new_hd <- c("HDI_Rank","Country","HDI","Life_Exp","Edu_Exp","Edu_Mean","GNI","GNI_Minus_Rank")
new_gii <- c("GII_Rank", "Country", "GII","Mat_Mor","Ad_Birth","Parli_F","Edu2F","Edu2M","LabF","LabM")

colnames(hd) <-new_hd 
colnames(gii) <-new_gii  
colnames(hd)
colnames(gii)


library(dplyr); library(ggplot2)

gii <- mutate(gii, Edu2FM = (Edu2F / Edu2M))
gii <- mutate(gii, LabFM = (LabF / LabM))

colnames(gii)

human <- inner_join(hd, gii, by = c("Country"), suffix = c(".hd", ".gii"))
colnames(human)
dim(human)

write.csv(human, file="C:/Users/vinnu/Documents/IODS-project/data/human.csv", row.names= FALSE)

human<- read.csv("C:/Users/vinnu/Documents/IODS-project/data/human.csv")
colnames(human)

#The final dataset contains 195 observations and 19 variables.