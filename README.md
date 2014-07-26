TidyDataProject
===============
Introduction
------------
It is now possible to collect a large amount of data about personal movement using activity monitoring devices such as a Fitbit, Nike Fuelband, or Jawbone Up. These type of devices are part of the "quantified self" movement -- a group of enthusiasts who take measurements about themselves regularly to improve their health, to find patterns in their behavior, or because they are tech geeks. But these data remain under-utilized both because the raw data are hard to obtain and there is a lack of statistical methods and software for processing and interpreting the data.

The purpose of this project is to demonstrate the ability of collect, work with, and clean a data set. The goal is to prepare tidy data that can be used for later analysis.  
 
On this repository you could find:

1. A tidy data set call TidyDataSet.txt created using various source of data.
2. A tidy data set call TidyDataSetFinal.txt based in the first one but with some processing. 
3. A script, run_analysis.R, that generates both tidy data set: TidyDataSet.txt and TidyDataSetFinal.txt
4. A code book that describes the variables, the data, and any transformations or work  performed to clean up the data called and CodeBook.md
5. This file, README.md, that summarizes all the process and serves as a guide

The data
--------
The data we're going to use represent data collected from the accelerometers from the Samsung Galaxy S smartphone. A full description is available at the site where the data was obtained: 

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 

Here are the data for the project: 

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

Requirements for the tidy data sets 
-----------------------------------
We were asked to create one R script called run_analysis.R that does the following: 

* Merges the training and the test sets of the data for the project to create one data set.
* Extracts only the measurements on the mean and standard deviation for each measurement. 
* Uses descriptive activity names to name the activities in the data set
* Appropriately labels the data set with descriptive variable names. 
* Creates a second, independent tidy data set with the average of each variable for each activity and each subject.

The script
----------
I have created a R script called run_analysis.R that can be run and executes all the steps demanded in the assignment. The code is commented in order to better understand how de tidy data is generated.