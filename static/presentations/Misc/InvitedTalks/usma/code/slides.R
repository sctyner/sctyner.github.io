## ----echo=FALSE--------------------------------------------------------------------------------------------------------------------------
options(tibble.print_min = 5)


## ----out.width='40%'---------------------------------------------------------------------------------------------------------------------
plot(faithful)

## ---- eval = FALSE, echo = TRUE----------------------------------------------------------------------------------------------------------
## rmarkdown::render("input.Rmd")


## ---- eval=FALSE-------------------------------------------------------------------------------------------------------------------------
## install.packages("rticles")


## ---- eval = FALSE, tidy=TRUE------------------------------------------------------------------------------------------------------------
## rmarkdown::draft("MyJSSArticle.Rmd",
##                  template = "jss_article", package = "rticles")

## ---- eval=FALSE-------------------------------------------------------------------------------------------------------------------------
## install.packages("flexdashboard")

## ----------------------------------------------------------------------------------------------------------------------------------------
library(tibble)
my_tbl <- tibble(x = rnorm(100), y = x +5)

## ---- echo=FALSE, warning = FALSE, message = FALSE---------------------------------------------------------------------------------------
library(tidyverse)


## ----------------------------------------------------------------------------------------------------------------------------------------
library(tibble)
(my_tbl <- tibble(x = rnorm(100), y= x*5 +2))


## ----------------------------------------------------------------------------------------------------------------------------------------
library(tidyverse)
sigacts <- read_csv("dat/sigacts.csv", 
                   col_types = list(col_character(),col_character(),               
                                    col_character(),col_character(),
                                    col_date(format = "%d-%b-%y"), col_character(),
                                    col_character()))


## ----------------------------------------------------------------------------------------------------------------------------------------
sigacts


## ----------------------------------------------------------------------------------------------------------------------------------------
sigacts$`Time of Event` %>% head; parse_number(sigacts$`Time of Event` %>% head)


## ----------------------------------------------------------------------------------------------------------------------------------------
sigacts$`Time of Event` %>% head ; str_to_lower(sigacts$`Time of Event` %>% head)
sigacts$`MGRS FRIENDLY` %>% head ; str_remove_all(sigacts$`MGRS FRIENDLY` %>% head, "\\W")


## ----------------------------------------------------------------------------------------------------------------------------------------
sigacts <- sigacts %>% 
  mutate(`Time of Event` = parse_time(str_to_lower(`Time of Event`), format="%H%Mz")) %>% 
  mutate_at(1:3, str_to_lower) %>% 
  mutate_at(vars(starts_with("MGRS")), str_remove_all, pattern = "\\W")
sigacts %>% select(1:4, starts_with("MGRS"))


## ----------------------------------------------------------------------------------------------------------------------------------------
(sigacts_summ <- sigacts %>% 
  group_by(AREA, Event) %>% 
  count() %>% 
  arrange(desc(n)))


## ---- fig.align='center', out.width="80%", warning=TRUE, fig.width=10, fig.height=4------------------------------------------------------
ggplot(data = sigacts, aes(x = DOI, y = `Time of Event`)) + 
  geom_point() 


## ---- fig.align='center',  out.width="80%", warning=TRUE, fig.width=10, fig.height=4-----------------------------------------------------
ggplot(data = sigacts, aes(x = DOI, y = `Time of Event`)) + 
  geom_point() + geom_rug()

## ----------------------------------------------------------------------------------------------------------------------------------------
(sigacts_longer <- sigacts %>% 
  pivot_longer(cols = starts_with("MGRS"), 
               names_to = "who", names_prefix = "MGRS ", 
               values_to = "mgrs", values_drop_na = TRUE))


## ---- warning=TRUE-----------------------------------------------------------------------------------------------------------------------
(sigacts_wider <- sigacts_longer  %>% 
  pivot_wider(names_from = "who", values_from = "mgrs"))


## ----eval = FALSE------------------------------------------------------------------------------------------------------------------------
## map(.x, .f, ...)



## ----------------------------------------------------------------------------------------------------------------------------------------
sigacts_longer$mgrs %>% head %>% mgrs::mgrs_to_latlng()


## ----------------------------------------------------------------------------------------------------------------------------------------
(sigacts_longer <- sigacts_longer %>% 
  mutate(coords = map(mgrs, mgrs::mgrs_to_latlng, include_mgrs_ref = FALSE)))


## ----------------------------------------------------------------------------------------------------------------------------------------
(sigacts_longer <- sigacts_longer %>% unnest(c(coords)))


## ----out.width='48%'---------------------------------------------------------------------------------------------------------------------
world <- rnaturalearth::ne_countries(scale = "medium", returnclass = "sf")
ggplot() + geom_sf(data = world) + 
  geom_point(data = sigacts_longer, aes(x = lng, y = lat, color = who), alpha = .5) + 
  scale_color_manual(name = NULL, values = c("black", "red")) + 
  xlim(c(36,48)) + ylim(c(30,39)) + theme_void() + theme(legend.position = c(.85,.9))


## ----------------------------------------------------------------------------------------------------------------------------------------
mu <- 1:5
sigma <- 1:3

mysims <- crossing(mu,sigma) %>% 
  mutate(sims = map2(mu, sigma, rnorm, n = 100))
glimpse(mysims)


## ---- message = FALSE, out.width='500px', out.height="400px", fig.align='center'---------------------------------------------------------
mysims %>% unnest(c(sims)) %>% ggplot(aes(x = sims)) + geom_histogram() + 
  facet_grid(sigma~mu, labeller = "label_both")
