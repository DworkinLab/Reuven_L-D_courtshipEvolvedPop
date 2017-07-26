
#require("rio")
#convert("./Courtship FINAL.xlsx", "Courtship_FINAL.txt")
require(lme4)
require(ggplot2)
require(effects)
require(car)

court <- read.table("Courtship_FINAL.txt", h=T)
head(court)

gg1 <- ggplot(court, aes(x=Phase, y=P_court, colour=Trt))
gg1 + geom_boxplot()  
  
stuff <- glm(P_court ~ Trt*Phase + (1|Day) , data=court)
summary(stuff)
plot(allEffects(stuff))





stuff2 <- lmer(C_dur ~ Trt + Phase + Phase:Trt + Trt:Population + (1|Day), data=court)

#stuff2 <- lmer(P_court ~ Trt + Phase + Phase:Trt + Trt:Population + (1|Day), data=court)
summary(stuff2)
car::Anova(stuff2)
plot(allEffects(stuff2))


stuff_plot <- effect("Trt*Phase", stuff2)
stuff_plot <- as.data.frame(stuff_plot)
head(stuff_plot)
stuff_plot2 <- ggplot(stuff_plot, 
                       aes(y=fit, x=Phase, colour=Trt))

stuff_plot3 <- stuff_plot2 + 
  geom_point(stat="identity", 
             position=position_dodge(0.5)) + 
  geom_linerange(aes(ymin=lower, ymax=upper), 
                 position = position_dodge(0.5)) + 
  labs(y="Intercept", 
       x="Phase") +
  ggtitle("Evolved Population") + 
  scale_colour_manual(values=
                        c("#999999", "#56B4E9", "#E69F00"))
print(stuff_plot3)

#Same layout with P_court or C_dur
#stuff_plot4 <- stuff_plot3
print(stuff_plot4)
