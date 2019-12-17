---
title:  "A Brief History of Statistical Computing (as told through a series of corny historical references)"
date:   2014-02-2T21:57:30-06:00
categories: ["stat585x"]
tags: ["coursework"]
---

---
title: "A Custom ggplot2 Theme for Facebook"
author: "Sam Tyner"
date: 2016-12-30T13:40:27-05:00
categories: ["R", "ggplot2"]
tags: ["plot", "fun", "facebook"]
---

*Written for Stat 585X after reading [From S to R](http://www.research.att.com/articles/featured_stories/2013_09/201309_SandR.html?fbid=qg6od6BDX3T) from AT&T Labs, Inc.*

Before the development of S, a time period which I will now refer to as the “Computational Dark Ages,” data analysis was really just statisticians performing the most basic of computations, like regression, and about half of their efforts were applied to the brutal task of programming.

But then, Richard Becker, John Chambers, and Allan Wilks of Bell Labs, henceforth referred to as the “fathers of the Computational Renaissance,” banded together to create S, a computational tool that allowed the basic data type to be a vector, and the output of any function to be an object that could be further used in computation. The advantages of S over the computational tools of the Statistical Dark Ages were many: in S, everything was a function that could be run easily and quickly; all outputs of functions were computational objects, not just printed output; and S was adaptable to new methods/technology in that it allowed new algorithms to be wrapped into it.

As computers developed more power and capabilities, so did S. It grew in popularity, both inside and outside of AT&T. I’ll call this period the “Colonization of Computation.” During this period, AT&T li- censed S to an outside company, Statistical Sciences, which rebranded S as S-PLUS and began to charge for it. This was successful for a while, but then frustrated statistics students, the “Computational Revo- lutionaries,” revolted because, as we all know, people don’t like paying for things they used to be able to get for free.

Thus, the “Computational Revolution” was created, and Ross Ihaka & Robert Gentleman, the creators of a new, free, open-source computational program called R, emerged as the George Washington and Benjamin Franklin of their time. R was essentially S, but the big advantage it had over S was that it was easily extensible. Anyone can write a package, a set of savable and shareable functions, and share it with others to do computation in R. And so the Computational Revolution grew, and grew, and grew. It became so popular that one of fathers of the Computational Renaissance, John Chambers, became a Computational Revolutionary and core developer of R. (I suppose he could be called the reverse Benedict Arnold in this particular history.) 

 R, the “Computational SupeR PoweR” of the world, is now the single most popular computational tool among statisticians. It’s openness and extensibility are what have allowed it to grow so much in popularity and ability. There are over 5000 packages on CRAN, the Comprehensive R Archive Network, and more are added every day. In order to immigrate into the Computational SupeR PoweR, a package must work properly and have proper documentation. Many packages, however, exist in the Computational SupeR PoweR without the proper documentation through repositories other than CRAN, like GitHub.
 
The influence of open sharing services like GitHub have led to the creation of R-Cloud, essentially “Computational Globalization.” R-Cloud allows user to document, share, and show their data analysis with many other users, and also allows these other users to make changes to or comment on the existing analysis. R-Cloud is interactive and collaborative, and people can access their projects and make changes from anywhere on the globe. By running R programs in the R-Cloud, users can outsouRce their computations to bigger and better servers that can perform the calculations much more quickly than a local machine. All in all, many people benefitted from the Computational Revolution, and hopefully just as many, and maybe even more, will benefit from Computational Globalization.