#Overview

The original source of the data used for this Course Project can be found here:

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

The full description of the original data can be found here:

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

##Course Project Output Description

The above sources provide sufficient descriptions of the original raw data. As such, this codebook is limited to describing the changes made in relation to the Course Project and the final output of tidy_data.txt. The variables in tidy_data.txt are labelled in columns as follows:

1. Activity - An id assigned to the particular activity i.e. numbers 1-6 are assigned to activities Walking, Walking Upstairs, Walking Downstairs, Sitting, Standing, Laying respectively.
2. Activity Name - The name of the activity corresponding to the id above.
3. Subject - An id assigned to the particular subject(s) numbered 1-30.

Besides the above 3 columns, the other columns/variables in tidy_data.txt retain the original names and meanings as the original raw data except for the following changes:

1. BodyBody - Renamed to "Body"
2. Acc - Renamed to "Acceleration"
3. Gyro - Renamed to "Angle"
4. Mag - Renamed to "Magnitude"

The variables were renamed to enable easier human readibility. No other changes were made to the original names as it is my personal view that other than the above, the original names achieve the objective of being concise, distinct and clear enough for quick reference by the end user.

The output in tidy_data.txt contains the average (mean) of the "Mean" and "Standard Variation" variables for each activity and each subject, as extracted from the original raw data.
