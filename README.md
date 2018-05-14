# Getting-and-Cleaning-Data
# Tidying up data from Wearable sensors
# The script merges data from Training and Test Sets
# It does so by first uploading each of the datasets.  Combining subject and activity related description with each of the data sets
# It then combines the training and test data set
# It then groups data by subject and activity type
# It presents the final output by means of all parameters (of mean and std deviation) by subject and activity type

STEPS FOR SETTING UP THE SYSTEM :

1. Download data files from the link provided in the problem statement to UCI HAR Dataset

2. Start R Studio

3. Set working directory as the UCI HAR Dataset directory

4. Run the R script attached

5. The final_output gets stored in the same directory as the "final_output.txt" file

PLEASE NOTE : The use of grep function picks a smaller set of "mean" related variables than the "contains" 
function.  Depending upon the correct interpretation, one could use one or the other construct here.

