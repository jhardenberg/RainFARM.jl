function downscale_spaceonly(r,f,weight=1.;fglob=false)

(nas,nas)=size(r);
(ns,ns)=size(f);

# No negative rain
ii=find(r[:].<=0); 
r[ii]=0;
rs=r;

# Gaussianize
# Alternative: rg=log(rs);
rg=gaussianize(rs); 

# Prepare small scale random fields
g=metagauss(f);

# aggiustiamo l'ampiezza di f
(pstg,pstg2d,pstgt)=fft3d(g); 
pstg=pstg*((ns*ns)^2);
(pstrg,pstrg2d,pstrgt)=fft3d(rg); 
pstrg=pstrg*((nas*nas)^2);

varg=pstg[div(nas,2)];
varrg=pstrg[div(nas,2)];

c=varrg/varg;
g=g*sqrt(c);

gm=mergespec_spaceonly(rg,g,div(nas,2));

st=std(gm);
if st==0.
   st=1.;
end
gm=gm/st;

fm=exp(gm);

fm=fm.*weight;

# We want the aggregated field to be the same as pa
ii=find(isnan(r)); fm[ii]=nan;

if(fglob)
  fm=fm*mean(r)/mean(fm)
else
  fma=agg(fm,nas,1);
  raa=agg(r,nas,1);
  ca=raa./fma; #pa=p aggregato a L0 e T0;
  cai=interpola(ca,ns,1);
  fm=cai.*fm;
end

return fm
end
