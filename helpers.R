# this file contains the code necessary to download the SSA data on baby names and prep it for use

library(dplyr)

# set to my local working directory
setwd("~/coursera/9DatProds/work/project/")

#Begin by downloading files directly from Social Security Administration
fileUrl<-"https://www.ssa.gov/oact/babynames/state/namesbystate.zip"
download.file(fileUrl, destfile="babynamesState.zip")

#next, unzip data files
unzip("babynamesState.zip", exdir="data")

# get list of state files
StateFileList<-list.files("~/coursera/9DatProds/work/project/data", pattern="*.txt$",ignore.case = TRUE)
states<-gsub(".TXT","",StateFileList)

# create empty data frame
names<-data.frame()

setwd("~/coursera/9DatProds/work/project/data")

# read in each of the 50 states + DC, put in empty database created above
for(i in 1:51) {
    print(StateFileList[i])
    temp<-read.table(StateFileList[i], header=FALSE,sep=",", col.names=c("State","Gender","Year","Name","Count"))
    names<-rbind(names,temp)
}

# just look at last 50 years for now    
names_sm<-names[which(names$Year>=1965),]    

states<-gsub(".TXT","",StateFileList)
BabyNames<-arrange(names_sm, State, desc(Year), Gender,  desc(Count))

# write the BabyNames and states files to disk so they can be called in and easily inluded in the data folder for the app
write.table(states,file="states",row.names=FALSE,col.names=FALSE)
write.table(BabyNames,file="BabyNames", row.names=FALSE)

