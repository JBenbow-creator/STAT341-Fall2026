#Author: L'Nauhre', Date:09/22/26, Purpose: To perform T-Test

# Create variables x and y with some dummy dataset
x=rnorm(10)
y=rnorm(10)

# Make a normal distribution plot/curve for reference 
pts = seq(-4.5,4.5,length=100)
plot(pts,dt(pts,df=9),col='red',type='l')

# Add x and y points on existing plot window
lines(density(x), col='green')
lines(density(y), col='blue')

# Add another curve, color Yellow with 100 points between 2 to 4
pts =seq(2,4,length=100)
lines(density(pts), col='yellow')

# Apply the T-Test Function to check differences between variables x and y
ttest = t.test(x,y)

Welch Two Sample t-test

data:  x and y
t = -0.33205, df = 16.544, p-value = 0.744
alternative hypothesis: true difference in means is not equal to 0
95 percent confidence interval:
 -1.0630664  0.7744743
sample estimates:
 mean of x  mean of y 
-0.4075047 -0.2632086 

# x and y are not significantly different variables/groups
