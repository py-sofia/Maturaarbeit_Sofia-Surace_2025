
# Convert gene symbols to Entrez IDs for each module
modulesMergedEntrez <- lapply(modulesMerged, function(gene_set) {
  result <- bitr(gene_set,
                 fromType="SYMBOL",
                 toType="ENTREZID",
                 OrgDb = org.Hs.eg.db)
  return(result$ENTREZID)
})


# Perform GO enrichment analysis for each module
enrichmentResults_ontALL <- lapply(modulesMergedEntrez, function(gene_set) {
  enrichGO(
    gene = gene_set,
    OrgDb = org.Hs.eg.db,
    keyType = "ENTREZID",
    ont = "ALL",
    pAdjustMethod = "BH",
    readable = TRUE,
    pvalueCutoff = 0.05,
    qvalueCutoff = 1)
})

