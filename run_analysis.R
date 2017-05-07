
run_analysis <- function(){
  
  # create activity lookup table
  Activity<-c("WALKING", "WALKING_UPSTAIRS", "WALKING_DOWNSTAIRS", "SITTING", "STANDING", "LAYING")
  actid<-c(1,2,3,4,5,6)
  lk<-data.frame(Activity, actid)
  
  #create feature columns
  path<-paste("UCIHARDataset/","features.txt", sep="")
  df1 <- read.table(path, colClasses="character", as.is=T)
  y<-df1$V2
  z1<-y[grep("*mean*", y)]
  z2<-y[grep("*std*", y)]
  z<-c(z1,z2)
  
  
  ## Read files into appropriate data frames and create a unified data frame 
  ## with subject and activity columns(activity with descriptive name) and only mean and STD variables
  x<-"train"
  
  df1<-loadUnifiedDF(x, lk, y, z)
  x<-"test"
  df2<-loadUnifiedDF(x, lk, y, z)
  
  ## merge both test and train data frames into a single data frame df3
  df3<-merge(df1, df2, all=T)
  
  ## create another data frame with averages of all variables in df3 per activity and subject
  df4 <- aggregate(df3[,z], list(Subject=df3$Subject, Actvity=df3$Activity), mean)
  write.table(df4, "output.txt", row.names=FALSE)
}


loadUnifiedDF <- function(x, lk, y, z) {
  
  path<-paste("UCIHARDataset/", x, "/X_", x, ".txt", sep="")
  
  df<-read.table(path)
  names(df)<-y
  df1 <-df[,z]
  
  # read activity list
  path<-paste("UCIHARDataset/", x, "/y_", x, ".txt", sep="")
  
  df3<-read.table(path)
  names(df3)<-c("actid")
  df4<-merge(df3, lk, by="actid")
  
  # read subject list
  path<-paste("UCIHARDataset/", x, "/subject_", x, ".txt", sep="")
  
  df5<-read.table(path)
  names(df5)<-c("Subject")
  
  df1$Subject <- df5$Subject
  df1$Activity <- df4$Activity
  
  df1
  
}