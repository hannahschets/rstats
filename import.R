## Import data ##

# Packages
library(tidyverse)

df <- read_csv("data-raw/correspondence-data-1585.csv")
glimpse(df)
nrow(df)
ncol(df)
summary(df)
df <- read_csv("data-raw/Rectagular Data.csv")
summary(df)
library(tidyverse)
library(here)
interviews <- read_csv(here("data-raw", "SAFI_clean.csv"), na = "NULL")
glimpse(interviews)
nrow(interviews)
ncol(interviews)
summary(interviews)
# select, filter, mutate, group_by, summarise, arrange
# select: columns
select(interviews, key_ID, village, no_membrs)
select(interviews, -liv_count)
select(interviews, key_ID:rooms)
#filter
filter(interviews, village == "Chirodzo")
chirodzo <- filter(interviews, village == "Chirodzo")
chirodzo <- select(chirodzo, -village)

#Pipes: Multiple functions at once
filter(interviews, village == "Chirodzo", rooms > 1)
filter(interviews, village == "Chirodzo" | village == "Ruaca")

# Nested functions 
select(filter(interviews, village == "Chirodzo"), -village)

#Pipe
interviews |> 
  filter(village == "Chirodzo") |> 
  select(-village)
         

# mutate: create new columns 
interviews |> mutate(per_room = no_membrs / rooms) |>  select(village, no_membrs, rooms, per_room)

interviews |> mutate(interview_date = as_date(interview_date))

interviews <- interviews |> mutate(interview_date = as_date(interview_date))


#summarize
interviews |> summarise(mean_membrs = mean(no_membrs))


# extract column
no_membrs <- interviews$no_membrs
mean(no_membrs)



# group by and summarize
interviews |> group_by(village) |> summarise(mean_membrs = mean(no_membrs))

interviews |> summarise(mean_membrs = mean(no_membrs), .by = village)

interviews |> 
  filter(is.na(memb_assoc)) |> 
  summarise(mean_membrs = mean(no_membrs),
                        min_membrs = min(no_membrs),
                        n = n(),
                       .by = c(village, memb_assoc))


interviews |> summarise(n = n(), .by = village)


                        