# Getting and Cleaning Data Course Project

The purpose of this project was to combine several sets of data into one set of tidy data that can be used for later analysis. 

## The data
The original data was downloaded from the [Getting and Cleaning data cloudfront site.](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip)

The zip file was unpacked without the help of R. This yielded a folder named **getdata_projectfiles_UCI HAR Dataset** which was put in the R working directory in its entirety. 

There are two folders named "Inertia signals" in this data set. These were not used for this project. 

## Merging the data
The data in the "test" and "train" folders have the same structure. The files named X_test and X_train contain the observations measured by the smart phones. These rows were combined.

The files named y_test and y_train contain only one column of numbers. These numbers refer to the activity labels in getdata_projectfiles_UCI HAR Dataset\UCI HAR Dataset\activity_labels.txt. These labels were added to the observations in an extra column.

The files named subject_test.txt and subject_train.txt contain ids for the persons who acted as experiment subjects. These ids were also added to the observations in another extra column.

## Naming the columns
Each observation consisted of 561 measurements, the names of which are in the file called features.txt. These names were added to the tidy data set in the order in which they appear.

The two new columns which were added have been named "activity" and "subject.id".

## Removing columns
Only the columns which contain data on the mean and standard deviation are deemed relevant for analysis. All the measurements which do not have the characters "mean" or "std" at any position in their variable names have been removed from the tidy data set. The search for the characters was case-insensitive.

## Averaging
Th data has been grouped by both subject.id and activity, after which the numbers were averaged. This means that the final, tidy data set has 180 rows (one for each of the six activities of each of the thirty test subjects, with the averages of each variable for each activity and each subject.

## Tidy data
The tidy data set was written to a file named tidy.txt. This can be read into R by typing 
x <- read.table("tidy.txt", header=TRUE)
in the console, provided the file is in R's working directory.
