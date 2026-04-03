# Configurational heterogeneity drives songbird diversity at distinct spatial scales in managed boreal forests

## General information

Code for: Configurational heterogeneity drives songbird diversity at distinct spatial scales in managed boreal forests<br>
Dataset archived on Borealis: https://doi.org/10.5683/SP3/RZ5DUQ

**Authors:**
- Isabelle Lebeuf-Taylor (corresponding author), Department of Biological Sciences, University of Alberta, Edmonton, Alberta, Canada. lebeufta@ualberta.ca. ORCID: 0000-0001-6809-7249
- Juan Andrés Martínez Lanfranco, Department of Biological Sciences, University of Alberta, Edmonton, Alberta, Canada
- Erin Bayne, Department of Biological Sciences, University of Alberta, Edmonton, Alberta, Canada

**Date of data collection:** 2014–2023

**Geographic location of data collection:** Boreal and Foothill Natural Regions, Alberta, Canada (approximately 49–60°N, 110–119°W)

**Funding sources:** Alberta Pacific Forest Industries Inc. matched by Mitacs Accelerate (IT34177), Forest Research Improvement Alliance of Alberta (FRIAA), Natural Sciences and Engineering Research Council of Canada (NSERC), Northern Scientific Training Program (NSTP), University of Alberta Northern Research Awards (UANRA)

**Associated publication:** Lebeuf-Taylor I, Martinez Lanfranco JA, Bayne E. Configurational heterogeneity drives songbird diversity at distinct spatial scales in managed boreal forests. *Landscape Ecology* (2026) https://doi.org/10.1007/s10980-026-02341-y

**Code repository:** https://github.com/IsabelleLebTay/boreal-songbird-scale-heterogeneity.git

## Dataset description

This dataset supports a multi-scale analysis of how landscape configurational heterogeneity influences passerine species richness in managed boreal and hemiboreal forests of Alberta, Canada. Birds were surveyed using autonomous recording units (ARUs) deployed at 392 sites in timber harvest areas within the first two decades of regeneration. Species richness was measured at 13 nested response extents (50–350 m radius) using sound-level distance truncation. Five landscape configuration metrics (edge density, Shannon diversity index, perimeter-area fractal dimension, core area index coefficient of variation, and contagion) were calculated at 232 landscape extents (50–500 m radius) around each site. The analysis identifies scales of effect and domains of scale through systematic variation of both response and landscape extents.

## File structure and descriptions

### Data files

| File | Description |
|------|-------------|
| `richness_dist.csv` | Site-level passerine species richness at each response extent (distance from ARU), derived from sound-level distance truncation of acoustic detections |
| `survey_year.csv` | Site-level survey year |
| `Climate_GDD.csv` | Growing degree days (GDD) extracted for each site from the ENVIREM dataset (Title 2018) |
| `Landscape_metrics_scaled.rds` | Landscape configuration metrics (edge density, PAFRAC, CAI CV, CONTAG, Shannon diversity) calculated at each landscape extent (50–500 m radius, 2 m increments) for all 392 sites. Metrics are scaled and centred. R serialized object |
| `scale_of_effect_final_models.csv` | Output from the scale-of-effect analysis: optimal model results for each response extent × configuration metric combination, including coefficient estimates, p-values, marginal R², AIC, and the landscape extent at which the scale of effect was identified |

### Code files

| File | Description |
|------|-------------|
| `1_scale_of_effects.Rmd` | Scale-of-effect analysis. Fits negative binomial GLMMs across all combinations of 13 response extents and 232 landscape extents for each of five configuration metrics. Compares additive, interactive, and polynomial fixed effect structures via likelihood ratio tests. Outputs optimal scale-of-effect results |
| `2_scale_domains.Rmd` | Scale domain analysis. Fits hierarchical generalized additive models (HGAMs) relating optimal landscape extents to response extents for each metric. Identifies domain boundaries from first derivative transitions using simulation-based confidence intervals |
| `utils.R` | Utility functions used by both analysis scripts: `filter_richness_data()` filters species richness to the closest available distance; `land_metrics_single_obs_multi_landscape_extents()` joins landscape metrics with richness, survey year, and climate data for a given response extent |

