function smooth(zi,nas)
        nss=size(zi);
        ns=nss[1]; 

        sdim=div(div(ns,nas),2);
        ir=-sdim:sdim; jr=ir; 
        z=zeros(ns,ns)
        zib=ones(ns+sdim*2,ns+sdim*2)*NaN
        zib[(sdim+1):(sdim+ns),(sdim+1):(sdim+ns)]=zi
        for i=1:ns
           for j=1:ns
                 zibr=zib[i+ir+sdim,j+jr+sdim] 
                 z[i,j]=mean(zibr[~isnan(zibr)]);
           end
        end
        return z
end

