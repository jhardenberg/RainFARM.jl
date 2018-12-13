var documenterSearchIndex = {"docs": [

{
    "location": "#",
    "page": "RainFARM Julia module Documentation",
    "title": "RainFARM Julia module Documentation",
    "category": "page",
    "text": ""
},

{
    "location": "#RainFARM-Julia-module-Documentation-1",
    "page": "RainFARM Julia module Documentation",
    "title": "RainFARM Julia module Documentation",
    "category": "section",
    "text": "RainFARM.jl is a Julia library and a collection of command-line interface tools implementing the RainFARM (Rainfall Filtered Autoregressive Model) stochastic precipitation downscaling method adapted for climate models. Adapted for climate downscaling according to (D\'Onofrio et al. 2018) and with fine-scale origraphic weights (Terzago et al. 2018).RainFARM (Rebora et al. 2006) is a metagaussian stochastic downscaling procedure based on the extrapolation of the coarse-scale Fourier power spectrum  of a spatio-temporal precipitation field to small scales.  "
},

{
    "location": "#RainFARM.rainfarm",
    "page": "RainFARM Julia module Documentation",
    "title": "RainFARM.rainfarm",
    "category": "function",
    "text": "rainfarm(r,slope,nf,weight=1.;fglob=false, fsmooth=false, verbose=false)\n\nPerform general RainFARM downscaling.\n\n#Arguments\n\nr      : large-scale array to downscale\nslope  : spatial spectral slope\nnf     : refinement factor for spatial downscaling\nweight : weights for orographic downscaling\nfglob  : conserve global average over domain\nfsmooth: use smoothing instead of gp conservation\nverbose: provide some progress report \n\n\n\n\n\n"
},

{
    "location": "#RainFARM.rfweights",
    "page": "RainFARM Julia module Documentation",
    "title": "RainFARM.rfweights",
    "category": "function",
    "text": "ww = rfweights(orofile, reffile, nf; weightsfn=\"\", varname=\"\", fsmooth=false)\n\nCompute orographic weights from a fine-scale precipitation climatology file.\n\n#Arguments\n\norofile  : filename of input climatology\nreffile  : filename of reference file (for metadata, e.g. the file to downscale)\nnf       : refinement factor for spatial downscaling\nweightsfn: write weights to file weightsfn\nvarname  : variable name in climatology\nfsmooth  : use smoothing instead of gp conservation\n\n#Returns\n\nww       : a weight matrix also saved to weightsfn\n\n#Depends\n\nThis function uses external system calls using the \"cdo\" command (https://code.mpimet.mpg.de/projects/cdo/wiki/Cdo) which needs to be available on your system.\n\n\n\n\n\n"
},

{
    "location": "#RainFARM.fft3d",
    "page": "RainFARM Julia module Documentation",
    "title": "RainFARM.fft3d",
    "category": "function",
    "text": "(fx,ft)=fft3d(z)\n\nCompute spatial (fx) and temporal (ft) Fourier spectra of field z.\n\n\n\n\n\n"
},

{
    "location": "#RainFARM.fitslopex",
    "page": "RainFARM Julia module Documentation",
    "title": "RainFARM.fitslopex",
    "category": "function",
    "text": "sx = fitslopex(fx; kmin=1)\n\nReturn spectral slope (minus 1) of spatial spectrum fx.\n\n\n\n\n\n"
},

{
    "location": "#RainFARM.lon_lat_fine",
    "page": "RainFARM Julia module Documentation",
    "title": "RainFARM.lon_lat_fine",
    "category": "function",
    "text": "(lon_f, lat_f) = lon_lat_fine(lon, lat,nf)\n\nInterpolate longitude and latitude arrays (2d or 1d) lon and lat to higher resolution by a factor nf. \n\n\n\n\n\n"
},

{
    "location": "#RainFARM.read_netcdf2d",
    "page": "RainFARM Julia module Documentation",
    "title": "RainFARM.read_netcdf2d",
    "category": "function",
    "text": "(data, lon, lat, time) = read_netcdf2d(file, varname=\"\")\n\nRead variable varname (optional) from netcdf file. Returns data and coordinate and time axes.\n\n\n\n\n\n"
},

{
    "location": "#RainFARM.write_netcdf2d",
    "page": "RainFARM Julia module Documentation",
    "title": "RainFARM.write_netcdf2d",
    "category": "function",
    "text": "write_netcdf2d(fname,var,lon,lat,varname,filenc)\n\nWrite field varto netcdf file fname, with coordinates lon and lat and variable name varname. File filenc is used to copy metadata from.\n\n\n\n\n\n"
},

{
    "location": "#RainFARM.agg",
    "page": "RainFARM Julia module Documentation",
    "title": "RainFARM.agg",
    "category": "function",
    "text": "za = agg(z,nas,nat)\n\nAggregate field z to an array za of size (nas,nas,nat)\n\n\n\n\n\n"
},

{
    "location": "#RainFARM.interpola",
    "page": "RainFARM Julia module Documentation",
    "title": "RainFARM.interpola",
    "category": "function",
    "text": "zi = interpola(z,ns,nt)\n\nInterpolate field z to size (ns,ns,nt) using nearest neighbors.\n\n\n\n\n\n"
},

{
    "location": "#RainFARM.initmetagauss",
    "page": "RainFARM Julia module Documentation",
    "title": "RainFARM.initmetagauss",
    "category": "function",
    "text": "f = initmetagauss(sx,st,nso,nto)\n\nGenerate the spectral amplitudes f for a metagaussian field of size nso * nso * nto with slopes sx and st. \n\n\n\n\n\n"
},

{
    "location": "#RainFARM.metagauss",
    "page": "RainFARM Julia module Documentation",
    "title": "RainFARM.metagauss",
    "category": "function",
    "text": "fr = metagauss(f)\n\nGenerate a metagaussian field multiplying the spectralfield f with random phases and performing an inverse FFT transform to real space.\n\n\n\n\n\n"
},

{
    "location": "#RainFARM.gaussianize",
    "page": "RainFARM Julia module Documentation",
    "title": "RainFARM.gaussianize",
    "category": "function",
    "text": "g = gaussianize(z)\n\nGaussianize field z using a sorted random sequence.\n\n\n\n\n\n"
},

{
    "location": "#RainFARM.smoothconv",
    "page": "RainFARM Julia module Documentation",
    "title": "RainFARM.smoothconv",
    "category": "function",
    "text": "zs = smoothconv(z,nas)\n\nSmoothen field z(ns,ns) with a circular kernel of diameter ns/nas using convolution. Takes into account missing values.\n\n\n\n\n\n"
},

{
    "location": "#RainFARM.mergespec_spaceonly",
    "page": "RainFARM Julia module Documentation",
    "title": "RainFARM.mergespec_spaceonly",
    "category": "function",
    "text": "fm = mergespec_spaceonly(ra,f,kmax)\n\nSpectral merging of coarse field ra and fine field f at wavenumber kmax.\n\n\n\n\n\n"
},

{
    "location": "#RainFARM.downscale_spaceonly",
    "page": "RainFARM Julia module Documentation",
    "title": "RainFARM.downscale_spaceonly",
    "category": "function",
    "text": "rf = downscale_spaceonly(r,f,weight=1.;fglob=false, fsmooth=false )\n\nDownscale precipitation field r using metagaussian spectral field f. An optional weights array can be specified. Precipitation can be conserved globally (fglob) or using convolution (fsmooth).\n\n\n\n\n\n"
},

{
    "location": "#Functions-1",
    "page": "RainFARM Julia module Documentation",
    "title": "Functions",
    "category": "section",
    "text": "rainfarm\nrfweights\nfft3d\nfitslopex\nlon_lat_fine\nread_netcdf2d\nwrite_netcdf2d\nagg\ninterpola\ninitmetagauss\nmetagauss\ngaussianize\nsmoothconv\nmergespec_spaceonly\ndownscale_spaceonly"
},

{
    "location": "#Index-1",
    "page": "RainFARM Julia module Documentation",
    "title": "Index",
    "category": "section",
    "text": ""
},

{
    "location": "#Scientific-references-1",
    "page": "RainFARM Julia module Documentation",
    "title": "Scientific references",
    "category": "section",
    "text": "Terzago, S., Palazzi, E., and von Hardenberg, J. (2018). Stochastic downscaling of precipitation in complex orography: a simple method to reproduce a realistic fine-scale climatology, Nat. Hazards Earth Syst. Sci., 18, 2825-2840, doi: https://doi.org/10.5194/nhess-18-2825-2018\nD’Onofrio, D., Palazzi, E., von Hardenberg, J., Provenzale, a., & Calmanti, S. (2014). Stochastic Rainfall Downscaling of Climate Models. Journal of Hydrometeorology, 15(2), 830–843. doi: https://doi.org/10.1175/JHM-D-13-096.1 \nRebora, N., Ferraris, L., von Hardenberg, J., & Provenzale, A. (2006). RainFARM: Rainfall Downscaling by a Filtered Autoregressive Model. Journal of Hydrometeorology, 7(4), 724–738. doi: https://doi.org/10.1175/JHM517.1 "
},

{
    "location": "#Authors-1",
    "page": "RainFARM Julia module Documentation",
    "title": "Authors",
    "category": "section",
    "text": "Julia module - J. von Hardenberg (2016-2018). Based on a Matlab version for climate downscaling by D. D\'Onofrio and J. von Hardenberg (2014).  Original Matlab code following Rebora et al. 2006, developed jointly by ISAC-CNR and CIMA Foundation in 2004-2006."
},

]}
