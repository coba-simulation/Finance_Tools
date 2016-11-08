# load packages

library(XML)
library(tseries)
library(PerformanceAnalytics)
library(foreach)

# Create matrix with name, secu, boerse_id, date.F, date.T,weights, savings plan=I{savng plan}, savings plan rate, cycle =1,2,4,12 ,inport=1 fix in portfolio, =2 one adidtional, =3 compare all


date.T=format(Sys.time(), "%d.%m.%Y")
MyAssets<-rbind(
   c("DekaFonds_CF","2859","8","02.01.2015",date.T,0.963,0,0,0,1), 
   c("DKB_ETF_sppl","122054829","8","03.11.2016",date.T,0,1,150,12,1),
   c("Paypal","121455745","40","06.11.2016",date.T,12,0,0,0,1)
)
colnames(MyAssets)<-c("Name","Secu","Boerse ID", "From", "To", "weights", "I{SavingPlan}","SP-Rate","SP_Cycle","In-Portfolio?")
# Desired output: portfolio stats

PortAnalytics<-function(Assetlist,desiredOutput,from,to){
  
  # DesiredOutput
  # chart gives the from/to Charts for the Asses
  
  # Import the Data
  
  if (desiredOutput=="Chart"){
  for (i in 1:dim(Assetlist)[1]) {
   dataload(Assetlist[i,2],Assetlist[i,3],from,to,Assetlist[i,1],T)
  }
  }
  
  if (desiredOutput=="PortVal"){
    timeseries<-list()
    for (i in 1:dim(Assetlist)[1]) {
      timeseries[[i]]<-dataload(Assetlist[i,2],Assetlist[i,3],from,to,Assetlist[i,1],picture=F)
    }
    return(timeseries)
  }
  

}




#http://www.ariva.de/xxx/historische_kurse

date.F<-"03.11.2015" #from when for historical data
date.T<-"03.11.2016" #to when

weights<-c(14.047,3.228,0.240,1.4653,12)

secu_labels = (2859,100087282,101597066,122054829,121455745)
boerse_id_labels= c(8,8,8,8,40)
watchlist<-c("BASF","Monsanto","Bayer","Merck","Novartis", "Nestle","Fresenius","Brookdale_Senior_Living","DaVita","LifePoint_Health","Cognex","DataLogic","Hollysys_Automation_Technologies","ISRA_Vision","Rockwell_Automation","Berkshire_Hathaway")

secu_wachtlist<-c(293,4372,295,1622,684,683,2038,805977,10381,29328,10182,89030,103516555)
boerse_id_watchlist<-c(6,21,6,6,6,83,6,21,21,40,40,1,40)

DekaFonds_CF<-rev(DekaFonds_CF[,2])
DekaFonds_CF <- gsub("\\,", ".",DekaFonds_CF)
DekaFonds_CF<-as.numeric(DekaFonds_CF)
plot(DekaFonds_CF,type="l")

UmweltInvest_CF<-rev(UmweltInvest_CF[,2])
UmweltInvest_CF <- gsub("\\,", ".",UmweltInvest_CF)
UmweltInvest_CF<-as.numeric(UmweltInvest_CF)
plot(UmweltInvest_CF,type="l")

ChancePlus<-rev(ChancePlus[,2])
ChancePlus <- gsub("\\,", ".",ChancePlus)
ChancePlus<-as.numeric(ChancePlus)
plot(ChancePlus,type="l")

DKB_ETF<-rev(DKB_ETF[,2])
DKB_ETF <- gsub("\\,", ".",DKB_ETF)
DKB_ETF<-as.numeric(DKB_ETF)
plot(DKB_ETF,type="l")

Paypal<-rev(Paypal[,2])
Paypal <- gsub("\\,", ".",Paypal)
Paypal<-as.numeric(Paypal)
plot(Paypal,type="l")



is<-length(DKB_ETF)
shall<-length(DekaFonds_CF)
delta<-shall-is
DekaFonds_CF<-DekaFonds_CF[-c(seq(from=1,to=delta,by=1))]
UmweltInvest_CF<-UmweltInvest_CF[-c(seq(from=1,to=delta,by=1))]
ChancePlus<-ChancePlus[-c(seq(from=1,to=delta,by=1))]
Paypal<-Paypal[-c(seq(from=1,to=(delta+1),by=1))]

Fonds<-cbind(DekaFonds_CF,UmweltInvest_CF,ChancePlus,DKB_ETF,Paypal)
portVal<-Fonds%*%weights
plot(portVal,type="l")
cov(Fonds)

DekaFonds_r<-c()
UmweltInvest_r<-c()
ChancePlus_r<-c()
DKB_ETF_r<-c()
Paypal_r<-c()
portVal_r<-c()
for (t in 2:length(ChancePlus)){
  DekaFonds_r<-c(DekaFonds_r,log(DekaFonds_CF[t]/DekaFonds_CF[t-1]))
  UmweltInvest_r<-c(UmweltInvest_r,log(UmweltInvest_CF[t]/UmweltInvest_CF[t-1]))
  ChancePlus_r<-c(ChancePlus_r,log(ChancePlus[t]/ChancePlus[t-1]))
  DKB_ETF_r<-c(DKB_ETF_r,log(DKB_ETF[t]/DKB_ETF[t-1]))
  Paypal_r<-c(Paypal_r,log(Paypal[t]/Paypal[t-1]))
  portVal_r<-c(portVal_r,log(portVal[t]/portVal[t-1]))
}

plot(DekaFonds_r,type="l")
plot( UmweltInvest_r,type="l")
plot(ChancePlus_r,type="l")
plot(ChancePlus_r,type="l")
plot(Paypal_r,type="l")
plot(portVal_r,type="l")

plot(density(portVal_r))
m<-mean(portVal_r)
std<-sd(portVal_r)
x<-seq(from=-0.1,0.1,by=0.001)
curve(dnorm(x, mean=m, sd=std), 
      col="darkblue", lwd=2, add=TRUE, yaxt="n")




rs<-cbind(DekaFonds_r, UmweltInvest_r, ChancePlus_r,DKB_ETF_r,Paypal_r)
averet<-colMeans(rs)
rcov<-cov(rs)
target.return = 0


port.sol = portfolio.optim(x = rs, pm = target.return, covmat = rcov, shorts=F)
port.sol$pw

var<-VaR(portVal_r,p=0.99, method="historical")
Var_hist<-portVal*var[1]
plot(Var_hist,type="l")
