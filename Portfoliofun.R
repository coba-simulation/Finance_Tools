#Finance Workbench

rm(list=ls())

# Load the libraries
library(quantmod)
library(corrplot)
library(corpcor)

# Load the function
load("/Users/apple/Desktop/Finance_Workbench/workbench_functions.RDATA")

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

CorrAnalysis(PortSeries,Analysis="Eigendecomp")

ValueAtRisk(PortSeries,alpha=0.05,method="gaussian")
ValueAtRisk(PortSeries,alpha=0.05,method="empirical")
ValueAtRisk(PortSeries,alpha=0.05,method="MCCauchy")
