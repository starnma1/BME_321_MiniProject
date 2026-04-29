#########################################################
######## Part 2 - Colour change experiment ##############
#########################################################

library(lme4)
library(lmerTest)
library(lsmeans)

################## GOBY VISION##########################
## preparing data
colchange_goby_data<-read.csv("data_all_goby.csv", header=TRUE)
head(colchange_goby_data)

# defining the factors
colchange_goby_data$colour<-as.factor(colchange_goby_data$colour)
colchange_goby_data$day<-as.factor(colchange_goby_data$day)

#########################################################################
################################## HUE ##################################
#########################################################################

### Subseting colour types
data_green_goby<-colchange_goby_data[colchange_goby_data$colour=="green",]
data_red_goby<-colchange_goby_data[colchange_goby_data$colour=="red",]

########## ANALYSIS FOR THE GREEN COLOUR FORM ##########################

# first model including size as a cofactor
m1_goby_g_hue<-lmer(hue~day+size+(1|prawn.id),
                    na.action = na.omit,data_green_goby)
# second model without size 
m2_goby_g_hue<-lmer(hue~day+(1|prawn.id),
                    na.action = na.omit,data_green_goby)

# comparing the two models
anova(m1_goby_g_hue,m2_goby_g_hue)
# let's keep model 1 since size improve model's fitting
# model output
anova(m1_goby_g_hue)
summary(m1_goby_g_hue)
# testing model assumptions
qqnorm(residuals(m1_goby_g_hue))
qqline(residuals(m1_goby_g_hue))
# a posteriori Tukey test
goby_hue_green_tukey<-lsmeans(m1_goby_g_hue,~day)
pairs(goby_hue_green_tukey)

########## ANALYSIS FOR THE RED COLOUR FORM ##########################

# first model including size as a cofactor
m1_goby_r_hue<-lmer(hue~day+size+(1|prawn.id),
                    na.action = na.omit,data_red_goby)
# second model without size 
m2_goby_r_hue<-lmer(hue~day+(1|prawn.id),
                    na.action = na.omit,data_red_goby)

# comparing the two models
anova(m1_goby_r_hue,m2_goby_r_hue)
# size did not improve model fitting
# let's stay with the simpler model
# model output
anova(m2_goby_r_hue)
# testing model assumptions
qqnorm(residuals(m2_goby_r_hue))
qqline(residuals(m2_goby_r_hue))
# a posteriori Tukey test
goby_hue_red_tukey<-lsmeans(m2_goby_r_hue,~day)
pairs(goby_hue_red_tukey)

#########################################################################
################################## JND ##################################
#########################################################################

########## ANALYSIS FOR THE GREEN COLOUR FORM ##########################

# first model including size as a cofactor
m1_goby_g_jnd<-lmer(log(jnd)~day+size+(1|prawn.id),
                    na.action = na.omit,data_green_goby)
# second model without size 
m2_goby_g_jnd<-lmer(log(jnd)~day+(1|prawn.id),
                    na.action = na.omit,data_green_goby)
# comparing the two models
anova(m1_goby_g_jnd,m2_goby_g_jnd) # size is important
# let's keep model 1 since size improve model's fitting
# model output
anova(m1_goby_g_jnd)

#testing model assumptions
qqnorm(residuals(m1_goby_g_jnd))
qqline(residuals(m1_goby_g_jnd))
# a posteriori Tukey test
goby_jnd_green_tukey<-lsmeans(m1_goby_g_jnd,~day)
pairs(goby_jnd_green_tukey)

########## ANALYSIS FOR THE RED COLOUR FORM ##########################

# first model including size as a cofactor
m1_goby_r_jnd<-lmer(jnd~day+size+(1|prawn.id),
                    na.action = na.omit,data_red)
# second model without size 
m2_goby_r_jnd<-lmer(jnd~day+(1|prawn.id),
                    na.action = na.omit,data_red)
# comparing the two models
anova(m1_goby_r_jnd,m2_goby_r_jnd) # size is not important
# let's keep model 2
# model output
anova(m2_goby_r_jnd)

# testing model assumptions 
qqnorm(residuals(m2_goby_r_jnd))
qqline(residuals(m2_goby_r_jnd))
# a posteriori Tukey test
goby_jnd_red_tukey<-lsmeans(m2_goby_r_jnd,~day)
pairs(goby_jnd_red_tukey)
