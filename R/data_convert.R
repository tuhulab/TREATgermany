# Convert DGE list (.xlsx) to RDS
library(dplyr)
DGE_publication_filename <- list.files("data/DGE_list_publication/", full.names = TRUE)
DGE_publication <- lapply(DGE_publication_filename, function(x){
  DGE <- readxl::read_excel(x)})
names(DGE) <- DGE_publication_filename %>% stringr::str_extract("(LS|NL)vs(NL|NN)")
saveRDS(DGE_publication, file = "data/DGE_list_publication/DGE_publication.rds")
