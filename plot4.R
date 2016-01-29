library(ggplot2)
library(dplyr)

#read files
NEI<-readRDS("Data/summarySCC_PM25.rds")
SCC<-readRDS("Data/Source_Classification_Code.rds")

SCC_coal<-SCC[grep("[cC]oal",SCC$Short.Name),]
NEI_merge<-merge(SCC_coal,NEI,by="SCC")

NEI_coal<-group_by(NEI_merge,year)
NEI_aggregate<-dplyr::summarise(NEI_coal,pol=sum(Emissions))

png(file="plot4.png")
ggplot(NEI_aggregate,aes(x=as.factor(year),y=pol,group=1))+geom_line()+geom_point()+theme_bw()+xlab("Year")+ylab("PM2.5 emission")+ggtitle("PM2.5 emission (coal combustion-related sources)")
dev.off()