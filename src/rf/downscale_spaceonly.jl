function downscale_spaceonly(r,f,weight=1.;fglob=false, fsmooth=false, fwind=false )

(nas,nas)=size(r);
(ns,ns)=size(f);



# Gaussianize
# Alternative: rg=log(rs);

if(fwind)
   rg=r
else
# No negative rain
   ii=find(r[:].<=0); 
   r[ii]=0;
   rg=gaussianize(r); 
end

# Prepare small scale random fields
g=metagauss(f);

# aggiustiamo l'ampiezza di f
(pstg,pstgt)=fft3d(g); 
pstg=pstg*((ns*ns)^2);
(pstrg,pstrgt)=fft3d(rg); 
pstrg=pstrg*((nas*nas)^2);

if(fwind)
varg=pstg[div(nas,2)-1]; # match spectra at fore to last wavenumber
varrg=pstrg[div(nas,2)-1];
else
varg=pstg[div(nas,2)];
varrg=pstrg[div(nas,2)]; # to be explored if the -1 can be beneficial also for rainfall
end

c=varrg/varg;
g=g*sqrt(c);

gm=mergespec_spaceonly(rg,g,div(nas,2));

st=std(gm);
if st==0.
   st=1.;
end

if(fwind)
   fm=gm
else
   gm=gm/st;
   fm=exp.(gm);
end

fm=fm.*weight;

# We want the aggregated field to be the same as pa
ii=find(isnan.(r)); fm[ii]=NaN;

if(fsmooth)
  fma=smoothconv(fm,nas);
  ri=interpola(r,ns,1);
  raa=smoothconv(ri,nas);
  if(!fwind)
#     fm=raa-fma+fm; #pa=p aggregato a L0 e T0;
#  else
     fm=raa./fma.*fm; #pa=p aggregato a L0 e T0;
  end
else
#fm=mergespec_spaceonly(fm,raa,div(nas,2));
  raa=agg(r,nas,1);
  fma=agg(fm,nas,1);
  if(fwind)
    ca=raa-fma; #pa=p aggregato a L0 e T0;
    cai=interpola(ca,ns,1);
    fm=cai+fm;  # This is wind, additive bias correction
  else
    ca=raa./fma; #pa=p aggregato a L0 e T0;
    cai=interpola(ca,ns,1);
    fm=cai.*fm;
  end
end
if(fglob)
  if(fwind)
     fm=fm+mean(r)-mean(fm)
  else
     fm=fm*mean(r)/mean(fm)
  end
end
return fm
end
