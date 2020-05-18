"""
    (data, lon, lat, time) = read_netcdf2d(file, varname="")

Read variable `varname` (optional) from netcdf `file`.
Returns data and coordinate and time axes.
"""
function  read_netcdf2d(file, varname="")

    nc = NetCDF.open(file, mode=NC_NOWRITE)
    if( haskey(nc.vars,"lon") )
        lat=ncread(file,"lat")
        lon=ncread(file,"lon")
    elseif (haskey(nc.vars,"longitude"))
        lat=ncread(file,"latitude")
        lon=ncread(file,"longitude")
    elseif (haskey(nc.vars,"x"))
        lat=ncread(file,"y")
        lon=ncread(file,"x")
    elseif (haskey(nc.vars,"X"))
        lat=ncread(file,"Y")
        lon=ncread(file,"X")
    else
        println("Input file does not contain lon or longitude dimensional variables")
        quit(1)
    end

    if(varname=="")
        for key in  keys(nc.vars)
            if(key!="lon" && key!="lat" && key!="time" && key!="longitude" &&
               key!="latitude" && key!="time_bnds" && key!="x" && key!="y" &&
               key!="X" && key!="Y" )
                varname = key
            end
        end
    end

    var = ncread(file, varname)

    var = float(var)
    if (haskey(nc.vars[varname].atts,"missing_value"))
        xmiss = nc.vars[varname].atts["missing_value"] 
        xmiss = convert(typeof(var[1,1,1]),xmiss)
        var[var .== xmiss] .= NaN
    end

    return var, lon, lat, varname
end
