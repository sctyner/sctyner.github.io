---
layout: post
title:  "Divide and Recombine or Split-Apply-Combine?"
date:   2014-03-12 21:57:30 -0600
categories: blog, stat585x
---

*Written for [STAT 585X](http://dicook.github.io/stat585/) after going through [the datadr tutorial](http://hafen.github.io/datadr/#background) by [Ryan Hafen and others](https://www.datadr.org/people.html)*

The concept that datadr was built upon, divide and recombine, is essentially the same as the concept behind plyr, split-apply-combine. In fact, the recombine() function in datadr has apply= and combine= as necessary arguments, so it really is doing the same exact thing as plyr! There are, however, two main differences between datadr and plyr/dplyr.

First, the key-value data structure of datadr is much more flexible than the data frame structure of dplyr. For example, complicated lists, lists of lists, or nested list structures are more easily converted to ddo or ddf structures for analysis in datadr, whereas a significant amount of time would have to be spent plyr-ing these data sets before they can be analyzed using dplyr.

The second key difference is that datadr was designed with data sets with sizes on the terabyte scale in mind, and while dplyr is fast and can work with larger data sets, data sets that are as large as the ones datadr was designed for are probably not in the tidy format that dplyr requires, so the large task of data cleaning/tidying would have to be undertaken before using dplyr. The ability to “execute Hadoop MapReduce jobs completely from within R and with R data structures” using RHIPE is (at least to my limited understanding) a big advantage of datadr over plyr/dplyr.

The actual divide & recombine strategies and functions, however, are not different in concept from the plyr and dplyr split-apply-combine strategies and functions. For example, the drFilter() and the drJoin() functions in datadr are essentially the same as the filter() and group by() functions in dplyr. Additionally, “much of the anticipated future work for datadr is the construction of several apply-combine pairs that are useful for different analysis tasks” using the recombine() function, and plyr/dplyr already do this very well because they apply and combine separately, while datadr does both at once. Finally, I think the one major advantage to using plyr/dplyr over datadr is that the syntax is much cleaner and easier to understand in plyr/dplyr, at least it is for me, especially when it comes to the preTransFn and postTransFn arguments in the divide function. All in all, I think they both have benefits, but since I don’t plan on analyzing a terabyte of data anytime soon, I’ll stick with plyr/dplyr! 
