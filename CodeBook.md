

One of the most exciting areas in all of data science right now is wearable computing - see for example this article . Companies like Fitbit, Nike, and Jawbone Up are racing to develop the most advanced algorithms to attract new users. The data linked to from the course website represent data collected from the accelerometers from the Samsung Galaxy S smartphone. A full description is available at the site where the data was obtained:

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

Here are the data for the project:

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 


run_analysis.r performs the following tasks:

# Check for data directory
# Check zipped file unzipped, if not unzip.

# Load test data
# Load train data
# Load activity labels
# Load feature names
# Name columns of test and train features
# Select only mean and std headers
# Filter mean and std columns on test and train
# Merge all test and train rows
# Combine all vectors/data.frames into one data.frame
# Aggregate by subjectid and activity
# Rename Activities
