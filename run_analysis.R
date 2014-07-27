# # # # # # # # # # # # # # # # # # # # # # # # # # # #
# This is the script that generates the tady data set #
# # # # # # # # # # # # # # # # # # # # # # # # # # # #
#
# ::Training data::
# Load the file with the names of the varables
dataNames <- read.table("~/Dropbox/Cursos/Coursera/Getting and Cleaning Data/Project/UCI HAR Dataset/features.txt", header=FALSE)
# Pass the names of the variables as header of the data
dataTrain <- read.table("~/Dropbox/Cursos/Coursera/Getting and Cleaning Data/Project/UCI HAR Dataset/train/X_train.txt", col.names=dataNames$V2, header=FALSE)
# Add the subject index to the data
dataTrain$subject <- as.matrix(read.table("~/Dropbox/Cursos/Coursera/Getting and Cleaning Data/Project/UCI HAR Dataset/train/subject_train.txt", header=FALSE))
# Add the activity index to the data
dataTrain$activity <- as.matrix(read.table("~/Dropbox/Cursos/Coursera/Getting and Cleaning Data/Project/UCI HAR Dataset/train/y_train.txt", header=FALSE))
dataTrain <- as.data.frame(dataTrain)
#
# ::Test data::
# Repeat the same steps with the test data
dataTest <- read.table("~/Dropbox/Cursos/Coursera/Getting and Cleaning Data/Project/UCI HAR Dataset/test/X_test.txt", col.names=dataNames$V2, header=FALSE)
dataTest$subject <- as.matrix(read.table("~/Dropbox/Cursos/Coursera/Getting and Cleaning Data/Project/UCI HAR Dataset/test/subject_test.txt", header=FALSE))
dataTest$activity <- as.matrix(read.table("~/Dropbox/Cursos/Coursera/Getting and Cleaning Data/Project/UCI HAR Dataset/test/y_test.txt", header=FALSE))
dataTest <- as.data.frame(dataTest)
#
# ::Binding Training and Test data::
# I put together the two data sets: training and test
data <- rbind.data.frame(dataTrain, dataTest)
# Change the activity indices to activity labels according with the correspondence in activity_labels.txt
activityLabels <- read.table("~/Dropbox/Cursos/Coursera/Getting and Cleaning Data/Project/UCI HAR Dataset/activity_labels.txt", header=FALSE)
ActLabels <- as.matrix(activityLabels$V2)
ActLabels[1:6]
data$activity <- factor(data$activity, labels=ActLabels)
# Selecting the valid columns for the tidy data set
validCol <- c("subject", "activity", grep(".mean", colnames(data), value=TRUE), grep(".std", colnames(data), value=TRUE))
# Redefining the data, this is my tidy data set
data <- data[,validCol]
# Creating the tidy data set
setwd("~/Dropbox/Cursos/Coursera/Getting and Cleaning Data/Project/TidyDataProject/")
write.table(data, file="TidyDataSet.txt")

# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # 
# Table with the average of each variable for each activity and each subject. #
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # 
library("reshape2")
# Using aggregate() to generate the new table with 
# the average of each variable for each activity and each subject.
dataSummary <-aggregate(data[3:81], by=list(data$subject,data$activity),FUN=mean, na.rm=TRUE)
names(dataSummary)[1]<-"subject"
names(dataSummary)[2]<-"activity"
write.table(dataSummary, file="TidyDataSetFinal.txt")