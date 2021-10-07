md <- read.csv(file=file.choose(), header=T) #Read in loan_data data set

str(md) # This tell me what kind of data types this is
unique(md$purpose) #Will tell the unique variables inside the column purposes
table(md$purpose) #will tell how many of each unique variable are there 
pie(table(md$home_ownership))
unique(md$outcome)


md$outcome_dummy <- 0 #1:paid off - 0  
head(md)
table(md$outcome_dummy)

md[md$ooutcome == "paid off",]$outcome_dummy <- 1

logistic_model <- glm(outcome_dummy ~ payment_inc_ratio + purpose_ + home_ + emp_len_ +borrower_score, data=loan_data, family='binomial')

pred <- predict(logistic_model)
summary(pred)


prob <- 1/(1+exp(-pred)) #This is the conversion to get probabilities
summary(prob) #This will tell the prob if they will pay off their loans 

plot(sort(prob ))
