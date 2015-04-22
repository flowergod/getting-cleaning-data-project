require(dplyr)
require(tidyr)

# Directories and files
uci_hard_dir <- "UCI HAR Dataset"
feature_file <- paste(uci_hard_dir, "/features.txt", sep = "")
activity_labels_file <- paste(uci_hard_dir, "/activity_labels.txt", sep = "")
x_train_file <- paste(uci_hard_dir, "/train/X_train.txt", sep = "")
y_train_file <- paste(uci_hard_dir, "/train/y_train.txt", sep = "")
subject_train_file <- paste(uci_hard_dir, "/train/subject_train.txt", sep = "")
x_test_file  <- paste(uci_hard_dir, "/test/X_test.txt", sep = "")
y_test_file  <- paste(uci_hard_dir, "/test/y_test.txt", sep = "")
subject_test_file <- paste(uci_hard_dir, "/test/subject_test.txt", sep = "")

# Load raw data 
features <- read.table(feature_file, colClasses = c("character"))
activity_labels <- read.table(activity_labels_file, col.names = c("ActivityId", "Activity"))
x_train <- read.table(x_train_file)
y_train <- read.table(y_train_file)
subject_train <- read.table(subject_train_file)
x_test <- read.table(x_test_file)
y_test <- read.table(y_test_file)
subject_test <- read.table(subject_test_file)

# Load raw data 
features <- read.table(feature_file, colClasses = c("character"))
activity_labels <- read.table(activity_labels_file, col.names = c("ActivityId", "Activity"))
x_train <- read.table(x_train_file)
y_train <- read.table(y_train_file)
subject_train <- read.table(subject_train_file)
x_test <- read.table(x_test_file)
y_test <- read.table(y_test_file)
subject_test <- read.table(subject_test_file)

#######################################################################
# 1. Merges the training and the test sets to create one data set.

# Binding sensor data
training_sensor_data <- cbind(cbind(x_train, subject_train), y_train)
test_sensor_data <- cbind(cbind(x_test, subject_test), y_test)
sensor_data <- rbind(training_sensor_data, test_sensor_data)

# Label columns
sensor_labels <- rbind(rbind(features, c(562, "Subject")), c(563, "ActivityId"))[,2]
names(sensor_data) <- sensor_labels

##################################################################
# 2. Extracts mean and standard deviation.

sensor_data_mean_std <- sensor_data[,grepl("mean\\(|std\\(|Subject|ActivityId", names(sensor_data))]

###########################################################################
# 3. Uses descriptive activity names to name the activities

sensor_data_mean_std <- join(sensor_data_mean_std, activity_labels, by = "ActivityId", match = "first")
sensor_data_mean_std <- sensor_data_mean_std[,-1]

##############################################################
# 4. Calculate average data
sensor_data_mean_std_avg <- ddply(sensor_data_mean_std, c("Subject","Activity"), numcolwise(mean))

##############################################################
# 5. Tidy data

sensor_data_mean_std_avg_tidy <- gather(sensor_data_mean_std_avg, Acc_Mtd_Dim, data, -Subject, -Activity)
sensor_data_mean_std_avg_tidy$Acc_Mtd_Dim <- gsub("\\(\\)", ".", sensor_data_mean_std_avg_tidy$Acc_Mtd_Dim, perl=TRUE)
sensor_data_mean_std_avg_tidy$Acc_Mtd_Dim <- gsub("\\-", ".", sensor_data_mean_std_avg_tidy$Acc_Mtd_Dim, perl=TRUE)
sensor_data_mean_std_avg_tidy$Acc_Mtd_Dim <- gsub("\\.\\.", ".", sensor_data_mean_std_avg_tidy$Acc_Mtd_Dim, perl=TRUE)
sensor_data_mean_std_avg_tidy <- 
  (sensor_data_mean_std_avg_tidy 
  %>% separate(Acc_Mtd_Dim, c("Accelerometer", "Method", "Axial"), sep="\\.") 
  %>% arrange(Subject, Activity))

##############################################################
# 6. Write data to file

write.table(sensor_data_mean_std_avg_tidy, file = "sensor_data_mean_std_avg_tidy.txt", row.name=FALSE)
