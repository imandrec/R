#
#install.packages("ggplot2")
#install.packages("quantmod")
#install.packages("magrittr")
#library(ggplot2)
#library(quantmod)
#library(magrittr)
#getSymbols("MMM", src = "yahoo", from = "2001-11-01", to = "2021-11-01")
#summary(MMM)
#candleChart(MMM, up.col = "green", dn.col = "red", theme = "white")


#
#install.packages("ggplot2")
#install.packages("quantmod")
#install.packages("magrittr")
library(ggplot2)
library(quantmod)
library(magrittr)
#download closing prices 20 stocks
tickers = c("JNJ", "CBNK", "MMM", "CAT", "AAPL", "NFLX", "AMZN", "GOOG", "PEP", "FB", "NVDA", "BABA", "ACC", "AAL", "ABNB", "ADBE", "ADSK", "APR", "ASTE", "ATHE")
#get from last 20 years
getSymbols(tickers, src = "yahoo", from = "2001-11-01", to = "2021-11-01")
summary(MMM)
#plot
#ta=null es para quitar los numeritos en rojo 
candleChart(MMM, up.col = "green", dn.col = "red", theme = "white", TA = NULL)
#calculate the 10-,50-,200 moving averages 
candleChart(MMM, up.col = "green", dn.col = "red", theme = "white")
addSMA(n = c(20, 50, 200))

plot(MMM$MMM.Adjusted)
