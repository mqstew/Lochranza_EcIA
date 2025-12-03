## Ecological Impact Assessment, Arran
## North vs South Slopes
## clean ----
rm(list=ls())
## libraries ----
library(vegan)
library(ggplot2)
library(ggpubr)
library(dplyr)

## data in ----
species_counts <- read.csv("data/Arran Counts.csv")
faunal_counts <- read.csv("data/Faunal Counts.csv")
counts <- read.csv("data/Arran Data.csv")

## separate into separate groups ----
moths = subset(species_counts, select = c(moths,north_moths, south_moths))
plants = subset(species_counts, select = c(plants,north_plants, south_plants))
inverts = subset(species_counts, select = c(inverts,north_inverts, south_inverts))
mammals = subset(species_counts, select = c(mammals,north_mams, south_mams))
birds = subset(species_counts, select = c(birds,north_birds, south_birds))
### clean the separated files ----
moths <- moths[!is.na(moths$north_moths), ]
plants <- plants[!is.na(plants$north_plants), ]
inverts <- inverts[!is.na(inverts$north_inverts), ]
mammals <- mammals[!is.na(mammals$north_mams), ]
birds <- birds[!is.na(birds$north_birds), ]

## separate differently, from the differently set up frame (more columns) ----
moth_frame <- filter(counts, counts$group=="Moth")
plant_frame <- filter(counts, counts$group=="Plant")
invert_frame <- filter(counts, counts$group=="Invertebrate")
mammal_frame <- filter(counts, counts$group=="Mammal")
bird_frame <- filter(counts, counts$group=="Bird")

## diversity indices (Simpson's and Shannon's) ----
north_sim <- simpson.unb(faunal_counts$North)
south_sim <- simpson.unb(faunal_counts$South)
north_shan <- diversity(faunal_counts$North)
south_shan <- diversity(faunal_counts$South)

# north_sim
# south_sim

## graphs?? ----
ggplot(counts, aes(x=group, fill=site)) +
  geom_bar() + 
  labs(title="Observations by site for each class (from the different baseline surveys)",
       x="Class", y="Observations")
  # guides(fill="none")
## number of observations by "group" for the five main 
## classes at either site

ggplot(counts, aes(x=site, fill=group)) +
  geom_bar() + 
  labs(title="Observations by site",
       x="Class", y="Observations")


### invertebrate boxplot ----
ggplot(invert_frame, aes(x=site, y=count)) +
  geom_boxplot() + guides(colour="none") +
  scale_y_continuous(limits=c(0, 25)) +
  labs(title="Invertebrate numbers at both sites", 
       x="Site", y="Observations")
## invertebrate observations
## removes spiders and ticks from South slope as extreme outlier


### moth boxplot ----
ggplot(moth_frame, aes(x=site, y=count)) +
  geom_boxplot() + guides(colour="none") +
  scale_y_continuous(limits=c(0, 7.5)) +
  labs(title="Moth numbers at both sites", 
       x="Site", y="Observations")
## adding limits discounts the Square Spot Rustic from both sides

### bird boxplot ----
ggplot(bird_frame, aes(x=site, y=count)) +
  geom_boxplot() + guides(colour="none") +
  # scale_y_continuous(limits=c(0, 10)) +
  labs(title="Bird numbers at both sites", 
       x="Site", y="Observations")
## limits remove Jackdaw and Pigeon from the North site

### mammal boxplot (kind of useless) ----
ggplot(mammal_frame, aes(x=site, y=count)) +
  geom_boxplot() + guides(colour="none") +
  # scale_y_continuous(limits=c(0, 10)) +
  labs(title="Mammal numbers at both sites", 
       x="Site", y="Observations")
## not a worthwhile graph, very low numbers on both sites
ggplot(mammal_frame, aes(x=site, fill=site)) +
  geom_bar() + guides(fill="none")+
  labs(title="Observation of Mammal species by site",
     x="Site", y="Observations")


### plant boxplot ----
ggplot(plant_frame, aes(x=site, y=count)) +
  geom_boxplot() + guides(colour="none") +
  scale_y_continuous(limits=c(0, 20)) +
  labs(title="Plant numbers at both sites", 
       x="Site", y="Observations")
## adding limits removes Nardus grass observations from South slope

## barplots by class ----
plant_bar<- ggplot(plant_frame, aes(x=site, fill=site)) +
  geom_bar() + guides(fill="none")+ 
  labs(title="A. Observation of Plant species by site",
       x="Site", y="Observations")
moth_bar<- ggplot(moth_frame, aes(x=site, fill=site)) +
  geom_bar() + guides(fill="none") +
  labs(title="B. Observation of Moth species by site",
       x="Site", y="Observations")
bird_bar<- ggplot(bird_frame, aes(x=site, fill=site)) +
  geom_bar() + guides(fill="none") + 
  labs(title="C. Observation of Bird species by site",
       x="Site", y="Observations")
invert_bar<- ggplot(invert_frame, aes(x=site, fill=site)) +
  geom_bar() + guides(fill="none") + 
  labs(title="D. Obs. of Invertebrate species by site",
       x="Site", y="Observations")

ggarrange(plant_bar, moth_bar, bird_bar, invert_bar, ncol=2, nrow=2, align="h")