## Variable definitions

### richness_dist.csv

| Variable | Description | Units/values |
|----------|-------------|--------------|
| `location` | Unique site identifier | Character string |
| `distance` | Distance from ARU at which species richness was truncated | Metres (50–350) |
| `richness` | Count of passerine species detected within the truncation distance | Integer |

### survey_year.csv

| Variable | Description | Units/values |
|----------|-------------|--------------|
| `location` | Unique site identifier | Character string |
| `survey_year` | Year of ARU deployment | Integer (2014–2023) |

### Climate_GDD.csv

| Variable | Description | Units/values |
|----------|-------------|--------------|
| `location` | Unique site identifier | Character string |
| `gdd` | Growing degree days | Degree-days |

### Landscape_metrics_scaled.rds

| Variable | Description | Units/values |
|----------|-------------|--------------|
| `location` | Unique site identifier | Character string |
| `distance_int` | Landscape extent radius | Metres (50–500) |
| `edge` | Edge density (scaled and centred) | m/ha (standardised) |
| `pafrac` | Perimeter-area fractal dimension (scaled and centred) | Dimensionless (standardised) |
| `cai_cv` | Core area index coefficient of variation (scaled and centred) | % (standardised) |
| `contag` | Contagion (scaled and centred) | % (standardised) |
| `shdi` | Shannon diversity index (scaled and centred) | Dimensionless (standardised) |
| `upland_prop` | Proportion upland forest | 0–1 |

### scale_of_effect_final_models.csv

| Variable | Description | Units/values |
|----------|-------------|--------------|
| `metric` | Configuration metric name | edge, pafrac, cai_cv, contag, shdi |
| `type` | Fixed effect structure selected | add, interact, poly |
| `response_area_ha` | Response extent | Hectares |
| `metric_extent_ha` | Landscape extent at scale of effect | Hectares |
| `beta` | Coefficient estimate for focal metric | Log-link scale |
| `p_value` | P-value for focal metric coefficient | 0–1 |
| `r2_marginal` | Marginal R² (variance explained by fixed effects) | 0–1 |
| `aic` | Akaike Information Criterion | Numeric |

## Missing data codes

- `NA` indicates missing or incalculable values. For PAFRAC, `NA` values occur when fewer than 10 patches are present within the landscape extent (see Hesselbarth et al. 2019).

## Software and dependencies

All analyses were performed in R (R Core Team 2024). Key packages:

- `glmmTMB` — generalized linear mixed models
- `mgcv` — hierarchical generalized additive models
- `landscapemetrics` — landscape configuration metric calculation
- `DHARMa` — residual diagnostics
- `gratia` — GAM derivatives and visualization
- `tidyverse` — data manipulation and visualization
- `MuMIn` — marginal R² calculation

## Reproduction

1. Clone the repository or download from Borealis
2. Place data files in a `Data/` directory relative to the code files
3. Run `1_scale_of_effects.Rmd` to generate scale-of-effect results
4. Run `2_scale_domains.Rmd` to fit HGAMs and identify domain boundaries
5. `utils.R` is sourced automatically by both analysis scripts

## License

Data are released under [CC0 1.0 Universal (Public Domain Dedication)](https://creativecommons.org/publicdomain/zero/1.0/). Code is released under the MIT License.

## References

- Hesselbarth MHK, Sciaini M, With KA, et al (2019) landscapemetrics: an open-source R tool to calculate landscape metrics. Ecography 42:1648–1657
- Lebeuf-Taylor I, Knight E, Bayne E (2025) Improving bird abundance estimates in harvested forests with retention by limiting detection radius through sound truncation. Ornithological Applications 127. https://doi.org/10.1093/ornithapp/duae055
- Title PO, Bemmels JB (2018) ENVIREM: an expanded set of bioclimatic and topographic variables increases flexibility and improves performance of ecological niche modeling. Ecography 41:291–307
