

function meshgrid{T}(vx::AbstractVector{T}, vy::AbstractVector{T})
    m, n = length(vy), length(vx)
    vx = reshape(vx, 1, n)
    vy = reshape(vy, m, 1)
    (repmat(vx, m, 1), repmat(vy, 1, n))
end


function  read_netcdf2d(file, varname="")
#== --------------------------------------------
 Read 2-dim (lon-lat + eventually time) netcdf file

 [var] = read_netcdf2d(file, VARname)
 [var, lon] = read_netcdf2d(file, VARname)
 [var, lon, lat] = read_netcdf2d(file, VARname)
 [var, lon, lat, time] = read_netcdf2d(file, VARname)
 -------------------------------------------- ==#

nc = NetCDF.open(file, mode=NC_NOWRITE)
if( haskey(nc.vars,"lon") )
   lat=ncread(file,"lat");
   lon=ncread(file,"lon");
elseif (haskey(nc.vars,"longitude"))
   lat=ncread(file,"latitude");
   lon=ncread(file,"longitude");
else
   println("Input file does not contain lon or longitude dimensional variables")
   quit(1)
end
NetCDF.close(nc)

if(varname=="")
   nc = NetCDF.open( file , mode=NC_NOWRITE, readdimvar=false )
   for key in  keys(nc.vars)
      if(key!="lon" && key!="lat" && key!="time" && key!="longitude" && key!="latitude" && key!="time_bnds" )
            varname=key
      end
   end
   NetCDF.close(nc)
end

var=ncread(file,varname);

#if(size(lon,2)==1) 
#   (lon,lat)=meshgrid(lon,lat)    
#end
#lon=lon';
#lat=lat';
return var,lon,lat
end
