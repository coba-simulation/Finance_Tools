#Finance Workbench

rm(list=ls())

# Load the libraries
library(quantmod)
library(corrplot)
library(corpcor)

# Load the functions
load("workbench_functions.RDATA")

# Define the start and the end date
start_date<-"2016-01-04"
end_date<- "2017-06-09"
from_to<-paste(start_date,"/",end_date,sep="")

stock(Symbol="DAX",from_to=from_to,value_invested=2500,convert=T,begin=F,price="close",plot=T,from="google")

stock(Symbol="MON",from_to=from_to,value_invested=1000,convert=T,price="close",plot=T,from="google")

stock(Symbol="GM",from_to=from_to,value_invested=500,convert=T,price="close",plot=T,from="google")

stock(Symbol="COL",from_to=from_to,value_invested=1000,convert=T,price="close",plot=T,from="google")


Port<- PortCreate(c("DAX","MON","GM","COL"),c(2500,1000,500,1000),from_to=from_to,begin=F)
Port

PortSeries<-Port[,1:4]

CorrAnalysis(PortSeries,Analysis="Correlation")
CorrAnalysis(PortSeries,Analysis="PartCorrelation")
CorrAnalysis(PortSeries,Analysis="Eigendecomp")

ValueAtRisk(PortSeries,alpha=0.05,method="gaussian")
ValueAtRisk(PortSeries,alpha=0.05,method="empirical")
ValueAtRisk(PortSeries,alpha=0.05,method="MCCauchy")

par(mfrow=c(1,3))
Look_in_the_future(PortSeries,nsim=100,howmuchfuture=30,dist="gaussian",yval=c(3500,6500))
Look_in_the_future(PortSeries,nsim=100,howmuchfuture=30,dist="empirical",yval=c(3500,6500))
Look_in_the_future(PortSeries,nsim=100,howmuchfuture=30,dist="cauchy",yval=c(3500,6500))

# Do you believe in looking into the future?
par(mfrow=c(1,4))
# Yes
#training period:
start_date<-"2016-01-04"
end_date<- "2017-05-09"
from_to_est<-paste(start_date,"/",end_date,sep="")
#magic
start_date<-"2017-05-09"
end_date<- "2017-07-13"
from_to_out<-paste(start_date,"/",end_date,sep="")
Look_in_the_future_CV(c("DAX","MON","GM","COL"),c(2500,1000,500,1000),nsim=100,from_to_est=from_to_est,from_to_out=from_to_out,dist="empirical")


# YESS
#training period:
start_date<-"2016-10-04"
end_date<- "2016-12-09"
from_to_est<-paste(start_date,"/",end_date,sep="")
#magic
start_date<-"2016-12-09"
end_date<- "2017-07-13"
from_to_out<-paste(start_date,"/",end_date,sep="")
Look_in_the_future_CV(c("DAX","MON","GM","COL"),c(2500,1000,500,1000),nsim=100,from_to_est=from_to_est,from_to_out=from_to_out,dist="gaussian")

# Aber zaubern kann niemand
#training period:
start_date<-"2017-06-02"
end_date<- "2017-06-08"
from_to_est<-paste(start_date,"/",end_date,sep="")
#magic
start_date<-"2017-06-08"
end_date<- "2017-07-13"
from_to_out<-paste(start_date,"/",end_date,sep="")
Look_in_the_future_CV(c("DAX","MON","GM","COL"),c(2500,1000,500,1000),nsim=100,from_to_est=from_to_est,from_to_out=from_to_out,dist="empirical")

# Oder doch?
#training period:
start_date<-"2017-03-02"
end_date<- "2017-06-08"
from_to_est<-paste(start_date,"/",end_date,sep="")
#magic
start_date<-"2017-06-08"
end_date<- "2017-07-13"
from_to_out<-paste(start_date,"/",end_date,sep="")
Look_in_the_future_CV(c("DAX","MON","GM","COL"),c(2500,1000,500,1000),nsim=500,from_to_est=from_to_est,from_to_out=from_to_out,dist="empirical")






