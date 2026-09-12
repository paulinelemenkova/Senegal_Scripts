# GRASS GIS Scripts — SVM and k-means Land-Cover Classification of Landsat over Senegal

GRASS GIS, GMT and R scripts used to produce the figures in the peer-reviewed article by Polina Lemenkova. The scripts classify a Landsat 8-9 OLI/TIRS time series (February 2015, 2018, 2020, 2021, 2022, 2023) of the Saloum River Delta and coastal wetlands of Senegal, West Africa, comparing unsupervised k-means clustering with supervised Support Vector Machine (SVM) classification.

**Published in:** *Earth* **2024**, *5*(3), 420–462
**DOI:** https://doi.org/10.3390/earth5030024
**Journal (open access):** https://www.mdpi.com/2673-4834/5/3/24
**SSRN:** https://ssrn.com/abstract=4948887

## Contents
- **GRASS GIS** shell scripts for raster import (r.import), clustering and classification (i.group, i.cluster k-means, i.maxlik maximum-likelihood), rejection-probability mapping, and Support Vector Machine classification (r.learn.train, r.learn.predict, SVC) from Python's Scikit-Learn library — one MaxLik and one SVM script per year.
- **GMT** script for the topographic study-area map.
- **R** (DiagrammeR) script for the methodological workflow diagram.
- Landsat metadata tables (LaTeX) and per-year clustering reports.

## LaTeX source
The LaTeX source (prose) of this article is in a separate repository: https://github.com/paulinelemenkova/svm-landcover-classification-senegal

## Citation
Lemenkova, P. Support Vector Machine Algorithm for Mapping Land Cover Dynamics in Senegal, West Africa, Using Earth Observation Data. *Earth* **2024**, *5*(3), 420–462. https://doi.org/10.3390/earth5030024
