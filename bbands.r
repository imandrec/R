#import 
library(quantmod)#valores stocks
library(BatchGetSymbols) #valores stocks

#set reference date
Data <- Sys.Date()
year(Date) <- year(Date) - 20

#20 stocks
sp500 <- GetSP500Stocks()
tickers <- sort(sample(sp500$Tickers,20))


data(ttrc)
bbands.HLC <- BBands( ttrc[,c("High","Low","Close")] )
bbands.close <- BBands( ttrc["Close"] )
