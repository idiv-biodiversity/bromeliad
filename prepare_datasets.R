library(bromeliad)
library(raster)
library(tidyverse)
library(sf)
library(stringi)

#load data
load(file = "C:/Users/az64mycy/Dropbox (iDiv)/research_projects/31_bromeliaceae_distribution/bromeliaceae_distributions/output/bromeliaceae_ranges_with_data.rda")

# all ranges
all_ranges <- bromeli %>%
  select(tax_accepted_name)

save(all_ranges, file = "data/all_ranges.rda", compress = "xz")

# taxonomy_traits
head(taxonomy_traits)

st_geometry(bromeli) <- NULL

taxonomy_traits <- bromeli %>%
  select(tax_accepted_name, tax_genus, tax_tribus, tax_subfamily,
         geo_range, conv_conr_eoo, conv_conr_aoo, conv_conr_pop, conv_conr_code, conv_conr_stat, tr_growth_form) %>%
  mutate(tax_canonical = paste(str_split_fixed(tax_accepted_name, n = 3, pattern = " ")[,1],
                               str_split_fixed(tax_accepted_name, n = 3, pattern = " ")[,2],
                               sep = " ")) %>%
  as.tibble()


save(taxonomy_traits, file = "data/taxonomy_traits.rda", compress = "xz")

# Ensemble models
head(model_ensemble)

lis <- list.files("C:/Users/az64mycy/Dropbox (iDiv)/research_projects/31_bromeliaceae_distribution/bromeliaceae_distributions/output/ensemble_rasters")

modens <- lapply(paste("C:/Users/az64mycy/Dropbox (iDiv)/research_projects/31_bromeliaceae_distribution/bromeliaceae_distributions/output/ensemble_rasters/",
                       lis,
                       sep = ""), "raster")
modens <- lapply(modens, "readAll")
model_ensemble <- modens
names(model_ensemble) <- gsub(".asc", "", lis)
save(model_ensemble, file = "data/model_ensemble.rda", compress = "xz")

# binary models
head(model_binary)

lis <- list.files("C:/Users/az64mycy/Dropbox (iDiv)/research_projects/31_bromeliaceae_distribution/bromeliaceae_distributions/output/binary_rasters")

modens <- lapply(paste("C:/Users/az64mycy/Dropbox (iDiv)/research_projects/31_bromeliaceae_distribution/bromeliaceae_distributions/output/binary_rasters/",
                      lis,
                      sep = ""), "raster")
modens <- lapply(modens, "readAll")
model_binary <- modens
names(model_binary) <- gsub(".asc", "", lis)
save(model_binary, file = "data/model_binary.rda", compress = "xz")


head(georef_additions)
load("C:/Users/az64mycy/Dropbox (iDiv)/research_projects/31_bromeliaceae_distribution/bromeliaceae_distributions/output/manual_georeferencing_all.rds")

georef_additions <- out_all
save(georef_additions , file = "data/georef_additions.rda", compress = "xz")
