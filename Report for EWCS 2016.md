Visualisation and unsupervised learning on EWCS 2016

The EWCS 2016 original dataset has 7813 observations and 11 variables. Q2a is a categorical variable, all of the remaining variables are numerical variable. 
The objective is to describe the dataset through visualization and unsupervised learning methods such as PCA, K-means clustering and hierarchical clustering.
1.	Data Cleaning

There are 329 observations recorded as -999 and will not be useful in our analysis hence removed. Now, the dataset is left with 7647 observations.

2.	Data Visualization

After filtering the data, it is reported that 3899 males and 3748 females participated in the survey. We would like to find out whether there is correlation between workers’ mental wellness (Q87a to Q87e) and their working performance (Q90a to Q90c). The diagram below, Figure 1 is the correlation plot and it shows some correlation between the mental wellness and working performance according to the intensity of colour. This could mean that worker who is feeling positive in terms of mental wellbeing will do better at work. However, the correlation seems to be decreasing in strength towards the last few survey questions answered. 
