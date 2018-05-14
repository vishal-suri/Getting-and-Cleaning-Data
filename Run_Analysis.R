##load dplyr
library(dplyr)

## Read the activity labels and feature labels
setwd("~/UCI HAR Dataset")
actlabel <- read.table("activity_labels.txt")
featurelabel <- read.table("features.txt")


## Read Training dataset into training files

setwd("~/UCI HAR Dataset/train")
subject_train <- read.table("subject_train.txt")
activity_train <- read.table("X_train.txt")
label_train <- read.table("y_train.txt")

## Merge training set into single file; 
## Map activity codes with activity
## Map feature variables with feature descriptions
label_train <- merge(label_train,actlabel,by.x="V1",by.y="V1")
label_train <- rename(label_train,actcode="V1",activity="V2")
subject_train <- rename(cbind(subject_train,label_train),subject="V1")
colnames(activity_train) <- as.character(featurelabel$V2)
activity_train <- cbind(select(subject_train,"subject","activity"),activity_train)

## Read Testing dataset into testing files
setwd("~/UCI HAR Dataset/test")
subject_test <- read.table("subject_test.txt")
activity_test <- read.table("X_test.txt")
label_test <- read.table("y_test.txt")

## Merge testing set into single file
## Map activity codes with activity
## Map feature variables with feature descriptions

label_test <- merge(label_test,actlabel,by.x="V1",by.y="V1")
label_test <- rename(label_test,actcode="V1",activity="V2")
subject_test <- rename(cbind(subject_test,label_test),subject="V1")
colnames(activity_test) <- as.character(featurelabel$V2)
activity_test <- cbind(select(subject_test,"subject","activity"),activity_test)

## Merge train and test set into single file
activity_total <- rbind(activity_train,activity_test)

## Find cols with only means or std deviations in the merged table
relevant_cols <- c(1,2,grep("mean",colnames(activity_total)),grep("std",colnames(activity_total)))
relevant_cols <- sort(relevant_cols)

## subset merged table into relevant table
relevant_table <- activity_total[,relevant_cols]

## create an index for unique entries by subject and activity
temp1 <- mutate(relevant_table,index=paste(relevant_table$subject,relevant_table$activity))

## group by that index, 
## remove the individual subject and activity columns
## and find means of all columns

temp2 <- group_by(temp1[3:82],index)
final_output <- temp2 %>% group_by(index) %>% summarise_all(mean,na.rm=TRUE)
write.table(final_output,file="~/UCI HAR Dataset/final_output.txt")

