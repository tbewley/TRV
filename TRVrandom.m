% Matlab script to test TRV with random votes.
n=20, p=10, m=5,  s=rand(n,p); s=s/max(max(s)); [winner]=TRV(n,p,m,s)
