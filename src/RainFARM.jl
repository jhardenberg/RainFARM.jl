# RainFARM:  Stochastic downscaling following 
# - *D'Onofrio et al. 2014, J of Hydrometeorology 15 , 830-843* and
# - *Rebora et. al 2006, JHM 7, 724* 
# Includes orographic corrections
# Implementation in Julia language

# Copyright (c) 2016, Jost von Hardenberg - ISAC-CNR, Italy

# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.

# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.

# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.

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
