	function fitslopex(fx)
        xr=collect(1:length(fx));
        (a,sx)=linreg(log(xr),log(fx))
	sx=abs(sx)
	sx=sx-1
	return sx
	end

