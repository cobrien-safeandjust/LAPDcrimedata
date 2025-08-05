library(tidyverse)
library(tidylog)
# this repository is forked from https://github.com/gregridgeway/LAPDcrimedata/tree/master/METROdata

data <- read.csv("LAPD crime counts 1988-2014 merged.csv")

watts <- c(1826,
           1835,
           1836,
           1837,
           1846,
           1827,
           1829,
           1838,
           1839,
           1849 ) # With Anne's help, we were able to identify which reporting districts were in Watts.


data <- data |> 
  filter(rd %in% watts)

data <- data |> 
  group_by(rd, year) |> 
  summarise(across(where(is.numeric), ~sum (.x)))

watts_homicides <- data |> 
  group_by(year) |> 
  summarise(homicides = sum(HOM)) |> 
  mutate(change_from_1992 = (homicides - 37)/37)

write.csv(watts_homicides, "watts homicides by year.csv")







data <- data |> 
  group_by(rd, year) |> 
  summarise(across(where(is.numeric), ~sum (.x)))

rd_homicides <- data |> 
  group_by(rd) |> 
  mutate(homicides = HOM,
         homicides_1992 = HOM[year == 1992]) |> 
  ungroup() |> 
  mutate(change_from_1992 = (homicides - homicides_1992)/homicides_1992)
  
  
  group_by(rd) |> 
  mutate(homicides_1992 = homicides[year == 1992],
         change_from_1992 = (homicides - homicides_1992) / homicides_1992)


