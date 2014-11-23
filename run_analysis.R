# Set Working Directory
getwd()
setwd("C:/Users/Toño Malanda/Documents/Data Science Specialization/Course 3 - Getting and Cleaning Data/Course Project")

# Load Test data
subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt")
X_test <- read.table("UCI HAR Dataset/test/X_test.txt")
y_test <- read.table("UCI HAR Dataset/test/y_test.txt")

names(subject_test) <- c('subject')
names(y_test) <- c('activity')

# Load Training data
subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt")
X_train <- read.table("UCI HAR Dataset/train/X_train.txt")
y_train <- read.table("UCI HAR Dataset/train/y_train.txt")

names(subject_train) <- c('subject')
names(y_train) <- c('activity')

# Load Activity Names
activity_labels <- read.table("UCI HAR Dataset/activity_labels.txt")
names(activity_labels) <- c('id', 'name')

# Load Feature names
features <- read.table("UCI HAR Dataset/features.txt")
names(features) <- c('id', 'name')

# Assign Column Names
names(X_train) <- features$name
names(X_test) <- features$name

# Merge the Training and Test sets
X <- rbind(X_train, X_test)
y <- rbind(y_train, y_test)
subject <- rbind(subject_train, subject_test)

# Uses descriptive activity names to name the activities
y$activity <- activity_labels[y$activity,]$name

# Convert Activity id to Activity Descriptive Labels
data <- cbind(subject, y, X)

# Extract the Mean and the Sd for each measurement
X_mean_sd <- X[,grep("-(mean|std)\\(\\)",features$name)]
data_mean_sd <- cbind(subject,y,X_mean_sd)

# Aggregate by subjectid and activity
tidy_data <- aggregate(. ~ subject + activity, data=data_mean_sd, FUN = mean)
head(tidy_data)

write.table(tidy_data, file="Tidy_Data_Set.txt", sep="\t", row.names=FALSE)
