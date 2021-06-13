Visualisation and unsupervised learning on EWCS 2016

The EWCS 2016 original dataset has 7813 observations and 11 variables. Q2a is a categorical variable, all of the remaining variables are numerical variable. 
The objective is to describe the dataset through visualization and unsupervised learning methods such as PCA, K-means clustering and hierarchical clustering.
1.	Data Cleaning

There are 329 observations recorded as -999 and will not be useful in our analysis hence removed. Now, the dataset is left with 7647 observations.

2.	Data Visualization

After filtering the data, it is reported that 3899 males and 3748 females participated in the survey. We would like to find out whether there is correlation between workers’ mental wellness (Q87a to Q87e) and their working performance (Q90a to Q90c). The diagram below, Figure 1 is the correlation plot and it shows some correlation between the mental wellness and working performance according to the intensity of colour. This could mean that worker who is feeling positive in terms of mental wellbeing will do better at work. However, the correlation seems to be decreasing in strength towards the last few survey questions answered. 

![image](https://user-images.githubusercontent.com/81580783/121814844-ba2b4480-cca5-11eb-9bd1-54177be480f1.jpeg)


Next, we would like to understand the distribution of age among the workers. Figure 2 shows the age of the workers ranged from early 20s to late 70s, with the median age at approximately 45 years old. Lastly, we want to find out what is the distribution of responses for each question. From Figure 3, the most frequent response from the respondents is “ 2: Most of the time ” except for Q90f whereby “ 1: Always” is chosen instead. This shows that respondents are generally very confident about their performance at work. The responses given for each question in the survey are majority also positive to neutral.


![image](https://user-images.githubusercontent.com/81580783/121814853-c6170680-cca5-11eb-8202-c18cc52b41de.jpeg)
![image](https://user-images.githubusercontent.com/81580783/121814858-d0390500-cca5-11eb-90fd-44be253f4429.jpeg)


3.	Principal Components Analysis

PCA is a dimensionality-reduction method which can transform a large set of data or correlated variables into a smaller number of representative variables that still preserve most of the information about the original dataset. Figure 4 below shows a PCA biplot of the scaled dataset, variables Q2b and Q87 will strongly influence PC1 as they hold the heaviest loading weights. Vectors of Q87a to Q87e are relatively close to one another, hence the variables they represent are positively correlated. Similar observations are made for vectors of Q90a to Q90f, also age and gender. The strength of correlation between questions can be determined by the degree of angle, there will be correlation as long as the vectors are not orthogonal.

![image](https://user-images.githubusercontent.com/81580783/121814904-0bd3cf00-cca6-11eb-87b7-e6d24ebf266e.png)
![image](https://user-images.githubusercontent.com/81580783/121814908-13937380-cca6-11eb-862f-7979028c9273.png)

Figure 5 is a scree plot depicting the proportion of variance explained (PVE) and cumulative PVE. According to the scree plots, the first principal component (PC) explains 40% of the variance in the data, the next PC explains 12.8% of the variance. Cumulatively, these two PCs explain only about 52% of the total data which is not accurate enough as a summary hence we might consider including more PCs to increase the accuracy.





