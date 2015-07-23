##Check for existence of zip file and download file if necessary

if(!file.exists("getdata-projectfiles-UCI HAR Dataset.zip")){
        download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip",destfile="getdata-projectfiles-UCI HAR Dataset.zip")
}

##unzip the file

unzip("getdata-projectfiles-UCI HAR Dataset.zip")

##install the required packages and loads them into R
install.packages("plyr")
install.packages("dplyr")
install.packages("reshape2")
install.packages("stringr")

library(plyr)
library(dplyr)
library(reshape2)
library(stringr)

## Step 1 : Merges the training and test sets to create one data set

## read all the necessary "train" files
ytrain<-read.table("./UCI HAR Dataset/train/y_train.txt")
xtrain<-read.table("./UCI HAR Dataset/train/X_train.txt")
subjecttrain<-read.table("./UCI HAR Dataset/train/subject_train.txt")

##read all the necessary "test" files
ytest<-read.table("./UCI HAR Dataset/test/y_test.txt")
xtest<-read.table("./UCI HAR Dataset/test/X_test.txt")
subjecttest<-read.table("./UCI HAR Dataset/test/subject_test.txt")

##read the features files which has the names for all variables
features<-read.table("./UCI HAR Dataset/features.txt")
feature_names<-features[,2]

##rename the columns in the "x" files to the variable names
colnames(xtrain)<-feature_names
colnames(xtest)<-feature_names

##rename the column in the "y" files to "activity"
colnames(ytrain)<-"activity"
colnames(ytest)<-"activity"

##renames the column in the "subject" files to "subject"
colnames(subjecttrain)<-"subject"
colnames(subjecttest)<-"subject"

##column binds the train and test dataframes so that both dataframes have the subject, activity and variables
train<-cbind(subjecttrain,ytrain,xtrain)
test<-cbind(subjecttest,ytest,xtest)

##combine the train and test dataframes into 1 dataframe with all the "test" and "train" data
all<-rbind(train,test) 

## Step 1 Completed

## Step 2 : Extracts only the measurements on the mean and standard deviation for each measurement 

##specify the columns that are wanted to be retained i.e. any variable with "mean", "std" and the subject and activity columns
meanstd<- grepl("mean()",colnames(all)) | grepl("std()",colnames(all)) | grepl("subject()",colnames(all)) | grepl("activity()",colnames(all))

all_meanstd<- all[,meanstd]

## Step 2 Completed (includes meanFreq)

## Step 3 : Uses descriptive activity names to name the activities in the data set

##read the activity names
activity_labels<-read.table("./UCI HAR Dataset/activity_labels.txt")

##renames the columns to activity (which is the id) and the activity name
colnames(activity_labels)<-c("activity","activity_name")

##merge the activity names to the dataframe by the id
all_meanstd <- merge(activity_labels,all_meanstd,by.x="activity",by.y="activity",all=TRUE)

## Step 3 Completed

## Step 4 : Appropriately labels the data set with descriptive variable names.

##find and replace the names to be renamed
names(all_meanstd) <- str_replace_all(names(all_meanstd), "[.][.]", "")
names(all_meanstd) <- str_replace_all(names(all_meanstd), "BodyBody", "Body")
names(all_meanstd) <- str_replace_all(names(all_meanstd), "Acc", "Acceleration")
names(all_meanstd) <- str_replace_all(names(all_meanstd), "Gyro", "Angle")
names(all_meanstd) <- str_replace_all(names(all_meanstd), "Mag", "Magnitude") 

## Step 4 Completed

## Step 5 : From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

##melt data for easier manipulation
data_melt <- melt(all_meanstd,id=c("activity","activity_name","subject"))

##use dcast function to calculate the mean of all variables
mean_data <- dcast(data_melt,activity + activity_name + subject ~ variable,mean)

##Step 5 Completed

write.table(mean_data,"tidy_data.txt",row.name=FALSE)
