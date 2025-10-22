

library(clusterProfiler)
library(org.Hs.eg.db)
library(enrichplot) 



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






dir.create("results/GO_enrichment_tables", showWarnings = FALSE)

lapply(names(enrichmentResults_ontALL), function(module_name) {
  obj <- enrichmentResults_ontALL[[module_name]]
  # Ensure object is valid and contains results
  if (!is.null(obj) && inherits(obj, "enrichResult")) {
    res <- obj@result
    if (!is.null(res) && nrow(res) > 0) {
      write.csv(res,
                file = file.path("results/GO_enrichment_tables",
                                 paste0("GO_enrichment_", module_name, ".csv")),
                row.names = FALSE)
    }
  }
})




top_enrichments <- do.call(rbind, lapply(names(enrichmentResults_ontALL), function(module_name) {
  # skip the grey module
  if (tolower(module_name) == "grey") return(NULL)
  res <- enrichmentResults_ontALL[[module_name]]@result
  if (!is.null(res) && nrow(res) > 0) {
    res <- res[order(res$p.adjust), ]
    res <- head(res, 3)  # top 3 per module
    res$Module <- module_name
    return(res[, c("Module", "ID", "Description", "ONTOLOGY", "p.adjust")])
  } else {
    # if no enrichment results
    return(data.frame(
      Module = module_name,
      ID = NA,
      Description = "No significant enrichment",
      ONTOLOGY = NA,
      p.adjust = NA,
      stringsAsFactors = FALSE
    ))
  }
}))

write.csv(top_enrichments, "results/GO_enrichment_tables/GO_enrichment_summary.csv", row.names = FALSE)
