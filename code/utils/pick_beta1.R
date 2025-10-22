
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

plot(sft$fitIndices[,1], -sign(sft$fitIndices[,3])*sft$fitIndices[,2],
     xlab="Soft Threshold (power)", ylab="Scale Free Topology Model Fit, signed R^2",
     type="n", main="Scale independence")
text(sft$fitIndices[,1], -sign(sft$fitIndices[,3])*sft$fitIndices[,2],
     labels=powers, cex=0.9, col="red")
abline(h=0.85, col="red")
