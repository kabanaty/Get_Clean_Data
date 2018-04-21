require(reshape2)

## URL of dataset to download
url <- "http://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"

## Name of .zip file
zip <- "samsung.zip"

## If .zip file already exists, does not download
if (!file.exists("samsung.zip")) {
  download.file(url, zip)
}

## If unzipped contents already exist, does not unzip
if (!file.exists("UCI HAR Dataset")) {
  unzip(zip)
}

## Reads in activity_labels and features
setwd("./UCI HAR Dataset")
activity_labels <- read.table("activity_labels.txt", sep = " ")
features <- read.table("features.txt", sep = " ")

## Sets labels to character strings
activity_labels[, 2] <- as.character(activity_labels[, 2])
features[, 2] <- as.character(features[, 2])
setwd("../")

## Extracts only data regarding mean and standard deviation
featuresWanted <- grep(".*mean*|.*std*", features[, 2])
featuresWanted.names <- features[featuresWanted, 2]

## Cleans header names
featuresWanted.names <- gsub("-mean", "Mean", featuresWanted.names)
featuresWanted.names <- gsub("-std", "Std", featuresWanted.names)
featuresWanted.names <- gsub("[-()]", "", featuresWanted.names)

## Loads train datasets
setwd("./UCI HAR Dataset/train")

train <- read.table("X_train.txt")[featuresWanted]
trainActivities <- read.table("y_train.txt")
trainSubjects <- read.table("subject_train.txt")
train <- cbind(trainSubjects, trainActivities, train)

## Loads test datasets
setwd("../test")

test <- read.table("X_test.txt")[featuresWanted]
testActivities <- read.table("y_test.txt")
testSubjects <- read.table("subject_test.txt")
test <- cbind(testSubjects, testActivities, test)

setwd("../../")

## Merge all datasets
all <- rbind(train, test)
colnames(all) <- c("subject", "activity", featuresWanted.names)

## Create factors
all$activity <- factor(all$activity, levels = activity_labels[, 1], labels = activity_labels[, 2])
all$subject <- as.factor(all$subject)

all_melt <- melt(all, id = c("subject", "activity"))
all_mean <- dcast(all_melt, subject + activity ~ variable, mean)

write.table(all_mean, "tidy.txt", row.names = FALSE, quote= FALSE)