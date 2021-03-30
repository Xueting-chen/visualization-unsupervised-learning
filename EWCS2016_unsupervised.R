setwd("~/Desktop/UOL/ML Year 3/Coursework/Part 1")
df <- read.csv("EWCS_2016.csv", sep = ",", header = T)
head(df)

# Data Cleaning
# Some data have -999 values which need to be removed
df[,][df[, ,] == -999] = NA
sum(is.na(df)) #329 obs are NA
clean.df <- complete.cases(df)
df1 <- df[clean.df, ]
scaled.df1 <- scale(df1)
# omitted 329 NA obs, left 7647 obs. with 11 variables
str(df1)

qn.data <- df1[ ,3:11]   #Exclude age and gender variables
Gender <- table(df1[ ,1])
Gender  #Q2a: 3899 males and 3748 females

# Data visualization #
library(ggplot2)
library(ggfortify)
library(GGally)
library(corrplot)
library(tidyverse)
library(cluster)
library(factoextra)

  
ggcorr(scaled.df1, label=TRUE, label_alpha = TRUE)
## Workers' mental health seem to be correlated to working performance

#Distribution of Age 
qplot(Q2b, data=df1, geom='histogram', bins=20, fill=..count.., xlab='Distribution of Age Plot')

#Distribution of responses in each question
options(repr.plot.width=6, repr.plot.height=6)
ggplot(gather(df1[, 3:11]), aes(value)) + 
  geom_bar(stat="count",color="black", fill="lightgreen")+
  facet_wrap(~key, scales = 'free_x')
## Most frequent response given is "2:Most of the time" 

# PCA #
pc <- prcomp(df1, scale. = T)
summary(pc)
pc$rotation
# PC1 and PC2 explains 53% of the variance proportions.
# Qns 87 is the more important differentiator in PC1 followed by Qns 90 in PC2.
dim(pc$x)

autoplot(pc, loadings = T, loadings.label = TRUE, loadings.label.size = 5)

pc$sdev
pc.var=pc$sdev^2
pc.var
pve=pc.var/sum(pc.var)
pve
par(mfrow=c(1,2))
plot(pve, main= "PVE Plot", xlab="Principal Component", 
     ylab="Proportion of Variance Explained", ylim=c(0,1),type='o', col="blue")
plot(cumsum(pve), main = "Cumulative PVE Plot", xlab="Principal Component", 
     ylab="Cumulative Proportion of Variance Explained", ylim=c(0,1),
     type='o', col = "brown3")
par(mfrow=c(1,1))

# K Means Clustering -----------------------------------------------------------
set.seed(2000)
scaled.df1 <- scale(df1) 

# Elbow method to find the optimum number of clusters
wss <- function(k) {
  kmeans(df1, k, nstart = 25 )$tot.withinss 
}
k.values <- 1:10
wss_values <- map_dbl(k.values, wss)

plot(k.values, wss_values,
     type="o", pch = 19, frame = FALSE, 
     xlab="Number of clusters K",
     ylab="Total within-clusters sum of squares")
abline(v=2, col="blue")

# Run Kmeans based on the optimum K
k2 = kmeans(scaled.df1, centers = 2, nstart=25)
summary(k2)
k2.cluster = k2$cluster
table(k2.cluster)  #4869 in the first group, 2778 in the second group
colMeans(df1[k2$cluster == 1, ])
colMeans(df1[k2$cluster == 2, ])
## Mean response for Q90f is between 1.38 to 1.78,
# find out whether they are significantly different btw the clusters.

## Chi-square test for differences between these two clusters
# cluster 1 and 2 results
k2results = cbind(df1, k2$cluster)
cluster1 = subset(k2results, k2$cluster==1)
cluster2 = subset(k2results, k2$cluster==2)

# Based on the significance of Q90f
M = as.matrix(table(cluster1$Q90f))
p.null <- as.vector(prop.table(table(cluster2$Q90f)))
chisq.test(M, p=p.null, simulate.p.value = TRUE)
# P-value < 0.05, Ho is rejected so Q90f is different in both clusters separately

## Gender
round(prop.table(table(cluster1$Q2a)),2)
round(prop.table(table(cluster2$Q2a)),2)
# 53% are males in Cluster 1 and 48% are males in Cluster 2. 
# Since numbers are so close, we want to know is there statistical difference.

M_gender = as.matrix(table(cluster1$Q2a))
p.null_gender <- as.vector(prop.table(table(cluster2$Q2a)))
chisq.test(M_gender, p=p.null_gender, simulate.p.value = TRUE)
# P-value = 0.0004998 < 0.05, Cluster 1 Gender Proportions are different from Cluster 2 Gender Proportions
## K-means clustering concludes Gender is significant differentiator.

## Age

table(cluster1$Q2b)
table(cluster2$Q2b)
M_age = table(cluster1$Q2b)
p.null_age <- as.vector(prop.table(table(cluster2$Q2b)))
chisq.test(M_age, p=p.null_age, simulate.p.value = TRUE)
#  p-value < 0.0004998 < 0.05, H0 is rejected and hence the distribution of age
# in cluster 1 and 2 are statistically different.

# Hierarchical Clustering ----------------------------------------------------
set.seed(2000)
eu.di = dist(scaled.df1, method = "euclidean")# euclidean distance

hc.comp = hclust(eu.di, method = "complete")
hc.avg = hclust(eu.di, method = "average")
hc.sg = hclust(eu.di, method = "single")

plot(hc.avg , main ="Average Linkage", xlab="", sub ="", hang = -1, cex =.9)
sum(cutree(hc.average , 2)==1) # 29 cases of cluster 2, 7618 of cluster 1
## Average linkage fails to provide sufficient sample size for one cluster.

plot(hc.comp , main ="Complete Linkage", xlab="", sub ="", cex =.9, hang = -1)
sum(cutree(hc.comp, 2)==2)  # 6427 cases of cluster 2, 1220 cases of cluster 1

plot(hc.sg , main ="Single Linkage", xlab="", sub ="", cex =.6, hang = -1)
sum(cutree(hc.sg, 2)==1) # 7647 cases of cluster 1, only 1 case of cluster 2
## Single linkage fails to provide sufficient sample size for one cluster.
## Hence Complete Linkage is most suitable. 

hc.cluster1 <- subset(df1, cutree(hc.comp, k=2)==1)
data.frame(colMeans(hc.cluster1))
hc.cluster2 <- subset(df1, cutree(hc.comp, k=2)==2)
data.frame(colMeans(hc.cluster2))

# Gender, age and Q90f have very similar values in HC as well.
# We want to find out whether they are statistically different btw clusters.

# Based on the significance of Q90f 
M.hc = as.matrix(table(hc.cluster1$Q90f))
p.null.hc <- as.vector(prop.table(table(hc.cluster2$Q90f)))
chisq.test(M.hc, p=p.null.hc, simulate.p.value = TRUE)
# P-value < 0.0004998 < 0.05,  Ho is rejected so Q90f is 
# statistically different btw both clusters. 

## Gender
round(prop.table(table(hc.cluster1$Q2a)),2)
round(prop.table(table(hc.cluster2$Q2a)),2)

M.gender <- as.matrix(table(hc.cluster1$Q2a))
p.null.gender <- as.vector(prop.table(table(hc.cluster2$Q2a)))
chisq.test(M.gender, p=p.null.gender)
# p-value = 0.001696 < 0.05, H0 is rejected so gender is 
# statistically different btw both clusters

### Age not able to find, the number of elements between the clusters of 
# age groups are different hence could not do chisq test
