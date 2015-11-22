##set file path to "UCI HAR Dataset" folder
library(dplyr)
library(tidyr)

## Read data from local directory
subject_train_data <- tbl_df(read.table("./train/subject_train.txt"))
subject_test_data <- tbl_df(read.table("./test/subject_test.txt"))

x_train_data <- tbl_df(read.table("./train/x_train.txt"))
x_test_data <- tbl_df(read.table("./test/x_test.txt"))

y_train_data <- tbl_df(read.table("./train/y_train.txt"))
y_test_data <- tbl_df(read.table("./test/y_test.txt"))

library(data.table)
# 1. Merges the training and the test sets to create one data set.
##Merging subject data
subject_data <- rbind(subject_test_data, subject_train_data)
##Merging activity number data
y_data <- rbind(y_test_data, y_train_data)
##Merging subject and activity number data
data <- cbind(subject_data, y_data)
setnames(data, c("subject", "activity_id" ))

#Merging activity data
x_data <- rbind(x_test_data, x_train_data)

#2.Extracts only the measurements on the mean and standard deviation for each measurement. 
#Extracting features and naming the columns
features <- read.table("features.txt")
setnames(features, names(features), c("feature_id", "feature_names"))
colnames(x_data) <- features$feature_names

## Merging activity data, activity name and number
data <- cbind(data, x_data)

# Extract Mean & Stdev data
variable_names<-grep("mean\\(\\)|std\\(\\)", features$feature_names, value = T)
variable_names <- union(c("subject", "activity_id"), variable_names)
data <- subset(data, select = variable_names)

# 3.Uses descriptive activity names to name the activities in the data set
## names the activities in the data set with activity names
activity_labels <- read.table("activity_labels.txt")
setnames(activity_labels, names(activity_labels), c("activity_id", "activity_name") )
data <- merge(activity_labels, data, by="activity_id", all.x = T)
data$activity_name <- as.character(data$activity_name)

# variable means sorting by subject and activity_name
com_data <- aggregate(.~subject - activity_name, data = data, mean)
data <- tbl_df(arrange(com_data, subject, activity_name))

# 4.Appropriately labels the data set with descriptive variable names. 
names(data)<-gsub("std()", "SD", names(data))
names(data)<-gsub("mean()", "Mean", names(data))
names(data)<-gsub("^t", "Time", names(data))
names(data)<-gsub("^f", "Frequency", names(data))
names(data)<-gsub("Acc", "Accelerometer", names(data))
names(data)<-gsub("Gyro", "Gyroscope", names(data))
names(data)<-gsub("Mag", "Magnitude", names(data))
names(data)<-gsub("BodyBody", "Body", names(data))

# 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
write.table(data, "TidyData.txt", row.name=FALSE)
