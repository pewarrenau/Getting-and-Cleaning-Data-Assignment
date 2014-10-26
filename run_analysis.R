# Create file handle variable
activitylabelsfile <- "./activity_labels.txt"
featuresfile <- "./features.txt"
outputfile <- "output.txt"
xtestfile <- "./test/X_test.txt"
ytestfile <- "./test/Y_test.txt"
ytrainfile <- "./train//y_train.txt"
xtrainfile <- "./train//x_train.txt"

# Load Activitity Labels description from file into a data.frame
activitylabels <- read.table(activitylabelsfile, col.names = c("activity", "activitydesc"))

# Load Features descirptions from file into a data.frame
features <- read.table(featuresfile, col.names = c("feature" ,"featuredesc"))
features$featuredesc <- gsub(pattern=",", replacement=" ", features$featuredesc)
features$featuredesc <- gsub(pattern="-", replacement=" ", features$featuredesc)
features$featuredesc <- gsub(pattern="[[:punct:]]", replacement="", features$featuredesc)
features2 <- features$featuredesc

# Load x and y test datasets into data.frames and then merge
xtest <- read.table(xtestfile, col.names=features2)
ytest <- read.table(ytestfile, col.names="activity")
testdata <- cbind(xtest, ytest)

# Load x and y training datasets into data.frames and then merge
xtrain <- read.table(xtrainfile, col.names=features2)
ytrain <- read.table(ytrainfile, col.names="activity")
traindata <- cbind(xtrain, ytrain)

# Merge test and training data.frames
alldata <- rbind(traindata, testdata)

# Create a logical vector for selecting the required columns from our dataset
matchStd <- grepl(pattern="std", names(alldata))
matchMean <- grepl(pattern="mean", names(alldata))
matchActivity <- grepl(pattern="activity", names(alldata))
matchcol <- matchStd | matchMean | matchActivity

# Subset the merged test and training on only the columns of interest
reducedData <- alldata[,matchcol]

# Join the reducedData datset with the activitylabel dataset to include activitiy
tidyData <- merge(activitylabels, reducedData, by="activity")

# Write tidyDada to a textfile
write.table(tidyData, file = outputfile, row.names = FALSE)



