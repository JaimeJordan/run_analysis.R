##Creat one R script called run_analysis.R that does the following:
## 1. Merges the training and the test sets to create one data set.
## 2. Extracts only the measurements on the mean and standard deviation for each measurement.
## 3. Uses descriptive activity names to name the activities in the data set.
## 4. Appropriately labels the data set with descriptive variable names.
## 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

##Load Data
featureNames<-read.table("features.txt")
activityLabels<-read.table("activity_labels.txt", header=FALSE)
subjectTrain <-read.table("train/subject_train.txt", header=FALSE)
activityTrain<-read.table("train/y_train.txt", header=FALSE)
featuresTrain<-read.table("train/X_train.txt", header=FALSE)
subjectTest<- read.table("test/subject_test.txt", header=FALSE)
activityTest<-read.table("test/y_test.txt", header=FALSE)
featuresTest<-read.table("test/x_test.txt", header=FALSE)

## STEP 1: MERGE THE TRAINING AND TEST SETS TO CREATE ONE DATA SET.
  subject <- rbind(subjectTrain, subjectTest)
  activity <- rbind(activityTrain, activityTest)
  features <- rbind(featuresTrain, featuresTest)
## Name the columns
    colnames(features) <- t(featureNames[2])
##Merge the data
      colnames(activity) <- "Activity"
      colnames(subject) <- "Subject"
      completeData <- cbind(features, activity, subject)

## STEP 2: EXTRACT ONLY THE MEASUREMENTS ON THE MEAN AND STANDARD DEVIATION FOR EACH MEASUREMENT
##Extract the column indices that have either mean or std in them
      columnsWithMeansSTD <- grep(".*Mean.*|.*Std.*", names(completeData), ignore.case=TRUE)
##Add activity and subject columns to the list and look at the dimension
      requiredColumns <- c(columnsWithMeansSTD, 562, 563)
      dim(completeData)
      [1] 10299   563
##Look at the dimension of requiredColumns
       extractedData <- completeData[, requiredColumns]
       dim(extractedData)
      [1] 10299    88

## STEP 3: USE DESCRIPTIVE ACTIVITY NAMES TO NAME THE ACTIVITIES IN THE DATA SET
## Change numeric type to character type
       extractedData$Activity <- as.character(extractedData$Activity)
       for (i in 1:6) {
         extractedData$Activity[extractedData$Activity == i] <- as.numeric(activityLabels[i,2])
          }
       extractedData$Activity <- as.factor(extractedData$Activity)
       
