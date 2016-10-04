"""
    rainfarmn(r,slope,nens,lon,lat,fnbase,varname,filenc,weight=1.;fglob=false, fsmooth=false)

Perform general RainFARM downscaling

#Arguments
* `r`      : large-scale array to downscale
* `slope`  : spatial spectral slope
* `nens`   : number of ensemble members
* `lon`    : array containing longitudes (for the output netcdf) 
* `lat`    : array containing latitudes (for the output netcdf) 
* `fnbase` : output filename prefix
* `varname`: output file variable name
* `filenc` : reference file from which to copy metadata for output
* `weight` : weights for orographic downscaling
* `fglob`  : conserve global average over domain
* `fsmooth`: use smoothing instead of gp conservation

Author: Jost von Hardenberg (j.vonhardenberg@isac.cnr.it) - ISAC-CNR 2016
"""
function rainfarmn(r,slope,nens,lon,lat,fnbase,varname,filenc,weight=1.;fglob=false, fsmooth=false)
(nas,nas,ntime)=size(r);
nt=1; nat=1; # This is the space_only version, downscaling nt is 1
#(ns, ns1)=size(lon); ns=max(ns,ns1); # Recover ns (the fine scale res) from lon
ns=size(lon); ns=ns[1]; # Recover ns (the fine scale res) from lon; we assume that RF works on squares, nlon=nlat
f=initmetagauss(slope,1,ns,1);
rd=zeros(ns,ns,ntime);

for iens=1:nens
  for k=1:ntime
    r1=r[:,:,k];    
@printf("Iens %d Frame %d\r",iens,k)
    if mean(r1)==0
	rd[:,:,k]=zeros(ns,ns);
   else	
   	fm=downscale_spaceonly(r1,f,weight,fglob=fglob,fsmooth=fsmooth);
	rd[:,:,k]=fm;
   end
  end
  fname=@sprintf("%s_%04d.nc",fnbase,iens);
  write_netcdf2d(fname,rd,lon,lat,varname,filenc) 
end

end


