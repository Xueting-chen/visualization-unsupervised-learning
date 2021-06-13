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

4.	K-means Clustering
The main objective of the K-Means algorithm is to partition the dataset into a certain number of non-overlapping clusters and minimizes the distance between points and their respective cluster centroid. It is important to specify the desired number of clusters before clustering. Then, the K-means algorithm will assign each observation to the closest cluster centroid. The centre centroids will adjust accordingly with each assignment until values of centroid stabilises. Hence the number of clusters to begin is crucial, we will use Elbow method to determine the optimal number of clusters. This can be done by eyeballing Figure 6 plot and look for the point at which the sum of squares distance drops off. Since the plot looks like an “arm”, the elbow on on the “arm” is the optimal number of clusters (James et. al.,2017). After running K-Means using the optimal K, the observations are divided into 2 clusters with 4869 in the first cluster and 2778 in the second cluster. 

![image](https://user-images.githubusercontent.com/81580783/121814928-3b82d700-cca6-11eb-9526-35a096d6ea28.png)
![image](https://user-images.githubusercontent.com/81580783/121814934-3e7dc780-cca6-11eb-8432-83cdccbd4e58.png)

Figure 7 shows the mean response for each question and the two clusters are represented by “positive” and “neutral to negative” responses.  All of the mean values in Cluster 1 are less than two which tells us that most responses in this cluster are positive. Whereas, mean values in Cluster 2 are generally more than two suggesting that there is mixture of neutral and negative responses. Furthermore, there are a few variables such as Q2a (Gender), Q2b (Age) and Q90f that are similar in values between the two clusters. Hence we will conduct Goodness of Fit Test (χ^2  test) to determine any significant difference between these two clusters.

	Q2a – Gender
The mean values for Cluster 1 and 2 are 1.47 and 1.52 respectively. In proportions, there are 53% males in Cluster 1 and 48% males in Cluster 2. To find out whether the values for gender are significantly different between the two clusters, we will reject H_0  for being similar in values if p-value < 0.05. The p-value given by χ^2 test is 0.0004998  < 0.05 hence conclude that gender is statistically different between the 2 clusters.
	
	Q2b – Age
The mean age for Cluster 1 and 2 are 41.5 and 45.4 respectively. Age ranges from 15 to 87 in Cluster 1 and 18 to 87 in Cluster 2, we will reject H_0  for being similar in values if p-value < 0.05. The p-value given by χ^2 test is 0.0004998  < 0.05 hence conclude that age is statistically different between the 2 clusters.

	Q90f - In my opinion, I am good at my job  [Please tell me how often you feel this way...]
The mean response for Cluster 1 and 2 are 1.38 and 1.78 respectively and both are positive response. This suggests most of the workers are confident in their abilities to perform well in their jobs. We will reject H_0  for being similar in values if p-value < 0.05. The p-value given by χ^2 test is 0.0004998 < 0.05 hence conclude that Q90f responses are statistically different between the 2 clusters.

5.	Hierarchical Clustering
Hierarchical clustering has many advantages over K-means clustering such as not requiring to specify the number of clusters K beforehand and producing a tree-based representation of the observations knowns as dendrogram which is easy to interpret. The algorithm works in a manner that each data point is assigned to a cluster, the closest two clusters will be identified and combined into one cluster, the process will repeat until all the data points are in one cluster. This structure will be represented by a dendrogram and there are a few ways to determine the proximity of two clusters, namely; complete linkage clustering (Fig. 7), average linkage clustering (Fig. 8) and single linkage clustering (Fig. 9).

![image](https://user-images.githubusercontent.com/81580783/121814973-7edd4580-cca6-11eb-87af-94751325bed2.png)
![image](https://user-images.githubusercontent.com/81580783/121814977-81d83600-cca6-11eb-9555-58deb4163cf7.png)
![image](https://user-images.githubusercontent.com/81580783/121814980-84d32680-cca6-11eb-9b13-2610ebdabbb7.png)

![image](https://user-images.githubusercontent.com/81580783/121814989-8a307100-cca6-11eb-871c-7b8e2115cf6a.png)
![image](https://user-images.githubusercontent.com/81580783/121814993-8d2b6180-cca6-11eb-8705-9a4254b1e7d2.png)

I.	Complete linkage clustering measures the maximum pairwise differences between observations in two clusters and record the largest difference. After cutting the tree, there are 1220 cases in cluster 1 and 6427 cases in cluster 2. 

II.	Single linkage clustering measures the minimum intercluster pairwise differences between observations in two clusters and record the lowest difference. After cutting the tree, there are 7647 cases in cluster 1 and only 1 case in cluster 2. Single linkage fails to provide sufficient sample size for cluster 2 hence it is not suitable to use.

III.	Average linkage clustering measures the mean intercluster pairwise differences between observations in two clusters and record the average of these difference. After cutting the tree, there are 7618 cases in cluster 1 and only 29 cases in cluster 2. Average linkage fails to provide sufficient sample size for cluster 2 hence it is not suitable to use.

Hence, complete linkage clustering is preferred over single linkage and average linkage due to sufficient sample sizes for both clusters. Figure 10 shows the results of the mean values from both clusters under complete linkage clustering. Since Q2a and Q90f are similar in values, we will conduct Goodness of Fit test to find out whether they are statistically different.

	Q2a – Gender
The mean values for Cluster 1 and 2 are 1.527 and 1.483 respectively. In proportions, there are 47% males in Cluster 1 and 52% males in Cluster 2. To find out whether the values for gender are significantly different between the two clusters, we will reject H_0  for being similar in values if p-value < 0.05. The p-value given by χ^2 test is 0.001696 < 0.05 thus conclude that gender is statistically different between the 2 clusters.

	Q90f - In my opinion, I am good at my job  [Please tell me how often you feel this way...]
The mean responses for Cluster 1 and 2 are 1.854 and 1.469 respectively and both are positive response. This suggests most of the workers are confident in their abilities to perform well in their jobs. We will reject H_0  for being similar in values if p-value < 0.05. The p-value given by χ^2 test is 0.0004998 < 0.05 thus conclude that Q90f responses are statistically different between the 2 clusters.
