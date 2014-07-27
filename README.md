TidyDataProject
===============
Introduction
------------
It is now possible to collect a large amount of data about personal movement using activity monitoring devices such as a Fitbit, Nike Fuelband, or Jawbone Up. These type of devices are part of the "quantified self" movement -- a group of enthusiasts who take measurements about themselves regularly to improve their health, to find patterns in their behavior, or because they are tech geeks. But these data remain under-utilized both because the raw data are hard to obtain and there is a lack of statistical methods and software for processing and interpreting the data.

The purpose of this project is to demonstrate the ability of collect, work with, and clean a data set. The goal is to prepare tidy data that can be used for later analysis.  
 
On this repository you could find:

1. A tidy data set called **TidyDataSet.txt** created using various source of data
2. A tidy data set called **TidyDataSetFinal.txt** based in the first one but with some processing 
3. A script, **run_analysis.R**, that generates both tidy data set: **TidyDataSet.txt** and **TidyDataSetFinal.txt**
4. A code book that describes the variables, the data, and any transformations or work  performed to clean up the data called and **CodeBook.md**
5. This file, **README.md**, that summarizes all the process, describes how the script works, and serves as a guide

The data
--------
The data we're going to use represent data collected from the accelerometers from the Samsung Galaxy S smartphone. A full description is available at the site where the data was obtained: 

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 

Here are the data for the project: 

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

For more details about the data please consult the **CodeBook.md**

Requirements for the tidy data sets 
-----------------------------------
We were asked to create one R script that does the following: 

* Merges the training and the test sets of the data for the project to create one data set.
* Extracts only the measurements on the mean and standard deviation for each measurement. 
* Uses descriptive activity names to name the activities in the data set
* Appropriately labels the data set with descriptive variable names. 
* Creates a second, independent tidy data set with the average of each variable for each activity and each subject.

At this repository you can find the script that accomplished all these tasks and that is called **run_analysis.R**.
The script
----------
In this last section I will describe how the script **run_analysis.R** works. This script can be run to produce all the steps demanded in the assignment (as long as you point to the appropiate direction to the original data sets). The code is also commented in order to better understand how de tidy data is generated.

The code can be seen as divided in two scripts, the first one generates the  **TidyDataSet.txt**, the second one generates **TidyDataSetFinal.txt**.
### The Tidy Data Set
First we generate and adecuate data.frame for each of the original data sets, i.e., the Test data and the Training data. By adecuate I mean with:
  * Appropiate labels
  * Including the information about the user of the device and the activity (with descriptive activity name, not an index)
For example, for the Training data

```
# Load the file with the names of the varables
dataNames <- read.table("~/Dropbox/Cursos/Coursera/Getting and Cleaning Data/Project/UCI HAR Dataset/features.txt", header=FALSE)
# Pass the names of the variables as header of the data
dataTrain <- read.table("~/Dropbox/Cursos/Coursera/Getting and Cleaning Data/Project/UCI HAR Dataset/train/X_train.txt", col.names=dataNames$V2, header=FALSE)
# Add the subject index to the data
dataTrain$subject <- as.matrix(read.table("~/Dropbox/Cursos/Coursera/Getting and Cleaning Data/Project/UCI HAR Dataset/train/subject_train.txt", header=FALSE))
# Add the activity index to the data
dataTrain$activity <- as.matrix(read.table("~/Dropbox/Cursos/Coursera/Getting and Cleaning Data/Project/UCI HAR Dataset/train/y_train.txt", header=FALSE))
dataTrain <- as.data.frame(dataTrain)
```
We did the same for the Test data. Bind together the two data frames is straightforward using **rbind.data.frame()**.

```
data <- rbind.data.frame(dataTrain, dataTest)
```
And change the activity indecies to descritive names

```
activityLabels <- read.table("~/Dropbox/Cursos/Coursera/Getting and Cleaning Data/Project/UCI HAR Dataset/activity_labels.txt", header=FALSE)
ActLabels <- as.matrix(activityLabels$V2)
ActLabels[1:6]
data$activity <- factor(data$activity, labels=ActLabels)
```

We, then, select only the variables with measurements on the mean and standard deviation for each measurement.

```
validCol <- c("subject", "activity", grep(".mean", colnames(data), value=TRUE), grep(".std", colnames(data), value=TRUE))
# Redefining the data, this is my tidy data set
data <- data[,validCol]
```

Finally we create the data as an independent archive.
```
# Just to send the archive to the correct place..
setwd("~/Dropbox/Cursos/Coursera/Getting and Cleaning Data/Project/TidyDataProject/")
# Creating the archive
write.table(data, file="TidyDataSet.txt")
```
### The Final Tidy Data Set
Some aditional steps must be followed to arrive to the **TidyDataSetFinal.txt**. I use  **aggregate()** in the **reshape2 package** to generate the new table with the average of each variable for each activity and each subject.

```
library("reshape2")
dataSummary <-aggregate(data[3:81], by=list(data$subject,data$activity),FUN=mean, na.rm=TRUE)
names(dataSummary)[1]<-"subject"
names(dataSummary)[2]<-"activity"
```

And finally we create the data as an independent archive.
```
# Just to send the archive to the correct place..
setwd("~/Dropbox/Cursos/Coursera/Getting and Cleaning Data/Project/TidyDataProject/")
# Creating the archive
write.table(dataSummary, file="TidyDataSetFinal.txt")
```

