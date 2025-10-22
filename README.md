# Maturaarbeit_Sofia-Surace_2025
Vitamin D3 und die Immunregulation bei Rheumatoider Arthritis: Eine bioinformatische Netzwerkanalyse

This repository contains all code, datasets, and results for my **Matura project**, which investigates how **vitamin D3–treated tolerogenic dendritic cells (tolDCs)** affect **T-cell gene expression**.  
The project combines **transcriptomic analysis** and **gene coexpression network modeling** to identify functional changes induced by vitamin D3 in the context of immune regulation and potential relevance to autoimmune diseases such as rheumatoid arthritis.


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


## Repository Structure
├── data/
│ ├── raw/ # Original datasets (from GEO or publication source)
│ ├── processed/ # Normalized and filtered expression matrices
│ └── metadata/ # Sample annotation and experimental details
│
├── code/
│ ├── 01_data_preprocessing.R
│ ├── 02_network_construction_bc3net.R
│ ├── 03_diffcoex_analysis.R
│ ├── 04_functional_enrichment.R
│ ├── 05_visualization.R
│ └── utils/ # Helper scripts (plotting, normalization, etc.)
│
├── results/
│ ├── networks/ # Adjacency matrices and network objects
│ ├── modules/ # Detected modules and annotations
│ ├── enrichment/ # GO enrichment results (CSV, barplots)
│ └── figures/ # All plots and diagrams used in the report
│
├── docs/
│ ├── Matura_paper.pdf
│ └── presentation_slides.pdf # will follow
│
├── LICENSE
└── README.md


## Requirements

### Software
- **R ≥ 4.3**
- Recommended R packages:
  ```R
  install.packages(c("WGCNA", "igraph", "bc3net", "preprocessCore", "clusterProfiler", "org.Hs.eg.db"))


## Data Availability

The dataset originates from public sources in the NCBI GEO database (see data/metadata/source_info.txt for accession numbers).
Processed matrices are included in /data/processed/ for reproducibility.


## Reproducing the Analysis

To reproduce the full analysis:

git clone https://github.com/<py-sofia>/<Maturaarbeit_Sofia-Surace_2025>.git
cd <Maturaarbeit_Sofia-Surace_2025>
Rscript code/01_data_preprocessing.R
Rscript code/02_network_construction_bc3net.R
Rscript code/03_diffcoex_analysis.R
Rscript code/04_functional_enrichment.R
Rscript code/05_visualization.R



## License

This repository is distributed under the MIT License.
See the LICENSE


## Contact

Author: Sofia Surace
Institution: Kantonsschule Zürich Nord
Supervisor: Patrick Aschwanden
