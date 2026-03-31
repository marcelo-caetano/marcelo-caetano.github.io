function ncomp = nobs2ncomp(nobs)
%NOBS2NCOMP Convert number of observations to number of pairwise comparisons.
%   NCOMP = NOBS2NCOMP(NOBS) returns the number of pairwise comparisons
%   NCOMP between NOBS observations. In general, NCOMP = NOBS*(NOBS-1)/2.
%
%   See also NCOMP2NOBS, LOWTRI2SYMM


ncomp = nobs*(nobs-1)/2;

end
