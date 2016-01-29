library(ggplot2)
library(dplyr)

#read files
NEI<-readRDS("Data/summarySCC_PM25.rds")
SCC<-readRDS("Data/Source_Classification_Code.rds")

baltimore<-subset(NEI,fips=="24510")

baltimore_year<-group_by(baltimore,type,year)
baltimore_aggregate<-dplyr::summarise(baltimore_year,pol=sum(Emissions))

png(file="plot3.png")
ggplot(baltimore_aggregate,aes(x=as.factor(year),y=pol,group=as.factor(type),col=as.factor(type)))+geom_line()+geom_point()+theme_bw()+xlab("Year")+ylab("Total PM2.5 Emission")+ggtitle("PM2.5 emission in Baltimore per type")
dev.off()