% Matlab script to test TAV for an example representing party affiliations.
% We assume 4 political parties, each with 10 candidates running.

n=1000; p=40; m=10; n1=0.4*n; n2=0.3*n; n3=0.2*n; n4=0.1*n;  % populations
w1=0.02; % percentage of time voters approve of a candidate outside their own party
w2=0.8;  % percentage of time voters approve of a candidate within  their own party

% Note that proportional representation is given (within quantization) by:
% n1/n Party A candidates in the range (1 :10)
% n2/n Party B candidates in the range (11:20)
% n3/n Party C candidates in the range (21:30)
% n4/n Party D candidates in the range (31:40)
% If w1 is almost 0 and w2 is almost 1, TAV well approximates these ratios,
% as indicated by the numerical results when the code below is run several times.

s=0.5+0.5*sign(rand(p,n)-(1-w1)); % initialze random (0 or 1) votes, with highest probabilty of
                                  % approval (as tweaked below) for candidates within one's party,
s(1 :10,1         :n1         )=0.5+0.5*sign(rand(10,n1)-(1-w2)); % Party A 
s(11:20,n1+1      :n1+n2      )=0.5+0.5*sign(rand(10,n2)-(1-w2)); % Party B 
s(21:30,n1+n2+1   :n1+n2+n3   )=0.5+0.5*sign(rand(10,n3)-(1-w2)); % Party C 
s(31:40,n1+n2+n3+1:n1+n2+n3+n4)=0.5+0.5*sign(rand(10,n4)-(1-w2)); % Party D 

[winners]=TRV(s,m)   % Finally, tally votes.
fprintf('there should be about %d winners in the range [ 1,10],\n',    10*n1/n)
fprintf('                      %d winners in the range [11,20],\n',    10*n2/n)
fprintf('                      %d winners in the range [21,30], and\n',10*n3/n)
fprintf('                      %d winner  in the range [31,40].\n',    10*n4/n)