## STEP 4: APPROPRIATELY LABEL THE DATA SET WITH DESCRIPTIVE VARIABLE NAMES
## After examining the names of variables in extractedData (with names(extractedData)), replace acronyms
       names(extractedData) <- gsub("Acc", "accelerometer", names(extractedData))
       names(extractedData) <- gsub("Gyro", "gyroscope", names(extractedData))
       names(extractedData) <- gsub("BodyBody", "body", names(extractedData))
       names(extractedData) <- gsub("Mag", "magnitude", names(extractedData))
       names(extractedData) <-gsub("^t", "time", names(extractedData))
       names(extractedData) <- gsub("^f", "frequency", names(extractedData))
       names(extractedData) <- gsub("tBody", "timeBody", names(extractedData))
       names(extractedData) <- gsub("-mean()", "mean", names(extractedData))
       names(extractedData) <- gsub("-std()", "std", names(extractedData))
       names(extractedData) <- gsub("-freq()", "frequency", names(extractedData))

       ##names of variables in extractedData after they are edited:
         names(extractedData)
       [1] "timeBodyaccelerometerelerometerelerometermean()-X"                    
       [2] "timeBodyaccelerometerelerometerelerometermean()-Y"                    
       [3] "timeBodyaccelerometerelerometerelerometermean()-Z"                    
       [4] "timeBodyaccelerometerelerometerelerometerstd()-X"                     
       [5] "timeBodyaccelerometerelerometerelerometerstd()-Y"                     
       [6] "timeBodyaccelerometerelerometerelerometerstd()-Z"                     
       [7] "timeGravityaccelerometerelerometerelerometermean()-X"                 
       [8] "timeGravityaccelerometerelerometerelerometermean()-Y"                 
       [9] "timeGravityaccelerometerelerometerelerometermean()-Z"                 
       [10] "timeGravityaccelerometerelerometerelerometerstd()-X"                  
       [11] "timeGravityaccelerometerelerometerelerometerstd()-Y"                  
       [12] "timeGravityaccelerometerelerometerelerometerstd()-Z"                  
       [13] "timeBodyaccelerometerelerometerelerometerJerkmean()-X"                
       [14] "timeBodyaccelerometerelerometerelerometerJerkmean()-Y"                
       [15] "timeBodyaccelerometerelerometerelerometerJerkmean()-Z"                
       [16] "timeBodyaccelerometerelerometerelerometerJerkstd()-X"                 
       [17] "timeBodyaccelerometerelerometerelerometerJerkstd()-Y"                 
       [18] "timeBodyaccelerometerelerometerelerometerJerkstd()-Z"                 
       [19] "timeBodygyroscopescopemean()-X"                                       
       [20] "timeBodygyroscopescopemean()-Y"                                       
       [21] "timeBodygyroscopescopemean()-Z"                                       
       [22] "timeBodygyroscopescopestd()-X"                                        
       [23] "timeBodygyroscopescopestd()-Y"                                        
       [24] "timeBodygyroscopescopestd()-Z"                                        
       [25] "timeBodygyroscopescopeJerkmean()-X"                                   
       [26] "timeBodygyroscopescopeJerkmean()-Y"                                   
       [27] "timeBodygyroscopescopeJerkmean()-Z"                                   
       [28] "timeBodygyroscopescopeJerkstd()-X"                                    
       [29] "timeBodygyroscopescopeJerkstd()-Y"                                    
       [30] "timeBodygyroscopescopeJerkstd()-Z"                                    
       [31] "timeBodyaccelerometerelerometerelerometermagnitudemean()"             
       [32] "timeBodyaccelerometerelerometerelerometermagnitudestd()"              
       [33] "timeGravityaccelerometerelerometerelerometermagnitudemean()"          
       [34] "timeGravityaccelerometerelerometerelerometermagnitudestd()"           
       [35] "timeBodyaccelerometerelerometerelerometerJerkmagnitudemean()"         
       [36] "timeBodyaccelerometerelerometerelerometerJerkmagnitudestd()"          
       [37] "timeBodygyroscopescopemagnitudemean()"                                
       [38] "timeBodygyroscopescopemagnitudestd()"                                 
       [39] "timeBodygyroscopescopeJerkmagnitudemean()"                            
       [40] "timeBodygyroscopescopeJerkmagnitudestd()"                             
       [41] "frequencyBodyaccelerometerelerometerelerometermean()-X"               
       [42] "frequencyBodyaccelerometerelerometerelerometermean()-Y"               
       [43] "frequencyBodyaccelerometerelerometerelerometermean()-Z"               
       [44] "frequencyBodyaccelerometerelerometerelerometerstd()-X"                
       [45] "frequencyBodyaccelerometerelerometerelerometerstd()-Y"                
       [46] "frequencyBodyaccelerometerelerometerelerometerstd()-Z"                
       [47] "frequencyBodyaccelerometerelerometerelerometermeanFreq()-X"           
       [48] "frequencyBodyaccelerometerelerometerelerometermeanFreq()-Y"           
       [49] "frequencyBodyaccelerometerelerometerelerometermeanFreq()-Z"           
       [50] "frequencyBodyaccelerometerelerometerelerometerJerkmean()-X"           
       [51] "frequencyBodyaccelerometerelerometerelerometerJerkmean()-Y"           
       [52] "frequencyBodyaccelerometerelerometerelerometerJerkmean()-Z"           
       [53] "frequencyBodyaccelerometerelerometerelerometerJerkstd()-X"            
       [54] "frequencyBodyaccelerometerelerometerelerometerJerkstd()-Y"            
       [55] "frequencyBodyaccelerometerelerometerelerometerJerkstd()-Z"            
       [56] "frequencyBodyaccelerometerelerometerelerometerJerkmeanFreq()-X"       
       [57] "frequencyBodyaccelerometerelerometerelerometerJerkmeanFreq()-Y"       
       [58] "frequencyBodyaccelerometerelerometerelerometerJerkmeanFreq()-Z"       
       [59] "frequencyBodygyroscopescopemean()-X"                                  
       [60] "frequencyBodygyroscopescopemean()-Y"                                  
       [61] "frequencyBodygyroscopescopemean()-Z"                                  
       [62] "frequencyBodygyroscopescopestd()-X"                                   
       [63] "frequencyBodygyroscopescopestd()-Y"                                   
       [64] "frequencyBodygyroscopescopestd()-Z"                                   
       [65] "frequencyBodygyroscopescopemeanFreq()-X"                              
       [66] "frequencyBodygyroscopescopemeanFreq()-Y"                              
       [67] "frequencyBodygyroscopescopemeanFreq()-Z"                              
       [68] "frequencyBodyaccelerometerelerometerelerometermagnitudemean()"        
       [69] "frequencyBodyaccelerometerelerometerelerometermagnitudestd()"         
       [70] "frequencyBodyaccelerometerelerometerelerometermagnitudemeanFreq()"    
       [71] "frequencybodyaccelerometerelerometerelerometerJerkmagnitudemean()"    
       [72] "frequencybodyaccelerometerelerometerelerometerJerkmagnitudestd()"     
       [73] "frequencybodyaccelerometerelerometerelerometerJerkmagnitudemeanFreq()"
       [74] "frequencybodygyroscopescopemagnitudemean()"                           
       [75] "frequencybodygyroscopescopemagnitudestd()"                            
       [76] "frequencybodygyroscopescopemagnitudemeanFreq()"                       
       [77] "frequencybodygyroscopescopeJerkmagnitudemean()"                       
       [78] "frequencybodygyroscopescopeJerkmagnitudestd()"                        
       [79] "frequencybodygyroscopescopeJerkmagnitudemeanFreq()"                   
       [80] "angle(timeBodyaccelerometerelerometerelerometerMean,gravity)"         
       [81] "angle(timeBodyaccelerometerelerometerelerometerJerkMean),gravityMean)"
       [82] "angle(timeBodygyroscopescopeMean,gravityMean)"                        
       [83] "angle(timeBodygyroscopescopeJerkMean,gravityMean)"                    
       [84] "angle(X,gravityMean)"                                                 
       [85] "angle(Y,gravityMean)"                                                 
       [86] "angle(Z,gravityMean)"                                                 
       [87] "Activity"                                                             
       [88] "Subject" 
         
## STEP 5: FROM THE DATA IN STEP 4, CREATE A SECOND, INDEPENDENT TIDY DATA SET WITH THE AVERAGE OF EACH VARIABLE FOR EACH ACTIVITY AND EACH SUBJECT.
         extractedData$Subject <- as.factor(extractedData$Subject)
         extractedData <- data.table(extractedData)
         ## tidyData will be the data set with the average for each activity and subject.
          tidyData <- aggregate(. ~Subject + Activity, extractedData, mean)
          tidyData <- tidyData[order(tidyData$Subject, tidyData$Activity),]
         ## write into data file Tidy.txt that contains the processed data
           write.table(tidyData, file = "Tidy.txt", row.names=FALSE)
       