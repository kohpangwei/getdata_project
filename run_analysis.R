library(data.table)
library(dplyr)


readData <- function(dataFolder, dataset){
  fX <- fread(paste0(dataFolder, "features.txt"))
  fX <- make.names(fX$V2)
  dupes <- duplicated(fX)
  fX <- fX[!dupes]
  X <- read.table(paste0(dataFolder, dataset, "/X_", dataset, ".txt"))
  X <- data.table(X)
  X <- X[, !dupes, with=FALSE]
  setnames(X, fX)
  
  fy <- fread(paste0(dataFolder, "activity_labels.txt"))
  y <- fread(paste0(dataFolder, dataset, "/y_", dataset, ".txt")) %>%
    transmute(activity = factor(V1, labels = fy[,V2]))
  
  s <- read.table(paste0(dataFolder, dataset, "/subject_", dataset, ".txt"))
  setnames(s, "subject")
  s <- mutate(s, subject = as.factor(subject))
  X <- select(X, contains("mean"), contains("std"))
  
  cbind(s,y,X) 
}


dataFolder <- "./UCI HAR Dataset/"

data <- rbind(readData(dataFolder, "train"), readData(dataFolder, "test")) %>%
  mutate(subject = as.factor(as.numeric(subject))) %>%
  arrange(activity, subject) %>%
  group_by(activity, subject) %>%
  summarise_each(funs(mean))

write.table(data, file="summarizedData.txt", row.name=FALSE) 