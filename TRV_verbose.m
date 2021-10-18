function [winner] = TRV_verbose(n,p,m,s)
% Inputs: n = # of voters, p = # of candidates, m = # of winners, 
% s(i,j) \in [0,S] = Score that ballot i assigns to candidate j (ties ok)
% Output: winner(k) = list of m winners
S = max(max(s));   % maximum score that any ballot assigns to any candidate
C = S;             % initial voting currency assigned to each ballot
total_cost = C*n   % initialize total_cost as the total currency
epsilon = 0.00001; % tolerance used to refine threshold quota q
first_iteration=1; % flag used to print some stuff
while 1, clear winner;
   q=total_cost/m  % (re-)initialize threshold quota required to be named a winner
   c(1:n) = C;     % (re-)initialize voting currency assigned to each ballot
   for k=1:m       % for each winner...
      for j=1:p    % for each candidate...
         offer(:,j)=min(c(:),s(:,j));    % amount voters offer to candidate j
         total_offer(j)=sum(offer(:,j)); % total candidate j is offered
      end
      if first_iteration, unsorted_inital_offers=total_offer % print stuff
         [sorted_initial_offers initial_rank]=sort(total_offer,'descend')
      first_iteration=0; end
      % remove offers to winning candidates, so they don't win again
      for kbar=1:k-1, total_offer(winner(kbar))=0.0; end
      [r(k),winner(k)] = max(total_offer);       % identify winner(k)
      total_offer(winner(k))=0;
      [r2(k),temp(k)] = max(total_offer); 
      cost(k)=min(q,r(k)); % cost is minimum of quota q and winning offer r(k)
      c(:)=c(:)-offer(:,winner(k))*cost(k)/r(k); % cash out winner(k)
   end
   winner
   previous_total_cost=total_cost; total_cost=sum(cost)  % adjust q if necessary
   if abs(total_cost-previous_total_cost) < epsilon*total_cost, break, end
end                                                      % repeat until converged
winning_offer=r
runnerup_offer=r2
cost
% end function TRV_verbose
