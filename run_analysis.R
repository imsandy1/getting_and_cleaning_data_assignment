
## Download zip file with data
download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip", destfile = 'file.zip')

library(data.table)

unzip("file.zip", exdir = "./data")
files <- list.files(file.path("./data" , "UCI HAR Dataset"), recursive = TRUE)

## Load features & activity labels
features <- read.table("./data/UCI HAR Dataset/features.txt")
activity_labels <- read.table("./data/UCI HAR Dataset/activity_labels.txt")
features <- features[,2]

## Load training data
training_set <- read.table("./data/UCI HAR Dataset/train/X_train.txt")
training_labels <- read.table("./data/UCI HAR Dataset/train/y_train.txt")
training_subject <- read.table("./data/UCI HAR Dataset/train/subject_train.txt")

## Load test data
test_set <- read.table("./data/UCI HAR Dataset/test/X_test.txt")
test_labels <- read.table("./data/UCI HAR Dataset/test/y_test.txt")
test_subject <- read.table("./data/UCI HAR Dataset/test/subject_test.txt")

## Match activity names to the training & test labels
test_labels[,2] = activity_labels[test_labels[,1],2]
training_labels[,2] = activity_labels[training_labels[,1],2]

## Name columns properly in all data frames loaded
names(training_subject) <- "subject"
names(test_subject) <- "subject"
names(training_labels) <- c("lable_id", "activity_name")
names(test_labels) <- c("lable_id", "activity_name")
names(training_set) <- features
names(test_set) <- features

## Identify features with mean & std
mean_std_features <- grep("mean|std", features)

## Subset training & test set with mean & std features
training_set <- training_set[,mean_std_features]
test_set <- test_set[,mean_std_features]

## Merge training data files into one data frame
training_data <- cbind(training_subject, training_labels, training_set)
test_data <- cbind(test_subject, test_labels, test_set)

## Merge training & test data into one data frame
merged_data <- rbind(test_data, training_data)

## Create tidy data
tidy_data <- melt(merged_data, id.vars = 1:3, measure.vars = 4:82)

## Get means
tidy_data_means <- dcast(tidy_data, subject + activity_name ~ variable, mean)

## Export means output into text file
write.table(tidy_data_means, file = "./tidy_data_means.txt")
