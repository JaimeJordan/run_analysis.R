This Code Book describes the variables, the data, and any transformations or work that I performed to clean up the data.
STEP 1:
I combined the data in the training and test data sets corresponding to subject, activity, and features.  The results are stored in
"subject," "activity," and "features."

The data from "subject," "activity" and "features" were merged under "completeData."

STEP 2:
After extracting the column indices that have either mean or std in them, I produced "extractedData."

STEP 3:
I changed the activity field in "extractedData" from numeric class to character so it can accept activity names.  I took the activity 
names from the metadata "activityLabels."

STEP 4:
I replaced the following acronyms in "extractedData."
ACC was replaced with accelerometer
Gyro was replaced with gyroscope
BodyBody was replaced with body
Mag was replaced with magnitude
f was replaced with frequency
t was replaced with time
tBody was replaced with timeBody
-mean() was replaced with mean
-std() was replaced with std

STEP 5:
I set "Subject" as a factor variable and created tidyData as a data set with the average for each activity and subject. 
