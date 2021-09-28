# There are many built-in functions in R. Make sure that new object names you assign are not already used by R.
# A simple way of checking this is to type in the name you want to use. If the system returns an error message telling
# you that such object is not found, it is safe to use the name. For example, c (for concatenate) is a built-in function
# used to combine elements so NEVER assign c as an object name!

2 + 3*5                        #Note the order of operations.
log(10)                      #Natural logarithm
4^2                    #4 raised to the second power
3/2                    #Divisions
sqrt(16)               #Square root
abs(3-7)               #Absolute value of 3-7
pi                     #The mysterious number
exp(2)                       #exponential function
15%/%4                         #Integer divide operation
#                      #comment line

x <- log(2.843432)              #assign value to x
floor(x)                 #largest integer less than or equal to x
ceiling(x)             #smallest integer greater than or equal to x

x <-3+2i
Re(x)                  # Real part of the complex number x
Im(x)                  # Imaginary part of x
y <- 4-5i
x+y
x*y

x <- c(1,3,2,10,5)           #create a vector x with 5 components
y <- 1:5               #create a vector of consecutive integers
y+2                    #scalar addition
2*y                          #scalar multiplication
y^2                          #raise each component to the second power
2^y                          #raise 2 to the first through fifth power
y                            #y itself has not been changed
y <-y*2
y                            #y is changed now

x <- c(1,3,2,10,5); y <-1:5  #separated two or more statements by semicolons
x+y
x*y
x/y
x^y

x <-c(1,3,2,10,5)
sum(x)
cumsum(x)              #cumulative sum vector
diff(x)                      #first order difference, x_{t}-x_{t-1}
diff(x,2)                    # two step difference x_{t}-x_{t-2}
diff(diff(x))                #second order difference
sort(x)                      #increasing order
sort(x, decreasing=T)        #decreasing order
length(x)              #number of elements in x
x[3]                   #the third element of x
x[3:5]                       #the third to fifth element of x,
x[-2]                  #all except the second element
x[x>3]                       #list of elements in x greater than 3

x>3                    #logical operations
as.numeric(x>3)                # logical to numeric conversion
sum(x>3)               #number of elements in x greater than 3
(1:length(x))[x<=2]          #indices of x whose components are less than or equal to 2
z <- as.logical(c(1,0,0,1))  #numeric to logical vector conversion

#Assign characteristic vector.
colors <- c("green", "blue", "orange", "yellow", "red")

#Individual components can be named and referenced by their names.
names(x)               #check if any names are attached to x
names(x) <- colors           #assign the names using the character vector colors
x
x["green"]             #component reference by its name green
names(x) <- NULL       #names can be removed by assigning NULL

#seq() and rep() provide convenient ways to a construct vectors with a certain pattern.
seq(10)
seq(0, 1, length=10)         #How many subinterval? How many numbers?
seq(0, 1, by=0.1)            #How many subinterval? How many numbers?
rep(1, 3)
c(rep(1, 3), rep(2, 2), rep(-1, 4))
rep("Small", 3)
c(rep("Small", 3), rep("Medium", 4))
rep(c("Low", "High"), 3)

#Matrices
x <- c(1, 3, 2, 10,5)
y <- c(1, 2, 3, 4, 5)
m1 <- cbind(x, y)            #combine two vectors in columns
t(m1)                        #transpose
dim(m1)                      #dimension of matrix
m2 <- matrix(c(1,3,2,5,-1,2,2,3,9), nrow = 3)
m3 <- matrix(c(1,3,2,5,-1,2,2,3,9), ncol = 3, byrow = T)
m2[2,3]                          #element of m2 at the second row, third column
m2[2,]                      #second row
m2[,3]                         #third column
m2[-1,]                          #submatrix of m2 without the first row
m2[,-1]                          # submatrix of m2 without the first column
m2[-1,-1]             #submatrix of m2 with the first row and column removed
m1<-matrix(1:4, ncol=2); m2<-matrix(c(10,20,30,40),ncol=2)

