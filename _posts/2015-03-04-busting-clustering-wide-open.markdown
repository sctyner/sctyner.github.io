---
layout: post
title:  "Busting Clustering Wide Open"
date:   2015-03-04 11:57:30 -0600
categories: blog, stat503
---

*Written for [STAT 503](http://dicook.github.io/teaching.html) after reading [two](http://www.stat.wmich.edu/wang/561/classnotes/Grouping/Cluster.pdf) [introductions](http://strata.uga.edu/6370/lecturenotes/clusterAnalysis.html)*

Cluster analysis is a type of unsupervised learning.  Up until this point in STAT 503, we have just been studying supervised learning methods, so unsupervised learning is an exciting new challenge.  In unsupervised learning, there is never a response variable, which poses a lot of problems. Most importantly, there is no "truth" to compare our modeling results to like there is in supervised learning.  According to the second link above, there are 3 stages of cluster analysis: partitioning, interpretation, and validation and profiling. The majority of the reading focused on the partitioning aspect of cluster analysis.

There are 2 main types of partitioning: Hierarchical and Non-hierarchical (or K-Means) clustering. Hierarchical clustering can be further split into agglomerative and divisive algorithms.  In agglomerative algorithms, you start with n clusters: each observation is its own cluster.  Then you use some sort of distance metric (there are many to choose from depending on the data at hand) to group the closest observations together, and repeat that process until some designated stopping point.  Each algorithm that performs agglomerative clustering stops in different ways so the stopping point depends on the data and the algorithm of choice. Divisive clustering is exactly the opposite: you start with one big cluster and split it up into 2 clusters, then 3, then 4, etc.  The reading did not spend too much time discussing this method of clustering. I understand that choice because agglomerative clustering makes much more intuitive sense and seems much easier to implement than divisive clustering. Non-hierarchical clustering, also called partitioning or K-means clustering, is only briefly discussed in the reading, so I won't spend any time on it here.

Finally, the major issue when dealing with clustering analysis is deciding just how many clusters are actually there to find in your analysis.  There may be a scientific choice for the number of clusters. For example, it could be restricted to the number of species of a plant or animal that are known to exist.  Or, there may be a previous study done that gives a good idea of the number of clusters to start looking for.  Often, however, this prior knowledge is unavailable to you.  So, the first reading recommends using Beale's pseudo F-test to decide between 2 different numbers of clusters 
at a time. 