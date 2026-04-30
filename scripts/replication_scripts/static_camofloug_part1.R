rm(list = ls())

## Recplicability script ##

# Load libraries

  library(ggplot2)
  library(pastecs)
  library(performance)
  library(lme4)
  library(ggeffects)
  library(tidyverse)
  library(GGally)
  library(ggpubr)
  
# Load the screen Data ----

  dd_goby <- read.csv("data/static_camouflage/jnd_field_goby.csv", stringsAsFactors = T)
  dd_pollack <- read.csv("data/static_camouflage/jnd_field_pollack.csv", stringsAsFactors = T)  

  # Screen data
  str(dd_goby)
  str(dd_pollack) 
  glimpse(dd_goby)
  glimpse(dd_pollack)  
  
    # Data is already nicely cleaned and no wrangaling is needed.

# Numerical Exploration ----

  # Summary stats
  round(stat.desc(dd_goby, norm = T), 2)
  round(stat.desc(dd_pollack, norm = T), 2)
  
  sapply(dd_goby, as.numeric) %>% cor() %>% round(2)
  sapply(dd_pollack, as.numeric) %>% cor() %>% round(2)
  
    # The normality assumption for the outcome variable seems to 
    # be heavily violated. There is also no immediate colinearity
    # or correlating predictors. Lets visualize the data some more. 
  
  ggpairs(dd_goby)
  ggpairs(dd_pollack)
  
    # The data is heavily skewed and has a lot of outliers. 
    # We will need to log transform the data before we can run any models.  

  hist(log(dd_goby$jnd))
  hist(log(dd_pollack$jnd))
  
    # Log transforming did not work, but the outcome has heavy tails
    # and has no negative values indicating a gamma distribution is better
    # then the normal distribution.
  
  # Finally check the variances increase with the group with higher median
  # , this is final straw for gamma
  ggplot(dd_goby, aes(x = seaweed, y = jnd)) + geom_boxplot()
  ggplot(dd_pollack, aes(x = morph, y = jnd)) + geom_boxplot()
  
# Fit research question plot 
  p1 <- ggplot(dd_goby, aes(x = seaweed, y = jnd, col = morph)) + 
    geom_boxplot()
  
  p2 <- ggplot(dd_pollack, aes(x = seaweed, y = jnd, col = morph)) + 
    geom_boxplot()

  ggarrange(p1, p2, common.legend = T)
  
# Fit the models ----
  library(glmmTMB)
  
  mod.1.goby <- glmmTMB(jnd ~ morph * seaweed + (1|ID),
          family = Gamma(link = "log"),
          data = dd_goby)
  mod.1.pollack <- glmmTMB(jnd ~ morph * seaweed + (1|ID),
                           family = Gamma(link = "log"),
                           data = dd_pollack)
  
  check_model(mod.1.goby)
  check_model(mod.1.pollack)
  
    # The model assumptions are not met, but we have no other options. 
    # We will proceed with the analysis, but we should be careful with
    # the interpretation of the results.

  # Model Summaries ----
  summary(mod.1.goby)
  summary(mod.1.pollack)
  
    # The interaction is not significant, but the main effects are. 
    # We will need to run post-hoc tests to see which groups are different.
  
  
  library(emmeans)
  
  jnd_goby <- emmeans(mod.1.goby, ~ seaweed | morph, type = "response")
  pairs(jnd_goby)
  
  jnd_pollack<-lsmeans(mod.1.pollack, ~ seaweed|morph, type = "response")  
  pairs(jnd_pollack)  
  