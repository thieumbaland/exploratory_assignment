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

pollution.total<-sum_df(NEI)
png(file="plot1.png")
plot_df(unique(NEI$year),pollution.total,"Total PM2.5 emission by year")
dev.off()
