function write_netcdf2d(fname,var,lon,lat,varname,filenc) 

if(length(size(lon))==1) 
  (nsx,)=size(lon)
  (nsy,)=size(lat)
else
  (nsx,nsy)=size(lon)
end
(ns,ns,nt)=size(var)

mode=NC_NETCDF4

#println("Reading ",filenc)
ncin= NetCDF.open(filenc)
if( haskey(ncin.vars,"lon") )
   lonatt= ncin.vars["lon"].atts
   latatt= ncin.vars["lat"].atts
elseif (haskey(ncin.vars,"longitude"))
   lonatt= ncin.vars["longitude"].atts
   latatt= ncin.vars["latitude"].atts
else
   println("Input reference file does not contain lon or longitude dimensional variables")
   quit(1)
end

timeatt= ncin.vars["time"].atts
varatt= ncin.vars[varname].atts
tim=NetCDF.readvar(ncin,"time");
NetCDF.close(ncin)

#ncgetatt(filenc, "global", gatts)

varattr=Dict()
for k in collect(keys(varatt))
   if(k!="_FillValue") 
       varattr[k]=varatt[k]
   end
end

isfile(fname) ? rm(fname) : nothing

if(length(size(lon))==1)
nccreate( fname, varname , "lon" , nsx, "lat", nsy, "time", tim[1:nt] ,timeatt, atts=varattr,mode=mode,t=NC_FLOAT);
nccreate( fname, "lon" , "lon" , nsx,  atts=lonatt,mode=mode,t=NC_FLOAT);
nccreate( fname, "lat" , "lat" , nsy,  atts=latatt,mode=mode,t=NC_FLOAT);
else
nccreate( fname, varname , "x" , nsx, "y", nsy, "time", tim[1:nt] ,timeatt, atts=varattr,mode=mode,t=NC_FLOAT);
nccreate( fname, "lon" , "x" , nsx, "y", nsy,  atts=lonatt,mode=mode,t=NC_FLOAT);
nccreate( fname, "lat" , "x" , nsx, "y", nsy,  atts=latatt,mode=mode,t=NC_FLOAT);
end

ncwrite(var,fname,varname)
ncwrite(lon,fname,"lon")
ncwrite(lat,fname,"lat")

ncclose(fname)
end


