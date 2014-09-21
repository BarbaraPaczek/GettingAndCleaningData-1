Getting and Cleaning Data Course Project
========================================

This repository contains:
* run_analysis.R - script preparing the output dataset, description below.
* output.txt - output dataset from the run_analysis.R script
* CodeBook.md - description of dataset variables

### Data preparation

**Assumption**: Data collected from the accelerometers from the Samsung Galaxy S smartphone ([link](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip))
is available in the working directory of the scripts (if located elsewhere, please adjust *directory* variable).

Steps performed by run_analysis.R script:

1. Read data from the files.
2. Merge train & test sets X & y.
3. Label the data set with descriptive variable names.
4. Leave out only the measurements on the mean and standard deviation for each measurement - i.e. columns containing "mean()" & "std()" in their names.
5. Append descriptive activity names based on activiy IDs (from sets y).
6. Create an independent tidy data set with the average of each variable for each activity and each subject:
   1. Append information on subject ID to the dataset.
   2. Aggregate averages of each variable for each activity and each subject.
   3. Write the output dataset to 'output.txt' file.
