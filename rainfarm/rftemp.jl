#!/usr/local/bin/julia
using RainFARM
using ArgParse

function parse_commandline()
    s = ArgParseSettings()

    @add_arg_table s begin
        "--radius", "-r"
            help = "Smoothing radius (in pixels)"
            arg_type = Int
            default = 0
        "--lapse", "-l"
            help = "Lapse rate [K/km]"
            arg_type =  Float64
            default = 6.5 
        "--varname", "-v"
            help = "Input variable name (in orofile)"
            arg_type = AbstractString 
            default = "" 
        "--coord", "-c", "--box", "-b"
            help = "Coordinates of box in which to downscale [lon1 lon2 lat1 lat2]"
 	    nargs = 4
            arg_type =  Float64
	    default =  [ 7, 7.65, 45.35, 45.75 ]
        "orofile"
            help = "The input file to use for orography"
            arg_type = AbstractString
            required = true
        "infile"
            help = "The file to downscale"
            arg_type = AbstractString
            required = true
        "outfile"
            help = "The output file name"
            arg_type = AbstractString
            required = true
    end

    s.description="Downscale temperature with a given lapse rate"
    s.version="0.1"
    s.add_version=true

    return parse_args(s)
end

args = parse_commandline()
lapse=abs(args["lapse"])
radius=args["radius"]
filein=args["infile"]
fileout=args["outfile"]
fileoro=args["orofile"]
varname=args["varname"]
coord=args["coord"]

lon1=coord[1]
lon2=coord[2]
lat1=coord[3]
lat2=coord[4]

println("Downscaling in box: ",coord[1],"/",coord[2],"/",coord[3],"/",coord[4])

(tin0,lonl0,latl0)=read_netcdf2d(filein,varname);
if(length(size(lonl0))>1)
dxl=max(lonl0[2,1]-lonl0[1,1],lonl0[1,2]-lonl0[1,1]);
else
dxl=lonl0[2]-lonl0[1];
end

println("dx=",dxl)
dxl2=dxl/2

#Add buffer
lonl1=lon1-dxl2
lonl2=lon2+dxl2
latl1=lat1-dxl2
latl2=lat2+dxl2
println("box + buffer=",lonl1,"/",lonl2,"/",latl1,"/",latl2)

run(`cdo -s sellonlatbox,$lonl1,$lonl2,$latl1,$latl2 $fileoro orocut.nc`)
(oro,lonl2,latl2)=read_netcdf2d("orocut.nc","");

println("Remapping input data ...")
run(`cdo -s -b F32 remapnn,orocut.nc $filein input_nn.nc`)
(tin,lonl,latl,varname)=read_netcdf2d("input_nn.nc",varname);
oro=float(oro); # convert to float
(nx,ny,nt)=size(tin)
if(length(size(lonl0))>1)
dxf=max(lonl2[2,1]-lonl2[1,1],lonl2[1,2]-lonl2[1,1]);
else
dxf=lonl2[2]-lonl2[1];
end

nf2=div(dxl/dxf,2)
println("Smoothing radius =",nf2)

println("Preparing correction ...")
oros=smooth(oro,nf2)

println("Downscaling ...")
for i=1:nt
    println("t=",i)
    tins=smooth(tin[:,:,i],nf2)
    tin[:,:,i]=tins-(oro-oros)*lapse/1000.
end

write_netcdf2d("out_temp.nc",tin,lonl,latl,varname,filein)
run(`cdo -s sellonlatbox,$lon1,$lon2,$lat1,$lat2 out_temp.nc $fileout `)
run(`rm orocut.nc input_nn.nc out_temp.nc `)



