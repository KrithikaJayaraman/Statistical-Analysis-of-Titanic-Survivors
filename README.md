# Statistical-Analysis-of-Titanic-Survivors

Titanic disaster is one of the most infamous shipwrecks in history. The main objective of this project is to understand “What sorts of people survived the disaster?” We have derived possible answers for this question through hypothesis testing.

Methodology:

1) We plot the Empirical CDF of the 'Age' variable along with the confidence band at 95% Confidence level. Upon plotting the ECDF, we observe that more than 50% of the survivors in the dataset are under the age of 30.

2) In order to study the gender-wise survival statistics, we use Maximum likelihood estimate to find the difference in the survival rates of make and female passengers. Based on the MLE estimate, we observe that it is highly likely that the number of female survivors are greater than the number of male survivors at the population level. We also use **Wald's test** to validate the hypothesis that  there is significant difference between the number of male and female survivors at the population level in a tragic disaster like this.

3) In order to obtain the standard error and the confidence interval for the MLE estimate of survival rate, we use parametric bootstrap. Observed resuts show that the difference in the proportion of female and male survivors is certain to be lie between 49% and 61% at 95% confidence level.

4) We confirm the estimates obtained by the above Frequentist approaches match Bayesian results. 

Prior Distribution for Bayesian analysis:
Uniform (0,1) given by a function of proportion of survived males & proportion of survived females. As we know that Uniform (0,1) is Beta (1,1), we will use the Beta Distribution in the analysis.

