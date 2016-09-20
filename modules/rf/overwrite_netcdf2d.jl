function overwrite_netcdf2d(fname,var,varname) 
ncin= NetCDF.open(fname)
ncwrite(var,fname,varname)
ncclose(fname)
end


