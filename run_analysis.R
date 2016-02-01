rm(list = ls())

# 1. Merge the training and the test sets to create one data set.
X_train <- read.table(file = "./UCI HAR Dataset/train/X_train.txt")
y_train <- read.table(file = "./UCI HAR Dataset/train/y_train.txt")
subject_train <- read.table(file = "./UCI HAR Dataset/train/subject_train.txt")
train <- cbind(subject_train, X_train, y_train)

X_test <- read.table(file = "./UCI HAR Dataset/test/X_test.txt")
y_test <- read.table(file = "./UCI HAR Dataset/test/y_test.txt")
subject_test <- read.table(file = "./UCI HAR Dataset/test/subject_test.txt")
test <- cbind(subject_test, X_test, y_test)

completeData <- rbind(train, test)



# 4. Appropriately label the data set with descriptive variable names.
features <- read.table(file = "./UCI HAR Dataset/features.txt")
featureNames <- c("subject", as.character(features[,2]), "activity_labels")
colnames(completeData) <- featureNames



# 2. Extract only the measurements on the mean and standard deviation for each measurement.
data2 <- completeData[grepl("subject|-mean[()]|-std[()]|activity_labels", colnames(completeData))]


# 3. Use descriptive activity names to name the activities in the data set.
# 1 WALKING
# 2 WALKING_UPSTAIRS
# 3 WALKING_DOWNSTAIRS
# 4 SITTING
# 5 STANDING
# 6 LAYING

completeData$activity_labels[completeData$activity_labels==1] <- "WALKING"
completeData$activity_labels[completeData$activity_labels==2] <- "WALKING_UPSTAIRS"
completeData$activity_labels[completeData$activity_labels==3] <- "WALKING_DOWNSTAIRS"
completeData$activity_labels[completeData$activity_labels==4] <- "SITTING"
completeData$activity_labels[completeData$activity_labels==5] <- "STANDING"
completeData$activity_labels[completeData$activity_labels==6] <- "LAYING"

data2$activity_labels[data2$activity_labels==1] <- "WALKING"
data2$activity_labels[data2$activity_labels==2] <- "WALKING_UPSTAIRS"
data2$activity_labels[data2$activity_labels==3] <- "WALKING_DOWNSTAIRS"
data2$activity_labels[data2$activity_labels==4] <- "SITTING"
data2$activity_labels[data2$activity_labels==5] <- "STANDING"
data2$activity_labels[data2$activity_labels==6] <- "LAYING"


# 5. From the data set in step 4, create a second, independent tidy data set with the average of each variable for each activity and each subject.
data3 <- aggregate(. ~ subject + activity_labels, data = data2, FUN = mean)


# Writing the final output in a file.
write.table(data3, file = "finalOutput.csv", sep = "\t")

