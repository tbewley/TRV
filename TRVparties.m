% Matlab script to test TRV for an example representing party affiliations.
% We assume 4 political parties, each with 10 candidates running.

n=1000; p=40; m=10; n1=0.4*n; n2=0.3*n; n3=0.2*n; n4=0.1*n;  % populations
w1=.2;   % percentage of time voters approve of a candidate outside their own party
w2=.8;   % percentage of time voters approve of a candidate within  their own party

% Note that proportional representation is given (within quantization) by:
% n1/n Party A candidates in the range (1 :10)
% n2/n Party B candidates in the range (11:20)
% n3/n Party C candidates in the range (21:30)
% n4/n Party D candidates in the range (31:40)
% If w1 is almost 0 and w2 is almost 1, TRV well approximates these ratios,
% as indicated by the numerical results when the code below is run several times.

s=w1*rand(p,n);                   % initialze random votes for candidates outside one's party...
                                  % ... then adjust votes higher when voting inside one's party
s(1 :10,1         :n1         )=w2+(1-w2)*rand(10,n1); % Party A 
s(11:20,n1+1      :n1+n2      )=w2+(1-w2)*rand(10,n2); % Party B 
s(21:30,n1+n2+1   :n1+n2+n3   )=w2+(1-w2)*rand(10,n3); % Party C 
s(31:40,n1+n2+n3+1:n1+n2+n3+n4)=w2+(1-w2)*rand(10,n4); % Party D 

[winners]=TRV(s,m)   % Finally, tally votes.
fprintf('there should be about %d winners in the range [ 1,10],\n',    10*n1/n)
fprintf('                      %d winners in the range [11,20],\n',    10*n2/n)
fprintf('                      %d winners in the range [21,30], and\n',10*n3/n)
fprintf('                      %d winner  in the range [31,40].\n',    10*n4/n)
