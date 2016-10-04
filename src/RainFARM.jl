# RainFARM:  Stochastic downscaling following 
# - *D'Onofrio et al. 2014, J of Hydrometeorology 15 , 830-843* and
# - *Rebora et. al 2006, JHM 7, 724* 
# Includes orographic corrections

# Implementation in Julia language
# Author: J. von Hardenberg - ISAC-CNR (2016)

__precompile__()
module RainFARM
export agg,fft3d,initmetagauss,gaussianize,metagauss,smoothconv
export mergespec_spaceonly,downscale_spaceonly,lon_lat_fine,fitslopex
export read_netcdf2d,write_netcdf2d,rainfarmn,interpola,smooth
export overwrite_netcdf2d

using Interpolations, NetCDF

include("rf/agg.jl")
include("rf/smoothconv.jl")
include("rf/smooth.jl")
include("rf/fft3d.jl")
include("rf/initmetagauss.jl")
include("rf/gaussianize.jl")
include("rf/metagauss.jl")
include("rf/mergespec_spaceonly.jl")
include("rf/downscale_spaceonly.jl")
include("rf/lon_lat_fine.jl")
include("rf/fitslopex.jl")
include("rf/read_netcdf2d.jl")
include("rf/write_netcdf2d.jl")
include("rf/overwrite_netcdf2d.jl")
include("rf/interpola.jl")
include("rf/rainfarmn.jl")

end
