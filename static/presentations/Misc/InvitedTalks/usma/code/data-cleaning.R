# scratch 

setwd("static/presentations/Misc/InvitedTalks/usma/")

library(tidyverse)
library(readxl)

# sheets <- excel_sheets("dat/Res_State.xls")
# sheets

# reserve1 <- read_excel("dat/Res_State.xls", sheet = sheets[1])
# reserve2 <- read_excel("dat/Res_State.xls", sheet = sheets[2])
# reserve3 <- read_excel("dat/Res_State.xls", sheet = sheets[3])
# 
# reserve1


sigacts <- read_csv("dat/sigacts.csv", 
                    col_types = list(col_character(),col_character(),col_character(),col_character(),
                                     col_date(format = "%d-%b-%y"), col_character(),col_character()))
sigacts %>% 
  janitor::clean_names() %>% 
  # make values uniform
  mutate_at(vars(area:time_of_event), tolower) %>% 
  # remove spaces so they all look the same 
  mutate_at(vars(mgrs_friendly, mgrs_non_partner), ~str_remove_all(., "\\W")) %>% 
  mutate_at(vars(mgrs_friendly, mgrs_non_partner), ~str_remove_all(., "IVO")) %>% 
  # adjust time variable so that its only the end time of the few obs with time intervals 
  # note: R defaults to UTC, which is the zulu time zone. all times in zulu
  mutate(time_of_event = parse_time(tolower(time_of_event), format = "%H%Mz")) -> sigacts_clean

# looking at head of sigacts_clean, it is obvious that there is something not quite right with the data. 
# rows are repeated when they shouldn't. 

# first, find the number of events by the 
sigacts_clean %>% 
  pivot_longer(mgrs_friendly:mgrs_non_partner, names_to = "who", values_to = "mgrs") %>% 
  filter(!is.na(mgrs)) %>% 
  pivot_wider(names_from = who, values_from = mgrs, values_fn = list(mgrs = length)) %>% 
  arrange(doi) -> sigacts_clean_counts

sigacts_clean_counts %>% 
  arrange(desc(mgrs_friendly), desc(mgrs_non_partner)) %>% 
  group_by(area, doi, event, sub_category, time_of_event) %>% 
  mutate(n_events = max(mgrs_friendly, mgrs_non_partner, na.rm = T)) -> sigacts_clean_counts


sigacts_clean_counts %>% 
  group_by(area, doi) %>% 
  summarize(n_events = sum(n_events)) %>% 
  ggplot(aes(x = doi, y = n_events)) + 
  geom_line(aes(group = area, color = area))

sigacts_clean %>% 
  pivot_longer(mgrs_friendly:mgrs_non_partner, names_to = "who", values_to = "mgrs") %>% 
  filter(!is.na(mgrs)) %>% 
  pivot_wider(names_from = who, values_from = mgrs, values_fn = list(mgrs = list)) %>% 
  arrange(doi) -> sigacts_clean_nested
sigacts_clean_nested %>% 
  mutate(length_np = map_int(mgrs_non_partner, length),
         length_fr = map_int(mgrs_friendly, length)) %>% 
  group_by(area, doi, time_of_event, event, sub_category) %>% 
  mutate(n_events = max(length_fr, length_np)) %>% ungroup() -> sigacts_clean_nested


sigacts_clean_nested %>% 
  filter(n_events == 1) -> unique_sigacts_clean
unique_sigacts_clean %>% 
  select(-length_np, -length_fr, -n_events) %>% 
  unnest(c(mgrs_non_partner, mgrs_friendly)) -> unique_sigacts_clean2 

sigacts_clean_nested %>% 
  filter(n_events > 1) %>% 
  select(-length_np, -length_fr, -n_events) %>% 
  mutate(row_id = row_number()) %>% 
  unnest(c(mgrs_friendly), keep_empty = T) %>% 
  unnest(c(mgrs_non_partner), keep_empty = T) %>% 
  group_by(area, event, sub_category, time_of_event, doi) %>% 
  distinct %>% 
  # ungroup() %>% 
  arrange(row_id) -> non_unique_sigacts_clean

bind_rows(unique_sigacts_clean2, select(non_unique_sigacts_clean, -row_id)) %>% 
  arrange(desc(doi), desc(time_of_event)) -> all_events_cleaned
  

all_events_cleaned %>% 
  mutate(location_np = map(mgrs_non_partner, mgrs::mgrs_to_latlng), 
         location_fr = map(mgrs_friendly, mgrs::mgrs_to_latlng)) %>% 
  unnest(c(location_np, location_fr), names_repair = "universal") %>% 
  select(1:7, lat_np = lat...9, lng_np = lng...10, lat_fr = lat...12, lng_fr = lng...13) -> all_events_cleaned_ll


leaflet(data = all_events_cleaned_ll) %>% 
  addTiles() %>% 
  addCircleMarkers(color = "red", lng = ~lng_np, lat = ~lat_np) %>% 
  addCircleMarkers(color = "blue", lng = ~lng_fr, lat = ~lat_fr)


all_events_cleaned_ll %>% 
  filter(is.na(lat_np) & is.na(lat_fr)) -> locations_both_missing

all_events_cleaned_ll %>% 
  filter(!(is.na(lat_np) & is.na(lat_fr))) -> locations_non_missing

locations_both_missing %>% 
  mutate(geocoded = map(area, geocode_OSM, as.data.frame=TRUE)) -> locations_both_missing

locations_both_missing %>% 
  unnest(c(geocoded)) %>% 
  select(area:lng_np, lat, lon) %>% 
  rename(lat_fr = lat, lng_fr = lon) -> locations_both_missing

