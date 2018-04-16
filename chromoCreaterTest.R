require(dplyr)
require(ggplot2)

ddatX <- read.csv('Chromosome_X.csv', h=T)
chr_X <- ddatX %>%
  group_by(position, chr, Effects) %>%
  summarise(meanpvalue = mean(p.value), meanlog_p = -log10(mean(p.value)), maxpvalue = max(p.value), minlog_p = -log10(max(p.value)))
a <- nrow(chr_X)
chr_X$number <- 1:a
str(chr_X)

ddat2L <- read.csv('Chromosome_2L.csv', h=T)
chr_2L <- ddat2L %>%
  group_by(position, chr, Effects) %>%
  summarise(meanpvalue = mean(p.value), meanlog_p = -log10(mean(p.value)), maxpvalue = max(p.value), minlog_p = -log10(max(p.value)))

b <- nrow(chr_2L)
chr_2L$number <- (a+1):(a+b)


ddat2R <- read.csv('Chromosome_2R.csv', h=T)
chr_2R <- ddat2R %>%
  group_by(position, chr, Effects) %>%
  summarise(meanpvalue = mean(p.value), meanlog_p = -log10(mean(p.value)), maxpvalue = max(p.value), minlog_p = -log10(max(p.value)))
c <- nrow(chr_2R)
chr_2R$number <- (a+b+1):(a+b+c)


ddat3L <- read.csv('Chromosome_3L.csv', h=T)
chr_3L <- ddat3L %>%
  group_by(position, chr, Effects) %>%
  summarise(meanpvalue = mean(p.value), meanlog_p = -log10(mean(p.value)), maxpvalue = max(p.value), minlog_p = -log10(max(p.value)))
d <- nrow(chr_3L)
chr_3L$number <- (a+b+c+1):(a+b+c+d)

ddat3R <- read.csv('Chromosome_3R.csv', h=T)
chr_3R <- ddat3R %>%
  group_by(position, chr, Effects) %>%
  summarise(meanpvalue = mean(p.value), meanlog_p = -log10(mean(p.value)), maxpvalue = max(p.value), minlog_p = -log10(max(p.value)))
e <- nrow(chr_3R)
chr_3R$number <- (a+b+c+d+1):(a+b+c+d+e)

ddat4 <- read.csv('Chromosome_4.csv', h=T)
chr_4 <- ddat4 %>%
  group_by(position, chr, Effects) %>%
  summarise(meanpvalue = mean(p.value), meanlog_p = -log10(mean(p.value)), maxpvalue = max(p.value), minlog_p = -log10(max(p.value)))
f <- nrow(chr_4)
chr_4$number <- (a+b+c+d+e+1):(a+b+c+d+e+f)

require(plyr)
CHROMOs <- rbind.fill(chr_X, chr_2L, chr_2R, chr_3L, chr_3R, chr_4)

#png("CHROMOS.png", width = 1000, height = 600)

#gdat <- ggplot(data = CHROMOs, aes(x=number, y=meanlog_p, colour = chr))
#gdat2 <- gdat + geom_point(size = 0.5, show.legend = F) + 
#geom_hline(yintercept = -log10(0.05)) +
#  theme(panel.background = element_blank()) +
#  xlab("Chromosome") +
#  scale_x_discrete(limits=c(a/2, a+(b/2), (a+b+ (c/2)), (a+b+c+(d/2)), (a+b+c+d+(e/2)), (a+b+c+d+e+(f/2))), labels = c("X", "2L", '2R', '3L', "3R", "4")) +
#  scale_colour_manual(values=c("#56B4E9", "#E69F00", 'grey30', 'grey46', 'wheat3', 'lemonchiffon4')) +
#ggtitle(Title) +
#  theme(text = element_text(size=20), 
#        axis.text.x= element_text(size=15), axis.text.y= element_text(size=15)) +
#  ylab("-log10(p)")
#gdat2


#dev.off()
#ggsave("CHROMOS.png")


#rm(gdat2)
#rm(gdat)


CHROMOs <- transform(CHROMOs, quant=cut(meanlog_p, quantile(meanlog_p, c(0,.99,.9999,1)), c("0-99", "99-99.99", "99.99-100"), TRUE))

gdat <- ggplot(data = CHROMOs, aes(x=position, y=meanlog_p))
gdat2 <- gdat + geom_point(aes(colour = quant), size = 0.5, show.legend = F) + 
  #geom_hline(yintercept = -log10(0.05)) +
  scale_colour_manual(values = c("grey65", "grey35", "green")) +
  theme(panel.background = element_blank()) +
  geom_vline(xintercept = a) +
  geom_vline(xintercept = a+b) +
  geom_vline(xintercept = a+b+c) +
  geom_vline(xintercept = a+b+c+d) +
  geom_vline(xintercept = a+b+c+d+e) +
  geom_vline(xintercept = a+b+c+d+e+f) +
  scale_x_discrete(limits=c(a/2, a+(b/2), (a+b+ (c/2)), (a+b+c+(d/2)), (a+b+c+d+(e/2)), (a+b+c+d+e+(f/2))), labels = c("X", "2L", '2R', '3L', "3R", "4")) +
  theme(text = element_text(size=20), 
        axis.text.x= element_text(size=15), axis.text.y= element_text(size=15)) +
  
  ylab("-log10(p)")

#print(gdat2)


ggsave("colours.png")