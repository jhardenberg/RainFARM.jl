	function metagauss(f);
#= g=metagauss(sx,st,nso,nto);
 Generates a metagaussian field of size ns x ns x nt
 with slopes sx and st
 this version creates an output in fourier space and does not use 
 padding =#

        (ns,ns,nt)=size(f);
#	phases as fft of a gaussian noise random field
#        ph=zeros(ns,ns,nt,'single');

        ph=zeros(ns,ns,nt);
        for i=1:nt; ph[:,:,i]=(randn(ns,ns)); end;
	ph=fft(ph);  
	ph=ph./abs(ph); ph[1,1,1]=0;
	ph=f.*ph;
	ph=real(ifft(ph)); 
end
