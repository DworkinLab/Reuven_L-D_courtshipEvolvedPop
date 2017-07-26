
#require("rio")
#convert("./Courtship FINAL.xlsx", "Courtship_FINAL.txt")
require(lme4)
require(ggplot2)

court <- read.table("Courtship_FINAL.txt", h=T)

gg1 <- ggplot(court, aes(x=Phase, y=P_court, colour=Trt))
gg1 + geom_boxplot()  
  
stuff <- glm(P_court ~ Trt*Phase, data=court)
summary(stuff)
