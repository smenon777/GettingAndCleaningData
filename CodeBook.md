The first step in the script is the creation of a lookup dictionary for the activities.
This is done completely in the code and does not read the activities file. 

Next an vector of feature names is created and another with mean and std features.
For both train and test sub folders the following steps are done:

The raw data is read from X_train or X_test.  Its columns are named to the feature vector and then subsetted 
by the filtered feature list, i.e., mean and std colums. This is filtered data frame.

Then the label file is read, combined with the dictionary using merge.
This is the subsetted by Activity name and added to the filtered data frame.

Similarly subjects are read from the subject file and combined with the filtered data frame.

The both trail and test data are combined and finally using the aggregate function the mean of each column grouped 
by Subject and Activity are created and written to an output file.
