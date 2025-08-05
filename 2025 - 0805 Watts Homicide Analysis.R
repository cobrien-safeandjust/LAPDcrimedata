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


plot(LAPDmap.new)
library(sf) 
ls()
library(sp)
plot(map_data)
