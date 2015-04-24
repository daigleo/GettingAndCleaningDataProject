## Code book

### understanding the variables
The following variables are included in the data:
-tBodyAcc-XYZ
-tGravityAcc-XYZ
-tBodyAccJerk-XYZ
-tBodyGyro-XYZ
-tBodyGyroJerk-XYZ
-tBodyAccMag
-tGravityAccMag
-tBodyAccJerkMag
-tBodyGyroMag
-tBodyGyroJerkMag
-fBodyAcc-XYZ
-fBodyAccJerk-XYZ
-fBodyGyro-XYZ
-fBodyAccMag
-fBodyAccJerkMag
-fBodyGyroMag
-fBodyGyroJerkMag

These 17 variables can be understood as follows:

-The prefix _t_ indicates a variable in the time domain;
-The prefix _f_ indicates a variables in the frequency domain (obtained by applying a fast Fourier transformation to the time domain variables);
-Any variable with an XYZ prefix means that one variable exists for each axial direction. E.g., tBodyAcc-XYZ mean that the three variables tBodyAcc-X, tBodyAcc-Y, and tBodyAcc-Z exist separately in the data;

### Subset of variable provided by the script
The script is used to report a subset of the variables contained in the UCI HAR Dataset. Only the mean and standard deviations of the above-listed variables are reported. The suffixes -mean() and -std() are used to set these values apart.