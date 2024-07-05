# denaltitude
Calculate density altitude based on METAR data for a specific airport.

## Install
Installation in R requires <a href="https://cran.r-project.org/package=devtools">devtools</a>. Requires <a href="https://cran.r-project.org/package=airportr">airportr</a> and <a href="https://cran.r-project.org/package=pmetar">pmetar</a> packages to run.
```
devtools::install_github("SaturdayActionStudio/denaltitude")
```

## Example
```
denalt(airportCode="FWA", elevation="ft")
```

## airportCode
Valid IATA airport code (character string)

## elevation
Units for elevation displayed in "ft" (default) or "m" meters
