## Source Dataset reference
## [1] Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. Human Activity
## Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine. International 
## Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012

## Load appropriate libraries
library(reshape2)


## Define the source dataset
## Change the location as per requirements

dataset <- "C:/Users/rahul pandey/Dropbox/11 Analytics/02 Assignments/03 Getting and cleaning data/Assigment 1/getdata-projectfiles-UCI HAR Dataset"

setwd(dataset)

## before executing, please ensure that the directories were not overridden. Else change the paths
## Read the test data
## In the following data X refers to training set, Y to test labels and S to Subject.

	XTestRead <- read.table("./UCI HAR Dataset/test/X_test.txt")
  	YTestRead <- read.table("./UCI HAR Dataset/test/y_test.txt")
  	STestRead <- read.table("./UCI HAR Dataset/test/subject_test.txt")

## Read the training data
  	XTrainRead <-read.table("./UCI HAR Dataset/train/X_train.txt")
  	YTrainRead <-read.table("./UCI HAR Dataset/train/y_train.txt")
  	STrainRead <-read.table("./UCI HAR Dataset/train/subject_train.txt")

## Part 1
## Merges the training and the test sets to create one data set.

## Merge testread and trainread into merged sets via rbind
	XMergeRead <- rbind(XTestRead, XTrainRead)
	YMergeRead <- rbind(YTestRead, YTrainRead)
	SMergeRead <- rbind(STestRead, STrainRead)

## Part 3
## Label the merges datasets appropriately, 
  	VarNames <- read.table("./UCI HAR Dataset/features.txt")
  	colnames(XMergeRead) <- VarNames[,2]
	colnames(YMergeRead) <- "Activity Id"
	colnames(SMergeRead) <- "Subject Id"
	ActLabels <- read.table("./UCI HAR Dataset/activity_labels.txt")
	colnames(ActLabels) <- c("Activity Id", "Activity Name")

## Now create a full dataset with subject, activity and value

	FullData <- cbind(SMergeRead, YMergeRead , XMergeRead)
	## head(FullData) - commented code, gets sense of data

## Part 2: The next steps extract mean and median. 

## Now extract only the mean and standard deviation columns; first col nums and then names

	FullMeanCols <- grep("mean",names(FullData),ignore.case=TRUE) ## Both mean and Mean have been used
	FullStdsCols <- grep("mean",names(FullData),ignore.case=TRUE)

	FullMeanNames <- names(FullData)[FullMeanCols]
	FullStdsNames <- names(FullData)[FullStdsCols]

## Create one unified dataset with these names and the final file requirement
## First populate the dataset with means and standard deviation ### Step 2
	FullMeansStdsData <- FullData[,c("Subject Id","Activity Id",FullMeanNames,FullStdsNames)]

## Part 4 - Create dataset with labels and appropriate activity
	DataDescActvNames <- merge(ActLabels,FullMeansStdsData,by.x="Activity Id",by.y="Activity Id",all=TRUE)
	DataDescActvNamesMelt <- melt(DataDescActvNames,id=c("Activity Id","Activity Name","Subject Id"))

### Part 5 - Create the final dataset
        write.table(DataDescActvNamesMelt,"./ActData.txt")
