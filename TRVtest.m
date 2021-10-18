% script TRVtest.m
% Script to test TRV (Transferable Range Voting)

m=5, n=20, p=10 % m = # of winners, n = # of voters, p = # of candidates
for i=1:n, for j=1:p
   s(i,j)=rand;
end, end
format compact
[winner] = TRV_verbose(n,p,m,s)


