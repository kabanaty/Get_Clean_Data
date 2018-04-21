Tidy data is stored in a text file "tidy.txt".
The tidy data is all of the mean and standard deviation data from the original files. Original data comes from 
  https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip.

First step is to retrieve data from URL.  The dataset is unzipped into the working directory.  There are two datasets, training and test.
These datasets are loaded and merged into one.  They are sorted using the activity_labels and features factors.

Next, the data including only mean and standard deviation are extracted from the test and training datasets.  This extracted data
is then merged to create one dataset, then merged again with activity_labels and features as factors.  This dataset is then printed to tidy.txt.
