# denaltitude
Simple function to calculate density altitude based on METAR data for a specific airport.

## Install
Installation in R requires <a href="https://cran.r-project.org/package=devtools">devtools</a>. Requires <a href="https://cran.r-project.org/package=airportr">airportr</a> and <a href="https://cran.r-project.org/package=pmetar">pmetar</a> packages to run.
```
devtools::install_github("PlantEcology/denaltitude")
```

```
denaltitude(airportCode, elevation="ft")
```
