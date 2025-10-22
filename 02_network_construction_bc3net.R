
netControl <- bc3net(datControl, verbose=TRUE, estimator="spearman", boot=100)
netTest <- bc3net(datTreated, verbose=TRUE, estimator="spearman", boot=100)
# ca. 24h to run 

save(netControl, file = "netControl.RData")
save(netTest, file = "netTest.RData")


adjMatControl <- as_adjacency_matrix(netControl, attr="weight", sparse=F)
adjMatTreated <- as_adjacency_matrix(netTest, attr="weight", sparse=F)

genesTreated <- V(netTest)$name # get the names of all the treated genes
adjMatControl <- adjMatControl[genesTreated, genesTreated] # only keep genes present in treated

collectGarbage()