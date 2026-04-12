# 1. Define paths and identify significant genes from your analysis
# Filter tT for significance (e.g., adj.P.Val < 0.05)
sig_genes <- tT$Gene.symbol[tT$adj.P.Val < 0.05]
sig_genes <- unique(na.omit(sig_genes))

module_path <- "results/modules"
module_files <- list.files(module_path, pattern = "\\.txt$", full.names = TRUE)

# 2. Loop through each file and compare
results_list <- lapply(module_files, function(file) {
  # Read gene list (assumes one gene per line)
  module_genes <- readLines(file)
  module_genes <- unique(trimws(module_genes))
  
  # Find overlapping genes
  common_genes <- intersect(sig_genes, module_genes)
  
  # Return a summary row
  data.frame(
    Module_File = basename(file),
    Module_Size = length(module_genes),
    Overlap_Count = length(common_genes),
    Overlapping_Genes = paste(common_genes, collapse = ", "),
    stringsAsFactors = FALSE
  )
})

# 3. Combine and view results
comparison_df <- do.call(rbind, results_list)
print(comparison_df)

# Optional: Save the comparison to a CSV
write.csv(comparison_df, "results/validation/module_overlap_results_GSE55235.csv", row.names = FALSE)
