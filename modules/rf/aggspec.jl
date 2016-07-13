	function aggspec(zi,nas)

        nss=size(zi);
        ns=nss[1];
        sdim=div(div(ns,nas),2);

        mask=zeros(ns,ns);
        for i=1:ns
           for j=1:ns
               kx=i-1;
               ky=j-1;
               if(i>ns/2+1)
                  kx=i-ns-1 ;
               end
               if(j>ns/2+1)
                  ky=j-ns-1 ;
               end
               r2=kx*kx+ky*ky;
               if(r2<=sdim*sdim)
                  mask[i,j]=1.0;
                end
           end
        end 
        zf=real(ifft(fft(mask).*fft(zi)))/sum(mask)
        return zf
   end
                


