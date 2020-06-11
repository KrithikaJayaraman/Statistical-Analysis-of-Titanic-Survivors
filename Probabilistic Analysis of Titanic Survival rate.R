#Project to study the survival rates of male and female in Titanic disaster
library(tidyverse)
data <- read.csv("./train.csv", header = TRUE)
head(data)
dim(data)

tab <- table(data$Sex, data$Survived)

#ECDF of the age of the survivors
age <- subset(data,!is.na(data$Age), select = c(Sex, Age ))
  
obs.ecdf <- ecdf(age$Age)
plot(obs.ecdf)
n=length(data$Age)
alpha <- 0.05
eps         <-  sqrt(log(2/alpha)/(2*n))
xx          <-  seq(min(age$Age)-1,max(age$Age)+1,length.out=1000)
ll          <-  pmax(obs.ecdf(xx)-eps,0)    
uu          <-  pmin(obs.ecdf(xx)+eps,1)
lines(xx, ll, col="blue")       
lines(xx, uu, col="blue")


#Bootstrapping to estimate the difference in the proportions of the male and female survivors
f_total <- tab[1,1] + tab[1,2]
m_total <- tab[2,1] + tab[2,2]

p_f_survived <- tab[1,2]/f_total #233/314
p_m_survived <- tab[2,2]/m_total
theta_hat <- p_m_survived - p_f_survived #MLE

#Parametric bootstrap
diff <- numeric(1000)
for(i in 1:1000)
{
  x <- rbinom(1,m_total,p_m_survived )
  y <- rbinom(1,f_total,p_f_survived )
  
  p.1 <- x/m_total
  p.2 <- y/f_total
  diff[i] <- p.1-p.2
}

se_boot <- sd(diff)
ci <- c(theta_hat - 2 * se_boot, theta_hat + 2 * se_boot)

quantile(diff, c(0.025,0.975))


#Hypothesis test to idenitify if there is difference in the proportion of male and female survivors
se_hat <- sqrt((p_f_survived*(1-p_f_survived)/f_total) + (p_m_survived*(1-p_m_survived)/m_total))
z.stat<-(p_m_survived - p_f_survived )/(se_hat)
p.value=2*pnorm(z.stat)
p.value

#p-value < alpha = 0.05. Thus the null hypothesis that p_m_survived - p_f_survived = 0 is rejected


#Bayesian Analysis
#Assuming f(p_m_survived, p_f_survived) follows Unif(0,1)
B <- 1000
no_f_survived <- tab[1,2]
no_m_survived <- tab[2,2]
p_f <- rbeta(B, no_f_survived + 1, f_total - no_f_survived + 1 )
p_m <- rbeta(B, no_m_survived + 1, m_total - no_m_survived + 1 )
xi <- p_m - p_f
mean(xi)

quantile(xi, c(0.025, 0.975))
