## Required libraries
library(reshape2)

################################################
## This section reads the data from files.
################################################
## Directory where data files are located
dataDir <- "./UCI HAR Dataset/"

## Read the features
features <- read.table(paste0(dataDir,"features.txt"), stringsAsFactors=F)
names(features) <- c("Number","Name")

## Read activities
activities <- read.table(paste0(dataDir,"activity_labels.txt"), stringsAsFactors=F)
names(activities) <- c("Number","Name")

## Read data
### Note that the y data contains a number associated with the activity
### performed for each row in the x data.
### The subject data identifies the participant in each row of the x data.
## Read test data
### Test subject data
test_sub <- read.table(paste0(dataDir,"test/subject_test.txt"))
names(test_sub) <- "SubjectID"
### this creates an additional column that counts the number of trials for
### each participant. This is used when recasting the tables during merging.
test_sub_seq <- apply(table(test_sub), 1,function(x) seq(1,x,by=1))
test_sub <- cbind(test_sub, SubjectTrialNo=as.vector(unlist(test_sub_seq)))

### Test x-data
test_x <- read.table(paste0(dataDir,"test/X_test.txt"))
names(test_x) <- features$Name
### Test y-data
test_y <- read.table(paste0(dataDir,"test/y_test.txt"))
names(test_y) <- "Activity"

## Read train data
### Train subject data
train_sub <- read.table(paste0(dataDir,"train/subject_train.txt"))
names(train_sub) <- "SubjectID"
### this creates an additional column that counts the number of trials for
### each participant. This is used when recasting the tables during merging.
train_sub_seq <- apply(table(train_sub), 1,function(x) seq(1,x,by=1))
train_sub <- cbind(train_sub, SubjectTrialNo=as.vector(unlist(train_sub_seq)))
### Train x-data
train_x <- read.table(paste0(dataDir,"train/X_train.txt"))
names(train_x) <- features$Name
### Train y-data
train_y <- read.table(paste0(dataDir,"train/y_train.txt"))
names(train_y) <- "Activity"

################################################
## This section cleans up the test and train
## data sets separately before attempting to
## merge them. This involves discarding the
## x-data not containing a mean or standard
## deviation and combining th subject, x, and y
## data in one table.
################################################
## Determines the indices of mean() and std() entries.
feati <- which(grepl("mean\\(\\)",features$Name) | grepl("std\\(\\)", features$Name))

## create a table containing all relevant train data
train <- cbind(train_sub, train_y, train_x[,feati])
## create a table containing all relevant test data
test <- cbind(test_sub, test_y, test_x[,feati])

## Replace activity IDs with activity names
for (i in activities$Number){
        train$Activity[which(train$Activity == i)] <- activities$Name[i]
        test$Activity[which(test$Activity == i)] <- activities$Name[i]
        print(i)
        print(activities$Name[i])
}

## train and test need to be recast for merging (otherwise there it leads into
## inelegant column duplicates with NA values.)
### Melt the train and test data based on Subject ID and subject trial number.
meltedTrain <- melt(train, id=c("SubjectID","SubjectTrialNo"))
meltedTest <- melt(test, id=c("SubjectID","SubjectTrialNo"))
### Merge the two melted data sets into one using rbind.
mergedData <- rbind(meltedTrain, meltedTest)
### Cast the data into a more user-friendly format.
castData <- dcast(mergedData, SubjectID + SubjectTrialNo ~ variable, 
                    value.var="value")

### Melt the train and test data based on Subject ID and subject trial number.
meltedTrain <- melt(train[,!(names(train)=="SubjectTrialNo")], id=c("SubjectID","Activity"))
meltedTest <- melt(test[,!(names(test) =="SubjectTrialNo")], id=c("SubjectID","Activity"))
### Merge the two melted data sets into one using rbind.
mergedData <- rbind(meltedTrain, meltedTest)
mergedDataMeans <- dcast(mergedData, SubjectID + Activity~ variable, mean)

## Save the tidy data to file
fName <- "./tidy-data.txt"
write.table(castData, fName, row.names=F, quote=F, sep="\t")

fName <- "./tidy-data-means.txt"
write.table(mergedDataMeans, fName, row.names=F, quote=F, sep="\t")