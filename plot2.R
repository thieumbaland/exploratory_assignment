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

baltimore<-subset(NEI,fips=="24510")
pollution.baltimore<-sapply(unique(baltimore$year),function(x){
  return(sum(baltimore$Emissions[baltimore$year==x]))
})

png(file="plot2.png")
plot_df(unique(baltimore$year),pollution.baltimore,"Total PM2.5 emission by year (Baltimore City)")
dev.off()