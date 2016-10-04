# RainFARM

Julia library and command-line tools implementing the RainFARM stochastic precipitation downscaling method.
Adapted for climate downscaling.

This version includes orographic corrections.

*References:*

- D'Onofrio et al. 2014, J of Hydrometeorology 15, 830-843

- Rebora et. al 2006, JHM 7, 724 

##Authors: 

*Julia* - J. von Hardenberg - ISAC-CNR (2016)

*Matlab* version for climate downscaling - D. D'Onofrio and J. von Hardenberg - ISAC-CNR (2014)

Based on original Matlab code following Rebora et al. 2006, developed jointly by ISAC-CNR and CIMA Foundation in 2004-2006.

##Requires: 
julia (>=4.5), cdo (>=1.5)

*Julia packages*: Interpolations, ArgParse, NetCDF

## Installation

- Install the content of this package in a directory, e.g. `/opt/julia`
- Add the modules subdirectory to the julia search path by adding the following line to `.juliarc` in your home directory:

```
    push!(LOAD_PATH, "/opt/julia/modules")
```

- launch julia and do:

``` 
    Pkg.add("Interpolations")
    Pkg.add("AggParse")
    Pkg.add("NetCDF") 
```

- test from the julia REPL calling `using RainFARM`

## Documentation

## Issues and Support


