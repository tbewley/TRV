function [winner] = TRV(n,p,m,s)
% Inputs: n = # of voters, p = # of candidates, m = # of winners, 
% s(i,j) \in [0,1] = Score that ballot i assigns to candidate j (ties ok),
%                    normalized to lie on the range [0,1]; that is, S=1.
% Output: winner(k) = list of m winners
C = 1;             % initial voting currency assigned to each ballot
total_cost = C*n;  % initialize total_cost as the total currency
epsilon = 0.00001; % tolerance used to refine threshold quota q
while 1
   q=total_cost/m, % (re-)initialize threshold quota required to be named a winner
   c(1:n) = C;     % (re-)initialize voting currency assigned to each ballot
   for k=1:m       % for each winner...
      for j=1:p    % for each candidate...
         offer(:,j)=min(c(:),s(:,j));    % amount voters offer to candidate j
         total_offer(j)=sum(offer(:,j)); % total candidate j is offered
      end
      % remove offers to winning candidates, so they don't win again
      for kbar=1:k-1, total_offer(winner(kbar))=0.0; end
      total_offer
      [r(k),winner(k)] = max(total_offer);       % identify winner(k)
      cost(k)=min(q,r(k)); % cost(k) is minimum of quota q and winning offer r(k)
      c(:)=c(:)-offer(:,winner(k))*cost(k)/r(k); % cash in winner(k)
   end
   previous_total_cost=total_cost; total_cost=sum(cost); % adjust q if necessary
   if abs(total_cost-previous_total_cost) < epsilon*total_cost, break, end
   winner, pause
end                                                      % repeat until converged
% end function TRV

