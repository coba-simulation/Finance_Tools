# Finance_Tools
A collection of different tools to analyze a private portfolio


Wir brauchen unbedingt eine ordentliche Struktur für dieses Projekt ansonsten funktioniert eine loose und ungezwungene Zusammenarbeit nicht. Ich schlage daher eine Art modularer Aufbau vor. Das heißt wir definieren verschiedene Funktionen für verschiedene Verarbeitungsschritte. Am besten wir machen 3 Ebenen:

1. Ebene: Loading
Hier passieren ganz Elementare Dinge, wie beispielsweise das Einlesen von Zeitreihen aus dem Internet, das Umrechnen von Währungen (€/$). Die Angleichung der Längen der Zeitreihen. Auf dieser Ebene werden keine statistischen Berechnungen und auch im allgemeinen quasi keine Rechenoperationen durchgeführt. Also auch keine Gewichtung oder ähnliches. Auf der ersten Ebene sollte es nur sehr wenige Funktionen geben. 

Beispiel:
dataLoad <-function(ISIN,Currency,from, to,...) {
   
   ...magic stuff that loads data, converts the currency, cuts the length, makes lengths equal, loads in the correct format, etc.
   
   return(Time series object)
}

2. Ebene: Pre-Processing, Bündelung und Umrechnung, Plots und deskriptives Zeug
Auf dieser Ebene sollen Funktionen entstehen die eine Mittlerfunktion zwischen dem Einlesen und Formatieren der Daten und der statistischen Verarbeitung einnehmen. Hier werden sehr wohl Berechnungen durchgeführt und es dürfen auch einfache statistische Operationen (Mittelwert, Trend, Variance-Covariance-Matrix, etc.) durchgeführt werden. Dabei sollen aber statistische Techniken eher die Ausnahme sein. Hier stelle ich mir eher Dinge wie das Gewichten des Portfolios vor oder irgendwelche Vorbereitende Schritte für die 3. Ebene. Zudem können hier deskriptive Plots von Zeitreihen und so erstellt werden. Beachte: Als Argumente soll die 2. Ebene nur Ojekte die in der ersten Ebene generiert wurden annehmen. Auch hier sollte es nicht zuviele Funktionen geben. Möglichwereise kann die 2. Ebene in die 1. Ebene integriert werden.

Beispiel:

# 1. Ebene
BeateUhse <- dataLoad("DE0007551400","EUR",01.01.1969,today,...) 

# 2. Ebene
PortCalc<-function(TS_object,weights,...) 

   ...magic stuff that uses the loaded time series to build portfolios with weights and calculates means, variances and stuff... etc.
   
   return(Portfolio_series,mean_reurns,VarCov)
}

Greife auf die erste Ebene zu: 
PortData<-PortCalc(BeateUhse) # Verarbeitet die Daten aus der 1. Ebene

# 3. Ebene: Finetuning, Analyse und wirklich komplexe Sachen
Hier kann man dann den ganzen Finance-Kram machen auf den man Bock hat. Alles ist denkbar, die Regel ist nur dass nur Elemente die in de 2. Ebene generiert wurden verwendet werden dürfen. Die Anzahl der Funktionen kann beliebig groß sein.

Beispiel:

VaR<-function(Portfolio,alpha,method) {

   ...magic stuff that creates totally irrelevant numbers...
   
   return(VaR)
}

# 1. Ebene
Assets <- dataLoad(c("DE0007551400",DE0007100000),"EUR",01.01.1969,today,...) 

# 2. Ebene
MyPortfolio <- PortCalc(Assets,c(0.5,0.5),plot=T)

# 3. Ebene
PortVaR <-VaR(MyPortfolio,0.00001)



ps irgendwann lad ich mal dne Code hoch den ich schon habe... :-P
