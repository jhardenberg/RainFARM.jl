__precompile__()

module RainFARM
export agg,fft3d,initmetagauss,gaussianize,metagauss
export mergespec_spaceonly,downscale_spaceonly,lon_lat_fini,fitslopex
export read_netcdf2d,write_netcdf2d,rainfarmn,interpola

using Interpolations, NetCDF

include("rf/agg.jl")
include("rf/fft3d.jl")
include("rf/initmetagauss.jl")
include("rf/gaussianize.jl")
include("rf/metagauss.jl")
include("rf/mergespec_spaceonly.jl")
include("rf/downscale_spaceonly.jl")
include("rf/lon_lat_fini.jl")
include("rf/fitslopex.jl")
include("rf/read_netcdf2d.jl")
include("rf/write_netcdf2d.jl")
include("rf/interpola.jl")
include("rf/rainfarmn.jl")

end
