# Coursera Cleaning Data Project
# You should create one R script called run_analysis.R that does the following. 
# Merges the training and the test sets to create one data set.
# Extracts only the measurements on the mean and standard deviation for each measurement. 
# Uses descriptive activity names to name the activities in the data set
# Appropriately labels the data set with descriptive variable names. 
# Creates a second, independent tidy data set with the average of each variable for each activity and each subject. 

library(RCurl)
library(reshape2)


# Check for data directory

if(!file.exists("data")){
        dir.create("data")
}

# Check original zip file is downloaded, if not download
if(!file.exists("./data/Dataset.zip")){
        fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip "
        download.file(fileUrl, destfile = "./data/Dataset.zip", method = "curl")
        list.files("./data")
        dateDownloaded <- date()
        dateDownloaded
}

# Check zipped file unzipped, if not unzip.

if (! file.exists("./UCI HAR Dataset")) {
        unzip("./data/Dataset.zip")
}

# Loading Data

#load test data
subject_test <- read.table("UCI\ HAR\ Dataset/test/subject_test.txt")
X_test <- read.table("UCI\ HAR\ Dataset/test/X_test.txt")
y_test <- read.table("UCI\ HAR\ Dataset/test/y_test.txt")

#load train data
subject_train <- read.table("UCI\ HAR\ Dataset/train/subject_train.txt")
X_train <- read.table("UCI\ HAR\ Dataset/train/X_train.txt")
y_train <- read.table("UCI\ HAR\ Dataset/train/y_train.txt")

#load activity labels
activity_labels <- read.table("UCI\ HAR\ Dataset/activity_labels.txt")

#load feature names
features <- read.table("UCI\ HAR\ Dataset/features.txt")
headers <- features[,2]

#name columns of test and train features
names(X_test) <- headers
names(X_train) <- headers

#select only mean and std headers
mean_and_std <- grepl("mean\\(\\)|std\\(\\)", headers)

#filter mean and std columns on test and train
X_test_mean_and_std <- X_test[,mean_and_std]
X_train_mean_and_std <- X_train[,mean_and_std]

#merge all test and train rows
subject_all <- rbind(subject_test, subject_train)
X_all <- rbind(X_test_mean_and_std, X_train_mean_and_std)
y_all <- rbind(y_test, y_train)

#combine all vectors/data.frames into one data.frame
merged <- cbind(subject_all, y_all, X_all)
names(merged)[1] <- "SubjectID"
names(merged)[2] <- "Activity"

#aggregate by subjectid and activity
tidy <- aggregate(. ~ SubjectID + Activity, data=merged, FUN = mean)

#give activities better names
tidy$Activity <- factor(tidy$Activity, labels=activity_labels[,2])

write.table(tidy, file="./tidy.csv", sep=",", row.names=FALSE)