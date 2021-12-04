#import libraries
library(quantmod)
library(BatchGetSymbols)
library(randomForest)
library(TTR)
library(shiny)

#import the first 20 stocks
sp500 <- GetSP500Stocks()
tickers <- head(sp500$Tickers,20)

#set date
first.date <- Sys.Date() - 7500
last.date <- Sys.Date()

#pull data from tickers
datalist <- list()
for (i in 1:20){
  datalist[[i]] <- BatchGetSymbols(tickers = tickers[i],
                                   first.date = first.date,
                                   last.date = last.date,
                                   thresh.bad.data = 0.1,
                                   freq.data = "weekly",
                                   do.cache = FALSE)
}

#set up list for values
tabla <- list()
for (i in 1:20){
  tabla[[i]] <- datalist[[i]]$df.tickers[c(1,2,8)]
  tabla[[i]]$MovingAverage10 <- 0
  tabla[[i]]$MovingAverage50 <- 0
  tabla[[i]]$MovingAverage200 <- 0
}

#Moving averages
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

#additional technical indicator
#Bollinger Bands
bollinger <- list()
for (i in 1:20){
  bollinger[[i]] <- BBands(tabla[[i]]$price.adjusted, n=20,sd=2)
}

#
ind <- list()
train <- list()
test <- list()
for (i in 1:20){
  ind[[i]] <- sample(1:nrow(tabla[[i]]), 0.7*nrow(tabla[[i]]),replace = FALSE) 
  train[[i]] <- tabla[[i]][ind[[i]],]
  test[[i]] <- tabla[[i]][!(c(1:nrow(tabla[[i]])) %in% ind[[i]]),]
}

#random forest
random_forest <- list()
for (i in 1:20){
  random_forest[[i]] <- randomForest(price.adjusted ~ MovingAverage10 + MovingAverage50 + MovingAverage200, data=tabla[[i]], ntree=10, mtry=1, importance=TRUE) 
}

#predictions
predictions <- list()
for (i in 1:20){
  predictions[[i]] <- predict(random_forest[[i]],tabla[[i]])
}

#R shiny app

# Define UI for application that draws a histogram
ui <- fluidPage(
  
  # Application title
  titlePanel("S&P 500 stocks"),
  
  # Sidebar with a slider input for number of bins 
  sidebarLayout(
    sidebarPanel(
      sliderInput("bins",
                  "Number of bins:",
                  min = 1,
                  max = 50,
                  value = 30),
      selectInput("variablechoice", "Stock", choices=c("uno","dos","tres"),
                  selected="dos")
      
    ),
    
    # Show a plot of the generated distribution
    mainPanel(
      plotOutput("distPlot")
    )
  )
)

# Define server logic required to draw a histogram
server <- function(input, output) {
  
  output$distPlot <- renderPlot({
    # generate bins based on input$bins from ui.R
    x    <- faithful[, 2]
    bins <- seq(min(x), max(x), length.out = input$bins + 1)
    
    # draw the histogram with the specified number of bins
    hist(x, breaks = bins, col = 'darkgray', border = 'white')
  })
}

# Run the application 
shinyApp(ui = ui, server = server)
