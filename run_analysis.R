##Script to Tidy the data set for the class Project
##Read features.txt get col names for variables with mean and std
colNames <- read.table("UCI HAR Dataset/features.txt")
colsToSel <- colNames[grep("mean|std",colNames$V2),]
colsIndexToSel <- colsToSel[,1]
colsNamesToSel <- colsToSel[,2]

## Read training data set
xTrain <- read.table("UCI HAR Dataset/train/X_train.txt")
yTrain <- read.table("UCI HAR Dataset/train/Y_train.txt")
sTrain <- read.table("UCI HAR Dataset/train/subject_train.txt")
names(sTrain) <- "Subject"
names(yTrain) <- "Activity"

## Combine subject and activity variables
mTrain <- cbind(sTrain, yTrain)
## Filter feature columns with mean and std
xTrain1 <- xTrain[, colsToSel[,1]]
## Rename the variables with more descriptive names
names(xTrain1) <- colsToSel[,2]
## Combine subject, activity and feature
mTrain <- cbind(mTrain, xTrain1)

## Read test data set
xTest <- read.table("UCI HAR Dataset/test/X_test.txt")
yTest <- read.table("UCI HAR Dataset/test/Y_test.txt")
sTest <- read.table("UCI HAR Dataset/test/subject_test.txt")
names(sTest) <- "Subject"
names(yTest) <- "Activity"

## Combine subject and activity variables
mTest <- cbind(sTest, yTest)
## Filter feature columns with mean and std
xTest1 <- xTest[, colsToSel[,1]]
names(xTest1) <- colsToSel[,2]
## Combine subject, activity and feature
mTest <- cbind(mTest, xTest1)
## Merge train and test dataset
mData <- rbind(mTrain,mTest)
##names(mData)



mData <- arrange(mData, Subject) 

# Columns you want to group by
grp_cols <- names(mData)[1:2]

# Convert character vector to list of symbols
dots <- lapply(grp_cols, as.symbol)
## Calculate average of features by Subject and Activity
mData1 <- mData %>%
    group_by_(.dots=dots) %>%
    summarise_each(funs(mean))

##Replace Activity with Description
mData1$Activity[mData1$Activity == 1] <- "WALKING" 
mData1$Activity[mData1$Activity == 2] <- "WALKING_UPSTAIRS" 
mData1$Activity[mData1$Activity == 3] <- "WALKING_DOWNSTAIRS" 
mData1$Activity[mData1$Activity == 4] <- "SITTING" 
mData1$Activity[mData1$Activity == 5] <- "STANDING" 
mData1$Activity[mData1$Activity == 6] <- "LAYING" 

write.table(mData1, "project_step5_result.txt", row.name=FALSE)



