

#Setting the workspace directory
setwd("C:/Users/renat/Desktop/ProjetosDS/Data-Testing-and-Scraping/")

#Testing the path
getwd()

#Well, I tried here to practice some testing with data. I'm using a dataset from kaggle
#It's called Titanic. My focus here is to test and force some situations :)


#importing the data from local storage
titanic<- read.csv('train.csv')

#For the first moment the data has 891 entries and 12 columns,
#but to force some testing I'm deleting one entire row
titanic2 <- titanic[-nrow(titanic),]

#One row for the SECOND TEST

#Viewing the dataset
View(titanic2)


#FIRST TEST: Verify missing data for all the columns
#Results show that there are 177 missing data from the column "Age"
sapply(titanic2, function(x) sum(is.na(x)))


#SECOND TEST: Verify Incomplete dataset at hand. For some reason(I deleted some data), I don't have all the data.
#This dataset contains at this moment 890 lines. Maybe the client or web site has the information that exists 891 entries
#and that information can be used:
nrow(titanic2)
#This dataset contains 12 columns
ncol(titanic2)

#ERRONEOUS: For this THIRD TEST on the dataset, I need to change the values of the column: "Pclass".
#Originally, the dataset has numbers at the Pclass column:
titanic2$Pclass <- gsub('1','TEST ASDF',titanic2$Pclass)
titanic2$Pclass <- gsub('2','TEST QWER',titanic2$Pclass)
titanic2$Pclass <- gsub('3','TEST YUIO',titanic2$Pclass)

#Looking the dataset again: All the column lost the numbers. I want in this test to see if
#column have the same value as required by the documentation. The documentation could've the information
#that this column needs the values 1,2,3 for the class. As well as on that pseudo website.

#Importing a Library to work with strings
library(stringr)
?str_sub

#FOURTH TEST: looking for partial data in a column
#This code below was made to remember to compare the data of a web page,
#considering an Use Case Test Data, and what I am seeing on the database

titanic3$Name <- str_sub(titanic2$Name, end=-4)
head(titanic3)
View(titanic3)
#I just altered the data to practice the concept for partial data.

#Now I have issues with my data. I can describe some bugs I found.


#------------------------------------------------------------#

#SCRAPING:

install.packages('rvest')
library(rvest)

library(stringr)

#To filter
library(dplyr)

#Read
library(readr)


#Loading data from the web page
webpage <- read_html("https://www.nytimes.com/2019/10/21/science/quantum-computer-physics-qubits.html?fallback=0&recId=1SXRW31AlS1X0vvVmLes1l0zTXV&locked=0&geoContinent=SA&geoRegion=PB&recAlloc=control&geoCountry=BR&blockId=home-discovery-vi-prg&imp_id=685937177&action=click&module=Science%20%20Technology&pgtype=Homepage")

#Seeing the content:
webpage
#It's a XML document now. The function read_html turned it into this type of file.

#<title data-rh="true">Quantum Computing Is Coming, Bit by Qubit - The New York Times</title>

#Filtering the title tag
result <- webpage %>% html_nodes("title")
head(result)

#Taking the record
record <- result %>% html_text(trim = TRUE)

#Seeing the record
record

#Transforming in a dataframe
df<-data.frame(record)

#And saving in a file :)
write_csv(df, "test.csv")

