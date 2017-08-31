
#require("rio")
#convert("./Courtship FINAL.xlsx", "Courtship_FINAL.txt")
require(lme4)
require(ggplot2)
require(effects)
require(car)

court <- read.table("Courtship_FINAL.txt", h=T)
head(court)
court$Treatment <- ifelse(court$Trt=="P", 
                            "Mantids", 
                            ifelse(court$Trt=="C",
                                   "Control", "Spiders"))

court$Treatment <- as.factor(court$Treatment)

court$Phase <- ifelse(court$Phase=="Dark", "dark", "light")
court$Phase <- as.factor(court$Phase)

gg1 <- ggplot(court, aes(x=Phase, y=P_court, colour=Treatment))
gg1 + geom_boxplot()  
  
stuff <- glm(P_court ~ Treatment*Phase + (1|Day) , data=court)
summary(stuff)
car::Anova(stuff)
plot(allEffects(stuff))





#stuff2 <- lmer(C_dur ~ Trt + Phase + Phase:Trt + Trt:Population + (1|Day), data=court)

stuff2 <- lmer(P_court ~ Treatment*Phase + Treatment:Population + Observer + (1|Day), data=court)
summary(stuff2)
car::Anova(stuff2)
plot(allEffects(stuff2))


stuff_plot <- effect("Treatment*Phase", stuff2)
stuff_plot <- as.data.frame(stuff_plot)
head(stuff_plot)
stuff_plot2 <- ggplot(stuff_plot, 
                       aes(y=fit, x=Phase, colour=Treatment))

stuff_plot3 <- stuff_plot2 + 
  geom_point(stat="identity", 
             position=position_dodge(0.5), size=3) + 
  geom_linerange(aes(ymin=lower, ymax=upper), 
                 position = position_dodge(0.5), size=1.5) + 
  labs(y="Proportion", 
       x="Phase") +
  #ggtitle("Evolved Population") + 
  theme(text = element_text(size=20), 
        axis.text.x= element_text(size=15), axis.text.y= element_text(size=15)) +
  scale_colour_manual(values=
                        c("#999999", "#56B4E9", "#E69F00"))

print(stuff_plot3)

#Same layout with P_court or C_dur
#stuff_plot4 <- stuff_plot3
#print(stuff_plot4)
