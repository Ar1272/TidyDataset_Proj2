
library(plyr)
library(reshape2)
library(downloader)
library(dplyr)
setInternet2(TRUE)

getwd()

fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI20HAR%20Dataset.zip" 

Dataset <- download.file(fileUrl,destfile="Dataset.zip",mode="wb")
unzip(Dataset)

# Activity labes for Test,Train dataset
act_t1<-read.table("./UCI HAR Dataset/activity_labels.txt",header=FALSE)

act_t2<-read.table("./UCI HAR Dataset/activity_labels.txt",header=FALSE)

#Providing column names to the Activity Lables
names(act_t1) <- c("Code","Activity")
names(act_t2) <- c("Code","Activity")

#Activity for Test,Train dataset
t1_a <-read.table("./UCI HAR Dataset/test/y_test.txt",header=FALSE)
t2_a <-read.table("./UCI HAR Dataset/train/y_train.txt",header=FALSE)

names(t1_a) <- c("Code")
names(t2_a) <- c("Code")

#Merge Test dataset Activity with Labels
t1_act <- merge(t1_a,act_t1,by="Code",t1_a=TRUE)
t2_act <- merge(t2_a,act_t2,by="Code",t2_a=TRUE)

#Read subject test,train datasets
t1_sub <- read.table("./UCI HAR Dataset/test/subject_test.txt",header=FALSE)
t2_sub <- read.table("./UCI HAR Dataset/train/subject_train.txt",header=FALSE)

names(t1_sub) <- c("Subject")
names(t2_sub) <- c("Subject")

#Merge Subject data with Activity data.
t1_sub_act <- cbind(t1_sub,t1_act)
t2_sub_act <- cbind(t2_sub,t2_act)

#Read feature dataset
features<-read.table("./UCI HAR Dataset/features.txt",header=FALSE)
names(features) <- c("ID","Feature")

#Read test dataset 
t1 <- read.table("./UCI HAR Dataset/test/X_test.txt",header=FALSE)
names(t1) <- features[,2]

#Read train dataset 
t2 <- read.table("./UCI HAR Dataset/train/X_train.txt",header=FALSE)
names(t2) <- features[,2]

#Extracting Mean, std columns from the Test dataset.
mean_cols <- matchcols(t1, with=c("mean"), without=c("meanFreq"), method="and")
mean_cols <- matchcols(t1, with=c("mean"), without=c("meanFreq"))
std_cols  <- matchcols(t1, with=c("std"))
new_cols <- c(mean_cols, std_cols)

Test_Dataset <-  t1[,c(new_cols)]
Train_Dataset <- t2[,c(new_cols)]

#Merging Test dataset with Subject, Activity labels data.
Test_vth_Sub_Act <-  cbind(Test_Dataset,t1_sub_act)
Train_vth_Sub_Act <- cbind(Train_Dataset,t2_sub_act)

#Merging Test dataset with Train dataset

TidyDataset <- rbind(Test_vth_Sub_Act,Train_vth_Sub_Act )

TidyDataset_Summ<-ddply(TidyDataset, .(Subject,Code,Activity),numcolwise(mean,na.rm=TRUE))

#Renaming column names in the Final Summarized Dataset
names(TidyDataset_Summ) <- gsub("fBody","Body",names(TidyDataset_Summ),fixed=TRUE)
names(TidyDataset_Summ) <- gsub("tBody","Body",names(TidyDataset_Summ),fixed=TRUE)
names(TidyDataset_Summ) <- gsub("BodyBody","Body",names(TidyDataset_Summ),fixed=TRUE)
names(TidyDataset_Summ) <- gsub("tGravity","Gravity",names(TidyDataset_Summ),fixed=TRUE)
names(TidyDataset_Summ) <- gsub("-mean()-X","_Mean_X",names(TidyDataset_Summ),fixed=TRUE)
names(TidyDataset_Summ) <- gsub("-mean()-Y","_Mean_Y",names(TidyDataset_Summ),fixed=TRUE)
names(TidyDataset_Summ) <- gsub("-mean()-Z","_Mean_Z",names(TidyDataset_Summ),fixed=TRUE)
names(TidyDataset_Summ) <- gsub("-mean()","_Mean",names(TidyDataset_Summ),fixed=TRUE)
names(TidyDataset_Summ) <- gsub("-std()-X","_std_X",names(TidyDataset_Summ),fixed=TRUE)
names(TidyDataset_Summ) <- gsub("-std()-Y","_std_Y",names(TidyDataset_Summ),fixed=TRUE)
names(TidyDataset_Summ) <- gsub("-std()-Z","_std_Z",names(TidyDataset_Summ),fixed=TRUE)
names(TidyDataset_Summ) <- gsub("-std()","_std",names(TidyDataset_Summ),fixed=TRUE)

write.table(TidyDataset_Summ,file="TidyDataset.txt",sep=" ", row.names=FALSE)
