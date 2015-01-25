#run_analysis.R
library(plyr)

#This script is for course project in "Getting and Cleanning Data"
#The original Samsung data is at:https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 
#To run this script, the Samsung data which is enclosed in directory UCI HAR Dataset should be downloaded to the main
#directory where this script is in

#This script aims to process the original datasets by completing following 5 steps:
#-----------------------------------------------------------
#1.Merge the training and test sets to create one data set.
#preparing training set
#loading the training sets
x_train<-read.table("./UCI HAR Dataset/train/X_train.txt")
y_train<-read.table("./UCI HAR Dataset/train/y_train.txt")
subject_train<-read.table("./UCI HAR Dataset/train/subject_train.txt")
#merge 3 training sets into on training set
train<-cbind(y_train,subject_train,x_train)

#preparing test set
#loading the test sets
x_test<-read.table("./UCI HAR Dataset/test/X_test.txt")
y_test<-read.table("./UCI HAR Dataset/test/y_test.txt")
subject_test<-read.table("./UCI HAR Dataset/test/subject_test.txt")
#merging 3 test sets into on test set
test<-cbind(y_test,subject_test,x_test)

#merging training and test sets to one data set
myData<-rbind(train,test)
#-------------------------------------------------------------
#2.Extracts only the measurements on the mean and standard deviation for each measurement. 
#get all varible(feature) names
#loading features which has dim=nx2 and the 2nd column has feature description
features<-read.table("./UCI HAR Dataset/features.txt")
features.desc<-features[,2]

#find a logical vector which is true only when the corresponding varible's name contains "mean"
mn<-grepl("mean",features.desc)
#find a logical vector which is true only when the corresponding varible's name contains "std"
stdn<-grepl("std",features.desc)
#mn or stdn
meanOrStd<-mn | stdn
#so the measurements which feature mean or std
features.meanOrStd<-features.desc[meanOrStd]
#the corresponding dataset is
#keepping the varibles activity and subject in the dataset
extrData<-myData[c(T,T,meanOrStd)]

#--------------------------------------------------------------
#3.Uses descriptive activity names to name the activities in the data set
activity_labels<-read.table("./UCI HAR Dataset/activity_labels.txt")
#using activity_labels to make activity varible a factor varible
activity_descriptive<-factor(extrData[,1],labels=as.character(activity_labels[,2]))
#replace the activity variable with variable_descriptive
extrData[1]=activity_descriptive

#---------------------------------------------------------------
#4.Appropriately labels the data set with descriptive variable names. 
#using feature's description as measurement's names but removing invalid characters
varNames<-gsub("[[:punct:]]","",features.meanOrStd)
#adding "activity" and "subject",so
varNames<-c("activity","subject",varNames)
#adding names to extrData
names(extrData)<-varNames

#----------------------------------------------------------------
#5.From the data set in step 4, creates a second, independent tidy data set 
#with the average of each variable for each activity and each subject.

tidyData=ddply(extrData,.(activity,subject),colwise(mean))

#save the tidy set to a txt file
write.table(tidyData,file="tidy.txt",row.name=F)

