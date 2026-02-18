
read_gene_list <- function(file) {
  unique(trimws(readLines(file)))
}

up <- read_gene_list("C:/Users/local/Downloads/upregulated_genes_navarro-barriuso.txt")
down <- read_gene_list("C:/Users/local/Downloads/downregulated_genes_navarro-barriuso.txt")

modules_dir <- "./results/modules"
module_files <- list.files(modules_dir, full.names = TRUE)

# ---- initialize results ----
results <- data.frame(
  gene = character(),
  module_file = character(),
  extra_list = character(),
  stringsAsFactors = FALSE
)

# ---- loop through modules ----
for (file in module_files) {
  
  module_genes <- read_gene_list(file)
  module_name  <- basename(file)
  
  if (basename(file) == "OutputSpecific_module_grey.txt") {next}
  # intersection with extra list 1
  intersect1 <- intersect(module_genes, up)
  if (length(intersect1) > 0) {
    results <- rbind(
      results,
      data.frame(
        gene = intersect1,
        module_file = module_name,
        extra_list = "upregulated",
        stringsAsFactors = FALSE
      )
    )
  }
  
  # intersection with extra list 2
  intersect2 <- intersect(module_genes, down)
  if (length(intersect2) > 0) {
    results <- rbind(
      results,
      data.frame(
        gene = intersect2,
        module_file = module_name,
        extra_list = "downregulated",
        stringsAsFactors = FALSE
      )
    )
  }
}

print(results)

# optional: save to file
write.csv(results, "./results/validation/module_overlap_Navarro-Barriuso.csv", row.names = FALSE)
