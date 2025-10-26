
powers <- c(seq(1,10,1), seq(12,20,2))

sft_no_similarity$powerEstimate


sft = pickSoftThreshold.fromSimilarity(
  similarity = AdjDiff,
  powerVector = powers,
  RsquaredCut = 0.5,
  moreNetworkConcepts = TRUE,
  verbose = 5);

beta1 <- sft$powerEstimate # optimal beta1, but NA
beta1 <- 3 # hand-picked

head(sft$fitIndices)

png("results/scale_free_topology_model.png", width = 1200, height = 700, res = 150)
plot(sft$fitIndices[,1], -sign(sft$fitIndices[,3])*sft$fitIndices[,2],
     xlab="Soft Threshold (power)", ylab="Scale Free Topology Model Fit, signed R^2",
     type="n")
text(sft$fitIndices[,1], -sign(sft$fitIndices[,3])*sft$fitIndices[,2],
     labels=powers, cex=0.9, col="red")
abline(h=0.85, col="red")
dev.off()



################################################################################


degTest <- degree(netTest, mode = "all")
degControl <- degree(netControl, mode = "all")

freqControl <- as.data.frame(table(as.numeric(degControl)))
freqControl$degree <- as.numeric(as.character(freq$Var1))

freqTest <- as.data.frame(table(as.numeric(degTest)))
freqTest$degree <- as.numeric(as.character(freqTest$Var1))

png("results/degree_distribution.png", width = 1200, height = 500, res = 150)
par(mfrow = c(1, 2))

plot(
  log1p(freqControl$degree), log1p(freqControl$Freq),
  pch = 19, cex = 0.7, col = rgb(0.1, 0.6, 0.1, 0.4),      
  main = "netControl",
  xlab = "log1p(Degree)", ylab = "log1p(Frequency)", las = 1, bty = "l")

plot(
  log1p(freqTest$degree), log1p(freqTest$Freq),
  pch = 19, cex = 0.7, col = rgb(0.1, 0.6, 0.1, 0.4),      
  main = "netTest",
  xlab = "log1p(Degree)", ylab = "log1p(Frequency)", las = 1, bty = "l")

dev.off()



