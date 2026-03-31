function nobs = ncomp2nobs(ncomp)
%NCOMP2NOBS Convert number of pairwise comparisons to number of observations.
%   NOBS = NCOMP2NOBS(NCOMP) returns the number of observations NOBS
%   required to generate NCOMP pairwise comparisons between the
%   observations. In general, NCOMP = NOBS*(NOBS-1)/2.
%
%   See also NOBS2NCOMP, LOWTRI2SYMM

% HOW TO FIND THE NUMBER OF STIMULI FROM S_N COMPARISONS
% n: number of stimuli
% S_n: number of comparisons
% Sum of arithmetic series: $S_n = \frac{n*(n-1)}{2}$
% Rearrange as n^2 - n -2S_n = 0 and find roots
root_pair = roots([1 -1 -2*ncomp]);

% The positive root is the number of stimuli NSTIM
nobs = root_pair(root_pair>0);

end
