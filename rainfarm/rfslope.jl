#!/usr/bin/julia
using RainFARM
using ArgParse

function parse_commandline()
    s = ArgParseSettings()

    @add_arg_table s begin
        "infile"
            help = "The input file to downscale"
            arg_type = AbstractString
            required = true
        "--varname", "-v"
            help = "Input variable name"
            arg_type = AbstractString
            default = ""
    end

    s.description="Estimation of spatial spectral slope for RainFARM downscaling"

    return parse_args(s)
end

args = parse_commandline()
filenc=args["infile"]
varnc=args["varname"]

#println("Estimating slope ",filenc)

(pr,lon_mat,lat_mat)=read_netcdf2d(filenc, varnc);
# Calcolo fft3d e slope
(fxp,fsp,ftp)=fft3d(pr);
sx=fitslopex(fxp);
#println("Computed spatial spectral slope: ",sx)
println(sx)
