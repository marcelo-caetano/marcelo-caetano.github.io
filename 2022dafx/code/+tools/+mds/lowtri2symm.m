function symm = lowtri2symm(low,nstimuli)
%LOWTRI2SYMM Convert lower triangular row vector to symmetric matrix.
%   SYMM = LOWTRI2SYMM(LOW,NSTIM) returns a symmetric matrix SYMM from
%   the row vector LOW that contains the lower triangular part of SYMM
%   arranged as (2,1),(3,1),(3,2),(4,1),(4,2),(4,3),(5,1),(5,2),(5,3),(5,4),...
%   LOW is 1 x NCMP, where NCMP is the number of pairwise comparisons.
%   SYMM is NSTI x NSTI, where NSTI is the number of stimuli compared.
%
%   WARNING! NOT equivalent to SQUAREFORM because the order of entries in
%   the lower triangular row vector is different!
%
%   See also SQUAREFORM

% Initialize SYMM
symm = zeros(nstimuli);

% Initialize index variable
iraw = 0;

for istim = 1:nstimuli-1
    
    % Lower triangular part
    symm(istim+1,1:istim) = low(iraw+1:iraw+istim);
    
    % Upper triangular part
    symm(1:istim,istim+1) = low(iraw+1:iraw+istim);
    
    iraw = iraw + istim;
    
end

end
