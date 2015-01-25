
## Human Activity Recognition Tidy Data Set

`Version 1.0  Gemy.Zhou`


Smartlab - Non Linear Complex Systems Laboratory has done a research work on human activity recognition and got experiment results.This script is to make the experiment results a tidy set.

reference:<br/>
[1] http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones<br/>
[2] Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine. International Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012


**The depository includes following files:**

------------------------------------------------------------------------

- 'README.md’

- ‘CodeBook.md’: Shows information about the variables of the tidy data.

- ‘run_analysis.R’: Gathers the experiment data sets and turns them to a tidy set.


**Steps:**

-------------------------------------------------------
1. Merges the training and the test sets to create one data set.<br>
   Combine together the activity,subject and measurements. Combine together training and test data sets.

2. Extracts only the measurements on the mean and standard deviation for each measurement. <br>
	Select all measurements which features contains “mean” or “std”
	
3. Uses descriptive activity names to name the activities in the data set<br>
   Replace activity code with their descriptive names.

4. Appropriately labels the data set with descriptive variable names.<br>
   For activities and subjects using the name “activity” and “subject”. For measurements, directly using their features by removing all the punctures in the features.

5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject<br>
  Grouped the data by activity and subject and mean all the measurements.