## CodeBOOK.md
## This file contains description of the script and variables used

Step 1. The script loads all the required libraries

Step 2. Reads the file features.txt and creates a dataframe called 'features'
        This dataframe contains the number and description equivalent of all the labels.

Step 3. Read the file activity_labels.txt and create a dataframe called "activities_df"
        This dataframe contains the number and descriptive equivalents of all the activities.
        
Step 4. Extract the descriptive column of activities_df into a character vector called "activities"

Step 5. Read the files train/subject_train.txt and test/subject_test.txt and create 
              dataframes "subject_train" and "subject_test" respectively
        These dataframes contain the list of subject id's for each measurement row of training dataset and test dataset.
        
Step 6. Read the train/X_data.txt file and create the dataframe "train.data" containing all the training measurements.
        The column names for this dataframe comes from the list of descriptions sourced from second column of "features"
        
Step 7. Read the train/y_train.txt file and create the dataframe "train.activities" containing the number equivalent of
              all the activities for all the measurements. Append this as a new column with label activities to the 
              dataframe "train.data".
        Append the list of all subjects from "subjects_train" as a new column with label subjects to the 
              dataframe "train.data"
              
Step 8. Repeat steps 6 and 7 for test data set and create the dataframe "test.data".

Step 9. Merge the two dataframes "train.data" and "test.data" vertically into a dataframe "test.train.merged"

Step 10. Extract columns with only mean and standard deviation measurements using pattern matching and create a new 
              dataframe "test.train.mean.SD"
Step 11. Replace 'activities' column in "test.train.mean.SD" with its descriptive equivalents.

Step 12. Melt the "test.train.merged" dataframe with activities and subjects and measurement variables, 
              into a new dataframe "melt.data".
Step 13. Recast "melt.data" into "tidy.data" with mean values of the measurement variables activities and subjects.
Step 14. Write "tidy.data" into a space separated file called "tidydata.txt".        
