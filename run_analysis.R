run_analysis <- function () {
  
  library(data.table)
  library(plyr)
  library(reshape2)
  library(jsonlite)
  library(httr)
  library(httpuv)
  library(XML)
  library(xlsx)
  ## Data frame containing all the features - used as descriptive labels in the final data set dataframe
          features <- read.table("./features.txt", header=FALSE, stringsAsFactors=FALSE)
                  #head(features)
  
  ## Build a data frame containing all the activity labels and the corresponding numbers
          activities_df <- read.table("./activity_labels.txt", header=FALSE, stringsAsFactors=FALSE)
          activities <- activities_df[[2]]
                  #print(class(activities))
                  #print(activities)
  
  ## Build data frames containing all the subject identifiers
          subjects_train <- read.table("./train/subject_train.txt", header=FALSE, stringsAsFactors=FALSE)
          subjects_test <- read.table("./test/subject_test.txt", header=FALSE, stringsAsFactors=FALSE)
                  #print(subjects_train)
                  #print(subjects_test)
  
  ## Build train data frame and label with descriptive variable names
          train.col.names <- features[[2]]
                  #print(train.test.col.names)
          train.data <- read.table("./train/X_train.txt", col.names=train.col.names, header=FALSE, stringsAsFactors=FALSE)
                  #print(head(train.data))
                  #print(tail(train.data))
                  #print(class(train.data))
          train.activities <- read.table("./train/y_train.txt", col.names=c("activities"), header=FALSE, stringsAsFactors=FALSE)
                  #print(head(train.activities))
          train.data["activities"] <- train.activities$activities
                  #print(head(train.data))
          train.data["subjects"] <- subjects_train[[1]]
  
  
  
  ## Build test data frame and label with descriptive variable names
          test.col.names <- features[[2]]
                  #print(test.col.names)
          test.data <- read.table("./test/X_test.txt", col.names=test.col.names, header=FALSE, stringsAsFactors=FALSE)
                  #print(head(test.data))
                  #print(tail(test.data))
                  #print(class(test.data))
          test.activities <- read.table("./test/y_test.txt", col.names=c("activities"), header=FALSE, stringsAsFactors=FALSE)
          test.data["activities"] <- test.activities$activities
                  #print(head(test.data))
          test.data["subjects"] <- subjects_test[[1]]
  
  
  ## Merge the two data frames vertically
          test.train.merged <- rbind(train.data, test.data)
                  #print((test.train.merged[[1]]))
  
  
  ## Extract only columns containing mean and Standard deviation measurements and the activity labels
          extract_list <- names(test.train.merged)[union(grep("^.*mean.*$", names(test.train.merged)), grep("^.*std.*$", names(test.train.merged)) )]
          test.train.mean.SD <- subset(test.train.merged, select=c(extract_list, "activities", "subjects"), stringsAsFactors=FALSE)
                  #print(head(test.train.mean.SD))
  
  
  ## Replace activity label numbers with their descriptive names
          
          descriptive <- lapply(as.numeric(test.train.mean.SD[["activities"]]), function(x) { activities[x]})
                  #print(head(descriptive))
                  #print(class(descriptive))
          test.train.mean.SD[["activities"]] <- descriptive
                  #print(head(test.train.mean.SD))
                  #print(tail(test.train.mean.SD))
  
  #####         test.train.mean.SD     done    #########
  
  
  ## Create a tidy data set with the average of each variable for each activity and each subject
  
          ## Start with test.train.merged
          
          # Extract row names of all variables except activities and subjects
                AllColumns <- colnames(test.train.merged)
                TidyColumns <- head(AllColumns, -2)
                        #print(TidyColumns)
          
          # Melt the data with activities and subjects as variables
                melt.data <- melt(test.train.merged, id=TidyColumns, measure.vars=c("activities", "subjects"))
                          #print(head(melt.data))
          
          # Recast into tidy data with mean values of varibales 
                tidy.data <- dcast(melt.data, TidyColumns ~ variable,mean)
                        #print(head(tidy.data))
                        #print(tail(tidy.data))
  
          # Write the tidy data into a space separated file tidydata.txt
          write.table(tidy.data, file="./tidydata.txt", sep=" ", row.names=FALSE)
  
}