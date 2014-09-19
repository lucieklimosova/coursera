Readme
========================
This document contains description of how the script works and the code book describing the variables.

### What the script does

The R script called run_analysis.R that does the following:

- Merges the training and the test sets to create one data set.
- Extracts only the measurements on the mean and standard deviation for each measurement. 
- Uses descriptive activity names to name the activities in the data set
- Appropriately labels the data set with descriptive variable names. 

The resulting data set is used to create and export tidy dataset (tidyData.txt):

- Independent tidy data set with the average of each variable for each activity and each subject.

### How the script works

The scipt wokrs when located in the data folder (inside UCI HAR Dataset folder).

- read test data, cbind activity code
- read train data, cbind activity code
- merge training and test data, name columns
- subset only mean() and std() columns
- replace activity codes with activity names
- cbind subjects
- use ddply function (plyr package) to create tidy set with the average of each variable for each activity and each subject
- write tidy data to text file (tidyData.txt)