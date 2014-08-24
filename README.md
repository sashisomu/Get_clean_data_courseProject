First a few initial lines describes about what the code does. It has
6 major steps. Function is to prepare tidy data set to perform analysis.
Code performs same set of operations of reading data, transforming columns etc..
to trainset and test set data seperately and merges them to generate one data set

In Step1: Read features from features.txt and remove unwanted characters
read.table is used to read txt file. and gsub command is used to remove
un wanted characters. All these modified features are stroed in object called features
The activity labels and corresponding descriptions are also read into a variable
called activity_labels 

In Step2: Read subject values rom subject_labels.txt. Valunteers codes or subject 
are read into a variable called vol_code_trainset. name of the column is also given as subjct

In Step3: Read trainset and give feature names. Train data set is read from working directory
As it don't have any column names default col names are assigned. These default colnames(variable names)
are changed using a for loop and cleaned feature names stored in features are assigned to 561 columns

In Step4: Read activity codes in t_train.txt,give descriptive names and generate train data set with activity
subject included corresponding to data. cbind function is used to perform this operation
Now the train data set will have 564 columns


In Step5: Repeat step1 to 4 on test data set & merge both. Above mentioned 4 steps are
performed on test data set just by replacing name of variables with test in place of train
by the end of step 5 both cleaned & modified train and test data sets are ready

Step6: Select columns of interest (with mean and Std) and write tidydata set file. 
And also writes master data set. In this step columns that has mean or std in its descreption
are extracted using grep command

means are calculated using aggregate function and written to a txt file