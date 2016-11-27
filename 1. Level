# Loading function:: dataload()

dataload<-function(secu,boerse_id,date.F,date.T=format(Sys.time(), "%d.%m.%Y"),Convert=F){
  
  # Input:
  ## secu
  ## Uniquely identifies the asset (from ariva.de/<assetname>/historische_kurse --> Untersuchen->Network)
  #
  ## borse_id
  ## uniquely identifies the trading venue of an asset (from ariva.de/<assetname>/historische_kurse --> Untersuchen->Network)
  #
  ## date.F
  ## Start date, Format: %d.%m.%Y
  #
  ## date.T
  ## End date, Format: %d.%m.%Y
  ## default = today
  #
  ## Convert
  ## If the Asset is in USD then Convert=T converts the values in EUR
  ## default = F
  ## Note that the conversion is rather time consuming
  # Output:
  ## A list giving the EUR values ($val) and the date ($date)
  
  # Load Data from Ariva.de by using secu, boerse_id, date.F and date.T
  return_object <-  read.csv(paste0("http://www.ariva.de/quote/historic/historic.csv?secu="
                                    ,secu,"&boerse_id="
                                    ,boerse_id,"&clean_split=1&clean_payout=0&clean_bezug=1&min_time="
                                    ,date.F,"&max_time="
                                    ,date.T,"&trenner=%3B&go=Download"),sep=";")
  
  # Processes the output from Arica.de
  return_object<-return_object[,1:2]
  val<-rev(return_object[,2])
  val <- gsub("\\,", ".",val)
  val <-as.numeric(val)
  date<-rev(return_object[,1])
  return_object<-list()
  
  # Defines the value list
  return_object[[1]]<-val
  
  # Defines the date list
  return_object[[2]]<-date
  
  # load Exchange rate EUR/USD in case of convert=T
  if (Convert==T) {
  
    val_EUR<-c()
    
    for (i in length(date):1){
    EX<-read.csv(paste0("http://www.ariva.de/quote/historic/historic.csv?secu="
                  ,4633,"&boerse_id="
                  ,130,"&clean_split=1&clean_payout=0&clean_bezug=1&min_time="
                  ,date[i],"&max_time="
                  ,date[i],"&trenner=%3B&go=Download"),sep=";")
  
  valex<-EX[,2]
  valex <- gsub("\\,", ".",valex)
  valex <-as.numeric(valex)
print(i)
   val_EUR<-c(val_EUR,val[i]/valex)
    }
  return_object[[1]]<- val_EUR
  }
  names(return_object)<-c("level","date")
  return(return_object)
 
}
  

  


