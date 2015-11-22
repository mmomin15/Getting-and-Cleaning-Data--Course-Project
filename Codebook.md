# Getting-and-Cleaning-Data--Course-Project
The features selected for this database come from the accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ. These time domain signals (prefix ‘t’ to denote time) were captured at a constant rate of 50 Hz. and the acceleration signal was then separated into body and gravity acceleration signals (tBodyAcc-XYZ and tGravityAcc-XYZ) – both using a low pass Butterworth filter.

The body linear acceleration and angular velocity were derived in time to obtain Jerk signals (tBodyAccJerk-XYZ and tBodyGyroJerk-XYZ). Also the magnitude of these three-dimensional signals were calculated using the Euclidean norm (tBodyAccMag, tGravityAccMag, tBodyAccJerkMag, tBodyGyroMag, tBodyGyroJerkMag).

A Fast Fourier Transform (FFT) was applied to some of these signals producing fBodyAcc-XYZ, fBodyAccJerk-XYZ, fBodyGyro-XYZ, fBodyAccJerkMag, fBodyGyroMag, fBodyGyroJerkMag. (Note the ‘f’ to indicate frequency domain signals).

Description of abbreviations of measurements

leading t or f is based on time or frequency measurements.
Body = related to body movement.
Gravity = acceleration of gravity
Acc = accelerometer measurement
Gyro = gyroscopic measurements
Jerk = sudden movement acceleration
Mag = magnitude of movement
mean and SD are calculated for each subject for each activity for each mean and SD measurements.

The units given are g’s for the accelerometer and rad/sec for the gyro and g/sec and rad/sec/sec for the corresponding jerks.

These signals were used to estimate variables of the feature vector for each pattern:
‘-XYZ’ is used to denote 3-axial signals in the X, Y and Z directions. They total 33 measurements including the 3 dimensions - the X,Y, and Z axes.

tBodyAcc-XYZ
tGravityAcc-XYZ
tBodyAccJerk-XYZ
tBodyGyro-XYZ
tBodyGyroJerk-XYZ
tBodyAccMag
tGravityAccMag
tBodyAccJerkMag
tBodyGyroMag
tBodyGyroJerkMag
fBodyAcc-XYZ
fBodyAccJerk-XYZ
fBodyGyro-XYZ
fBodyAccMag
fBodyAccJerkMag
fBodyGyroMag
fBodyGyroJerkMag
The set of variables that were estimated from these signals are:

mean(): Mean value
std(): Standard deviation

Activity Labels
1 WALKING
2 WALKING_UPSTAIRS
3 WALKING_DOWNSTAIRS
4 SITTING
5 STANDING
6 LAYING


## Explanation for run_analysis.R

set file path to "UCI HAR Dataset" folder
Read data from local directory
1.  Merged the training and the test sets to create one data set.
    Merged the subject data and activity number data with the activity number. 
    Labeled column names with names of the features included in the features.txt file.

2.  Extracts only the measurements on the mean and standard deviation for each measurement. 
    Extracted Mean & Stdev data from the dataset with grep function
    created a dataset with mean and standard deviation along with activity names and subject ids

3.  Uses descriptive activity names to name the activities in the data set
    Extract activity names from the file activity_labels.txt, and create the database with those labels as a
    column
    Sorted variable means by subject and activity_name

4.  Appropriately labels the data set with descriptive variable names. 
    Relabled the dataset with gsub function
    
5.  From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

The analysis file created the tidy data set, a set of variables for each activity and each subject. 10299 rows of data is split into 180 groups which includes 30 subjects and 6 activities (1 WALKING, 2 WALKING_UPSTAIRS, 3 WALKING_DOWNSTAIRS, 4 SITTING, 5 STANDING, 6 LAYING) and 66 mean and standard deviation features are averaged for each group. The resulting data table has 180 rows and 69 columns; 33 Mean variables + 33 Standard deviation variables + 1 Subject( 1 of of the 30 test subjects) + activity_name + activity_id . The tidy data set’s first row is the header containing the names for each column.