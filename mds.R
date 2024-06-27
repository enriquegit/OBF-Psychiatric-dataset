# Script used to generate the MDS plot.

# Path to the directory where the features.csv file is contained.
path = "../processed/"

dataset <- read.csv(paste0(path,"features.csv"),stringsAsFactors = T)

dataset <- dataset[,-1]

colNames <- names(dataset)

cols <- as.integer(dataset$class)

labels <- unique(dataset$class)

d <- dist(dataset[,-ncol(dataset)])

fit <- cmdscale(d, k = 2) # k is the number of dimensions.

x <- fit[,1]; y <- fit[,2]

pdf("mds2D.pdf", width = 7, height = 4)
plot(x, y, xlab="Coordinate 1", ylab="Coordinate 2", main="MDS of features", pch=19, col=cols, cex=0.7)

legend("bottomleft",legend = labels, pch=19, col=unique(cols), cex=0.7, horiz = F)
dev.off()
