#Getting and Cleaning Data - Course Project
#You should create one R script called run_analysis.R that does the following. 

#1. Merges the training and the test sets to create one data set.
#2. Extracts only the measurements on the mean and standard deviation for each measurement. 
#3. Uses descriptive activity names to name the activities in the data set
#4. Appropriately labels the data set with descriptive variable names. 
#5. From the data set in step 4, creates a second, independent tidy data set
#   with the average of each variable for each activity and each subject.

#make sure appropriate working directory is set up
#setwd("./coursera/getdata-007/CourseProject/UCI HAR Dataset/")

#libraries
library(plyr) #needed for ddply function

#read and label test data
testData <- read.table("./test/X_test.txt", sep="")
testLabels <- read.table("./test/y_test.txt")
testDataLabeled <- cbind(testLabels,testData)

#read and label train data
trainData <- read.table("./train/X_train.txt", sep="")
trainLabels <- read.table("./train/y_train.txt")
trainDataLabeled <- cbind(trainLabels,trainData)

#merge training and test sets, name columns
dataLabeled <- rbind(testDataLabeled,trainDataLabeled)
featureLabels <- read.table("./features.txt")
labels <- c("activity",as.character(featureLabels[,2]))
colnames(dataLabeled) <- labels

#extract only mean() and std() measurements
dataLabeled <- subset(dataLabeled, select=grepl("activity|mean\\(\\)|std\\(\\)",labels))

#replace activity codes with activity names
activityLabels <- read.table("./activity_labels.txt")
dataLabeled$activity <- activityLabels$V2[match(dataLabeled$activity,activityLabels$V1)]

#add subjects
testSubject <- read.table("./test/subject_test.txt")
trainSubject <- read.table("./train/subject_train.txt")
subject <- rbind(testSubject,trainSubject)
colnames(subject) <- c("subject")
dataLabeled <- cbind(subject,dataLabeled)

#tidy set with the average of each variable for each activity and each subject
tidyData <- ddply(dataLabeled, .(activity,subject), function(x) colMeans(x[,3:68]))

#write tidy data to text file
write.table(tidyData,file="tidyData.txt",row.name=FALSE)