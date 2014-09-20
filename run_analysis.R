# plyr package is required
library(dplyr)

# path to the directory with the dataset - can be relative or absolute
directory <- "UCI HAR Dataset"

# paths to particular files in the dataset
pathSep = "\\"  # windows format, change to "/" for unix systems
trainSetXPath <- paste(directory, "train", "X_train.txt", sep=pathSep)
trainSetYPath <- paste(directory, "train", "y_train.txt", sep=pathSep)
testSetXPath <- paste(directory, "test", "X_test.txt", sep=pathSep)
testSetYPath <- paste(directory, "test", "y_test.txt", sep=pathSep)
subjectTrainPath <- paste(directory, "train", "subject_train.txt", sep=pathSep)
subjectTestPath <- paste(directory, "test", "subject_test.txt", sep=pathSep)
featuresPath <- paste(directory, "features.txt", sep=pathSep)
activityLabelsPath <- paste(directory, "activity_labels.txt", sep=pathSep)

# read data from files
trainSetX <- read.table(trainSetXPath)
trainSetY <- read.table(trainSetYPath)
testSetX <- read.table(testSetXPath)
testSetY <- read.table(testSetYPath)
subjectTrain <- read.table(subjectTrainPath)
subjectTest <- read.table(subjectTestPath)
features <- read.table(featuresPath)
activityLabels <- read.table(activityLabelsPath)

# merge train & test sets
dataSet <- rbind(trainSetX, testSetX)

# label the data set with descriptive variable names
names(dataSet) <- features[,2]

# extract only the measurements on the mean and standard deviation for each measurement
# i.e. columns containing "mean()" & "std()" in their names
meanCols <- grep("mean()", names(dataSet), fixed=TRUE)
stdCols <- grep("std()", names(dataSet), fixed=TRUE)
dataSet <- dataSet[, c(meanCols, stdCols)]

# append descriptive activity names to name the activities in the data set
setsY <- rbind(trainSetY, testSetY)
activities <- inner_join(setsY, activityLabels)
names(activities)[2] <- "activityLabel"
dataSet <- cbind(dataSet, activities[2])


# create an independent tidy data set with the average of each variable for each activity and each subject

# add column with subjects information
subjects <- rbind(subjectTrain, subjectTest)
names(subjects) <- c("subjectID")
dataSet2 <- cbind(dataSet, subjects)

# get dataset with averages of each variable for each activity
dataSet2 <- aggregate(. ~ subjectID + activityLabel, dataSet2, mean)

# create output file
write.table(dataSet2, "output.txt", row.names=FALSE, sep=",")