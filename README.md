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

Launch julia and from the REPL do

    Pkg.clone("https://github.com/jhardenberg/RainFARM.jl")

where `username` is your username. This will install the package. 
Assuming your julia is v0.5, in `~/.julia/v0.5/rainfarm/tools` you will find the command line tools. Copy/link these to somewhere in your path in order to use them.

- test from the julia REPL calling `using RainFARM`

In the `tools` subdirectory you will find the command line tools. Link or copy these to somewhere in you path in order to use them.

## Documentation

## Issues and Support

