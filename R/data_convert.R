# Convert DGE list (.xlsx) to RDS
library(dplyr)
DGE_publication_filename <- list.files("data/DGE_list_publication/", pattern = "xlsx", full.names = TRUE)
DGE_publication <- lapply(DGE_publication_filename, function(x){
  DGE <- readxl::read_excel(x)})
names(DGE_publication) <- DGE_publication_filename %>% stringr::str_extract("(LS|NL)vs(NL|NN)")

lapply(names(DGE_publication), 
       function(name = ...){
         df <- DGE_publication[[name]] %>% dplyr::arrange(-log2FoldChange)
         readr::write_csv(df, file.path("data", "DGE_list_publication", paste0("pool_", name, ".csv")))})

saveRDS(DGE_publication, file = "data/DGE_list_publication/DGE_publication.rds")

# Core signature ----
core_signature <- readxl::read_excel("data/publication_appendix/mmc5.xlsx")
core_signature %>% readr::write_csv("data/core_signature.csv")
saveRDS(core_signature, file = "data/core_signature.rds")
