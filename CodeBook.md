# getting_and_cleaning_data_assignment

All the relevant .txt files were loaded into the variable training & test, set/labels/subject

Activity lables data set was used to match the activity name to the relevant activity ID in the training lable data set. Simliar process was repeated for test label data set.

Column names were assigned for the subject, label, dataset for both training & test datasets. Features data file was used to assign column names to traning & test data sets.

A subset from traning data set was created using the grepl funtion to identify columns with mean/std string in the names. This subset is used going forward as the training data. Similar process was repeated for test data set.

Final traning data set was created by cbinding the subject, activity label, data set for training. Similar process was repeated for test data set.

Training and test data were merged into a single merged_data using rbind.

merged_data is transformed into a tidy dataset tidy_data using melt function.

Means were calculated for each feature, by suject and activity using dcast funtion.

Resultant output is written into a txt file tidy_data_mean.