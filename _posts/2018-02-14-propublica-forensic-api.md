---
layout: post
title: "Exploring Data from ProPublica’s Forensics API"
date: "2018-02-14 11:24:05 CST"
categories: blog, APIs, rstats, forensics
editor_options: 
  chunk_output_type: console
---





```r
library(tidyverse)
library(sf)
library(RPublica)
library(albersusa)
library(visdat)
library(ggrepel)
library(colorRamps)
```

## ProPublica

For those who don't know, [ProPublica](https://www.propublica.org/about/) is "an independent, nonprofit newsroom that produces investigative journalism with moral force." In addition to being a force for truth, they are also a force for openness, and have several publicly available data sets in their [Data Store](https://www.propublica.org/datastore/) with a wide array of interests and implications. I recently stumbled across their [forensics API](http://projects.propublica.org/forensics/api) while doing some research for [CSAFE](https://forensicstats.org/). As a researcher for CSAFE, I thought it'd be pertinent to our work to download and explore this data, which pertains to coroner and medical examiner systems in the United States. For more on ProPublica's forensic-related endeavors, see [their website](http://projects.propublica.org/forensics). 

## Getting the Data

There is, of course, an [`R`](https://www.r-project.org/) package for accessing the data from this API. It's called [`RPublica`](https://cran.r-project.org/web/packages/RPublica/RPublica.pdf) and it's authored by [Thomas J. Leeper](http://thomasleeper.com/). There are two functions for accessing the ProPublica Forensics API: 

- `geos()`: Access information about the geographical levels (state or county) with coroner or medical examiner systems in the U.S. 
- `systems()`: Query further details about a given system using an `id` from a `geos` query.

First, I query all available `geos`: 


```r
# install.packages("RPublica")
allgeos <- RPublica::geos()
```

The geo-level variables returned by `geos()` and prefixed with `geo.` are: 

- `ar_association_key_name`: The location ID to pass to the `systems()` function
- `cached_slug`: Shortened name of geo
- `coroner_system`, `medical_examiner_system`, `system_types.medical_examiner_system`, `system_types.coroner_system`: 	"In the case of county geos, we report if the county is part of a `state`, `county` or `district` system (or none at all). If we don't have data, it will return `unavailable`. In the case of states, we return the same values, though we also add `county_state` for states that have a statewide system with exception counties, and `sometimes` for when certain counties have medical examiner systems and others have coroner systems. At the county level, we return `unavailable` when we haven't gathered data for the county, and we can't deduce the system type from its parent state (i.e. when its state's system is `county_state` or `sometimes`)." [(API documentation)](http://projects.propublica.org/forensics/api)
- `created_at`: Date entry created 
- `district`: Returns all `NA` values
- `id`: Geo-level ID variable
- `kind`: Is it a `state` or `county` system?
- `name`: State or county name 
- `note`: Other details about the geo
- `population`: Returns all `NA` values 
- `postal_abbreviation`: Two-letter state abbreviation
- `updated_at`: Date entry last updated

First, let's look at which states and counties we have information on: 


```r
# mapping the offices 

# usa county map
usa_counties <- albersusa::counties_sf(proj = "longlat")
# usa state map
usa_states <- albersusa::usa_sf(proj = "longlat")
# get just county names
allgeos %>% 
  mutate(geo.name = str_replace(geo.name, " County", "")) -> allgeos2
# separate states and counties
cnty_geos <- allgeos2 %>% 
  filter(geo.kind !="state")
state_geos <- allgeos2 %>% 
  filter(geo.kind == "state")
# merge with map data
cnty_geos_map <- merge(cnty_geos, usa_counties, by.x = c("geo.name", "geo.postal_abbreviation"), by.y = c("name", "iso_3166_2"), all = T)  
state_geos_map <- merge(state_geos, usa_states, by.x = c("geo.name", "geo.postal_abbreviation"), by.y = c("name", "iso_3166_2"), all = T)  

# map
ggplot() + 
  geom_sf(data = cnty_geos_map, aes(fill = geo.kind, geometry = geometry), color = "white") + 
  geom_sf(data = state_geos_map, aes(fill = geo.kind, geometry = geometry)) +
  scale_fill_manual(values = c('red', 'blue',"white")) + 
  coord_sf(crs = st_crs(state_geos_map$geometry)) + 
  theme_void() + 
  theme(panel.grid.major = element_line(color = "white"),
        legend.position = c(.8,.3))
```

<img src="/figure/source/2018-02-14-propublica-forensic-api/mapp-1.png" title="plot of chunk mapp" alt="plot of chunk mapp" style="display: block; margin: auto;" />

So, there are a lot of states missing completely, and many where only a few counties are represented. This is important to keep in mind throughout the rest of our analysis. 

Next, I use the [`purrr::map()`](http://purrr.tidyverse.org/) function to query all data from each geo using the `systems()` function. First, I wrote my own functions to extract each piece (`geos`,  `stats`, and the other information) one-at-a-time. I did this so that the [`tidyr::unnest()`](http://tidyr.tidyverse.org/) function I use later on to unnest all the data from the list columns would work. The final step here is to look at all the data using the [`visdat`](http://visdat.njtierney.com/) package, which allows us to see where there are missing data quickly and easily. 


```r
# get the geos information 
get_sys_geos <- function(num){
  dat <- RPublica::systems(id = num)
  geos <- dat$geos
  return(geos)
}
# get the stats information
get_sys_stats <- function(num){
  dat <- RPublica::systems(id = num)
  stats <- dat$stats
  if (length(stats) == 0){
    stats2 <- data.frame()
  } else {
    stats2 <- stats %>% spread(kind, value)
  }
  return(stats2)
}
# get the remaining info
get_sys_oth <- function(num){
  dat <- RPublica::systems(id = num)
  idx <- !(names(dat) %in% c("geos", "stats"))
  other <- data.frame(t(unlist(dat[idx])), stringsAsFactors = F)
  return(other)
}
# use purrr to extract all the data
alldat2 <- allgeos %>% 
  mutate(geos = map(.x = geo.ar_association_key_name, get_sys_geos),
         stats = map(.x = geo.ar_association_key_name, get_sys_stats),
         other = map(.x = geo.ar_association_key_name, get_sys_oth))
# use unnest to unnest the data (What an aptly named function! I can't think of another way to describe it.)
alldat3 <- alldat2 %>% 
  unnest(geos, .drop=FALSE) %>% 
  unnest(stats, .drop=FALSE) %>% 
  unnest(other, .drop = FALSE)

visdat::vis_dat(alldat3)
```

<img src="/figure/source/2018-02-14-propublica-forensic-api/purrrdat-1.png" title="plot of chunk purrrdat" alt="plot of chunk purrrdat" style="display: block; margin: auto;" />

It looks like there are some columns that are all `NA`: `geo.district`, `geo.note`, `geo.population`, `district`, `note`, `population`. It seems like they were stored in one place (e.g. the `population1` column) and repeated elsewhere with no values. I drop those columns and continue. 




The `stats` and other variables are, according to the documentation: 
website	A website for the system.	

- `accreditation`:	Accreditation status from the National Association of Medical Examiners.	One of `Inspection in progress`, `Provisional`, `Full Accreditation`
- `bc_forensic_pathologists`:	Board Certified Forensic Pathologists working in this system.	
- `pt_bc_forensic_pathologists`:	Part-time Board Certified Forensic Pathologists working in this system.	
- `uc_forensic_pathologists`:	Uncertified Forensic Pathologists working in this system.	
- `pt_uc_forensic_pathologists`:	Part-time Uncertified Forensic Pathologists working in this system.	
- `fellows`:	Fellows working in this system.	
- `autopsy_ratio`:	The percentage difference between the actual autopsy rate and the expected autopsy rate according to ProPublica's analysis.	
- `raw_autopsy_rate`:	The number of autopsies performed per 100 deaths.	
- `autopsy_standard_deviation`:	Number of standard deviations based on the distribution. If less than -1, the system performed fewer autopsies than expected. If greater than 1, the system performed more autopsies than expected	
- `population`:	State or county population in a given year.
- `autopsies`:	Number of completed autopsies performed in a given year.	
- `contract_cases`:	Number of autopsies performed on cases outside of an office's jurisdiction but which they take on for smaller counties.	
- `forensic_pathologists`:	Number of forensic pathologists employed by the state or county in a given year.	
- `pt_provisional_forensic_pathologists`:	Forensic pathologists employed on a part-time basis, meaning anything from three days a week to an as-needed basis.	
- `annual_fiscal_budget`:	Annual budget for the state/county coroner or medical examiner system. (May change to annual_budget since budgets are either fiscal or calendar).

Note: a forensic pathologist is a pathologist who focuses on determining the cause of death by examining a corpse [(Wikipedia)](https://en.wikipedia.org/wiki/Forensic_pathology). See more about the variables in this data and how they were calculated [here](https://www.propublica.org/article/about-our-autopsy-data). 

## Data Exploration

First, let's look at the relationship between number of autopsies and annual budget: 


```r
alldat4 %>% 
  ggplot() + 
  geom_point(aes(x = autopsies, y = annual_fiscal_budget)) + 
  ggrepel::geom_label_repel(data = alldat4 %>% filter(autopsies > 3500) %>% select(autopsies, annual_fiscal_budget, year, name1) %>% unique, 
                            aes(x = autopsies, y = annual_fiscal_budget, label = name1), size = 2) + 
  facet_wrap(~year, nrow=2) 
```

![plot of chunk explore](/figure/source/2018-02-14-propublica-forensic-api/explore-1.png)

New York City has far more autopsies and a much higher budget than the others, but the North Carolina medical examiner typically performs way more autopsies than offices with similar budgets. 

Next, let's look at the personnel. First, I get all of the information about pathologists together, then look at the raw numbers of the qualifications of the pathologists.


```r
paths <- alldat4 %>% 
  select(c(8,9,37, 32, 22, which(str_detect(names(alldat4), "pathologist")))) %>% 
  unique()
paths <- paths %>% gather(type, number, pt_provisional_forensic_pathologists:uc_forensic_pathologists) %>% 
  mutate(number = parse_integer(number))
paths <- paths %>% mutate(type = str_replace(type, "_forensic_pathologists", ""))

paths %>% group_by(year, type) %>% summarize(total = sum(number, na.rm = T)) %>% 
ggplot( aes(x = type, weight = total )) +
  geom_bar() + 
  facet_wrap(~year, nrow = 2) + 
  labs(x = "Pathologist type", y = "Total count")
```

<img src="/figure/source/2018-02-14-propublica-forensic-api/paths-1.png" title="plot of chunk paths" alt="plot of chunk paths" style="display: block; margin: auto;" />

Next, I combine the two uncertified categories and look at which organizations have the most uncertified pathologists working for them, on average from 2004-2010: 


```r
paths %>% filter(type %in% c("pt_uc", "uc")) %>% 
  filter(number > 0) %>% 
  group_by(year, name1, geo.postal_abbreviation) %>% 
  summarize(tot = sum(number, na.rm = T)) %>% 
  ungroup() %>% group_by(name1, geo.postal_abbreviation) %>% 
  summarize(mean = mean(tot, na.rm = T)) %>% arrange(desc(mean))-> uc_paths
ggplot(data = uc_paths) + 
  geom_bar(aes(x = reorder(name1, mean), weight = mean, fill = geo.postal_abbreviation)) + 
  coord_flip() + 
  labs(x = "Office") + 
  scale_fill_manual(values = colorRamps::primary.colors(23), name = "State")
```

<img src="/figure/source/2018-02-14-propublica-forensic-api/ucpaths-1.png" title="plot of chunk ucpaths" alt="plot of chunk ucpaths" style="display: block; margin: auto;" />

Two of the busiest offices, North Carolina and New York City, also have the most uncertified forensic pathologists. This could be, as ProPublica describes [here](https://www.propublica.org/article/about-our-autopsy-data), because they have the most new hires who haven't yet passed their certification, a test only available once per year. Combined with the previous budget information, this suggests that the medical examiner's office of North Carolina is in desperate need of more funding so that they can hire more certified pathologists.

Finally, let's look at the accredidation of medical examiner offices. 


```r
# separate states and counties
cnty_data <- alldat4 %>% 
  filter(geo.kind !="state") %>% 
  mutate(name = str_replace(name, " County", ""))
state_data <- alldat4 %>% 
  filter(geo.kind == "state")
# merge with map data
cnty_geos_map2 <- merge(cnty_data, usa_counties, by.x = c("name", "geo.postal_abbreviation"), by.y = c("name", "iso_3166_2"), all = T)  
state_geos_map2 <- merge(state_data, usa_states, by.x = c("geo.name", "geo.postal_abbreviation"), by.y = c("name", "iso_3166_2"), all = T)  
# map
ggplot() + 
  geom_sf(data = cnty_geos_map2, aes(fill = accreditation, geometry = geometry), color = "white") + 
  geom_sf(data = state_geos_map2, aes(fill = accreditation, geometry = geometry)) +
  scale_fill_manual(values = c("#e41a1c","#377eb8","#4daf4a","#984ea3","white")) + 
  coord_sf(crs = st_crs(state_geos_map$geometry)) + 
  theme_void() + 
  theme(panel.grid.major = element_line(color = "white"),
        legend.position = c(.95,.3))
```

<img src="/figure/source/2018-02-14-propublica-forensic-api/unnamed-chunk-1-1.png" title="plot of chunk unnamed-chunk-1" alt="plot of chunk unnamed-chunk-1" style="display: block; margin: auto;" />

Labs that show up red on the map have blank value for accreditation. Based on my reading of the ProPublica documentation, it is unclear to me if those values are missing or if it should be "full" accreditation. 

## Summary and References 

This is just a small example of what can be done with this data. We've learned that  The dataset `alldat4` that I used can be downloaded [here](../static/dat/propublica_forensics.csv). 

Thanks to the following for their R packages used above: 

1. Hadley Wickham (2017). tidyverse: Easily Install and Load the 'Tidyverse'. R package version 1.2.1. https://CRAN.R-project.org/package=tidyverse
2. Edzer Pebesma (2017). sf: Simple Features for R. R package version 0.4-3. https://CRAN.R-project.org/package=sf
3. Thomas J. Leeper (2015). RPublica: ProPublica API Client. R package version 0.1.3.
4. Bob Rudis (2017). albersusa: Tools, Shapefiles & Data to Work with an 'AlbersUSA' Composite Projection. R package version 0.3.0. http://github.com/hrbrmstr/albersusa
5. Nicholas Tierney (2017). visdat: Preliminary Data Visualisation. R package version 0.1.0. https://CRAN.R-project.org/package=visdat
6. Kamil Slowikowski (2017). ggrepel: Repulsive Text and Label Geoms for 'ggplot2'. R package version 0.7.0. https://CRAN.R-project.org/package=ggrepel
7. Tim Keitt (2012). colorRamps: Builds color tables. R package version 2.3. https://CRAN.R-project.org/package=colorRamps






