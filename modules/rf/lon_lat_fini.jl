function lon_lat_fini(lon_mat, lat_mat,nf)
#using Interpolations

ns=size(lon_mat)

if(length(ns)==2)
  nlon=ns[1]; nlat=ns[2];

  xc=1:nlon
  yc=1:nlat
  xf=(0.5+1/(2*nf)):1/nf:(nlon+0.5-1/(2*nf))
  yf=(0.5+1/(2*nf)):1/nf:(nlat+0.5-1/(2*nf))
  knots=(collect(yc),collect(xc))

  itplon = interpolate(knots, lon_mat, Gridded(Linear()))
  itplat = interpolate(knots, lat_mat, Gridded(Linear()))

  lon_f=itplon[yf,xf]
  lat_f=itplat[yf,xf]
else
  (nlat,)=size(lat_mat);
  (nlon,)=size(lon_mat);

  xc=1:nlon
  yc=1:nlat

  xf=(0.5+1/(2*nf)):1/nf:(nlon+0.5-1/(2*nf))
  yf=(0.5+1/(2*nf)):1/nf:(nlat+0.5-1/(2*nf))
  knotsx=collect(xc)
  knotsy=collect(yc)

  itplon = interpolate((knotsx,), lon_mat, Gridded(Linear()))
  itplat = interpolate((knotsy,), lat_mat, Gridded(Linear()))

  lon_f=itplon[xf]
  lat_f=itplat[yf]
end

return lon_f, lat_f
end