2*m1             #scalar multiplication
m1+m2              #matrix addition
m1*m2              #component-wise multiplication, NOT the usual matrix multiplication
m1%*%m2                  #usual matrix multiplication
solve(m1)        #inverse matrix 1
solve(m1)%*%m1           #check if it is so
diag(3)                #diag() is used to construct a 3x3 identity matrix
diag(c(2,3,3))         #as well as other diagonal matrices
eigen(m2)        #Eigenvalues and eigenvectors of matrix

x <- c(0,4,15, 1, 6, 3, 20, 5, 8, 1, 3)
sort(x)                                 #increasing order
sort(x, decreasing=T)                     #decreasing order
sum(x)
mean(x)                           #Mean
median(x)                         #Median
var(x)                                  #Variance
sd(x)                                   #Standard deviation
quantile(x,0.25)                  #25th Percentile
quantile(x,c(0,0.25,0.5,0.75,1))
summary(x)                              #Five number summary
IQR(x)                                  #Interquatile

basicStats(x)    #More detailed summary, need #to install fBasic package

# Generate random number sequences according to different probability density functions.
# The functions have the generic structure rfunc(n, par1, par2, ...), where func is the
# name of the probability distribution, n is the number of data to generate, and par1, par2, ...
# are the values of some parameters of the density function that may be required. For example
rnorm(10)
#generates 10 random numbers according to standard Normal distribution.

rnorm(20, mean = 10, sd = 3)
#generates 20 random numbers according to Normal distribution with mean 10 and standard deviation 3.

rt(5, df = 10)#generates 5 random numbers according to t-distribution with degree freedom of 10

# Simple Pie Chart
slices <- c(10.6,14.7,14.5,5.2,11.2,12.8,3.7,2.4,10.1,14.9)
lbls <- c("Arts", "Biology","Business","Education","Engineering","Health","Math","Physical Science","Social Science","Other")
pie(slices, labels = lbls, main="Pie Chart of Field of Study")

#If percentages are known
slices <- c(10.6,14.7,14.5,5.2,11.2,12.8,3.7,2.4,10.1,14.9)
lbls <- c("Arts", "Biology","Business","Education","Engineering","Health","Math","Physical Science","Social Science","Other")
lbls <- paste(lbls, slices) # add percents to labels
lbls <- paste(lbls,"%",sep="") # adds % to labels
pie(slices,labels = lbls, col=rainbow(length(lbls)),main="Pie Chart of Field of Study")

#Pie Chart with percentages when unknown
slices <- c(7134,11430,12387,12230,12308,12047,8124)
lbls <- c("Sunday", "Monday","Tuesday","Wednesday","Thursday","Friday","Saturday")

pie(slices, labels = lbls, main="Pie Chart of Days Babies are Born") #This gives the basic pie chart

pct <-round(slices/sum(slices)*100,1)
lbls <- paste(lbls, pct) # add percents to labels
lbls <- paste(lbls,"%",sep="") # adds % to labels
pie(slices,labels = lbls, col=rainbow(length(lbls)),main="Pie Chart of Days Babies are Born")

# Simple Bar Graph
H <- c(2,3,3,3,4,5,5,5,5,6)
counts <- table(H)
counts
barplot(counts)

# More detailed Bar Graph
B <- c(3, 2, 25, 37, 22, 34, 19)
barplot(B, main="MY NEW BARPLOT", xlab="LETTERS", ylab="MY Y VALUES", names.arg=c("A","B","C","D","E","F","G"))

#Histogram
md <- read.csv(file=file.choose(), header=T) #This will pull a data set saved as a .csv file into R
hist(md$tuition, col="green") #Note: argument must match EXACTLY how it is in the data file. This is CASE SENSITIVE.

#Stem plot
stem(md$tuition)

#Time plot
plot(md$year,md$tuition) #this gives the time plot with dots
plot(md$year,md$tuition,type='l') #this gives the time plot with the line connecting the dots
plot(md$year,md$tuition,type='l',xlab="Year", ylab="Tuition Cost (in dollars)") #Adds labels
plot(md$year,md$tuition,type='l',xlab="Year", ylab="Tuition Cost (in dollars)",main="Tuition vs. Time") #Includes labels and  title

?beaver2 # Asi busco mas information sobre algo 
