library(quantmod)
library(BatchGetSymbols)
library(randomForest)

sp500 <- GetSP500Stocks()

tickers <- head(sp500$Tickers,20)
first.date <- Sys.Date() - 7500
last.date <- Sys.Date()

stocks <- BatchGetSymbols(tickers = tickers,
                         first.date = first.date,
                         last.date = last.date,
                         thresh.bad.data = 0.1,
                         freq.data = "weekly",
                         do.cache = FALSE)

adj <- stocks[["df.tickers"]]

tabla <- list()

for (i in 1:20){
  tabla[[i]] <- adj[c(1,2,8)]
  tabla[[i]]$MovingAverage10 <- 0
  tabla[[i]]$MovingAverage50 <- 0
  tabla[[i]]$MovingAverage200 <- 0
}

#moving average


for (i in 1:20){
  for (j in 11:nrow(tabla[[i]])){
    tabla[[i]]$MovingAverage10[j] <- mean(tabla[[i]]$price.adjusted[(j-10):(j-1)])
  }
}

for (i in 1:20){
  for (j in 51:nrow(tabla[[i]])){
    tabla[[i]]$MovingAverage50[j] <- mean(tabla[[i]]$price.adjusted[(j-50):(j-1)])
  }
}

for (i in 1:20){
  for (j in 201:nrow(tabla[[i]])){
    tabla[[i]]$MovingAverage200[j] <- mean(tabla[[i]]$price.adjusted[(j-200):(j-1)])
  }
}


md <- list()

for (i in 1:20){
  md[[i]] <- tabla[[i]][sample(nrow(tabla[[i]]), 0.8*nrow(tabla[[i]])),]
}

#random forest
rfmodel <- list()
for (i in 1:20){
  rfmodel[[i]] <- randomForest(price.adjusted ~ ., data=md[[i]], ntree=10, mtry=1, importance=TRUE) 
}

#prediction
preds <- list()
for (i in 1:20){
  preds[[i]] <- predict(rfmodel[[i]],tabla[[i]])
}
