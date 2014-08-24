### Function to prepare tidy data set to perform analysis. It has 6 steps
## Step1: Read features from features.txt and remove unwanted characters
## Step2: Read subject values rom subject_labels.txt
## Step3: Read trainset and give feature names
## Step4: Read activity codes in t_train.txt,give descriptive names and
## generate train data set with activity,subject included corresponding to data
## Step5: Repeat step1 to 4 on test data set & merge both
## Step6: Select columns of interest (with mean and Std) and write tidydata.txt
## file
## Before running this function execute sourcce ("run_analysis.R") from wd
## sourcce("run_analysis.R")
runAnalysis <- function(path_wd) {
    
    ### set working directory
    setwd(path_wd)
    
    ## Step1
    ## Read files common for both data sets
    features <- read.table("./features.txt", sep=" ")
    features <- gsub("-|\\(|\\)|\\,|\\()","",as.character(features[,2]))
    activity_labels <- read.table("./activity_labels.txt", sep=" ")
    
    ## Step2
    ##Read files for tain data set and make train data table
    vol_code_trainset <- read.table("./train/subject_train.txt")
    colnames(vol_code_trainset)[1] <- "subject"
    
    ## Step3
    ## Name the columns with feature names in train data set
    data_trainset <- read.table("./train/X_train.txt")
    for ( i in 1:length(features)) {
        colnames(data_trainset)[i] <- features[i]
    }
    
    ## Step4
    ## Giving descriptive names for activity codes in train data set
    activity_code_trainset <- read.table("./train/y_train.txt")
    colnames(activity_code_trainset)[1] <- "activityCode"
    activity_descreption_trainset <- activity_code_trainset
    
    factors <- factor(activity_descreption_trainset$activityCode)
    levels(factors) <- activity_labels[,2]
    activity_descreption_trainset$activityCode <- factors
    colnames(activity_descreption_trainset)[1] <- "activity"
    
    data_trainset <- cbind(vol_code_trainset,data_trainset)
    data_trainset <- cbind(activity_code_trainset,data_trainset)
    data_trainset <- cbind(activity_descreption_trainset,data_trainset)
    
    ## Step5
    ##Read files for test data set and make test data table
    vol_code_testset <- read.table("./test/subject_test.txt")
    colnames(vol_code_testset)[1] <- "subject"
    ## Assign column names for feature variables in test data set
    data_testset <- read.table("./test/X_test.txt")
    for ( i in 1:length(features)) {
        colnames(data_testset)[i] <- features[i]
    }
    
    ## Giving descriptive names for activity codes in test data set
    activity_code_testset <- read.table("./test/y_test.txt")
    colnames(activity_code_testset)[1] <- "activityCode"
    activity_descreption_testset <- activity_code_testset
    
    factors <- factor(activity_descreption_testset$activityCode)
    levels(factors) <- activity_labels[,2]
    activity_descreption_testset$activityCode <- factors
    colnames(activity_descreption_testset)[1] <- "activity"
    
    data_testset <- cbind(vol_code_testset,data_testset)
    data_testset <- cbind(activity_code_testset,data_testset)
    data_testset <- cbind(activity_descreption_testset,data_testset)
    
    master_tidydata <- rbind (data_trainset,data_testset)
    req_cols <- grep("ean|std",names(master_tidydata))
    
    reqdataSet <- master_tidydata[,1:3]
    #reqdataSet <- data.frame()
    
    for (k in 1:length(req_cols)) {  
        reqdataSet <- cbind(reqdataSet,master_tidydata[req_cols[k]])
    }
    
    tidydata <-aggregate(reqdataSet, by=list(reqdataSet$activity,reqdataSet$subject),FUN=mean, na.rm=TRUE)
    
    write.table(reqdataSet,"./tidydata.txt",row.name=FALSE)
    write.table(master_tidydata,"./masterdataset.txt",row.name=FALSE)
    #melted <- melt(master_tidydata, id.vars = c("activity", "subject"))
    #tidy <- ddply(melted, c("activity", "subject"), summarise, mean = mean(value))
}