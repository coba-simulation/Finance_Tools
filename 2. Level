# Pre-processing functions

# Toolkit for manipulating the series:: TimeCont()

TimeCont<-function(time_series,mode){
  # Input:
  ## time_series
  ## The series that should be converted
  #
  ## mode
  ## "LagOperator", is defined as a backshift operator: L(X_t)=X_t-1
  ## "Delta", is defined as the time difference: Delta(X_t)=X_t-X_t-1
  ## "relDiff", is defined as the relative change in time: relDiff(X_t)=(X_t-X_t-1)/X_t-1
  ## "logDiff", is defined as the log difference in time: logDiff(X_t)=log(X_t/X_t-1)
  #
  # Output:
  ## the converted object
  if (mode=="LagOperator"){
  object<-c(0,time_series[-length(time_series)])
  }

  if (mode=="Delta"){
    object<-time_series-c(0,time_series[-length(time_series)])
    object<-object[-1]
  }
  
  if (mode=="relDiff"){
    object<-(time_series-c(0,time_series[-length(time_series)]))/c(0,time_series[-length(time_series)])
    object<-object[-1]
  }
  
  if (mode=="logDiff"){
    object<-log(time_series)-log(c(0,time_series[-length(time_series)]))
    object<-object[-1]
  }
  
  return(object)
}


# Plotter for the series:: Plotter()

Plotter<-function(time_series,date,ret=F){
  # Input:
  ## time_series
  ## The series that should be plotted
  #
  ## date
  ## a date series for the x-axis
  #
  ## ret
  ## Indicator whether returns should be plotted
  ## if ret=T then the date series will be cutted by one unit
  ## default = F
  #
  # Output:
  ## a plot() object
  if(ret==F){
  plot(time_series,type="l",xaxt="n")
  axis(1,at=1:length(time_series),labels=date)
  }
  
  
  if(ret==T){
    
    date<-date[-1]
    
    plot(time_series,type="l",xaxt="n")
    axis(1,at=1:length(time_series),labels=date)
  }

}

# Combines the series to one weighted asset, the portfolio:: PortConstruct()

PortConstruct<-function(MyAssets,date.F){
  # Input:
  ## MyAssets
  ## A matrix with the following structure
  ## MyAssets[i,] gives the row for ith asset
  ## MyAssets[i,]=c("Name","secu","boerse_id",weight,convert)
  ## I.e. with two Assets: DekaFonds with 14.074 shares and 21 Rockwell assets
  ## MyAssets<-rbind(c("DekaFonds_CF","2859","8",14.047,F),c("RockwellC","11210","21",7,T))
  #
  ## date.F
  ## The Start Date for the Portfolio
  #
  # Output:
  ## A list giving the EUR values ($val) and the date ($date) of the portfolio
  Series<-list()
  date<-list()
  length<-c()
  
  for (i in 1: dim(MyAssets)[1]){
    
    addobject<- as.numeric(MyAssets[i,4])*dataload(MyAssets[i,2],MyAssets[i,3],date.F,Convert=MyAssets[i,5])$level
    addobject_date<- dataload(MyAssets[i,2],MyAssets[i,3],date.F,Convert=MyAssets[i,5])$date
    
    length<-c(length,length(addobject))
    Series[[i]]<-addobject
    date[[i]]<-addobject_date
    
  }
  
  
  
  index<-which(length==min(length))
  index_save<-index
  index<-index[1]
  
  standlength<-length(Series[[index]])
  '%!in%' <- function(x,y)!('%in%'(x,y))
  for (i in 1:length(Series)){
    if (i %!in% index_save){
      delta<-length(Series[[i]])-standlength
      Series[[i]]<-Series[[i]][-c(1:delta)]
    }
  }
  
  end_series<-rep(0,length(Series[[1]]))
  for (i in 1:length(Series)){
    end_series<-end_series + Series[[i]]
  }
  
  return_object<-list()
  return_object[[1]]<-end_series
  return_object[[2]]<-date[[index]]
  names(return_object)<-c("level","date")
  
  return(return_object)
}
