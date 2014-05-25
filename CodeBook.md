## CodeBook for run_analysis.R script
## Data used in script
# features.txt:
A 561-feature vector with time and frequency domain variables.
# activity_labels.txt
Identifies the activities that were observed
# X_test.txt and X_train.txt
Activity observations for "test" and "train" segments
# y_test.txt and y_train.txt
Identifies the specific activity that correlates to the observation files
# subject_test.txt and subject_train.tx
Identifies the participant performing each activity that was observed
## Variables and Transformations
all_obs: data frame containing combined "test" and "train" observations
all_subjects: data frame containing combined "test" and "train" subjects
all_activities: data frame containing combined "test" and "train" activities

all_obs ultimately became the tidy data set containing all of the above
data

select_obs: a subset of all_obs, that contained only variables names
containing "mean" or "std"; this was cast as a data.table for summarization

summary_obs: the final tidy data set containing the averages of the
select features, grouped by subject and activity.

The "features.txt" data was used to provide meaningful column names to
the observations data frames.  The data required editing to remove special
characters "(",")",and "-", as these caused errors when trying to calculate
averages via the mean() function. 