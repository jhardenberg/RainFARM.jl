#!/usr/bin/env julia
# Copyright (c) 2016, Jost von Hardenberg - ISAC-CNR, Italy
using RainFARM
using ArgParse
using Compat

function parse_commandline()
    s = ArgParseSettings()

    @add_arg_table! s begin
        "--radius", "-r"
            help = "Smoothing radius (in grid units or pixels (if negative))"
            arg_type = Float64
            default = 0.
        "--gaussian", "-g"
            help = "Use a Gaussian kernel instead of a top hat. The radius parameter mean sigma in that case."
            action = :store_true
        "--varname", "-v"
            help = "Input variable name (in orofile)"
            arg_type = AbstractString 
            default = "" 
        "infile"
            help = "The file to downscale"
            arg_type = AbstractString
            required = true
        "outfile"
            help = "The output file name"
            arg_type = AbstractString
            required = true
    end

    s.description="Smooth input file using convolution with a circle of fixed radius"
    s.version="0.1"
    s.add_version=true

    return parse_args(s)
end

args = parse_commandline()
radius=args["radius"]
fgauss=args["gaussian"]
filein=args["infile"]
fileout=args["outfile"]
varname=args["varname"]

(tin0,lonl0,latl0)=read_netcdf2d(filein,varname);
if(length(size(lonl0))>1)
dxl=max(lonl0[2,1]-lonl0[1,1],lonl0[1,2]-lonl0[1,1]);
else
dxl=lonl0[2]-lonl0[1];
end

(tin,lonl,latl,varname)=read_netcdf2d(filein,varname);
nx=size(tin,1)
ny=size(tin,2)
nt=size(tin,3)

if (fgauss && (nx!=ny))
  println("Domain is ", nx, " by ", ny, " pixel")
  println("If Gaussian smoothing is used then the domain should be square!") 
  exit(1)
end

if(radius>0)
  nf2=div(radius,dxl)
else
  nf2=-radius
end

println("Original resolution: ", dxl)

if (fgauss) 
  nas=div(nx, nf2*2)
  println("Gaussian smoothing, nas=",nas)
  println("Smoothing with sigma ",nf2 ," pixel")
  for i=1:nt
    tin[:,:,i]=smoothconv(tin[:,:,i],nas)
  end
else
  println("Smoothing with radius ",nf2 ," pixel")
  for i=1:nt
    tin[:,:,i]=smooth(tin[:,:,i],nf2)
  end
end

run(`cp $filein $fileout`)
overwrite_netcdf2d(fileout,tin,varname)
