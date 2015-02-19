# Getting and Cleaning Data - Assignment 2

####This file describes the variables, the data, and any transformations or work that I have performed to clean up the data. 

####The site where the data was obtained:
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

####The data for the project:
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

The run_analysis.R script performs the following steps to clean the data:

1. Download the file from the source URL, unzip the file.
2. Read Activity Labels for Test and Train datasets. 
3. Read Subjects for Test and Train datasets.
4. Merge Subjects with Activity data. 
   a. variable act_t1 --> Test data, 
   b. variable act_t2 --> Train data.
5. Read feature dataset
   a. variable features --> Stores all the features info.
6. Read test, train dataset.
   a. variable t1 --> data from test dataset.
   b. variable t2 --> data from train dataset.
7. Extracting mean, std columns from the Test, Train datasets. 
   a. variable Test_Dataset --> Extracted columns from Test dataset.
   b. variable Train_Dataset --> Extracted columns from Train dataset.
8. Merge Test dataset with subject, Activity data. 
   a. variable Test_vt_Sub_Act --> Combined info of Subject, Activity with the features.
   b. variable Train_vt_Sub_Act --> Combined info of Subject, Activity with the features.
9. Merging Test dataset with Train dataset
   a. variable TidyDataset  --> has the merged data from Test, Train dataset.
10. Summarize the TidyDataset to calculate the average of the features group by subject, activity.
   a. variable TidyDataset_Summ --> Summarized dataset. 
11. Rename feature columns to make it more readable. 
12. Write the TidyDataset_Summ data to a file in the working directory with filename as "TidyDataset.txt"
