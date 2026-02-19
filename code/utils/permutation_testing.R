# code from DiffCoEx supplementary files
# principle from Choi and Kendziorski 2009



# compute dispersion value between a pair of modules c1 and c2
dispersionModule2Module <- function(c1, c2, datC1, datC2, colorh1C1C2) 
{
  
  """
  logic: 
  c1 == c2 --> involved_genes only contains genes from one module
           --> bc3net only builds network from these genes
           --> matrix shows how the module interacts with itself
  c1 != c2 --> involved_genes combines genes from both modules
           --> bc3net builds network with both sets of genes
           --> matrix shows how c1 and c2 interact with themselves and with each other 
  """
  
  genes_c1 <- which(colorh1C1C2 == c1)
  genes_c2 <- which(colorh1C1C2 == c2)
  involved_genes <- unique(c(genes_c1, genes_c2))
  
  net1 <- bc3net(datC1[, involved_genes], estimator="spearman", boot=100)
  net2 <- bc3net(datC2[, involved_genes], estimator="spearman", boot=100)
  adj1 <- as_adjacency_matrix(net1, attr="weight", sparse=F)
  adj2 <- as_adjacency_matrix(net2, attr="weight", sparse=F)

  difCor <- (abs(adj1 - adj2)/2)^(beta1/2)


  n <- length(involved_genes) # num of genes in module
  
  # calculate Root Mean Square (RMS) of difference for unique gene pairs
  (1/((n^2 -n)/2)*(sum(difCor)/2))^(.5)
  
}

# generate 1000 sets of random indices to swap samples between C1 and C2
permutations <- NULL 
for (i in 1:1000) {  permutations <- rbind(permutations, 
                        sample(1:(nrow(datC1) + nrow(datC2)), nrow(datC1))) }

# combine and scale the data to mean 0 and variance 1
d <- rbind(scale(datC1),scale(datC2))

# dispersion value of module to module change
permutationProcedureModule2Module <- function(permutation, d, c1, c2, colorh1C1C2)
{
  # create two "fake" conditions
  d1 <- d[permutation,]
  d2 <- d[-permutation,]
  dispersionModule2Module(c1, c2, d1, d2, colorh1C1C2)
}



################################################################################

# compute all pairwise module to module dispersion values
# generate null distribution from permuted scaled data

dispersionMatrix <- matrix(nrow=length(unique(colorh1C1C2))-1,
                           ncol=length(unique(colorh1C1C2))-1)
nullDistrib <- list()
i <- j <- 0

# loop through every module but grey
for (c1 in setdiff(unique(colorh1C1C2),"grey")) 
{
  i <- i+1 
  j <- 0
  nullDistrib[[c1]]<-list()
  for (c2 in setdiff(unique(colorh1C1C2),"grey"))
  {
    j <- j+1
    # compute "real" observed value
    dispersionMatrix[i,j] <- dispersionModule2Module(
      c1, c2, datC1, datC2, colorh1C1C2) 
    # compute "fake" randomly generated value
    nullDistrib[[c1]][[c2]] <- apply(
      permutations, 1, permutationProcedureModule2Module, d, c2, c1, colorh1C1C2)
  }
}





# summary matrix: number of permuted data yielding for each module to module diffcoex

permutationSummary<-matrix(nrow=7,ncol=7) # hard coded for number of modules!

colnames(permutationSummary)<-setdiff(unique(colorh1C1C2),"grey")
rownames(permutationSummary)<-setdiff(unique(colorh1C1C2),"grey")

# how many random trials produced a larger value than actually observed?
# could be simplified to not run e.g. c1/c2 and c2/c1 twice
for (i in 1:7) { for (j in 1:7) {permutationSummary[i,j] <- 
  length(which(nullDistrib[[i]][[j]] >= dispersionMatrix[i,j]))} }



plotMatrix(permutationSummary)

# interpretation:
# low values (0-50): significant (few random shuffles beat real data)
# high values (>50): insignificant 