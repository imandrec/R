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

datalist <- list()

for (i in 1:20){
  datalist[[i]] <- adj[c(1,2,8)]
  datalist[[i]]$MovingAverage10 <- 0
  datalist[[i]]$MovingAverage50 <- 0
  datalist[[i]]$MovingAverage200 <- 0
}

#calculate 10 day moving average


for (i in 1:20){
  for (j in 11:nrow(datalist[[i]])){
    datalist[[i]]$MovingAverage10[j] <- mean(datalist[[i]]$price.adjusted[(j-10):(j-1)])
  }
}

for (i in 1:20){
  for (j in 51:nrow(datalist[[i]])){
    datalist[[i]]$MovingAverage50[j] <- mean(datalist[[i]]$price.adjusted[(j-50):(j-1)])
  }
}

for (i in 1:20){
  for (j in 201:nrow(datalist[[i]])){
    datalist[[i]]$MovingAverage200[j] <- mean(datalist[[i]]$price.adjusted[(j-200):(j-1)])
  }
}
#check moving averages


trainingdata <- list()

for (i in 1:20){
  trainingdata[[i]] <- datalist[[i]][sample(nrow(datalist[[i]]), 0.8*nrow(datalist[[i]])),]
}


#create random forest models
modellist <- list()
for (i in 1:20){
  modellist[[i]] <- randomForest(price.adjusted ~ ., data=trainingdata[[i]], ntree=100, mtry=2, importance=TRUE) 
}

#run prediction
predictions <- list()
for (i in 1:20){
  predictions[[i]] <- predict(modellist[[i]],datalist[[i]])
}
