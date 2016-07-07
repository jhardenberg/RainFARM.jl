function rainfarmn(r,slope,nens,lon,lat,fnbase,varname,filenc,weight=1.;fglob=false)
tic()
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
    	fm=downscale_spaceonly(r1,f,weight,fglob=fglob);
	rd[:,:,k]=fm;
   end
  end
toc()
  fname=@sprintf("%s_%04d.nc",fnbase,iens);
  write_netcdf2d(fname,rd,lon,lat,varname,filenc) 
end

end


