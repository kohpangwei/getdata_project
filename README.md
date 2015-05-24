# getdata_project

run_analysis.R is a script that takes the data in 

  https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

and generates a tidy dataset from it.

For the script to run, the file above needs to be extracted to the same directory.

The script generates summarizedData.txt. 
This dataset contains 180 observations of 88 variables.
The variables are:
- Activity
- Subject
- 86 other variables describing various measurements collected from the smartphone

Each variable represents the average over all measurements of that variable from the same subject doing the same activity. For example, the "tBodyAcc.mean...X" column represents the averages of all tBodyAcc.mean...X measurements over each (activity,subject) pair.




