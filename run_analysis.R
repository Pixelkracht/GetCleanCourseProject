# This is a script that cleans and combines the data collected from 30 subjects performing
# activities of daily living (ADL) while carrying a waist-mounted Samsung Galaxy
# S smartphone with embedded inertial sensors.
# 
# The script can be run as long as the Samsung data is in your working
# directory, that is: the folder named "getdata_projectfiles_UCI HAR Dataset"
# should be in the working directory.
# 
# For a high-level description of how the data were combined please consult the readme file.

# Load the data files.
actlabels <- read.table("getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/activity_labels.txt", header=FALSE)
varnames <- read.table("getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/features.txt", header=FALSE, stringsAsFactors=FALSE)
testx <- read.table("getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/test/X_test.txt", header=FALSE)
testy <- read.table("getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/test/y_test.txt", header=FALSE)
testsub <- read.table("getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/test/subject_test.txt", header=FALSE)
trainx <- read.table("getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/train/X_train.txt", header=FALSE)
trainy <- read.table("getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/train/y_train.txt", header=FALSE)
trainsub <- read.table("getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/train/subject_train.txt", header=FALSE)

# Merge the training and the test sets to create one data set. 
tidydata <- rbind(cbind(testx, testy, testsub), cbind(trainx, trainy, trainsub))

# Replace the numbers in the second-to-last column with character labels.
tidydata[,562] <- actlabels[tidydata[,562],2]

# Label the columns appropriately with descriptive variable names. 
varnames <- c(varnames[,2], "activity", "subject.id")
colnames(tidydata) <- varnames

# Remove the columns which do not pertain to the means and standard deviations.
meanies <- grepl("(mean)|(std)", varnames[1:561], ignore.case=TRUE)
tidydata <- tidydata[,meanies]

# Create a second, independent tidy data set with the average of each variable
# for each activity and each subject.
library(reshape2)
molten <- melt(tidydata, id.vars=c("subject.id", "activity"))
finaltidy <- dcast(molten, subject.id + activity ~ variable, mean)

# Write the final tidy data set to a .txt file.
write.table(finaltidy, "tidy.txt", row.names=FALSE)
              
# Unclutter the environment.
remove(actlabels, varnames, testx, testy, testsub, trainx, trainy, trainsub, meanies, tidydata, molten, finaltidy)

