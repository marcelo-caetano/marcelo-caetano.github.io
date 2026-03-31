function sq = sqform(pair,nstim)
%SQFORM Square form of pairwise similarity matrix.
%   SQ = SQFORM(PAIR,NSTIM) returns the square form SQ of the similarity
%   matrix in the row vector PAIR that contains the lower triangular part
%   of SQ as pairwise distances arranged in the order (2,1), (3,1), ...,
%   (NCMP,1), (NCMP,2), ..., (NCMP,2), ..., (NCMP,NCMP–1), where
%   PAIR is 1 x NCMP, where NCMP is the number of pairwise comparisons.
%   SQ is NSTI x NSTI, where NSTI is the number of stimuli compared.
%
%   NOTE: This function reimplements SQUAREFORM
%
%   See also SQUAREFORM

% Initialize SQ
sq = zeros(nstim);

% Initialize index variables
low_bound = 1;
range = nstim-2;
up_bound = low_bound+range;

for istim = 1:nstim-1
    
    % Upper triangular
    sq(istim,istim+1:nstim) = pair(low_bound:up_bound);
    
    % Lower triangular
    sq(istim+1:nstim,istim) = pair(low_bound:up_bound);
    
    % Update indices
    low_bound = up_bound+1;
    range = range-1;
    up_bound = low_bound+range;
    
end

end
