function est_entr = entropy(randvar)
%ENTROPY Differential entropy.
%   DE = ENTROPY(RV) returns the differential entropy DE of the random
%   variable RV. The differential entropy is calculated as
%   -sum(P.*log2(P)), where P is the probability density function (PDF)
%   approximated by the histogram of RV.

[~,ncol] = size(randvar);

est_entr = zeros(1,ncol);

for icol = 1:ncol
    
    [hcount,binedge] = histcounts(randvar(:,icol),'Normalization','pdf');
    iszero = hcount == 0;
    % Bin width
    bw = binedge(2) - binedge(1);
    % Entropy
    est_entr(icol) = -bw*sum(hcount(~iszero).*log2(hcount(~iszero)));
    
end

end
