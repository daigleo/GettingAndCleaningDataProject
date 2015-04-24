# GettingAndCleaningDataProject
Project for the Getting and Cleaning Data Coursera online course.
# Format of data
Triaxial Accelerometer data were measured on 30 participants performing six activities. Each activity was performed multiple times by each subject. The participants were split into two groups: a training group and a testing group.

# Purpose of the script
The script takes the data from the UCI HAR Dataset and merge the training and testing sets into one table. The table contains only the mean and standard deviation of the triaxial measurements. In addition, a second table is calculated providing the mean of each variable for each activity and each subject.

# How to run the script
The script requires the reshape2 library to be installed. The script file needs to be located in the same folder as the UCI HAR Dataset folder.

# Output
The script writes two files in the folder: tidy-data.txt and tidy-data-means.txt containing, respectively, all the mean and standard deviation for all participants and all trial for each activity and the mean of all trials for each participant and activity.
