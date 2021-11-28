library(quantmod)
library(BatchGetSymbols)
library(randomForest)
library(TTR)

sp500 <- GetSP500Stocks()

tickers <- head(sp500$Tickers,20)
first.date <- Sys.Date() - 7500
last.date <- Sys.Date()


datalist <- list()

for (i in 1:20){
  datalist[[i]] <- BatchGetSymbols(tickers = tickers[i],
                                   first.date = first.date,
                                   last.date = last.date,
                                   thresh.bad.data = 0.1,
                                   freq.data = "weekly",
                                   do.cache = FALSE)
}

tabla <- list()

for (i in 1:20){
  tabla[[i]] <- datalist[[i]]$df.tickers[c(1,2,8)]
  tabla[[i]]$MovingAverage10 <- 0
  tabla[[i]]$MovingAverage50 <- 0
  tabla[[i]]$MovingAverage200 <- 0
}

# declaration
i = 1
while(i <= 20){
    # Moving Average - 10
    for (j in 11:nrow(tabla[[i]])){
      tabla[[i]]$MovingAverage10[j] <- mean(tabla[[i]]$price.adjusted[(j-10):(j-1)])
    }
    # Moving Average - 50
    for (j in 51: nrow(tabla[[i]])) {
      tabla[[i]]$MovingAverage50[j] <- mean(tabla[[i]]$price.adjusted[(j-50):(j-1)])
    }
    # Moving Average - 200
    for (j in 201:nrow(tabla[[i]])){
      tabla[[i]]$MovingAverage200[j] <- mean(tabla[[i]]$price.adjusted[(j-200):(j-1)])
    }
    i <- i+1 
}

for (i in 1:20){
  tabla[[i]] <- datalist[[i]]$df.tickers[c(1,2,8)]
  tabla[[i]]$MovingAverage10 <- 0
  tabla[[i]]$MovingAverage50 <- 0
  tabla[[i]]$MovingAverage200 <- 0
}
