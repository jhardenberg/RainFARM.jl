"""
    smooth(z, sdim)

Smoothen field `z` with a circular kernel of radius `sdim` using convolution
"""
function smooth(zi, sdim)

    iinan = findall(isnan.(zi))
    iinotnan = findall(.~isnan.(zi))
    zi[iinan] .= 0.

    (nsx,nsy) = size(zi)
    #sdim=div(div(ns,nas),2)

    nsx2 = div(nsx, 2)
    nsy2 = div(nsy, 2)
    mask = zeros(nsx, nsy)

    for i = 1:nsx
        for j = 1:nsy
            kx = i-1
            ky = j-1
            if (i>nsx2+1)
                kx = i-nsx-1
            end
            if (j>nsy2+1)
                ky = j-nsy-1
            end
            r2 = kx*kx+ky*ky
            if (r2<=sdim*sdim)
                mask[i,j] = 1.0
            end
        end
    end 
    fm = fft(mask)
    zf = real(ifft(fm.*fft(zi)))/sum(mask)
    if length(iinan)>0
        zi1 = deepcopy(zi)
        zi1[iinotnan] .= 1.0
        zf = zf./(real(ifft(fm.*fft(zi1)))/sum(mask))
    end
    zf[iinan] .= NaN

    return zf
end
