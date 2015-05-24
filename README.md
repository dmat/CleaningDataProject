 # CleaningDataProject

 This README files explains how the run_analysis.R is implemented
 to complete the project work

 First, it reads features.txt file to get descriptive variable names.
 Then a subset of variable names that has mean or std is filtered
 This is to meet the requirement for Step 4.

 The next step is to read the training data and merge Subject, Activity
 and Feature data frames.

 Next, the test data set is read and merged Subject, Activity and Feature
 data frames

 Once both Test and Training data set is prepared with Subject, Activity
 and Feature variables, both test and Training data frames were merged to one
 data frame called mData
 During the merge, only the feature variable with mean or std is inlcuded

 Then the merged data frame is sorted by Subject

 Then the data frame is grouped by Subject and Activity and average
 of Feature variable is calculated.
 The summary result is the written to a file called project_step5_result.txt
