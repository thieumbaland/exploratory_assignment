#read files
NEI<-readRDS("Data/summarySCC_PM25.rds")
SCC<-readRDS("Data/Source_Classification_Code.rds")

#function to make sum across year
sum_df=function(df){
  return(sapply(unique(df$year),function(x){
    return(sum(df$Emissions[df$year==x]))
  }))
}
#function to plot sum across year
plot_df=function(xvals,yvals,mytitle){
  plot(xvals,yvals,xlab="Year",ylab="Total PM2.5 emission",
       type="o",col="red",main=as.character(mytitle))
}
#question 1
pollution.total<-sum_df(NEI)
plot_df(unique(NEI$year),pollution.total,"Total PM2.5 emission by year")


#question 2
baltimore<-subset(NEI,fips=="24510")
pollution.baltimore<-sapply(unique(baltimore$year),function(x){
  return(sum(baltimore$Emissions[baltimore$year==x]))
})
plot_df(unique(baltimore$year),pollution.baltimore,"Total PM2.5 emission by year (Baltimore City)")

#question 3
library(ggplot2)
baltimore<-subset(NEI,fips==24510)
test<-group_by(baltimore,type,year)
test2<-dplyr::summarise(test,pol=sum(Emissions))
ggplot(test2,aes(x=as.factor(year),y=pol,group=as.factor(type),col=as.factor(type)))+geom_line()+geom_point()

#question 4
SCC_coal<-SCC[grep("[cC]oal",SCC$Short.Name),]
NEI_merge<-merge(SCC_coal,NEI,by="SCC")
test<-group_by(NEI_merge,year)
test2<-dplyr::summarise(test,pol=sum(Emissions))
ggplot(test2,aes(x=as.factor(year),y=pol,group=1))+geom_line()+geom_point()+theme_bw()+xlab("Year")+ylab("Pollution")

#question 5
baltimore<-subset(NEI,fips=="24510" & type=="ON-ROAD")
test<-group_by(baltimore,year)
test2<-dplyr::summarise(test,pol=sum(Emissions))
ggplot(test2,aes(x=as.factor(year),y=pol,group=1))+geom_line()+geom_point()+theme_bw()+xlab("Year")+ylab("Pollution")

#question 6
baltimore<-subset(NEI,fips=="24510" & type=="ON-ROAD")
california<-subset(NEI,fips=="06037" & type=="ON-ROAD")
baltimore_year<-group_by(baltimore,year)
baltimore_aggregate<-dplyr::summarise(baltimore_year,pol=sum(Emissions))
california_year<-group_by(california,year)
california_aggregate<-dplyr::summarise(california_year,pol=sum(Emissions))
california_aggregate<-as.data.frame(california_aggregate);california_aggregate$City<-"Los Angeles County"
aggregate_df<-as.data.frame(baltimore_aggregate);aggregate_df$City<-"Baltimore";
aggregate_df<-rbind(aggregate_df,california_aggregate)
ggplot(aggregate_df,aes(x=as.factor(year),y=pol,group=as.factor(City),col=as.factor(City)))+geom_line()+geom_point()+theme_bw()+xlab("Year")+ylab("Pollution")
