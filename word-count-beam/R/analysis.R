
library(tm)
library(ggplot2)
library(ggthemes)

data <- read.csv("counts-marx-00003", h = F, sep = ":")

colnames(data)[1] <- "Word"
colnames(data)[2] <- "Count"


stopwords('english')
myStopwords <- c(stopwords('english'),
                 "The", "s", "one", "c", "In", "p", "It", "I", "l",
                 "A", "This", "But", "e", "d", "If",
                 "th", "first", "two",
                 "available", "via", "can", "must", "made", "given", "generally",
                 "may", "make", "since", "also", "know", "said", "particularly", "firstly",
                 "whether", "might", "secondly", "without", "even", "will")

plotGraph <- function(relevant, filename) {
  top.100 <- head(relevant[order(-relevant$Count),], 40)
  top.100$Word <- factor(top.100$Word, levels <- top.100$Word)
  
  
  ggplot(top.100, aes(x = Word, y = Count, group = 1)) + 
    geom_line(colour = "red") +
    geom_point(stat="identity", colour="grey50") +
    theme_bw() +
    # scale_y_continuous(breaks = seq(from=0, to=max(top.100$Count) + 1000, by=1000), minor_breaks = seq(from=0, to=max(top.100$Count) + 1000, by = 200)) +
    theme(
      axis.text.x = element_text(angle=45, vjust=1.0, hjust=1.0)      
    )
  ggsave(filename)
  
}

relevant <- data[!(data$Word %in% myStopwords),]
plotGraph(relevant, "counts-marx-plotted.png")


data.lear <- read.csv("counts-00005", h = F, sep = ":")
colnames(data.lear)[1] <- "Word"
colnames(data.lear)[2] <- "Count"
relevant <- data.lear[!(data.lear$Word %in% myStopwords),]
plotGraph(relevant, "counts-shakespear-plotted.png")
