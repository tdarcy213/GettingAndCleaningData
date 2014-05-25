## run_analysis.R
##
## R script that will:
##	- read subject, activity, features, and observation data for "test" and "train" segments
##	- Merges the training and the test sets to create one data set.
##	- Extracts only the measurements on the mean and standard deviation for each measurement. 
##	- Use descriptive activity names to name the activities in the data set
##	- Appropriately label the data set with descriptive activity names 
##	- Creates a second, independent tidy data set with the average of each variable for each activity and each subject. 
##
##
## We are using the data.table package...
library(data.table)
##
## read activity labels
activities<-read.table("activity_labels.txt",header=FALSE)
colnames(activities)<-c("activityId","activity")
##
## read features, and employ "gsub" function to render feature names "R appropriate"
features<-read.table("features.txt",header=FALSE)
features$V2<-gsub("()","",features$V2,fixed=TRUE)
features$V2<-gsub("-","_",features$V2,fixed=TRUE)
##
## read test and train observations; combine via rbind function; give meaningful column names
test_obs<-read.table("X_test.txt",header=FALSE,sep="")
train_obs<-read.table("X_train.txt",header=FALSE,sep="")
all_obs<-rbind(test_obs,train_obs)
colnames(all_obs)<-features$V2
##
## read test and train subjects; combine via rbind function; give meaningful column name
test_subjects<-read.table("subject_test.txt",header=FALSE)
train_subjects<-read.table("subject_train.txt",header=FALSE)
all_subjects<-rbind(test_subjects,train_subjects)
colnames(all_subjects)<-"subjectId"
##
## read test and train activities; combine via rbind function; give meaningful column name
test_activities<-read.table("y_test.txt",header=FALSE)
train_activities<-read.table("y_train.txt",header=FALSE)
all_activities<-rbind(test_activities,train_activities)
colnames(all_activities)<-"activityId"
##
## build tidy data set comprised of all subjects, activities, and observations
all_obs<-cbind(all_subjects,all_activities,all_obs)
##
## build derivative of tidy data set the contains only "mean" or "std" observations (based on column name)
select_obs<-cbind(all_obs[,1:2],all_obs[,grep("mean|std",names(all_obs))])
select_obs<-merge(select_obs,activities,by='activityId',sort=FALSE)
##
## cast select_obs "tidy" as a data.table
select_obs<-data.table(select_obs)
##
## calculate mean of all observations, and group by subject and activity
summary_obs<-select_obs[,list(AVG_tBodyAcc_mean_X=mean(tBodyAcc_mean_X),
AVG_tBodyAcc_mean_Y=mean(tBodyAcc_mean_Y),
AVG_tBodyAcc_mean_Z=mean(tBodyAcc_mean_Z),
AVG_tBodyAcc_std_X=mean(tBodyAcc_std_X),
AVG_tBodyAcc_std_Y=mean(tBodyAcc_std_Y),
AVG_tBodyAcc_std_Z=mean(tBodyAcc_std_Z),
AVG_tGravityAcc_mean_X=mean(tGravityAcc_mean_X),
AVG_tGravityAcc_mean_Y=mean(tGravityAcc_mean_Y),
AVG_tGravityAcc_mean_Z=mean(tGravityAcc_mean_Z),
AVG_tGravityAcc_std_X=mean(tGravityAcc_std_X),
AVG_tGravityAcc_std_Y=mean(tGravityAcc_std_Y),
AVG_tGravityAcc_std_Z=mean(tGravityAcc_std_Z),
AVG_tBodyAccJerk_mean_X=mean(tBodyAccJerk_mean_X),
AVG_tBodyAccJerk_mean_Y=mean(tBodyAccJerk_mean_Y),
AVG_tBodyAccJerk_mean_Z=mean(tBodyAccJerk_mean_Z),
AVG_tBodyAccJerk_std_X=mean(tBodyAccJerk_std_X),
AVG_tBodyAccJerk_std_Y=mean(tBodyAccJerk_std_Y),
AVG_tBodyAccJerk_std_Z=mean(tBodyAccJerk_std_Z),
AVG_tBodyGyro_mean_X=mean(tBodyGyro_mean_X),
AVG_tBodyGyro_mean_Y=mean(tBodyGyro_mean_Y),
AVG_tBodyGyro_mean_Z=mean(tBodyGyro_mean_Z),
AVG_tBodyGyro_std_X=mean(tBodyGyro_std_X),
AVG_tBodyGyro_std_Y=mean(tBodyGyro_std_Y),
AVG_tBodyGyro_std_Z=mean(tBodyGyro_std_Z),
AVG_tBodyGyroJerk_mean_X=mean(tBodyGyroJerk_mean_X),
AVG_tBodyGyroJerk_mean_Y=mean(tBodyGyroJerk_mean_Y),
AVG_tBodyGyroJerk_mean_Z=mean(tBodyGyroJerk_mean_Z),
AVG_tBodyGyroJerk_std_X=mean(tBodyGyroJerk_std_X),
AVG_tBodyGyroJerk_std_Y=mean(tBodyGyroJerk_std_Y),
AVG_tBodyGyroJerk_std_Z=mean(tBodyGyroJerk_std_Z),
AVG_tBodyAccMag_mean=mean(tBodyAccMag_mean),
AVG_tBodyAccMag_std=mean(tBodyAccMag_std),
AVG_tGravityAccMag_mean=mean(tGravityAccMag_mean),
AVG_tGravityAccMag_std=mean(tGravityAccMag_std),
AVG_tBodyAccJerkMag_mean=mean(tBodyAccJerkMag_mean),
AVG_tBodyAccJerkMag_std=mean(tBodyAccJerkMag_std),
AVG_tBodyGyroMag_mean=mean(tBodyGyroMag_mean),
AVG_tBodyGyroMag_std=mean(tBodyGyroMag_std),
AVG_tBodyGyroJerkMag_mean=mean(tBodyGyroJerkMag_mean),
AVG_tBodyGyroJerkMag_std=mean(tBodyGyroJerkMag_std),
AVG_fBodyAcc_mean_X=mean(fBodyAcc_mean_X),
AVG_fBodyAcc_mean_Y=mean(fBodyAcc_mean_Y),
AVG_fBodyAcc_mean_Z=mean(fBodyAcc_mean_Z),
AVG_fBodyAcc_std_X=mean(fBodyAcc_std_X),
AVG_fBodyAcc_std_Y=mean(fBodyAcc_std_Y),
AVG_fBodyAcc_std_Z=mean(fBodyAcc_std_Z),
AVG_fBodyAcc_meanFreq_X=mean(fBodyAcc_meanFreq_X),
AVG_fBodyAcc_meanFreq_Y=mean(fBodyAcc_meanFreq_Y),
AVG_fBodyAcc_meanFreq_Z=mean(fBodyAcc_meanFreq_Z),
AVG_fBodyAccJerk_mean_X=mean(fBodyAccJerk_mean_X),
AVG_fBodyAccJerk_mean_Y=mean(fBodyAccJerk_mean_Y),
AVG_fBodyAccJerk_mean_Z=mean(fBodyAccJerk_mean_Z),
AVG_fBodyAccJerk_std_X=mean(fBodyAccJerk_std_X),
AVG_fBodyAccJerk_std_Y=mean(fBodyAccJerk_std_Y),
AVG_fBodyAccJerk_std_Z=mean(fBodyAccJerk_std_Z),
AVG_fBodyAccJerk_meanFreq_X=mean(fBodyAccJerk_meanFreq_X),
AVG_fBodyAccJerk_meanFreq_Y=mean(fBodyAccJerk_meanFreq_Y),
AVG_fBodyAccJerk_meanFreq_Z=mean(fBodyAccJerk_meanFreq_Z),
AVG_fBodyGyro_mean_X=mean(fBodyGyro_mean_X),
AVG_fBodyGyro_mean_Y=mean(fBodyGyro_mean_Y),
AVG_fBodyGyro_mean_Z=mean(fBodyGyro_mean_Z),
AVG_fBodyGyro_std_X=mean(fBodyGyro_std_X),
AVG_fBodyGyro_std_Y=mean(fBodyGyro_std_Y),
AVG_fBodyGyro_std_Z=mean(fBodyGyro_std_Z),
AVG_fBodyGyro_meanFreq_X=mean(fBodyGyro_meanFreq_X),
AVG_fBodyGyro_meanFreq_Y=mean(fBodyGyro_meanFreq_Y),
AVG_fBodyGyro_meanFreq_Z=mean(fBodyGyro_meanFreq_Z),
AVG_fBodyAccMag_mean=mean(fBodyAccMag_mean),
AVG_fBodyAccMag_std=mean(fBodyAccMag_std),
AVG_fBodyAccMag_meanFreq=mean(fBodyAccMag_meanFreq),
AVG_fBodyBodyAccJerkMag_mean=mean(fBodyBodyAccJerkMag_mean),
AVG_fBodyBodyAccJerkMag_std=mean(fBodyBodyAccJerkMag_std),
AVG_fBodyBodyAccJerkMag_meanFreq=mean(fBodyBodyAccJerkMag_meanFreq),
AVG_fBodyBodyGyroMag_mean=mean(fBodyBodyGyroMag_mean),
AVG_fBodyBodyGyroMag_std=mean(fBodyBodyGyroMag_std),
AVG_fBodyBodyGyroMag_meanFreq=mean(fBodyBodyGyroMag_meanFreq),
AVG_fBodyBodyGyroJerkMag_mean=mean(fBodyBodyGyroJerkMag_mean),
AVG_fBodyBodyGyroJerkMag_std=mean(fBodyBodyGyroJerkMag_std),
AVG_fBodyBodyGyroJerkMag_meanFreq=mean(fBodyBodyGyroJerkMag_meanFreq)
),by=list(subjectId,activityId,activity)]
summary_obs<-summary_obs[order(subjectId,activityId),]
##
## write all_obs as a .csv file
write.csv(all_obs,"all_obs.csv",row.names=FALSE)
## write summary_obs as a .csv file
write.csv(summary_obs,"summary_obs.csv",row.names=FALSE)