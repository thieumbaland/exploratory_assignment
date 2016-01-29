library(ggplot2)
library(dplyr)

#read files
NEI<-readRDS("Data/summarySCC_PM25.rds")
SCC<-readRDS("Data/Source_Classification_Code.rds")

baltimore<-subset(NEI,fips=="24510" & type=="ON-ROAD")
baltimore_year<-group_by(baltimore,year)
baltimore_aggregate<-dplyr::summarise(baltimore_year,pol=sum(Emissions))

png(file="plot5.png")
ggplot(baltimore_aggregate,aes(x=as.factor(year),y=pol,group=1))+geom_line()+geom_point()+theme_bw()+xlab("Year")+ylab("PM2.5 emission")+ggtitle("PM2.5 emission in Baltimore (motor related sources)")
dev.off()