all_events_cleaned_ll <- bind_rows(locations_both_missing, locations_non_missing)

summary(all_events_cleaned_ll)

write_csv(all_events_cleaned_ll, "dat/sigacts_cleaned.csv")

sigacts_clean %>% 
  pivot_longer(mgrs_friendly:mgrs_non_partner, names_to = "who", values_to = "mgrs") %>% 
  filter(!is.na(mgrs)) %>% 
  group_by(area, event, sub_category, time_of_event, doi, who) %>% 
  mutate(n_events = n()) %>% 
  arrange(desc(n_events))

sigacts_clean_nested %>% 
  filter(n_events > 1) %>% summarize(sum(n_events))

# check names 
sigacts_clean %>% count(area) %>% write_csv("dat/area-counts.csv")

# From Nick: 
# DML – Demilitarization Line
# IED -Improvised Explosive Device
# SAF – Small Arms Fire
# VBIED-Vehicle Borne IED (Car Bomb)
# TSO  - Turkish backed forces (not sure acronym meaning)
# SVBIED = suicide vehicle borned ied 
# MBIED = motorcycle-borne ied 
# FLOT – Forward Line of Troops
# 
# UAS – Unmanned Aerial Surveillance
# 
# MGRS Friendly – Grid location of friendly force who observed event in Military Grid Reference System format
# MGRS NonPartner – Grid location of other unit committing the act if available
# UXO = unexploded ordnance
# Sy-iz = syria - iraq? 

sigacts %>% count(AREA)
sigacts %>% count(Event)

unique(sigacts$AREA) %>% sort()
# Bashrah = Basrah ? 
# Darik = Daryik = Dayrik = Derrik ? 
# Kobane = Kobani ? 
# Raqah = Raqqa = Raqqah ?
# Suwaidon = Suwaydan ? 
# Tall Tamir/Hasakah = Hasakah ?
# Tal Ar Rafi (Manbij) = Manbij = manbij = Manbij City ?

sigacts2 <- sigacts %>% 
  janitor::clean_names() %>% 
  mutate_at(vars(mgrs_friendly, mgrs_non_partner), ~str_remove_all(., "\\W")) %>% 
  mutate_at(1:3, tolower) %>% 
  mutate(coords_friendly = map(mgrs_friendly, mgrs::mgrs_to_latlng)) %>% 
  unnest(c(coords_friendly))
sigacts2 <- sigacts2 %>% mutate(event = tolower(event))

sigacts2 %>% filter(is.na(lat)) %>% arrange(mgrs_friendly) %>% 
  mutate(length_mgrs =str_length(mgrs_friendly))

sigacts2 %>% count(event) %>% data.frame()

# idf ? 
# uxo? 


library(leaflet)
library(tmaptools)

leaflet(data = sigacts2) %>% 
  addTiles() %>% 
  addMarkers()

leaflet() %>% 
  addTiles() %>% 
  addMarkers(lat = 36.44813, lng = 37.66689, label = "Add zero") %>% 
  addMarkers(lat = 36.16836, lng = 37.67164, label = "Remove last digit") %>% 
  addMarkers(lat = 36.5294082, lng = 37.8877236, label = "Google") %>% 
  addMarkers(lat = 36.52692, lng = 37.95593, label = "Geocode OSM")


locations <- sigacts2 %>% filter(is.na(lat))%>% 
  arrange(mgrs_friendly) %>% 
  pull(area) %>% 
  unique() %>% 
  sort()

geo_locations <- tibble(loc = locations) %>% 
  mutate(coords = map(locations, geocode_OSM))

geo_locations2 <- geo_locations %>% 
  mutate(missing = map_lgl(coords, ~length(.)==0)) %>% 
  filter(!missing) %>% 
  mutate(lng = map_dbl(coords, ~.$coords[1]), 
         lat = map_dbl(coords, ~.$coords[2]))

geo_locations %>% 
  mutate(missing = map_lgl(coords, ~length(.)==0)) %>% 
  select(loc, missing) %>% write_csv("dat/missing_locations.csv")

leaflet() %>% 
  addTiles() %>% 
  addMarkers(data = sigacts2, label = ~area) %>% 
  addCircleMarkers(data = geo_locations2, color = "red", label = ~loc)

non_na_locations <- sigacts2 %>% filter(!is.na(lat)) %>% pull(area) %>% unique %>% sort
# only need to geocode these locations 
locations[!(locations %in% non_na_locations)]


geo_locations %>% filter(loc %in% locations[!(locations %in% non_na_locations)])

geo_locations %>% filter(loc %in% locations[(locations %in% non_na_locations)])


sigacts2 %>% filter(area == "manbij") %>% 
  leaflet() %>% 
  addProviderTiles(providers$Stamen.Toner) %>% 
  addMarkers()
  

# only two are missing tayannah / tayanni 
geo_locations %>%  
  filter(!missing) %>% 
  unnest()

non_na_locations


#install.packages("tmaptools")
geocode_OSM("manbij")

# where are mrgs missing in both columns? 
sigacts2 %>% filter(is.na(mgrs_friendly) & is.na(mgrs_non_partner))


sigacts2 %>% filter(area == "jurniah")


# I think that there may be repeats. mgrs friendly and non partner should  be together more than they are 

sigacts2 %>% select(area: mgrs_non_partner) %>% 
  pivot_longer(6:7, names_to = "who", values_to = "mgrs") %>% 
  filter(!is.na(mgrs)) %>% arrange(area, event, sub_category) %>% 
  pivot_wider(names_from = who, values_from = mgrs, values_fn = list(mgrs = length)) %>% 
  arrange(desc(mgrs_friendly))
