md <- read.csv(file=file.choose(), header=T) #This will pull cancer csv file into R
cor (md$WineIntake.md$Risk) #This will give the correlation between the variables. Note:Order doesnt matter
cor (md) #This gives a correlation table 
plot(md)

#Scatterplots
beaver2 #preloaded R data set
plot(beaver2$time, beaver2$temp) #gives scatterplot
plot(beaver2$time, beaver2$temp, pch=beaver2$activ) #gives more detailed scatterplot/pch in R The pch stands for plot symbols
cor(beaver2) #Correlation matrix

#Fitted Line Plots
#lm = linear model

cars #preloaded R data set
plot(cars$speed, cars$dist) #gives scatterplot
lm(formula=cars$dist~cars$speed, data=cars) #gives slope and intercept of best fit line/ first will be for Y and second for X
lm.cars<-lm(formula=cars$dist~cars$speed, data=cars) #saves information as lm.cars
abline(lm.cars) #plots best fit line / abline in R to add straight lines to a scatter plot
abline(v=mean(cars$speed),col='red') #plots mean for speed
abline(h=mean(cars$dist),col='red') #plots mean for distance

abline(lm(formula=cars$dist~cars$speed-1, data=cars)) #gives slope and intercept of best fit line through the origin
names(lm.cars)
lm.cars$coefficients
lm.cars$fit
summary(lm.cars)

prediction <- function(x){
  return(coef(lm.cars)["(Intercept)"]+(coef(lm.cars)["cars$speed"])*(x))}

prediction(30)
