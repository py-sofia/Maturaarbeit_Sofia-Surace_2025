# Maturaarbeit_Sofia-Surace_2025
Immunregulation von T-Zellen durch Vitamin D3: Eine Netzwerkanalyse

This repository contains all code, datasets, and results for my **Matura project**, which investigates how **vitamin D3–treated tolerogenic dendritic cells (tolDCs)** affect **T-cell gene expression**.  <br />
The project combines **transcriptomic analysis** and **gene coexpression network modeling** to identify functional changes induced by vitamin D3 in the context of immune regulation and potential relevance to autoimmune diseases such as rheumatoid arthritis. <br /><br />
See the latest version of the Matura paper in /docs. <br />



## Project Overview

**Goal:**  
To determine how vitamin D3–treated tolDCs alter the gene coexpression structure of T cells compared to untreated tolDCs, using a network-based approach.

**Approach:**
1. **Data acquisition** — RNA-seq gene expression data of T cells co-cultured with tolDCs.
2. **Preprocessing** — normalization, filtering, and log-transformation.  
3. **Network construction** — coexpression networks built using the `bc3net` algorithm and validated through topological overlap analysis.  
4. **Differential coexpression analysis** — identification of modules showing condition-specific connectivity changes using a *DiffCoEx* workflow.  
5. **Functional enrichment** — GO enrichment for condition-specific modules.  
6. **Visualization** — plots of module structures, differential edges, and enrichment results.


## Software Requirements

- **R ≥ 4.3**
- Required R packages:
  ```R
  install.packages(c("bc3net", "WGCNA", "RColorBrewer", "igraph", "moduleColor", "scales", "dplyr", "ggplot2", "flashClust")
  if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")
  BiocManager::install(version = "3.21")
  BiocManager::install(c("preprocessCore", "clusterProfiler", "org.Hs.eg.db", "enrichplot")
  ```

## Data Availability 

The dataset originates from public sources in the NCBI GEO database (GSE128816). <br />
Processed matrices are included in /data/ for reproducibility. <br />


## Reproducing the Analysis

To reproduce the full analysis:
  ```bash
  git clone https://github.com/<py-sofia>/<Maturaarbeit_Sofia-Surace_2025>.git
  cd <Maturaarbeit_Sofia-Surace_2025>
  Rscript code/01_data_preprocessing.R
  Rscript code/02_network_construction_bc3net.R
  Rscript code/utils/pick_beta1.R
  Rscript code/utils/pick_cut_height.R
  Rscript code/03_diffcoex_analysis.R
  Rscript code/04_functional_enrichment.R
  Rscript code/05_visualization.R
  ```


## License

This repository is distributed under the MIT License. <br />
See the LICENSE <br />

