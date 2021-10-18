% Matlab script to test TRV for an example representing party affiliations.
% We assume 4 political parties, each with 10 candidates running.

n=1000; p=40; m=10; n1=0.4*n; n2=0.3*n; n3=0.2*n; n4=0.1*n;  % populations
w1=.2;   % maximum support given to someone outside your own party
w2=.8;  % minimum support given to someone within your own party

% Note that proportional representation is given (within quantization) by:
% n1/n Party A candidates in the range (1 :10)
% n2/n Party B candidates in the range (11:20)
% n3/n Party C candidates in the range (21:30)
% n4/n Party D candidates in the range (31:40)
% If w1 is almost 0 and w2 is almost 1, TRV well approximates these ratios,
% as generally shown in the numerical results below, when run several times.

s=w1*rand(n,p); % initialze random votes for candidates outside one's party...
                % ... then adjust votes higher when voting inside one's party
s(1         :n1,         1 :10)=w2+(1-w2)*rand(n1,10); % Party A 
s(n1+1      :n1+n2,      11:20)=w2+(1-w2)*rand(n2,10); % Party B 
s(n1+n2+1   :n1+n2+n3,   21:30)=w2+(1-w2)*rand(n3,10); % Party C 
s(n1+n2+n3+1:n1+n2+n3+n4,31:40)=w2+(1-w2)*rand(n4,10); % Party D 

s=s/max(max(s));
[winner]=TRV_verbose(n,p,m,s)   % Finally, tally votes.
