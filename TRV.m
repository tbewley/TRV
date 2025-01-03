function [winners] = TRV(s,m,C,flag)
% function [winners] = TRV(s,m,C,flag)
% INPUTS: s(i,j) = score that each candidate i is assigned by each voter j (ties ok)
%         m = # of winners in the election
%         C = initial voting currency assigned to each ballot (OPTIONAL, default=1)
%         flag = specify if s should be scaled independently (OPTIONAL, default=true)
% OUTPUT: winners = the (ordered) set of m winners in the election
% TESTS:  p=5; n=10; s=rand(p,n); m=3, [winners]=TRV(s,m), pause
%         s=[2 2 2 1 1 1 1 0 0; ...
%            0 1 1 2 2 2 0 0 0; ...
%            0 0 0 0 0 0 2 2 2]; m=2, [winners]=TRV(s,m,1) 
% The scores s(i,j) can be defined over any range [a,b] by each voter; the range
% of scores used by each voter is INDEPENDENTLY (if flag=true) normalized to [0,1]
% during the analysis, so that each voter has the same total impact on the outcome.
% It is likely better to take flag=false if tallying "combined approval" ballots.
%% Copyright 2024 by Thomas Bewley, published under the BSD 3-Clause License. 

if nargin<4, flag=true; end % specify if scores by each voter be scaled independently
if nargin<3, C=1,       end % initial voting currency assigned to each ballot
[p,n]=size(s)               % p = # of candidates, n = # of voters, 
min_s=min(s); max_s=max(s);
if flag % shift scores s(:,j), for each voter j, to be over range [0,1]
   for j=1:n, if max_s(j)==min_s(j), s(1:p,j)=0.5;
              else, s(:,j)=(s(:,j)-min_s(j))/(max_s(j)-min_s(j));
         end, end
else    % shift all scores s to be over range [0,1].  Probably use this only in the
   s=(s-min(min_s))/(max(max_s)-min(min_s));  % case of "combined approval" ballots.
end
if n<11, s, pause, end % print the modified s (if small) to screen, as sanity check
total_cost = C*n;  % initialize total_cost as the total currency
epsilon = 0.00001; % tolerance used to refine threshold quota q
while 1
   q=total_cost/m, % (re-)initialize threshold quota required to be named a winner
   c(1,1:n) = C;   % (re-)initialize voting currency assigned to each ballot
   for k=1:m       % for each winner...
      for i=1:p    % for each candidate...
         offer(i,:)=min(c(1,:),s(i,:));    % amount voters offer to candidate i
         total_offer(i)=sum(offer(i,:));   % total candidate i is offered
      end
      % remove offers to winning candidates, so they don't win again
      for kbar=1:k-1, total_offer(winners(kbar))=0.0; end, total_offer
      [r(k),winners(k)] = max(total_offer);              % identify winners(k)
      cost(k)=min(q,r(k)); % cost(k) is minimum of quota q and winning offer r(k)
      c(1,:)=c(1,:)-offer(winners(k),:)*cost(k)/r(k);    % cash in winners(k)
   end
   previous_total_cost=total_cost; total_cost=sum(cost); % reduce q if necessary
   if abs(total_cost-previous_total_cost) < epsilon*total_cost, break, end
   winners, if n<11, pause, end
end                                                      % repeat until converged
% end function TRV