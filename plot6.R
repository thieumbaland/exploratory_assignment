library(ggplot2)
library(dplyr)

#read files
NEI<-readRDS("Data/summarySCC_PM25.rds")
SCC<-readRDS("Data/Source_Classification_Code.rds")


#Baltimore data
baltimore<-subset(NEI,fips=="24510" & type=="ON-ROAD")
baltimore_year<-group_by(baltimore,year)
baltimore_aggregate<-dplyr::summarise(baltimore_year,pol=sum(Emissions))

#California data
california<-subset(NEI,fips=="06037" & type=="ON-ROAD")
california_year<-group_by(california,year)
california_aggregate<-dplyr::summarise(california_year,pol=sum(Emissions))
california_aggregate<-as.data.frame(california_aggregate);california_aggregate$City<-"Los Angeles County"

#merge Baltimore and California data
aggregate_df<-as.data.frame(baltimore_aggregate);aggregate_df$City<-"Baltimore";
aggregate_df<-rbind(aggregate_df,california_aggregate)

#plot graph
png(file="plot6.png")
ggplot(aggregate_df,aes(x=as.factor(year),y=pol,group=as.factor(City),col=as.factor(City)))+geom_line()+geom_point()+theme_bw()+xlab("Year")+ylab("PM2.5 emission")+ggtitle("PM2.5 emission comparison Baltimore-LA (motor related sources)")
dev.off()