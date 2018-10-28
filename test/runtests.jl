using RainFARM
@static if VERSION < v"0.7.0-DEV.2005"
    using Base.Test
else
    using Test
end

# write your own tests here

print("Testing main RainFARM function and aggregation\n")
nt=2; nf=8; ns=64; nas=8; 
prf=rand(ns,ns,nt);
prl=agg(prf,nas,nt);
pr=rainfarmn(prl,1.7,nf,1.;fglob=false, fsmooth=false, verbose=false);
pra=agg(pr,nas,nt);
eps=mean((pra-prl).^2);
@test eps < 1e-10
