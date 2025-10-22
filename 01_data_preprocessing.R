library(WGCNA)
library(RColorBrewer) 
library(preprocessCore) 
library(igraph)
library(bc3net)
library(infotheo)
library(moduleColor)
library(flashClust)
library(ComplexHeatmap)
library(scales)
library(ggplot2)
library(dplyr)



expressionMatrix <- read.csv("GSE128816.csv")

rownames(expressionMatrix) <- expressionMatrix[, 1]  # Set gene symbols as row names
expressionMatrix <- as.matrix(expressionMatrix[, 3:ncol(expressionMatrix)])  # Remove first two columns


normData <- normalize.quantiles(log2(expressionMatrix +1)) # +1 to avoid log(0)

dimnames(normData) <- list(rownames(expressionMatrix), colnames(expressionMatrix))


datControl <- normData[, 1:10]  ### control group
datTreated <- normData[, 11:20] ### treatment group


