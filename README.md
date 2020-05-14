[![DOI](https://zenodo.org/badge/DOI/10.5281/zenodo.3243425.svg)](https://doi.org/10.5281/zenodo.3243425)


# bromeliad 1.0-3

A data package with distribution data for 3,272 bromeliaceae species across tropical America.

## Included data
The package includes five data files:

1. `taxonomy traits` - a data.frame with taxonomy, traits and conservation assessment for the included species.
2. `all_ranges` - a simple features object containing range polygons for 3,272 bromeliaceae species.
3. `model_binary` - a list of presence/absence rasters, for 541 species for which the ranges were estimated based on climate suitability models
4. `model_ensemble` - a list of rasters with habitat suitability, for 541 species for which the ranges were estimated based on climate suitability models
5. `digitized_records` - a data.frame with 1,207 point locations of 920 species type specimens, georeferenced from the literature for this package

## Installation
The package can be installed from github using `devtools::install_github`
```{r}
library(devtools)

install_github("idiv-biodiversity/bromeliad")

library(bromeliad)
```

## Documentation
The pacakge also includes some convinieince functions to select taxa and visualize species ranges and diversity. A vignette describing how to select individual taxa and visualize species distributions and diversity patterns is available [here](https://idiv-biodiversity.github.io/bromeliad/), the corresponding paper [here](https://onlinelibrary.wiley.com/doi/full/10.1111/ddi.13004).

## Contribute
If you want to contribute with new species or corrections, please contact the [maintainer](mailto:alexander.zizka@idiv.de) of the package.

## Licence
The package and data are available under a CC-BY license.

## Citation
If you use the data, please cite the package as Zizka A, Azevedo J, Leme E, NEves B, Costa AFC, Caceres D & Zizka, G (2019) Biogeography and conservation status of the pineapple family (Bromeliaceae). *Diversity and Distributions*, 26(2):183-195. DOI:10.1111/ddi.13004.
