#1 Loading function

dataload<-function(secu,boerse_id,date.F,date.T,name,EUR=T,picture=F){
return_object <-  read.csv(paste0("http://www.ariva.de/quote/historic/historic.csv?secu="
                  ,secu,"&boerse_id="
                  ,boerse_id,"&clean_split=1&clean_payout=0&clean_bezug=1&min_time="
                  ,date.F,"&max_time="
                  ,date.T,"&trenner=%3B&go=Download"),sep=";")
date.F_format <- gsub("\\.", "/",date.F)
date.F_format <- as.Date(date.F_format, "%d/%m/%Y")
date.F_format <- as.Date(date.F_format, "%Y/%m/%d")
date.T_format <- gsub("\\.", "/",date.T)
date.T_format <- as.Date(date.T_format, "%d/%m/%Y")
date.T_format <- as.Date(date.T_format, "%Y/%m/%d")

time_measure<-seq(as.Date(date.F_format), as.Date(date.T_format), "days")

time<-rev(return_object[,1])

return_object<-rev(return_object[,2])

if (EUR==F){
  EUR_USD <-  read.csv(paste0("http://www.ariva.de/quote/historic/historic.csv?secu="
                                    ,4633,"&boerse_id="
                                    ,130,"&clean_split=1&clean_payout=0&clean_bezug=1&min_time="
                                    ,date.F,"&max_time="
                                    ,date.T,"&trenner=%3B&go=Download"),sep=";")
  EUR_USD<-rev(EUR_USD[,2])
  EUR_USD <- gsub("\\,", ".",EUR_USD)
  EUR_USD <-as.numeric(EUR_USD)
  
return_object <- gsub("\\,", ".",return_object)
return_object<-as.numeric(return_object)
return_EUR<-return_object/EUR_USD

if (picture==T) {
  plot(return_EUR,type="l",main=paste("Chart",name),xaxt='n',ylab="EUR")
  axis(1,1:length(return_object),time)
}
return(return_EUR)
}

if (EUR==T){

  return_object <- gsub("\\,", ".",return_object)
  return_object<-as.numeric(return_object)
  if (picture==T) {
    plot(return_object,type="l",main=paste("Chart",name),xaxt='n',ylab="EUR")
    axis(1,1:length(return_object),time)
  }
  return(return_object)
}




}

tst<-dataload("2859","8","03.11.2015","03.11.2016","test",T)
tst<-dataload("121455745","40","03.11.2015","03.11.2016","test",EUR=F,picture=T)
