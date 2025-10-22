
dissTOM <- TOMdist((AdjDiff)^(beta1/2))
rownames(dissTOM) <- rownames(adjMatControl)
colnames(dissTOM) <- rownames(adjMatControl)
collectGarbage()

# Hierarchical clustering is performed using the 
# Topological Overlap of the adjacency difference as input distance matrix
geneTree = flashClust(as.dist(dissTOM), method = "ward");

# Plot the resulting clustering tree (dendrogram)
png(file="hierarchicalTree.png",height=1000,width=3000)
plot(geneTree, xlab="", sub="", main = "Gene clustering on TOM-based dissimilarity",labels=F, hang = 0.04);
dev.off()

#We now extract modules from the hierarchical tree.
dynamicModsHybrid = cutreeDynamic(dendro = geneTree, 
                                  distM = dissTOM,
                                  method="hybrid",
                                  cutHeight=0.96,
                                  deepSplit = T, 
                                  pamRespectsDendro = FALSE,
                                  minClusterSize = 5);

# Every module is assigned a color. 
# Note that GREY is reserved for genes which do not belong to any differentially coexpressed module
dynamicColorsHybrid = labels2colors(dynamicModsHybrid)

# The next step merges clusters which are close (see WGCNA package documentation)
mergedColor <- WGCNA::mergeCloseModules(t(cbind(datControl, datTreated)),
                                        dynamicColorsHybrid,cutHeight=.2)$color
colorh1 <- mergedColor

#reassign better colors
colorh1[which(colorh1 =="midnightblue")]<-"red"
colorh1[which(colorh1 =="lightgreen")]<-"yellow"
colorh1[which(colorh1 =="cyan")]<-"orange"
colorh1[which(colorh1 =="lightcyan")]<-"green"

# Plot the dendrogram and colors underneath
png(file="module_assignment.png",width=4000,height=1000)
plotDendroAndColors(geneTree, 
                    colorh1, 
                    "Hybrid Tree Cut",
                    dendroLabels = FALSE, 
                    hang = 0.03,
                    addGuide = TRUE, 
                    guideHang = 0.05,
                    main = "Gene dendrogram and module colors cells")
dev.off()


# create anno (needed by extractModules())
geneSymbols <- rownames(expressionMatrix)
anno <- data.frame(gene_symbol = geneSymbols)
rownames(anno) <- geneSymbols


#We write each module to an individual file containing affymetrix probeset IDs
modulesMerged <- extractModules(colorh1,
                                t(datControl),
                                anno,
                                dir="modules",
                                file_prefix=paste("Output","Specific_module",sep=''),
                                write=T)

write.table(colorh1,
            file="module_assignment.txt",
            row.names=F,col.names=F,
            quote=F)


