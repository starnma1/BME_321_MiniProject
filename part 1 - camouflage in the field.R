#########################################################
### Part 1 - Camouflage in the field ####################
#########################################################

library(lme4)
library(lmerTest)
library(lsmeans)

jnd_field_goby<-read.csv("jnd_field_goby.csv",header=T)
jnd_field_pollack<-read.csv("jnd_field_pollack.csv",header=T)

# defining all factors
jnd_field_goby$seaweed<-factor(jnd_field_goby$seaweed,levels=c("lettuce","dulse"))
jnd_field_goby$morph<-factor(jnd_field_goby$morph,levels=c("G","R"))
jnd_field_goby$ID<-as.factor(jnd_field_goby$ID)

jnd_field_pollack$seaweed<-factor(jnd_field_pollack$seaweed,levels=c("lettuce","dulse"))
jnd_field_pollack$morph<-factor(jnd_field_pollack$morph,levels=c("G","R"))
jnd_field_pollack$ID<-as.factor(jnd_field_pollack$ID)

## analysing prawn JNDs - Goby vision ##
# defining the first model: morph and seaweed as fixed factor and interacting
# and prawn ID as a random factor
model_goby_1<-lmer(jnd~morph*seaweed + (1|ID),data=jnd_field_goby)
summary(model_goby_1)
# testing whether the interaction between morph and seaweed is important
model_goby_2<-lmer(jnd~morph+seaweed+(1|ID),data=jnd_field_goby)
summary(model_goby_2)
# comparing the two models
anova(model_goby_2,model_goby_1)
# interaction is important - we need to keep it in the model
# model 1 is the best
anova(model_goby_1)
# testing model assumptions - residual analysis
qqnorm(resid(model_goby_1))
qqline(resid(model_goby_1))
# a posteriori Tukey test - comparing JND values between seaweeds
# within each prawn colour form
jnd_goby_tukey<-lsmeans(model_goby_1, ~ seaweed|morph)
pairs(jnd_goby_tukey)

## analysing prawn JNDs - Pollack vision ##
# the analysis below are the same than those for goby vision
model_pollack_1<-lmer(jnd~morph*seaweed + (1|ID),data=jnd_field_pollack)
summary(model_pollack_1)
model_pollack_2<-lmer(jnd~morph+seaweed+(1|ID),data=jnd_field_pollack)
summary(model_pollack_2)

anova(model_pollack_2,model_pollack_1)
anova(model_pollack_1)

qqnorm(resid(model_pollack_1))
qqline(resid(model_pollack_1))

jnd_pollack_tukey<-lsmeans(model_pollack_1, ~ seaweed|morph)
pairs(jnd_pollack_tukey)